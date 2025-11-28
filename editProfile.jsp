<%@ page import="java.sql.*, java.util.*" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="server/authCheck.jsp"%>
<%@ include file="server/DBConnection.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Edit Profile</title>

<!-- Global CSS and JS -->
<jsp:include page="Templates/HeadMeta.jsp" />

<link rel="stylesheet" href="css/editProfile.css" />

<script type="module" src="js/updatePassword.js"></script>
<script type="module" src="js/updateProfile.js"></script>
</head>
<body>
	<!-- Sidebar -->
	<jsp:include page="Templates/Header.jsp" />

	<!-- Main Content -->
	<main class="main-content">
		<section class="section">
			<!-- Change Password -->
			<div class="row">
				<div class="column col-no-padding">
					<h4 class="heading">Change Password</h4>
					<form id="updatePasswordForm" class="form">
						<div class="form-group full">
							<label for="current_password" class="label">Current Password</label> 
							<div class="password-wrapper">
								<input type="password" id="current_password" name="current_password" class="input" placeholder="Enter your current password" required />
								<i class="fa-solid fa-eye eye visible"></i>
								<i class="fa-solid fa-eye-slash eye invisible"></i>
							</div>
						</div>

						<div class="form-group full">
							<label for="new_password" class="label">New Password</label> 
							<div class="password-wrapper">
								<input type="password" id="new_password" name="new_password" class="input"
								placeholder="Enter your current password" required />
								<i class="fa-solid fa-eye eye visible"></i>
								<i class="fa-solid fa-eye-slash eye invisible"></i>
							</div>
						</div>

						<div class="form-group full">
							<label for="confirm_password" class="label">Confirm Password</label> 
								<div class="password-wrapper">
								<input type="password" id="confirm_password" name="confirm_password"
								class="input" placeholder="Enter your current password" required />
								<i class="fa-solid fa-eye eye visible"></i>
								<i class="fa-solid fa-eye-slash eye invisible"></i>
							</div>
						</div>

						<button type="submit" class="f-btn full">Change Password</button>
					</form>

				</div>
			</div>

			<!-- Edit Profile -->
			<div class="row">
				<div class="column col-no-padding">
					<h4 class="heading">Edit Profile</h4>
					<form id="updateProfileForm" class="form form-full">
						<div class="form-group half">
							<label for="username" class="label">Full Name</label> <input type="text" id="username" class="input" name="username"
								placeholder="Enter your full name" required>
						</div>

						<div class="form-group half">
							<label for="phone" class="label">Phone</label> <input type="text" id="phone" class="input" name="phone"
								placeholder="Enter your phone number" required>
						</div>
						
						<div class="form-group third">
							<label for="whatsapp" class="label">WhatsApp</label> <input type="text" id="whatsapp" class="input" name="whatsapp"
								placeholder="Enter your WhatsApp number">
						</div>
						
						<div class="form-group third">
							<label for="gender" class="label">Gender</label> <select id="gender" class="input" name="gender" required>
								<option value="">Select gender</option>
								<option value="Male">Male</option>
								<option value="Female">Female</option>
							</select>
						</div>
						
						<div class="form-group third">
							<label for="blood-group" class="label">Blood Group</label> <select id="blood-group" class="input" name="blood_group" required>
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
						
						<div class="form-group third">
							<label for="birth-date" class="label">Birth Date</label> <input type="date" id="birth-date" class="input" name="birth_date"
								required>
						</div>
						
						<div class="form-group third">
							<label for="district" class="label">District</label> <select id="district" class="input" name="district" required>
								<option value="">Select district</option>
								<%
								String[] districts = { "Bagerhat", "Bandarban", "Barguna", "Barishal", "Bhola", "Bogura", "Brahmanbaria", "Chandpur",
										"Chattogram", "Chuadanga", "Cox's Bazar", "Cumilla", "Dhaka", "Dinajpur", "Faridpur", "Feni", "Gaibandha",
										"Gazipur", "Gopalganj", "Habiganj", "Jamalpur", "Jashore", "Jhalokathi", "Jhenaidah", "Joypurhat",
										"Khagrachari", "Khulna", "Kishoreganj", "Kurigram", "Kushtia", "Lakshmipur", "Lalmonirhat", "Madaripur",
										"Magura", "Manikganj", "Meherpur", "Moulvibazar", "Munshiganj", "Mymensingh", "Naogaon", "Narail",
										"Narayanganj", "Narsingdi", "Natore", "Netrokona", "Nilphamari", "Noakhali", "Pabna", "Panchagarh",
										"Patuakhali", "Pirojpur", "Rajbari", "Rajshahi", "Rangamati", "Rangpur", "Satkhira", "Shariatpur", "Sherpur",
										"Sirajganj", "Sunamganj", "Sylhet", "Tangail", "Thakurgaon" };
								for (String dist : districts) {
								%>
								<option value="<%=dist%>"><%=dist%></option>
								<%
								}
								%>
							</select>
						</div>

						<button type="submit" class="f-btn full">Update Profile</button>
					</form>
				</div>
			</div>
		</section>
	</main>


</body>
</html>