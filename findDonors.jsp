<%@ page import="java.sql.*, java.util.*" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="server/DBConnection.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Find Donors</title>
<jsp:include page="Templates/HeadMeta.jsp" />
<link rel="stylesheet" href="css/findDonors.css" />

<script type="module" src="js/findDonors.js"></script>
</head>
<body>

	<!-- Sidebar -->
	<jsp:include page="Templates/Header.jsp" />

	<main class="main-content">
		<div class="row page-heading">
			<h2 class="heading">Find Donors</h2>
		</div>

		<!-- Filter Form -->
		<section class="section">
			<div class="row">
				<div class="column col-no-padding">
					<form class="filter">
						<label for="blood_group" class="label">Blood Group: <select id="bloodGroupSelect" name="blood_group" id="bloodGroupSelect" class="input">
								<option value="">All</option>
								<%
								String[] bloodGroups = { "A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-" };
								for (String group : bloodGroups) {
								%>
								<option value="<%=group%>"><%=group%></option>
								<%
								}
								%>
						</select>
						</label> <label for="district" class="label">District: <select id="districtSelect" name="district" id="disctrictSelect" class="input">
								<option value="">All</option>
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
						</select></label>
					</form>
				</div>
			</div>
		</section>

		<!-- Donor Table -->
		<section class="section section-donors">
			<div class="row">
				<div class="column">
					<div id="donors-list">
						Loading Donors...
					</div>
				</div>
			</div>
		</section>
	</main>
</body>
</html>