<%@ page import="dbConnect.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

	//allow access only if session exists

	if (session.getAttribute("user") == null) {
		response.sendRedirect("Login.jsp");
	} else {
		String Role = (String) session.getAttribute("Role");
		if (Role.equals("2")) {
			response.sendRedirect("StudentHome.jsp");
		}
	}

	List<Grades> gradesList = new ArrayList<Grades>();
	DBConnection c = new DBConnection();
	Connection con = null;
	con = c.getConnection();
	Statement statement = con.createStatement();
	Statement studentNameStatement = con.createStatement();

	ResultSet resultset = statement.executeQuery(
			"select StudentID, grades from Grade where ExamId= " + session.getAttribute("ExamID"));
	ResultSet resultsetOfStudentName = null;
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>grades</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link href="AdminGrade.css" rel="stylesheet">

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









	<form name="EditPrivilege" method="post" action="report.jsp">
		<!-- No characters are encoded. This value is required when you are using forms that have a file upload control -->
		<div class="container contact">
			<div class="row" style="margin-left: 110px">
				<div class="col-sm-10 text-center">
					<h3 Style="color: #337ab7; margin-top: 100px">Students Grades</h3>
					<table class="table table-bordered">
						<thead>


							<tr>
								<th scope="col">#</th>
								<th scope="col">Student Id</th>
								<th scope="col">Student Name</th>
								<th scope="col">Grade</th>
							</tr>

						</thead>
						<tbody>
							<%
								int count = 0;
								while (resultset.next()) {
									Grades grade = new Grades();
							%>
							<tr>
								<td scope="row"><%=++count%></td>
								<td name="StudentId"><%=resultset.getInt("StudentID")%></td>
								<%
									int StudentID = resultset.getInt("StudentID");
										resultsetOfStudentName = studentNameStatement
												.executeQuery("Select userName from users where userId = " + StudentID);
										while (resultsetOfStudentName.next()) {
								%>
								<td><%=resultsetOfStudentName.getString("userName")%></td>



								<%
									grade.setStudentName(resultsetOfStudentName.getString("userName"));
										}
								%>

								<td><%=resultset.getDouble("grades")%></td>
							</tr>
							<%
								grade.setStudentId(resultset.getInt("StudentID"));

									grade.setGrade(resultset.getInt("grades"));
									gradesList.add(grade);
								}
								// store the grades from the data base in a list 
								session.setAttribute("grades", gradesList);
							%>

						</tbody>
					</table>

					<div class="col-sm-offset-2 col-sm-10">
						<button id="startBtn" type="submit"
							class="btn btn-primary mid-center"
							style="float: right; margin-top: 50px">Extract to Excel</button>
					</div>


				</div>
			</div>
		</div>

	</form>

</body>
</html>
