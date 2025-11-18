<%@ page import="java.sql.*, java.util.*" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="server/authCheck.jsp"%>
<%@ include file="server/DBConnection.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Contact Us</title>

<!-- Global CSS and JS -->
<jsp:include page="Templates/HeadMeta.jsp" />

<script type="module" src="js/contactForm.js"></script>

</head>
<body>
	<!-- Sidebar -->
	<jsp:include page="Templates/Header.jsp" />

	<!-- Main Content -->
	<main class="main-content">
		<div class="row page-heading">
			<h2 class="heading">Feedback/Contact</h2>
		</div>
		
		<section class="section">
			<div class="row">
				<div class="column col-no-padding">
					<!-- Contact Form -->
					<div id="contact-form">
						<form id="contactForm" class="form">
							<div class="form-group full">
								<label for="name" class="label">Name<span class="required-star">*</span></label> <input type="text" id="name" class="input" name="name" placeholder="Your Name" required />
							</div>

							<div class="form-group full">
								<label for="email" class="label">Email<span class="required-star">*</span></label> <input type="email" id="email" class="input" name="email" placeholder="Your Email" required/>
							</div>

							<div class="form-group full">
								<label for="subject" class="label">Subject<span class="required-star">*</span></label> <input type="text" id="subject" class="input" name="subject"
									placeholder="Subject of your message" required />
							</div>

							<div class="form-group full">
								<label for="message" class="label">Message<span class="required-star">*</span></label>
								<textarea id="message" class="input" name="message" placeholder="Write your message here..." rows="5" required></textarea>
							</div>

							<button type="submit" class="f-btn full">Send Message</button>
						</form>
					</div>
				</div>
			</div>
		</section>
	</main>


</body>
</html>