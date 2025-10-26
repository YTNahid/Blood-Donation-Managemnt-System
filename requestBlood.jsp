<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat"%>
<%@ include file="server/authCheck.jsp"%>
<%@ include file="server/DBConnection.jsp"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Request for Blood</title>

    <!-- Global CSS and JS -->
    <jsp:include page="Templates/HeadMeta.jsp" />

    <link rel="stylesheet" href="css/requestBlood.css" />
    <script type="module" src="js/BloodRequestInfo.js"></script>
</head>
<body>
    <!-- Sidebar -->
    <jsp:include page="Templates/Header.jsp" />

    <!-- Main Content -->
    <main id="blood-request-page" class="main-content">

        <!-- Page Heading -->
        <div class="row page-heading">
            <h2 class="heading">Request Blood</h2>
            <a href="requestBloodForm.jsp" class="button">Send Request</a>
        </div>

        <!-- Recent Requests Section -->
        <section class="section section-recent">
            <div class="row">
                <div class="column col-no-padding no-gap">

                    <!-- Filter Form -->
                    <form id="filterForm" class="filter">
                        <label class="label">
                            Blood Group:
                            <select id="bloodGroupSelect" name="blood_group" class="input">
                                <option value="">All</option>
                                <option value="A+">A+</option>
                                <option value="A-">A-</option>
                                <option value="B+">B+</option>
                                <option value="B-">B-</option>
                                <option value="AB+">AB+</option>
                                <option value="AB-">AB-</option>
                                <option value="O+">O+</option>
                                <option value="O-">O-</option>
                            </select>
                        </label>

                        <label class="label">
                            <input type="checkbox" id="ownCheckbox" name="own" />
                            Show Own Requests
                        </label>

                        <label class="label">
                            <input type="checkbox" id="nearbyCheckbox" name="nearby" />
                            Nearby
                        </label>

                        <label class="label">
                            <input type="checkbox" id="urgentCheckbox" name="urgent" />
                            Urgent Only
                        </label>

												<label class="label">
														Search ID: 
                            <input type="number" id="searchRequestId" name="searchRequestId" class="input" />
                        </label>
                    </form>

                    <!-- Requests List -->
                    <div id="blood-requests-list" class="column col-no-padding">
                        Loading Requests...
                    </div>

                </div>
            </div>
        </section>
    </main>
</body>
</html>
