<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login or Register</title>

<!-- Global CSS and JS -->
<jsp:include page="Templates/HeadMeta.jsp" />

<link rel="stylesheet" href="css/login.css">

<script src="js/handleLoginRegister.js"></script>
</head>
<body>
	<div class="auth-container">

		<div class="auth-header">
			<h2 class="heading">Welcome</h2>
			<p class="text">Join our amazing community</p>
		</div>

		<div class="tab-container">
			<button class="tab-button tab-login active" onclick="switchTab('login', this)">Login</button>
			<button class="tab-button tab-register" onclick="switchTab('register', this)">Register</button>
		</div>

		<div class="form-container">
			<!-- Login Form -->
			<div id="login-form" class="form-tab active">
				<form id="loginForm" class="form">
					<div class="form-group full">
						<label for="login-email" class="label">Email Address<span class="required-star">*</span></label> <input type="email" id="login-email" class="input" name="email"
							placeholder="Enter your email" required>
					</div>

					<div class="form-group full">
						<label for="login-password" class="label">Password<span class="required-star">*</span></label> <input type="password" id="login-password" class="input" name="password"
							placeholder="Enter your password" required>
					</div>

					<button type="submit" class="f-btn full">Sign In</button>
				</form>
			</div>

			<!-- Register Form -->
			<div id="register-form" class="form-tab">
				<form id="registerForm"  class="form form-full">
					<div class="form-group half">
						<label for="register-fullname" class="label">Full Name<span class="required-star">*</span></label> <input type="text" id="register-fullname" class="input" name="fullname"
							placeholder="Enter your full name" required>
					</div>

					<div class="form-group half">
						<label for="register-email" class="label">Email Address<span class="required-star">*</span></label> <input type="email" id="register-email" class="input" name="email"
							placeholder="Enter your email" required>
					</div>

					<div class="form-group half">
						<label for="register-password" class="label">Password<span class="required-star">*</span></label> <input type="password" id="register-password" class="input" name="password"
							placeholder="Create a password" required>
					</div>

					<div class="form-group half">
						<label for="register-confirm" class="label">Confirm Password<span class="required-star">*</span></label> <input type="password" id="register-confirm" class="input"
							name="confirmPassword" placeholder="Confirm your password" required>
					</div>

					<div class="form-group half">
						<label for="register-phone" class="label">Phone<span class="required-star">*</span></label> <input type="text" id="register-phone" class="input" name="phone"
							placeholder="Enter your phone number" required>
					</div>
					
					<div class="form-group half">
						<label for="register-whatsapp" class="label">WhatsApp (Optional)</label> <input type="text" id="register-whatsapp" class="input" name="whatsapp"
							placeholder="Enter your WhatsApp number">
					</div>
					
					<div class="form-group half">
						<label for="register-gender" class="label">Gender<span class="required-star">*</span></label> <select id="register-gender" class="input" name="gender" required>
							<option value="">Select gender</option>
							<option value="Male">Male</option>
							<option value="Female">Female</option>
						</select>
					</div>
					
					<div class="form-group half">
						<label for="register-blood-group" class="label">Blood Group<span class="required-star">*</span></label> <select id="register-blood-group" class="input" name="blood_group" required>
							<option value="">Select blood group</option>
							<option value="A+">A+</option>
							<option value="A-">A-</option>
							<option value="B+">B+</option>
							<option value="B-">B-</option>
							<option value="AB+">AB+</option>
							<option value="AB-">AB-</option>
							<option value="O+">O+</option>
							<option value="O-">O-</option>
						</select>
					</div>
					
					<div class="form-group half">
						<label for="register-birth-date" class="label">Birth Date<span class="required-star">*</span></label> <input type="date" id="register-birth-date" class="input" name="birth_date"
							required>
					</div>
					
					<div class="form-group half">
						<label for="register-district" class="label">District<span class="required-star">*</span></label> <select id="register-district" class="input" name="district" required>
							<option value="">Select district</option>
							<%
							String[] districts = {"Bagerhat", "Bandarban", "Barguna", "Barishal", "Bhola", "Bogura", "Brahmanbaria", "Chandpur",
									"Chattogram", "Chuadanga", "Cox's Bazar", "Cumilla", "Dhaka", "Dinajpur", "Faridpur", "Feni", "Gaibandha",
									"Gazipur", "Gopalganj", "Habiganj", "Jamalpur", "Jashore", "Jhalokathi", "Jhenaidah", "Joypurhat",
									"Khagrachari", "Khulna", "Kishoreganj", "Kurigram", "Kushtia", "Lakshmipur", "Lalmonirhat", "Madaripur",
									"Magura", "Manikganj", "Meherpur", "Moulvibazar", "Munshiganj", "Mymensingh", "Naogaon", "Narail",
									"Narayanganj", "Narsingdi", "Natore", "Netrokona", "Nilphamari", "Noakhali", "Pabna", "Panchagarh",
									"Patuakhali", "Pirojpur", "Rajbari", "Rajshahi", "Rangamati", "Rangpur", "Satkhira", "Shariatpur", "Sherpur",
									"Sirajganj", "Sunamganj", "Sylhet", "Tangail", "Thakurgaon"};
							for (String dist : districts) {
							%>
							<option value="<%=dist%>"><%=dist%></option>
							<%
							}
							%>
						</select>
					</div>

					<div class="form-group half">
						<label for="register-availability" class="label">Register as a Donor?</label> <select id="register-availability" class="input"
							name="availability">
							<option value="yes">Yes</option>
							<option value="no" selected>No</option>
						</select>
					</div>

					<button type="submit" class="f-btn full">Create Account</button>
				</form>
			</div>
		</div>
	</div>

	<script src="js/login.js"></script>

</body>
</html>