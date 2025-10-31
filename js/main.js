import { getUserLocation } from './api.js';

document.addEventListener('DOMContentLoaded', async () => {
  // Mobile Menu
  const hamburger = document.querySelector('.header-mobile .ham');
  const sidebar = document.querySelector('.sidebar');
  const close = document.querySelector('.sidebar-close');

  if (hamburger && close && sidebar) {
    hamburger.style.transition = 'transform 0.1s';
    close.style.display = 'none';

    hamburger.addEventListener('click', function () {
      hamburger.style.transform = 'rotate(180deg)';
      sidebar.classList.add('open');
      setTimeout(() => {
        hamburger.style.display = 'none';
        close.style.display = 'inline';
      }, 100);
    });

    close.addEventListener('click', function () {
      hamburger.style.display = 'inline';
      setTimeout(() => {
        hamburger.style.transform = 'rotate(0deg)';
      }, 10);
      close.style.display = 'none';
      sidebar.classList.remove('open');
    });
  }

  // Alert nearby blood requests
  await nearbyAlert();
  //setInterval(nearbyAlert, 0);
});

const nearbyAlert = async () => {
  // Skip on login or requestBlood pages
  const path = window.location.pathname;
  if (path.endsWith('login.jsp')) return;

  try {
    const location = await getUserLocation();
    if (!location) return;

    const params = new URLSearchParams({
      latitude: location.latitude,
      longitude: location.longitude,
      radius: 2,
    });

    const response = await fetch(`server/getNearbyRequests.jsp?${params.toString()}`);

    const data = await response.json();
    console.log(data);

    const nearbyTag = document.querySelector('.nearby-tag');
    if (!nearbyTag) return;

    if (data.results && data.results.length > 0) {
      const isNearbyClicked = JSON.parse(localStorage.getItem('isNearbyClicked'));

      if (!isNearbyClicked || Date.now() - isNearbyClicked.time > 1000 * 60 * 60) {
        if (!path.endsWith('requestBlood.jsp')) {
          if (confirm('There is a blood request nearby. See Details?')) {
            window.location.href = 'requestBlood.jsp?nearby=true';
          }
          localStorage.setItem('isNearbyClicked', JSON.stringify({ clicked: true, time: Date.now() }));
        }
      }

      nearbyTag.style.display = 'inline';
    } else {
      nearbyTag.style.display = 'none';
    }
  } catch (err) {
    console.error('Error in nearbyAlert:', err);
  }
};
