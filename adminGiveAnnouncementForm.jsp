<%@ page import="java.sql.*, java.util.*" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="server/authCheckAdmin.jsp"%>
<%@ include file="server/DBConnection.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Give Announcement</title>

<!-- Global CSS and JS -->
<jsp:include page="Templates/HeadMeta.jsp" />

<script type="module" src="js/announcements.js"></script>
</head>
<body>
	<!-- Sidebar -->
	<jsp:include page="Templates/Header.jsp" />

	<!-- Main Content -->
	<main class="main-content">
		<div class="row page-heading">
			<h2 class="heading">Announcement Form</h2>
		</div>

		<section class="section">
			<div class="row">
				<div class="column col-no-padding">
					<!-- Contact Form -->
					<div id="request-blood-form">
						<form id="announcementForm" class="form">
							<div class="form-group full">
								<label for="title" class="label">Announcement Title</label> <input type="text" id="title" name="title" class="input"
									placeholder="Enter announcement title" required />
							</div>

							<div class="form-group full">
								<label for="message" class="label">Message</label>
								<textarea id="message" name="message" class="input" placeholder="Write your announcement here..." rows="5" required></textarea>
							</div>

							<button type="submit" class="f-btn full">Give Announcement</button>
						</form>
					</div>
				</div>
			</div>
		</section>
	</main>


</body>
</html>