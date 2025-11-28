<%@ page import="java.sql.*, java.util.*" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="server/authCheck.jsp"%>
<%@ include file="server/DBConnection.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Request Blood Form</title>

<!-- Global CSS and JS -->
<jsp:include page="Templates/HeadMeta.jsp" />

<link rel="stylesheet" href="css/requestBlood.css">
<script type="module" src="js/BloodRequestInfo.js"></script>
</head>
<body>
	<!-- Sidebar -->
	<jsp:include page="Templates/Header.jsp" />

	<!-- Main Content -->
	<main class="main-content">
		<div class="row page-heading">
			<h2 class="heading">Request Blood Form</h2>
		</div>

		<section class="section">
			<div class="row">
				<div class="column col-no-padding">
					<!-- Contact Form -->
					<div id="request-blood-form">
						<form id="bloodRequestForm" class="form form-full form-wrap">
							<div class="form-group third">
								<label for="blood_group" class="label">Blood Group<span class="required-star">*</span></label> <select id="blood_group" name="blood_group"
									class="input" required>
									<option value="">Select Blood Group</option>
									<option value="A+">A+</option>
									<option value="A-">A-</option>
									<option value="B+">B+</option>
									<option value="B-">B-</option>
									<option value="O+">O+</option>
									<option value="O-">O-</option>
									<option value="AB+">AB+</option>
									<option value="AB-">AB-</option>
								</select>
							</div>

							<div class="form-group third">
								<label for="district" class="label">District<span class="required-star">*</span></label> <select id="district" name="district" class="input"
									required>
									<option value="">Select District</option>
									<%
									String[] districts = { "Bagerhat", "Bandarban", "Barguna", "Barisal", "Bhola", "Bogra", "Brahmanbaria", "Chandpur",
											"Chapai Nawabganj", "Chattogram", "Chuadanga", "Comilla", "Cox's Bazar", "Dhaka", "Dinajpur", "Faridpur",
											"Feni", "Gaibandha", "Gazipur", "Gopalganj", "Habiganj", "Jamalpur", "Jashore", "Jhalokathi", "Jhenaidah",
											"Joypurhat", "Khagrachari", "Khulna", "Kishoreganj", "Kurigram", "Kushtia", "Lakshmipur", "Lalmonirhat",
											"Madaripur", "Magura", "Manikganj", "Meherpur", "Moulvibazar", "Munshiganj", "Mymensingh", "Naogaon", "Narail",
											"Narayanganj", "Narsingdi", "Natore", "Netrokona", "Nilphamari", "Noakhali", "Pabna", "Panchagarh",
											"Patuakhali", "Pirojpur", "Rajbari", "Rajshahi", "Rangamati", "Rangpur", "Satkhira", "Shariatpur", "Sherpur",
											"Sirajganj", "Sunamganj", "Sylhet", "Tangail", "Thakurgaon" };
									Arrays.sort(districts);
									for (String d : districts) {
									%>
									<option value="<%=d%>"><%=d%></option>
									<%
									}
									%>
								</select>
							</div>

							<div class="form-group third">
								<label for="due_date" class="label">Due Date<span class="required-star">*</span></label> <input type="date" id="due_date" class="input"
									name="due_date" required>
							</div>

							<div class="form-group half">
								<label for="latlng" class="label">Latitude, Longitude (Optional)
									<span class="info-container">
										<span class="info"><b>Desktop:</b> Right click on your desired location on <a href="https://www.google.com/maps" target="_blank">google map</a> and copy the latitude and longitude. <br><br> <b>Mobile:</b> Tap and hold on your desired location on <a href="https://www.google.com/maps" target="_blank">google map</a> and copy the latitude and longitude from top.</span>
										<i class="fa-regular fa-circle-question"></i>
									</span>
								</label> <input type="text" id="latlng" class="input" name="latlng" placeholder="e.g. 23.8103, 90.4125" pattern="^-?\d{1,3}\.\d+,\s*-?\d{1,3}\.\d+$" />
							</div>

							<div class="form-group half">
								<label for="contact_info" class="label">Contact Info<span class="required-star">*</span></label> <input type="text" id="contact_info"
									class="input" name="contact_info" placeholder="ex: Phone: 01XXXXXXXXX" required />
							</div>

							<div class="form-group full">
								<label for="location" class="label">Full Location<span class="required-star">*</span></label> <input type="text" id="location" class="input"
									name="location" placeholder="Where is the patient? (Full address)" required />
							</div>

							<div class="form-group full">
								<label for="reason" class="label">Reason for Request<span class="required-star">*</span></label>
								<textarea id="reason" class="input" name="reason" placeholder="Why is blood needed?" rows="4" required></textarea>
							</div>

							<label for="urgent" class="label full"><input type="checkbox" id="urgent" name="urgent" /> Check this box if this is an urgent request</label>

							<button type="submit" class="f-btn full">Submit Blood Request</button>
						</form>
					</div>
				</div>
			</div>
		</section>
	</main>


</body>
</html>