import { getOneUser, getSessionInfo } from './api.js';

document.addEventListener('DOMContentLoaded', async () => {
	const form = document.getElementById('updateProfileForm');

	const username = document.getElementById('username');
	const phone = document.getElementById('phone');
	const whatsapp = document.getElementById('whatsapp');
	const gender = document.getElementById('gender');
	const bloodGroup = document.getElementById('blood-group');
	const birthDate = document.getElementById('birth-date');
	const district = document.getElementById('district');

	// Fill form data of the user
	const session = await getSessionInfo();
	const user_Id = session.user_id;
	const user = await getOneUser(user_Id);

	console.log(user);

	if (user) {
		username.value = user.username || '';
		phone.value = user.phone || '';
		whatsapp.value = user.whatsapp || '';
		gender.value = user.gender || '';
		bloodGroup.value = user.blood_group || '';
		birthDate.value = user.birth_date || '';
		district.value = user.district || '';
	}

	// Handle form submission
	form.addEventListener('submit', async (e) => {
		e.preventDefault();

		const formData = new URLSearchParams(new FormData(form));
		formData.append("user_id", user_Id);

		const res = await fetch('server/updateProfile.jsp', {
			method: 'POST',
			headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
			body: formData.toString()
		});

		const result = await res.json();
		if (result.success) {
			alert('Profile updated successfully.');
		} else {
			alert('Error updating profile: ');
			console.error(result.error);
		}
	});
});
