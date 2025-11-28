<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat"%>
<%@ include file="server/DBConnection.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Announcements</title>

<!-- Global CSS and JS -->
<jsp:include page="Templates/HeadMeta.jsp" />

<link rel="stylesheet" href="css/announcements.css" />
<script type="module" src="js/announcements.js"></script>
</head>
<body>
	<!-- Sidebar -->
	<jsp:include page="Templates/Header.jsp" />

	<!-- Main Content -->
	<main class="main-content">
		<div class="row page-heading">
			<h2 class="heading">Announcements</h2>
			<%
			String role = (String) session.getAttribute("role");
			if ("admin".equals(role)) {
			%>
			<a href="adminGiveAnnouncementForm.jsp" class="button">Give Announcement</a>
			<%
			}
			%>
		</div>


		<section class="section section-recent">
			<div class="row">
				<div id="announcements-list" class="column col-no-padding">
					Loading Announcements...
				</div>
			</div>
		</section>
	</main>




</body>
</html>
