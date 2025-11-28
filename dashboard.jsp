<%@ page import="java.sql.*, java.util.*" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="server/DBConnection.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Dashboard</title>

<!-- Global CSS and JS -->
<jsp:include page="Templates/HeadMeta.jsp" />

<link rel="stylesheet" href="css/dashboard.css" />

<script type="module" src="js/dashboard.js"></script>
</head>
<body>
	<!-- Sidebar -->
	<jsp:include page="Templates/Header.jsp" />

	<!-- Main Content -->
	<main class="main-content">
		<div class="row page-heading">
			<h2 class="heading">Dashboard</h2>
		</div>

		<!-- Stats Cards -->
		<section class="section section-cards">
			<div class="row cards-container">
				<div class="column card">
					<div class="card-number" id="total-donors">0</div>
					<h4 class="heading card-title">Total Donors</h4>
					<a href="findDonors.jsp" class="card-link link">
						View Donors <span>></span>
					</a>
				</div>
				<div class="column card">
					<div class="card-number" id="total-donations">0</div>
					<h4 class="heading card-title">Total Donations</h4>
					<a href="history.jsp" class="card-link link">
						View History <span>></span>
					</a>
				</div>
				<div class="column card">
					<div class="card-number" id="total-requests">0</div>
					<h4 class="heading card-title">Incomplete Blood Requests</h4>
					<a href="requestBlood.jsp" class="card-link link">
						View Requests <span>></span>
					</a>
				</div>
			</div>
		</section>

		<!-- Recent Donors Table -->
		<section class="section section-recent">
			<div class="row">
				<div class="column">
					<h4 class="heading">Recent Donors</h4>
					<div class="table-container">
						<table>
							<thead>
								<tr>
									<th>Name</th>
									<th>Blood Group</th>
									<th>Phone</th>
									<th>District</th>
									<th>More Contacts</th>
								</tr>
							</thead>
							<tbody id="recent-donors-body">
								<!-- Data from JS -->
							</tbody>
						</table>
					</div>
					<a href="findDonors.jsp" class="link">
						View All <span>></span>
					</a>
				</div>
			</div>
		</section>
	</main>

</body>
</html>