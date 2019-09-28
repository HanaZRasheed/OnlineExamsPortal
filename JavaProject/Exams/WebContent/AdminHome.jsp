<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Instructor Home Page</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link href='fullcalendar.css' rel='stylesheet' />
<link href='fullcalendar.print.css' rel='stylesheet' media='print' />
<script src='jquery-1.10.2.js' type="text/javascript"></script>
<script src='jquery-ui.custom.min.js' type="text/javascript"></script>
<script src='fullcalendar.js' type="text/javascript"></script>
<script>
	$(document).ready(
			function() {
				var date = new Date();
				var d = date.getDate();
				var m = date.getMonth();
				var y = date.getFullYear();

				/*  className colors

				className: default(transparent), important(red), chill(pink), success(green), info(blue)

				 */

				/* initialize the external events
				-----------------------------------------------------------------*/

				$('#external-events div.external-event').each(function() {

					// create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
					// it doesn't need to have a start or end
					var eventObject = {
						title : $.trim($(this).text())
					// use the element's text as the event title
					};

					// store the Event Object in the DOM element so we can get to it later
					$(this).data('eventObject', eventObject);

					// make the event draggable using jQuery UI
					$(this).draggable({
						zIndex : 999,
						revert : true, // will cause the event to go back to its
						revertDuration : 0
					//  original position after the drag
					});

				});

				/* initialize the calendar
				-----------------------------------------------------------------*/

				var calendar = $('#calendar').fullCalendar(
						{
							header : {
								left : 'title',
								center : 'agendaDay,agendaWeek,month',
								right : 'prev,next today'
							},
							editable : true,
							firstDay : 1, //  1(Monday) this can be changed to 0(Sunday) for the USA system
							selectable : true,
							defaultView : 'month',

							axisFormat : 'h:mm',
							columnFormat : {
								month : 'ddd', // Mon
								week : 'ddd d', // Mon 7
								day : 'dddd M/d', // Monday 9/7
								agendaDay : 'dddd d'
							},
							titleFormat : {
								month : 'MMMM yyyy', // September 2009
								week : "MMMM yyyy", // September 2009
								day : 'MMMM yyyy' // Tuesday, Sep 8, 2009
							},
							allDaySlot : false,
							selectHelper : true,
							select : function(start, end, allDay) {
								var title = prompt('Event Title:');
								if (title) {
									calendar.fullCalendar('renderEvent', {
										title : title,
										start : start,
										end : end,
										allDay : allDay
									}, true // make the event "stick"
									);
								}
								calendar.fullCalendar('unselect');
							},
							droppable : true, // this allows things to be dropped onto the calendar !!!
							drop : function(date, allDay) { // this function is called when something is dropped

								// retrieve the dropped element's stored Event Object
								var originalEventObject = $(this).data(
										'eventObject');

								// we need to copy it, so that multiple events don't have a reference to the same object
								var copiedEventObject = $.extend({},
										originalEventObject);

								// assign it the date that was reported
								copiedEventObject.start = date;
								copiedEventObject.allDay = allDay;

								// render the event on the calendar
								// the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
								$('#calendar').fullCalendar('renderEvent',
										copiedEventObject, true);

								// is the "remove after drop" checkbox checked?
								if ($('#drop-remove').is(':checked')) {
									// if so, remove the element from the "Draggable Events" list
									$(this).remove();
								}

							},

							events : [ {
								title : 'All Day Event',
								start : new Date(y, m, 1)
							}, {
								id : 999,
								title : 'Java Exam',
								start : new Date(y, m, d - 3, 16, 0),
								allDay : false,
								className : 'info'
							}, {
								id : 999,
								title : 'English Assignment',
								start : new Date(y, m, d + 4, 16, 0),
								allDay : false,
								className : 'info'
							}, {
								title : 'Java Project',
								start : new Date(y, m, d, 10, 30),
								allDay : false,
								className : 'important'
							}, {
								title : 'Soft Skills Presentation',
								start : new Date(y, m, d, 12, 0),
								end : new Date(y, m, d, 14, 0),
								allDay : false,
								className : 'important'
							}, {
								title : 'Interview',
								start : new Date(y, m, d + 1, 19, 0),
								end : new Date(y, m, d + 1, 22, 30),
								allDay : false,
							},

							],
						});

			});
