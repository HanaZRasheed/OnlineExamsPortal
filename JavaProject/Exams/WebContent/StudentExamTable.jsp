<%@ page import="dbConnect.*"%>
<%@ page import="java.sql.*"%>
<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

	//allow access only if session exists
	String Role = (String) session.getAttribute("Role");
	if (session.getAttribute("user") == null) {
		response.sendRedirect("Login.jsp");
	} else {
		if (Role.equals("1")) {
			response.sendRedirect("AdminHome.jsp");
		}
	}

	DBConnection c = new DBConnection();
	Connection con = null;
	con = c.getConnection();
	Statement statement = con.createStatement();
	Statement examDataStatement = con.createStatement();
	// select the exams of the student that he has to do
	ResultSet resultset = statement.executeQuery(
			"select ExamName,ExamId from Privilege where flag=1 and UserID= " + session.getAttribute("userID"));
	System.out.println("userId in privilege " + session.getAttribute("userID"));
	ResultSet examData = null;
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Student Exams</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<link href='AdminStyle.css' rel='stylesheet' />
<link href="StudentExamsTableStyle.css" rel='stylesheet' />
<title>Exams Table</title>


</head>
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
					<li><a href="StudentHome.jsp">Home</a></li>
					<li><a href="StudentExamTable.jsp">Exams Table</a></li>
					<li><a href="StudentGrade.jsp">Grades</a></li>
					<li><a href="StudentExam.jsp">Exams </a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li class="username"><%=session.getAttribute("userName")%></li>
					<li><a href="Logout.jsp"><span
							class="glyphicon glyphicon-log-out"></span> Logout</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="container contact">
		<div class="row">
			<div class="col-md-3">
				<img src="/static/examsTable.jpg" height="350px" width="250px" />
			</div>
			<div class="col-md-9 text-center">
				<h3 Style="color: #337ab7">Exams Table</h3>
				<table class="table table-bordered">
					<thead>
						<tr>
							<th scope="col">#</th>
							<th scope="col">Exam Name</th>
							<th scope="col">Exam Date</th>
							<th scope="col">Exam Time</th>
						</tr>

					</thead>
					<tbody>
						<%
							int count = 0;
							while (resultset.next()) {
						%>
						<tr>
							<td scope="row"><%=++count%></td>
							<td name="examName"><%=resultset.getString("examName")%></td>

							<%
								int examID = resultset.getInt("ExamID");

									examData = examDataStatement
											.executeQuery("Select ExamDate,ExamStartTime from Exams where examID = " + examID);
									while (examData.next()) {
							%>
							<td><%=examData.getString("ExamDate")%></td>
							<td><%=examData.getString("ExamStartTime")%></td>

							<%
								}
							%>

						</tr>
						<%
							}
						%>

					</tbody>
				</table>
				<input type="hidden" name="ExamID"
					value=<%=session.getAttribute("ExamID")%>>

			</div>
		</div>
</body>