<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat"%>
<%@ include file="server/DBConnection.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Donation History</title>

<!-- Global CSS and JS -->
<jsp:include page="Templates/HeadMeta.jsp" />

<link rel="stylesheet" href="css/history.css" />

<script type="module" src="js/history.js"></script>
</head>
<body>
	<!-- Sidebar -->
	<jsp:include page="Templates/Header.jsp" />

	<!-- Main Content -->
	<main class="main-content">
		<div class="row page-heading">
			<h2 class="heading">Donation History</h2>
			<%
			String role = (String) session.getAttribute("role");
			if ("admin".equals(role)) {
			%>
			<a href="adminDonationHistoryForm.jsp" class="button">Add History</a>
			<%
			}
			%>
		</div>



		<section class="section section-recent">
			<div class="row">
				<div id="history-list" class="column col-no-padding">
					Loading History...
				</div>
			</div>
		</section>
	</main>




</body>
</html>
