document.addEventListener('DOMContentLoaded', function() {
	const loginForm = document.getElementById('loginForm');
	const registerForm = document.getElementById('registerForm');

	// Handle login form submission
	loginForm.addEventListener('submit', async (e) => {
		e.preventDefault();

		const formData = new URLSearchParams(new FormData(loginForm));

		const response = await fetch(`server/loginLogic.jsp?${formData.toString()}`);

		const result = await response.json();

		if (result.success) {
			window.location.href = 'dashboard.jsp';
		} else {
			alert('Login failed: ' + result.error);
		}
	});

	// Handle register form submission
	registerForm.addEventListener('submit', async (e) => {
		e.preventDefault();

		const formData = new FormData(registerForm);
		
		const formParams = new URLSearchParams(formData);

		if (formData.get('password') !== formData.get('confirmPassword')) {
			alert('Passwords do not match!');
			return;
		}
		
		const response = await fetch(`server/registerLogic.jsp?${formParams.toString()}`);

		const result = await response.json();

		if (result.success) {
			alert(result.message);
			window.location.href = 'login.jsp';
		} else {
			alert(result.message);
			console.error(result.error);
		}
	});
});