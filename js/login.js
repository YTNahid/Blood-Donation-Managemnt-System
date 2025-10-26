function switchTab(tabName, element) {
	document.querySelectorAll('.tab-button').forEach(btn => btn.classList.remove('active'));
	document.querySelectorAll('.form-tab').forEach(tab => tab.classList.remove('active'));

	element.classList.add('active');
	document.getElementById(tabName + '-form').classList.add('active');

	// Add or remove 'register' class on .auth-container based on tabName
	const authContainer = document.querySelector('.auth-container');
	if (authContainer) {
		authContainer.classList.toggle('register', tabName === 'register');
	}
}


const registerForm = document.querySelector('#register-form form');


// Switch to register Tab
if (window.location.search.includes('register')) {
	const registerTabBtn = document.querySelector('.tab-register');
	if (registerTabBtn) {
		switchTab('register', registerTabBtn);
	}
	const authContainer = document.querySelector('.auth-container');
	if (authContainer) {
		authContainer.classList.add('register');
	}
}