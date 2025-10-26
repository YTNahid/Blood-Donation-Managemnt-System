<%@ page import="java.sql.*, java.util.*" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="server/authCheckAdmin.jsp"%>
<%@ include file="server/DBConnection.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Manage Users</title>
<jsp:include page="Templates/HeadMeta.jsp" />
<link rel="stylesheet" href="css/manageUsers.css" />

<script type="module" src="js/manageUsers.js"></script>
</head>
<body>

	<!-- Sidebar -->
	<jsp:include page="Templates/Header.jsp" />

	<main class="main-content">
		<div class="row page-heading">
			<h2 class="heading">Manage Users</h2>
		</div>


		<!-- Admins Table -->
		<section class="section admins-section">
			<div class="row">
				<div class="column col-no-padding">
					<h4 class="heading">Admins</h4>
					<div class="table-container">
						<table>
							<thead>
								<tr>
									<th>User ID</th>
									<th>Username</th>
									<th>Email</th>
									<th>Phone</th>
									<th>District</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>Loading Admins...</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</section>

		<!-- Users Table -->
		<section class="section users-section">
			<div class="row">
				<div class="column col-no-padding">
					<h4 class="heading">Users</h4>
					<div class="table-container">
						<table>
							<thead>
								<tr>
									<th>User ID</th>
									<th>Username</th>
									<th>Email</th>
									<th>Phone</th>
									<th>District</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>Loading Users...</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</section>
	</main>
</body>
</html>