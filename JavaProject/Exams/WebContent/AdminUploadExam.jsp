<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="dbConnect.*"%>
<%@ page import="java.sql.*"%>
<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

	//allow access only if session exists
	String Role = (String) session.getAttribute("Role");
	if (session.getAttribute("user") == null) {
		response.sendRedirect("Login.jsp");
	} else {
		if (Role.equals("2")) {
			response.sendRedirect("StudentHome.jsp");
		}
	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Upload Exam Page</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link href="AdminStyle.css" rel="stylesheet">

</style>
<body>
	<nav class="navbar navbar-light" style="background-color: #eee7ef;">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#myNavbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<img src="/static/HomePage.jpg" height="40px" width="40px">
			</div>
			<div class="collapse navbar-collapse navbar-light " id="myNavbar"
				style="background-color: #eee7ef;">
				<ul class="nav navbar-nav navbar-light"
					style="background-color: #eee7ef;">
					<li><a href="AdminHome.jsp">Home</a></li>
					<li><a href="AdminUploadExam.jsp">Upload Exam</a></li>
					<li><a href="admingrades.jsp">Grades</a></li>
					<li><a href="examPrivilege.jsp">Privilege </a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li class="username"><%=session.getAttribute("userName")%></li>
					<li><a href="Logout.jsp"><span
							class="glyphicon glyphicon-log-out"></span> Logout</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<div id="upload" style="margin-top: 20px; font-size: 16px;">
		<div class="container">
			<div id="upload-row"
				class="row justify-content-center align-items-center">
				<div id="upload-column" class="col-md-5 col-md-offset-3">
					<div id="upload-box" class="col-md-12">
						<form id="upload-form" class="form" action="AdminServlet"
							method="post" enctype="multipart/form-data">
							<h3 class="text-center text-info">
								Upload
								<%=session.getAttribute("ExamName")%>
								Exam
							</h3>
							<div class="form-group">
								<label for="ExamDate" class="text-info">Exam Date:</label><br>
								<input type="date" name="ExamDate" id="datepicker"
									class="form-control" Default: today todayHighlight:true
									required>
								<script>
									$('#datepicker').datepicker({
										uiLibrary : 'bootstrap'
									});
								</script>
							</div>
							<div class="form-group">
								<label for="ExamStartTime" class="text-info">Start Time:</label><br>
								<input type="time" name="ExamStartTime" id="startTime"
									class="form-control" required>
							</div>
							<div class="form-group">
								<label for="ExamEndTime" class="text-info">End Time:</label><br>
								<input type="time" name="ExamEndTime" id="endTime"
									class="form-control" required>
							</div>
							<div class="form-group">
								<label for="NumberOfQuestions" class="text-info">Number
									Of Questions:</label><br> <input type="number" name="questionNum"
									id="QuestionNum" class="form-control" min="1" max="100"
									required>
							</div>
							<div class="form-group">
								<label for="TotalMarks" class="text-info">Total Marks:</label><br>
								<input type="number" name="TotalMark" id="TotalMark"
									class="form-control" min="1" max="100" required>
							</div>
							<div class="form-group">
								<label for="UploadFile" class="text-info">Upload File:</label><br>
								<input type="file" name="fileName" id="exampleFormControlFile1"
									class="form-control" required>
							</div>
							<div class="form-group">
								<input type="submit" name="submit"
									class="btn btn-primary btn-md center-block" value="submit">
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>