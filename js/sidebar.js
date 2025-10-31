import { getSessionInfo, getOneUser } from './api.js';

document.addEventListener('DOMContentLoaded', async () => {
  const profilePhoto = document.querySelector('.profile-photo');
  if (!profilePhoto) return;

  // Set initial loading image
  profilePhoto.src = 'assets/profile-photo/loading.png';

  try {
    const session = await getSessionInfo();
    const userData = await getOneUser(session.user_id);

    // Try to fetch photo from server
    const response = await fetch(`server/getUserPhoto.jsp?user_id=${userData.user_id}`);
    const contentType = response.headers.get('content-type');
    if (!contentType || !contentType.startsWith('image/')) {
      throw new Error('Not an image');
    }

    const blob = await response.blob();

    if (blob.size === 0) throw new Error('Empty photo');

    const imageUrl = URL.createObjectURL(blob);
    profilePhoto.src = imageUrl;
  } catch (err) {
    console.warn('Using fallback photo:', err.message);
    profilePhoto.src = 'assets/profile-photo/luffy.jpg';
  }
});
