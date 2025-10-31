import { getSessionInfo, getOneUser, formatDate } from './api.js';

document.addEventListener('DOMContentLoaded', async () => {
  let user = null;
  let session = null;

  const params = new URLSearchParams(window.location.search);
  const user_id = params.get('user_id');

  try {
    session = await getSessionInfo();

    if (user_id) {
      user = await getOneUser(user_id);
    } else {
      user = await getOneUser(session.user_id);
    }
  } catch (error) {
    console.error('Error fetching user details:', error);
    user = null;
  }

  renderUserProfile(user, session?.user_id);

  if (user?.user_id) {
    fetchAndApplyUserPhoto(user.user_id);
  }

  // Update Availability
  const updateAvaibilityBtn = document.getElementById('updateAvaibility');
  const availabilityStatus = document.getElementById('availabilityStatus');

  if (updateAvaibilityBtn) {
    updateAvaibilityBtn.addEventListener('click', async () => {
      const response = await fetch('server/updateDonorAvailability.jsp', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: new URLSearchParams({
          user_id: user.user_id,
          currentAvailability: user.availability,
        }).toString(),
      });

      const result = await response.json();

      if (result.success) {
        alert(result.message);
        user.availability = user.availability === 'yes' ? 'no' : 'yes';
        availabilityStatus.textContent = user.availability === 'yes' ? 'Yes' : 'No';
        availabilityStatus.style.color = user.availability === 'yes' ? 'green' : 'red';
      } else {
        alert(result.message);
        console.error(result.error);
      }
    });
  }
});

const renderUserProfile = (user, sessionUserId) => {
  const container = document.getElementById('userProfileContainer');
  if (!container) return;

  if (!user) {
    container.innerHTML = '<p class="text">User details not found.</p>';
    return;
  }

  container.innerHTML = `
    <div class="profile data">
      <div class="row main-profile">
        <div class="column img-container">
          <img id="profileImage" src="assets/profile-photo/loading.png" 
               alt="Profile Picture" class="profile-photo" />
          ${user.user_id === sessionUserId ? `<button id="changePhoto" class="button button-small change-photo">Change Photo</button>` : ''}
          <input type="file" id="photoInput" accept="image/*" style="display:none;" />
        </div>
        <h3 class="heading name">${user.username}</h3>
      </div>
      <div class="profile-details">
        <p class="text"><strong>Email:</strong> ${user.email}</p>
        <p class="text"><strong>Phone:</strong> ${user.phone}</p>
        <p class="text"><strong>WhatsApp:</strong> ${user.whatsapp ? user.whatsapp : 'Not provided'}</p>
        <p class="text"><strong>Gender:</strong> ${user.gender}</p>
        <p class="text"><strong>Blood Group:</strong> ${user.blood_group}</p>
        <p class="text"><strong>Birth Date:</strong> ${formatDate(user.birth_date, false)}</p>
        <p class="text"><strong>District:</strong> ${user.district}</p>
        <p class="text"><strong>Role:</strong> ${user.role}</p>
      </div>
      <div class="availability">
        <p class="text"><strong>Available for Donation: 
          <span id="availabilityStatus" style="color: ${user.availability === 'yes' ? 'green' : 'red'};">
            ${user.availability === 'yes' ? 'Yes' : 'No'}
          </span>
        </strong></p>
        <button id="updateAvaibility" class="button">Change Availability</button>
      </div>
    </div>
  `;

  // Update Photo
  const changePhotoBtn = document.getElementById('changePhoto');
  const photoInput = document.getElementById('photoInput');

  if (changePhotoBtn && photoInput) {
    changePhotoBtn.addEventListener('click', () => {
      photoInput.click();
    });

    photoInput.addEventListener('change', async () => {
      const file = photoInput.files[0];
      if (!file) return;

      const formData = new FormData();
      formData.append('user_id', user.user_id);
      formData.append('photo', file);

      try {
        const response = await fetch('server/updatePhoto.jsp', {
          method: 'POST',
          body: formData,
        });

        const text = await response.text();
        let result;

        try {
          result = JSON.parse(text);
        } catch (err) {
          console.error('Invalid JSON:', text);
          alert('Server returned unexpected response');
          return;
        }

        if (result.success) {
          alert('Photo updated successfully!');
          fetchAndApplyUserPhoto(user.user_id); // refresh image
          window.location.reload();
        } else {
          alert('Failed to update photo: ' + result.message);
        }
      } catch (err) {
        console.error('Upload error:', err);
        alert('Error uploading photo');
      }
    });
  }
};

async function fetchAndApplyUserPhoto(userId) {
  const profileImage = document.getElementById('profileImage');
  if (!profileImage) return;

  try {
    const response = await fetch(`server/getUserPhoto.jsp?user_id=${userId}`);
    if (!response.ok) throw new Error('No photo found');
    // Try to fetch photo from server
    const contentType = response.headers.get('content-type');
    if (!contentType || !contentType.startsWith('image/')) {
      throw new Error('Not an image');
    }

    const blob = await response.blob();
    if (blob.size === 0) throw new Error('Empty photo');

    const imageUrl = URL.createObjectURL(blob);
    profileImage.src = imageUrl;
  } catch (err) {
    console.warn('Using fallback photo:', err.message);
    profileImage.src = 'assets/profile-photo/luffy.jpg';
  }
}
