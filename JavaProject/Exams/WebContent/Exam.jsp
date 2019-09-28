<%@ page import="dbConnect.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>


<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

	//allow access only if session exists
	String Role = (String) session.getAttribute("Role");
	if (session.getAttribute("user") == null) {
		response.sendRedirect("Login.jsp");
	} else {
		if (Role.equals("1")) {
			response.sendRedirect("Admin.jsp");
		}
	}

	Question objQ = new Question();
	Answers objAnswer = new Answers();
	int index = 0;
	// get the questionsList from student servlet 
	List<Question> questionsList = (List<Question>) request.getSession().getAttribute("QList");
	List<Answers> answersList = new ArrayList<Answers>();

	if (questionsList != null && questionsList.size() > 0) {
		// to index hidden field that has the index of the questions List
		String x = request.getParameter("to");
		//  get the question of index 0
		if (x == null) {
			objQ = questionsList.get(0);
			index = 0;
			// set the hidden field with index value=0
			request.setAttribute("value", index);
		} else {
			// get the index not equal zero
			index = Integer.parseInt(request.getParameter("to"));
			// get the  checked radio button value by name is Answer
			String ans = request.getParameter("Answer");
			// check if there is a selected answer for the question
			if (ans != null) {
				// get the corresponding answers options for each question according to the index
				for (int i = 0; i < questionsList.get(index).getAnswers().size(); i++) {
					// get the id of the selected answer and set checked to true
					if (questionsList.get(index).getAnswers().get(i).getAID() == Integer.parseInt(ans)) {
						questionsList.get(index).getAnswers().get(i).setChecked(true);
						/* Check the selected radio button value is true or false and check if it is the coreect answer
						 if true then set Result=true;
						else set result = false; */
						if (questionsList.get(index).getAnswers().get(i).getChecked() == true
								&& questionsList.get(index).getAnswers().get(i).getIsCorrect() == 1) {

							questionsList.get(index).setResult(true);

						} else {
							questionsList.get(index).setResult(false);

						}
					} else { // other options are not checked 
						questionsList.get(index).getAnswers().get(i).setChecked(false);

					}

				}
				// Store the Qlist in a session with checked answers
				request.getSession().setAttribute("QList", questionsList);
			}
			// when next is pressed then increment the index by 1 and store the value of the index
			if (request.getParameter("Next") != null) {
				index = index + 1;
				objQ = questionsList.get(index);
				request.setAttribute("value", index);
				// when previous is pressed then decrement the index by 1 and store the value of the index
			} else if (request.getParameter("Previous") != null) {
				index = index - 1;
				objQ = questionsList.get(index);
				request.setAttribute("value", index);
				// when finish is pressed redirect to grades.jsp page and set index to zero
			} else if (request.getParameter("Finish") != null) {
				index = 0;
				objQ = questionsList.get(index);
				request.setAttribute("value", index);
				response.sendRedirect("grades.jsp");
			}
		}
	}
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>



<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Exam Page</title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">

<link href="ExamStyle.css" rel="stylesheet">
<script
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
	<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous">
</script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
	integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
	crossorigin="anonymous"></script>
<script src="https://unpkg.com/gijgo@1.9.13/js/gijgo.min.js"
	type="text/javascript"></script>
<link href="https://unpkg.com/gijgo@1.9.13/css/gijgo.min.css"
	rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">


<script type="text/javascript">
<!-- Prevent copy paste of the exam -->
	$(document).ready(function() {
		$('body').bind('copy paste', function(e) {
			e.preventDefault();
		});
	});
</script>

</head>
<body>

	<nav class="navbar navbar-light" style="background-color: #eee7ef;">
		<div class="container-fluid">

			<div class="collapse navbar-collapse navbar-light " id="myNavbar"
				style="background-color: #eee7ef;">
				<ul class="nav navbar-nav navbar-light"
					style="background-color: #eee7ef;">
					<li><img src="/static/HomePage.jpg" height="40px" width="40px">
					</li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li class="username"><%=session.getAttribute("userName")%></li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="row content">
		<form name="#" method="post" autocomplete="off">

			<div class="container contact">


				<div class="row">
					<div class="col-md-2"></div>
					<!-- Orange part -->
					<div class="col-md-9">


						<div class="contact-form">

							<h2>
								<!--  Questions Text -->
								<span class="label label-primary d-flex justify-content-between"
									id="<%=objQ.getID()%>"> <%=index + 1%>) <%=objQ.getText()%>
								</span>
							</h2>
							<!--  hidden filed name is "to" value of index -->
							<input id="index" type="hidden" name="to" value="${value}">

							<input type="hidden" name="<%=objQ.getText()%>"
								value="<%=objQ.getID()%>">


							<div class="answerContainer">
								<div class="Answer">
									<input type="radio" name="Answer"
										value="<%=objQ.getAnswers().get(0).getAID()%>"
										<%=objQ.getAnswers().get(0).getChecked() ? "checked" : ""%>>
									<%=objQ.getAnswers().get(0).getAnswerText()%>
								</div>
								<div class="Answer">
									<input type="radio" name="Answer"
										value="<%=objQ.getAnswers().get(1).getAID()%>"
										<%=objQ.getAnswers().get(1).getChecked() ? "checked" : ""%>>
									<%=objQ.getAnswers().get(1).getAnswerText()%>
								</div>
								<div class="Answer">
									<input type="radio" name="Answer"
										value="<%=objQ.getAnswers().get(2).getAID()%>"
										<%=objQ.getAnswers().get(2).getChecked() ? "checked" : ""%>>
									<%=objQ.getAnswers().get(2).getAnswerText()%>
								</div>
								<div class="Answer">
									<input type="radio" name="Answer"
										value="<%=objQ.getAnswers().get(3).getAID()%>"
										<%=objQ.getAnswers().get(3).getChecked() ? "checked" : ""%>>
									<%=objQ.getAnswers().get(3).getAnswerText()%>

								</div>
							</div>


							<%
								// if the last element is reached hide the next button and show Finish button
								if (index == questionsList.size() - 1) {
							%>
							<div class=col-sm-10">
								<input type="submit" name="Finish" id="FinishExam"
									class=" col-sm-offset-4 btn btn-primary float-right"
									value="Finish Exam">

								<%
									} else {
								%>
								<!--  the next button is shown -->
								<input type="submit" name="Next"
									class=" col-sm-offset-4 btn btn-primary float-right"
									id="nextButton" value=" Next ">

								<%
									}
								%>
								<%
									if (index == 0) {
								%>
								<!--  hide previos button on the first question -->
								<input type="submit" name="Previous" id="Previous"
									class="col-sm-offset-0 btn btn-primary float-left"
									value="previous" style="display: none">


								<%
									} else {
								%>


								<input type="submit" name="Previous" id="Previous"
									class=" col-sm-offset-0 btn btn-primary float-left"
									value="previous">
								<!-- set buttontoleftside by adding this to the tag  mid-center -->
							</div>



							<%
								}
							%>

						</div>
					</div>
				</div>

			</div>

		</form>
	</div>

</body>
</html>