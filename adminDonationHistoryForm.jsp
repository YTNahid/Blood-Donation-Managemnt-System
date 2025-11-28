<%@ page import="java.sql.*, java.util.*" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="server/authCheckAdmin.jsp"%>
<%@ include file="server/DBConnection.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Add Donation History</title>

<!-- Global CSS and JS -->
<jsp:include page="Templates/HeadMeta.jsp" />

<script type="module" src="js/history.js"></script>

</head>
<body>
	<!-- Sidebar -->
	<jsp:include page="Templates/Header.jsp" />

	<!-- Main Content -->
	<main class="main-content">
		<div class="row page-heading">
			<h2 class="heading">Donation History Form</h2>
		</div>
		<section class="section">
			<div class="row">
				<div class="column col-no-padding">
					<!-- Contact Form -->
					<div id="request-blood-form">
						<form id="historyForm" class="form">
							<div class="form-group full">
								<label for="donor_id" class="label">Select Donor<span class="required-star">*</span></label> <select name="donor_id" id="donor_id"
									class="input" required>
									<option value="">-- Select Donor --</option>
								</select>
							</div>

							<div class="form-group full">
								<label for="donor_id" class="label">Select Action<span class="required-star">*</span></label> <select name="action" id="action"
									class="input" required>
									<option value="">-- Select Action --</option>
									<option value="donated">Donated Blood</option>
									<option value="received">Received Blood</option>
								</select>
							</div>

							<div class="form-group full">
								<label for="donated_to" class="label">Donation Date</label> <input type="date" id="donation_date" name="donation_date" class="input" />
							</div>

							<button type="submit" class="f-btn full">Add Donation Record</button>
						</form>
					</div>
				</div>
			</div>
		</section>
	</main>


</body>
</html>