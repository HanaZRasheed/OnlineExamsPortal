	<%@ page import="dbConnect.*"%>
	<%@ page import="java.util.*"%>
	<%
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	
		//allow access only if session exists

		if (session.getAttribute("user") == null) {
			response.sendRedirect("Login.jsp");
		} else {
			String Role = (String) session.getAttribute("Role");
			if (Role.equals("2")) {
				response.sendRedirect("Student.jsp");
			}
		}
	%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Excel Report</title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<link href="AdminStyle.css" rel="stylesheet">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</head>
<body>
	<form name="report" method="post" action="report.jsp">
		
					<table border="1">
						<thead>
							<tr>
								<th >#</th>
								<th >Student Id</th>
								<th >Student Name</th>
								<th >Grade</th>
							</tr>
						</thead>
						<tbody>
							<%
							// Set the content type of response to Excelsheet using apachi POI
							response.setContentType("application/vnd.ms-excel");
							//Content-Disposition: to download and save locally
							// inline: displayed inside a web page or as the Web page
							// filename: the name to be saved in.
							response.setHeader("Content-Disposition","inline; filename=grades.xls");
							int count = 0;
							ArrayList <Grades> gradesList=(ArrayList<Grades>)session.getAttribute("grades");
							System.out.println(gradesList);
							for (Grades grade: gradesList)	{
							%>
							<tr>
								<th scope="row"><%=++count%> </th>
								<td ><%=grade.getStudentId() %> </td>
								<td ><%=grade.getStudentName() %> </td>
								<td ><%=grade.getGrade() %> </td>
							<% }%>
							

						</tbody>
					   </table>
	</form>

</body>
</html>
