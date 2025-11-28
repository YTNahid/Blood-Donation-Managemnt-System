<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String username = (String) session.getAttribute("username");
String role = (String) session.getAttribute("role");
String currPage = request.getServletPath();
%>
<div class="section header-mobile">
	<div class="row exclude">
		<a href="BloodDonation/dashboard.jsp">
			<h3 class="heading">Blood Donation</h3>
		</a>
		<img src="assets/bars-solid-full.svg" alt="Ham" class="ham"> <img src="assets/xmark-solid-full.svg" alt="Ham" class="sidebar-close">

	</div>
</div>

<aside id="sidebar" class="sidebar">
	<div class="sidebar-header">
		Blood Donation
	</div>
	<nav class="nav-links">
		<a href="dashboard.jsp" class="text<%=currPage.endsWith("dashboard.jsp") ? " active" : ""%>">
			<img src="assets/house-solid-full.svg" class="icon"> Dashboard
		</a>
		<%
		if (username != null) {
		%>
		<a href="profile.jsp" class="text<%=currPage.endsWith("profile.jsp") ? " active" : ""%>">
			<img src="assets/user-solid-full.svg" class="icon"> Profile
		</a>
		<% } %>
		<a href="announcements.jsp" class="text<%=currPage.endsWith("announcements.jsp") ? " active" : ""%>">
			<img src="assets/bullhorn-solid-full.svg" class="icon"> Announcements
		</a>
		<a href="findDonors.jsp" class="text<%=currPage.endsWith("findDonors.jsp") ? " active" : ""%>">
			<img src="assets/magnifying-glass-solid-full.svg" class="icon"> Find Donor
		</a>
		<a href="requestBlood.jsp" class="text<%=currPage.endsWith("requestBlood.jsp") ? " active" : ""%>">
			<img src="assets/droplet-solid-full.svg" class="icon"> Blood Requests <sup class="nearby-tag">(Nearby)</sup>
		</a>
		<a href="history.jsp" class="text<%=currPage.endsWith("history.jsp") ? " active" : ""%>">
			<img src="assets/clock-solid-full.svg" class="icon"> History<span class="pending-notify"></span>
		</a>
		<% if (!"admin".equals(role)) { %>
		<a href="contact.jsp" class="text<%=currPage.endsWith("contact.jsp") ? " active" : ""%>">
			<img src="assets/comment-solid-full.svg" class="icon"> Feedback / Contact
		</a>
		<% } %>

		<%
		if ("admin".equals(role)) {
		%>
		<h6 class="heading admin-heading">ADMIN PANEL</h6>
		<a href="manageUsers.jsp" class="text<%=currPage.endsWith("manageUsers.jsp") ? " active" : ""%>">
			<img src="assets/users-solid-full.svg" class="icon"> Manage Users
		</a>
		<a href="feedbacks.jsp" class="text<%=currPage.endsWith("feedbacks.jsp") ? " active" : ""%>">
			<img src="assets/newspaper-solid-full.svg" class="icon"> Feedbacks
		</a>
		<a href="quicklinks.jsp" class="text<%=currPage.endsWith("quicklinks.jsp") ? " active" : ""%>">
			<img src="assets/forward-fast-solid-full.svg" class="icon"> QuickLinks
		</a>
		<%
		}
		%>
	</nav>
	<%
	if (username != null) {
	%>
	<div class="sidebar-profile">
		<img src="assets/profile-photo/luffy.jpg" alt="Profile Picture" class="profile-photo" />
		<p class="text">
			<%
			String firstName = username.split("\\s+")[0];
			out.print(firstName + "<br> <span class=\"user-role\">(" + role + ")</span>");
			%>
		</p>
		<a href="server/logout.jsp" title="Logout" class="logout-btn">
			<i class="fa-solid fa-right-from-bracket" style="cursor: pointer;"></i>
		</a>
	</div>
	<% } else { %>
	<div class="sidebar-profile">
		<a href="login.jsp" class="button" style="width: 100%; text-align: center;">Login / Register</a>
	</div>
	<% } %>
</aside>
