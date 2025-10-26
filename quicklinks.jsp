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

<link rel="stylesheet" href="css/quicklinks.css" />
</head>
<body>
	<!-- Sidebar -->
	<jsp:include page="Templates/Header.jsp" />

	<!-- Main Content -->
	<main class="main-content">
		<div class="row page-heading">
			<h2 class="heading">Quicklinks</h2>
		</div>

		
		<section class="section">
			<div class="row">
				<div class="column col-no-padding quicklinks">
					<a href="adminGiveAnnouncementForm.jsp" class="button">Give Announcement</a>
					<a href="adminDonationHistoryForm.jsp" class="button">Add Donation History</a>
					<a href="adminDonationHistoryForm.jsp" class="button">Request Blood</a>
				</div>
			</div>
		</section>
	</main>


</body>
</html>