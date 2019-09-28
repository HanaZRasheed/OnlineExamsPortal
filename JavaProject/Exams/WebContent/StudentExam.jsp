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
	ResultSet resultset = null;

	int examId = 0;
	String userID = (String) session.getAttribute("userID");
	resultset = statement
			.executeQuery("select ExamID, ExamName from Privilege where UserID= " + userID + " and Flag=1 ;");
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Student Home Page</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<meta charset="ISO-8859-1">
<script type="text/javascript">
	function Enable() {
		document.getElementById("startBtn").disabled = false;
	}
</script>
<link href="StudentStyle.css" rel="stylesheet">

</head>


<body>
	<form name="StudentExam" action="StudentServlet" method="post"
		autocomplete="off">
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
						<li class="active"><a href="StudentHome.jsp">Home</a></li>
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

		<div class="container-fluid text-center">
			<div class="row content">
				<div class="col-sm-2 sidenav">
					<img src="/static/Student.jpg" style="width: 100%">


				</div>
				<div class=" col-sm-6">
					<span class="border border-primary" style="font-size: 20px">
						<div class=" col-sm-offset-4 col-sm-8">
							</br>
							<ul class="list-group list-group-flush">

								<li class="list-group-item whiteFont"
									Style="background-color: #337ab7">Exams Instructions</li>
								<li class="list-group-item">Select Exam then press on
									"Start Exam"</li>
								<li class="list-group-item">You can go forward by pressing
									on "Next" button</li>
								<li class="list-group-item">You can go backward by pressing
									on "Previous" button</li>
								<li class="list-group-item">Your result will be displayed
									by the end of the Exam after you press "Finish" button</li>
							</ul>
							<!-- Start button is enabled once the student selects an exam -->
							<select onChange="Enable()" id="Exam" name="SelectExam"
								class="form-control" id="exampleFormControlSelect1 " required>
								<option name="Select Exam" selected="" disabled>Select
									Course</option>
								<%
									while (resultset.next()) {
								%>
								<option value="<%=resultset.getInt("ExamID")%>"><%=resultset.getString("ExamName")%></option>
								<%
									}
								%>
							</select>

							<button id="startBtn" type="submit"
								class="btn btn-primary mid-center" disabled="disabled">Start
								Exam</button>
						</div>



					</span>
				</div>
			</div>
		</div>
	</form>

</body>

</html>