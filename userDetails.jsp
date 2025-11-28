<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat"%>
<%@ include file="server/authCheckAdmin.jsp"%>
<%@ include file="server/DBConnection.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Profile</title>

<!-- Global CSS and JS -->
<jsp:include page="Templates/HeadMeta.jsp" />

<link rel="stylesheet" href="css/profile.css" />

<script type="module" src="js/userProfile.js"></script>
</head>
<body>
	<!-- Sidebar -->
	<jsp:include page="Templates/Header.jsp" />

	<!-- Main Content -->
	<main class="main-content">
		<div class="row page-heading">
			<h2 class="heading">User Details</h2>
		</div>

		
		<section class="section section-recent">
			<div class="row">
				<div id="userProfileContainer" class="column col-no-padding">
					Loading user details...
				</div>
			</div>
		</section>
	</main>




</body>
</html>