</script>
<style>
/* Remove the navbar's default margin-bottom and rounded borders */
.navbar {
	margin-bottom: 0;
	border-radius: 0;
}

a {
	font-size: 16px;
	font-weight: bold;
}

/* Set height of the grid so .sidenav can be 100% (adjust as needed) */
.row.content {
	height: 450px
}

/* Set gray background color and 100% height */
.sidenav {
	padding-top: 20px;
	background-color: #f1f1f1;
	height: 100%;
}

/* Set black background color, white text and some padding */
footer {
	background-color: #;
	color: #337ab7;
	font-weight: bold;
	padding: 15px;
}

/* On small screens, set height to 'auto' for sidenav and grid */
@media screen and (max-width: 767px) {
	.sidenav {
		height: auto;
		padding: 15px;
	}
	.row.content {
		height: auto;
	}
}

ul.nav a:hover {
	background-color: #f7f3f7;
}

.sidenav {
	background-color: #ffffff;
}

.color {
	background-color: #e1e1e1;
}
</style>
<style>
body {
	text-align: center;
	font-size: 14px;
	font-family: "Helvetica Nueue", Arial, Verdana, sans-serif;
	background-color: #FFFFFF;
}

#wrap {
	width: 1100px;
	margin: 0 auto;
}

#external-events {
	float: left;
	width: 150px;
	padding: 0 10px;
	text-align: left;
}

#external-events h4 {
	font-size: 16px;
	margin-top: 0;
	padding-top: 1em;
}

.external-event { /* try to mimick the look of a real event */
	margin: 10px 0;
	padding: 2px 4px;
	background: #3366CC;
	color: #fff;
	font-size: .85em;
	cursor: pointer;
}

#external-events p {
	margin: 1.5em 0;
	font-size: 11px;
	color: #666;
}

#external-events p input {
	margin: 0;
	vertical-align: middle;
}

#calendar {
	/* 		float: right; */
	margin: 0 auto;
	width: 900px;
	background-color: #FFFFFF;
	border-radius: 6px;
	box-shadow: 0 1px 2px #C3C3C3;
}

footer {
	color: eee7ef;
}

.username {
	padding-top: 15px;
	padding-bottom: 15px;
	line-height: 20px;
	font-size: 16px;
	font-weight: bold;
	color: #337ab7;
	text-decoration: none;
}

.links {
	background-color: #337ab7;
}
</style>
</head>

<%@ page import="dbConnect.*"%>
<%@ page import="java.sql.*"%>


<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
%>

<%
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

	<div class="container-fluid text-center">
		<div class="row content">

			<div class="col-sm-2 sidenav" Style="margin-top: 70px;">
				<h3>
					<span class=" label label-primary"> Some Useful Links </span>
				</h3>
				<p>
					<a href="https://www.w3schools.com/">W3Schools</a>
				</p>
				<p>
					<a href="https://www.wikipedia.org/">wikipedia </a>
				</p>
				<p>
					<a href="#"></a>
				</p>


			</div>
			<div class="col-sm-10 text-center">
				<h1></h1>
				<div id='calendar'></div>

				<div style='clear: both'></div>
				<hr>


			</div>

		</div>

	</div>

	<footer class="page-footer font-small indigo"
		style="background-color: #eee7ef">
		<div class="footer-copyright text-center py-3">
			© 2018 Copyright: <a
				href="https://mdbootstrap.com/education/bootstrap/">
				MDBootstrap.com</a>
		</div>
	</footer>


</body>
</html>
