<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<link href="LoginStyle.css" rel="stylesheet">
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="Login.js">
	
</script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<title>Exams Login page</title>
</head>
<body>
	<!-- Login page where user fills his/her user name and password -->
	<form name="loginForm" method="post" action="LoginServlet">
		<div class="register-info-box">
			<img src="/static/HomePage.jpg" height="600" width="600" />
		</div>
		<div class="white-panel">
			<div class="login-show">
				<h2 class="fontColor">LOGIN</h2>
				<input type="text" placeholder="Username" name="username" required
					maxlength="20" autocomplete="off"> <input type="password"
					placeholder="Password" name="password" required maxlength="20">

				<input type="submit" value="Login" class=" btn buttoncolor">

			</div>
		</div>
	</form>

</body>
</html>