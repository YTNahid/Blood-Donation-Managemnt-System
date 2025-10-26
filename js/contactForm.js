import { getSessionInfo, getOneUser } from './api.js';

document.addEventListener('DOMContentLoaded', async () => {
	const contactForm = document.getElementById('contactForm');

	const session = await getSessionInfo();
	const user = await getOneUser(session.user_id);

	if (user) {
		contactForm.elements['email'].value = user.email || '';
		contactForm.elements['name'].value = user.username || '';
	}

	contactForm.addEventListener('submit', async (e) => {
		e.preventDefault();


		const formData = new URLSearchParams(new FormData(contactForm));

		const response = await fetch(`server/postContact.jsp?${formData.toString()}`)

		const result = await response.json();

		if (result.success) {
			alert(result.message);
			contactForm.reset();
		} else {
			alert(result.message);
			console.error(result.error);
		}
	});
});