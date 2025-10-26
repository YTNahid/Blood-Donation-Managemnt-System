import { getSessionInfo, getUserPasswordMatch } from './api.js';

document.addEventListener('DOMContentLoaded', () => {
  const form = document.getElementById('updatePasswordForm');

  // Hide or Show Password
  const passWrapper = document.querySelectorAll('.password-wrapper');
  passWrapper.forEach((wrapper) => {
    const input = wrapper.querySelector('input');
    const eyeIcon = wrapper.querySelector('.eye.visible');
    const eyeSlashIcon = wrapper.querySelector('.eye.invisible');

    eyeIcon.addEventListener('click', () => {
      input.type = 'text';
      eyeIcon.style.display = 'none';
      eyeSlashIcon.style.display = 'inline';
    });

    eyeSlashIcon.addEventListener('click', () => {
      input.type = 'password';
      eyeIcon.style.display = 'inline';
      eyeSlashIcon.style.display = 'none';
    });
  });

  form.addEventListener('submit', async (e) => {
    e.preventDefault(); // stop normal form submission

    const currentPassword = document.getElementById('current_password').value;
    const newPassword = document.getElementById('new_password').value;
    const confirmPassword = document.getElementById('confirm_password').value;

    // Check current password match
    const session = await getSessionInfo();
    const user_Id = session.user_id;

    const getPasswordMatch = await getUserPasswordMatch(user_Id, currentPassword);

    if (!getPasswordMatch.match) {
      alert('Current password is incorrect.');
      return;
    }

    // New and Confirm password match check
    if (newPassword !== confirmPassword) {
      alert('New password and confirm password do not match.');
      return;
    }

    // Update password in database
    const formData = new URLSearchParams();
    formData.append('user_id', user_Id);
    formData.append('password', newPassword);

    const response = await fetch('server/updatePassword.jsp', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: formData.toString(),
    });

    const result = await response.json();

    if (result.success) {
      alert('Password updated successfully.');
      form.reset();
    } else {
      alert('Error updating password: ');
      console.error(result.error);
    }
  });
});
