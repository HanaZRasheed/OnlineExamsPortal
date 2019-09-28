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
		if (Role.equals("1")) {
			response.sendRedirect("AdminHome.jsp");
		}
	}

	DBConnection c = new DBConnection();
	Connection con = null;
	con = c.getConnection();
	Statement statement = con.createStatement();
	Statement examDataStatement = con.createStatement();

	ResultSet resultset = statement.executeQuery(
			"select ExamId, grades from Grade where StudentID= " + session.getAttribute("userID"));
	System.out.println("userId in privilege " + session.getAttribute("userID"));
	ResultSet examName = null;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Student Grades Page</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<link href='AdminStyle.css' rel='stylesheet' />
<link href="StudentExamsTableStyle.css" rel='stylesheet' />
<title>Student Grades</title>
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

	<div class="container-fluid text-center ">
		<div class="row content ">
			<div class="col-md-3 sidenav" style="margin-top: 50px">

				<img src="/static/girl.jpg" height="350px" width="300px" />
			</div>

			<!-- No characters are encoded. This value is required when you are using forms that have a file upload control -->
			<div class="container contact">
				<div class="row" style="margin-left: 200px">
					<div class="col-sm-10 text-center">
						<h3 Style="color: #337ab7">Grades Table</h3>
						<table class="table table-bordered ">
							<thead>


								<tr>
									<th scope="col">#</th>
									<th scope="col">Exam Name</th>
									<th scope="col">Total Grade</th>
									<th scope="col">Exam Grade</th>

								</tr>

							</thead>
							<tbody>
								<%
									int count = 0;
									while (resultset.next()) {
								%>
								<tr>
									<td scope="row"><%=++count%></td>


									<%
										int examID = resultset.getInt("ExamID");

											examName = examDataStatement
													.executeQuery("Select ExamName,TotalMark from Exams where examID = " + examID);
											while (examName.next()) {
									%>

									<td><%=examName.getString("ExamName")%></td>
									<td name="grade"><%=examName.getInt("TotalMark")%></td>
									<%
										}
									%>
									<td name="grade"><%=resultset.getDouble("grades")%></td>


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
			</div>

		</div>
	</div>


</body>
</html>