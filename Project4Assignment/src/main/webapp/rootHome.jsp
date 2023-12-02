<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>

<html lang="en">
<head>
<title>System Login</title>
<meta charset="UTF-8">
<style>
body {
	background-color: #2d4059;
	font-family: 'Arial', sans-serif;
	color: #e5e5e5;
	margin: 0;
	padding: 0;
}

form {
	background-color: #2d4059;
	display: flex;
	flex-direction: column;
	align-content: center;
	align-items: center;
	width: 20%;
	margin: 20px auto;
	padding: 20px;
	border: 2px solid #e5e5e5;
	border-radius: 5px;
}

label {
	color: #e5e5e5;
}

input {
	background-color: #2d4059;
	color: #e5e5e5;
	border: 1px solid #e5e5e5;
	padding: 8px;
	margin-top: 5px;
	border-radius: 3px;
	width: 100%;
	box-sizing: border-box;
}

.submit {
	background-color: #4f97a3;
	border: 1px solid #4f97a3;
	color: #2d4059;
	font-family: 'Arial', sans-serif;
	margin-top: 15px;
	cursor: pointer;
	padding: 10px;
	border-radius: 5px;
}
</style>
</head>
<body>

	<form action="/Project4Assignment/RootLevel" method="post">
		<p> 
			<center>
			<h2>Please Login:</h2>
			<br>
		</center>

		<label>Username: <input type="text" name="username" />
		</label><br> <label>Password: <input type="password"
			name="password" />
		</label><br> <input class="submit" type="submit" name="Submit" />
		</p>
		
	
	</form>

</body>
</html>