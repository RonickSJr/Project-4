<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ResourceBundle"%>

<%@ page import="jakarta.servlet.*"%>
<%@ page import="jakarta.servlet.http.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>



<!DOCTYPE html>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.FileReader"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.util.ResourceBundle"%>

<%
String firstName = (String) session.getAttribute("firstName");
String message = (String) session.getAttribute("message");

String user = (String) session.getAttribute("user");
String pass = (String) session.getAttribute("pass");

if (message == null)
	message = " ";

ResourceBundle resource = ResourceBundle.getBundle("root");
String prop1u = resource.getString("username");
String prop1p = resource.getString("password");



%>



<html>
<head>
<meta charset="UTF-8" />
<title>Root Test</title>
<style>
body {
	background-color: #2d4059;
	font-family: 'Arial', sans-serif;
	color: #e5e5e5;
	margin: 0;
	padding: 0;
}

.topHeader {
	color: #ea5455;
}

.topSection {
	display: flex;
	flex-direction: column;
	align-content: center;
	align-items: center;
	color: #e5e5e5;
	margin: 20px;
}

hr {
	display: block;
	margin: 20px auto;
	height: 2px;
	border: 0;
	border-top: 2px solid #e5e5e5;
}

.inLine {
	color: #f07b3f;
}

.queryEntry {
	display: block;
	position: relative;
	align-content: center;
	align-items: center;
	width: 70%;
	margin: 20px auto;
}

#buttonContainer {
	display: flex;
	flex-direction: row;
	justify-content: center;
	width: 100%;
	margin-top: 20px;
}

.queryButton {
	margin-inline: 15px;
	background-color: #4f97a3;
	border: none;
	color: #2d4059;
	font-family: 'Arial', sans-serif;
	margin-top: 25px;
	cursor: pointer;
	padding: 10px 20px;
	border-radius: 5px;
}

.databaseResSection {
	display: block;
	margin-top: 50px;
	text-align: center;
	margin: 20px;
}
</style>
</head>
<body>
	<section class="topSection">
		<h1 class="topHeader">Welcome to 2023 Project 4 Enterprise
			Database System</h1>
		<h2>A Servlet/JSP-based Multi-tiered Enterprise Application Using
			a Tomcat Container</h2>
	</section>
	<hr>
	<section class="topSection">
		<h4>
			You are connected to the Project 4 Enterprise System as a <span
				class="inLine">${user}-level</span> user.
		</h4>
		<h4>Please enter any valid SQL query or update below:</h4>
	</section>
	<section class="queryEntry">
		<form action="/Project4Assignment/BaseUser" method="post">
			<textarea name="sqlStatement" type="text"
				style="width: 100%; height: 250px; margin: 20px 0;"
				value="select * from test;"></textarea>
			<section id="buttonContainer">
				<input class="queryButton" name="exec" type="submit"
					value="Execute Command" /> <input class="queryButton" name="reset"
					type="reset" value="Reset" /> <input class="queryButton"
					name="clear" type="submit" value="Clear Results" />
			</section>
		</form>
	</section>
	<section class="databaseResSection">
		<h4>All execution results will appear below this line:</h4>
		<hr>
		<h3>Database Results:</h3>
		<%=message%>
	</section>
</body>
</html>
