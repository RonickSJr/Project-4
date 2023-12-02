
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%
    String tableContent = (String) session.getAttribute("tableContent");
    if (tableContent == null) tableContent = "null";
    String message = (String) session.getAttribute("message");
    if (message == null) message = " ";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Accountant User</title>

    <style>
        body {
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            height: 100vh;
            margin: 0;
            background-color: #f0f0f0;
        }

        div.container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            margin-bottom: 20px;
        }

        div.result-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        input[type="button"], input[type="reset"] {
            background-color: #4caf50;
            color: #fff;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="button"]:hover, input[type="reset"]:hover {
            background-color: #45a049;
        }
    </style>

    <script>
        function updateQuery() {
            var selectedOption = document.querySelector('input[name="option"]:checked');
            if (selectedOption) {
                // Set the hidden input value with the selected radio button value
                document.getElementById('query').value = selectedOption.value;
            } else {
                // No radio button selected, clear the query value
                document.getElementById('query').value = '';
            }
        }
    </script>
</head>
<body>

<div class="container">
    <h4>Accountant User</h4>
    
    <form name="yourFormName" action="/Project4Assignment/ClientUserApp" method="post">
        <!-- Options -->
    <div style="margin-bottom: 10px; display: flex; align-items: center;">
        <input type="radio" name="option" value="SELECT MAX(status) FROM suppliers" required>
        <label style="margin-left: 10px;">Get The Maximum Status Value Of All Supplier</label>
    </div>

    <div style="margin-bottom: 10px; display: flex; align-items: center;">
        <input type="radio" name="option" value="SELECT SUM(weight) FROM parts" required>
        <label style="margin-left: 10px;">Get The Total Weight Of All Parts</label>
    </div>

    <div style="margin-bottom: 10px; display: flex; align-items: center;">
        <input type="radio" name="option" value="SELECT COUNT(*) FROM shipments" required>
        <label style="margin-left: 10px;">Get The Total Number Of Shipments</label>
    </div>

    <div style="margin-bottom: 10px; display: flex; align-items: center;">
        <input type="radio" name="option" value="SELECT jname, numworkers FROM jobs ORDER BY numworkers DESC LIMIT 1" required>
        <label style="margin-left: 10px;">Get The Name And Number Of Workers Of The Job With The Most Workers</label>
    </div>

    <div style="margin-bottom: 10px; display: flex; align-items: center;">
        <input type="radio" name="option" value="SELECT sname, status FROM suppliers" required>
        <label style="margin-left: 10px;">List The Name And Status Of Every Supplier</label>
    </div>

    <!-- Hidden input to store the query value -->
    <input type="hidden" name="query" id="query" value="">
        <!-- ... (unchanged) ... -->

        

        <!-- Buttons -->
        <div style="margin-top: 20px; display: flex; align-items: center; justify-content: space-between;">
            <input type="button" onclick="updateQuery(); document.forms['yourFormName'].submit();" value="Execute command">
            <input type="reset" onclick="document.getElementById('data').innerHTML = '';" value="Clear result">
        </div>
    </form>
</div>

<!-- Result Table -->
<div class="result-container">
    <h4>Execution Result</h4>
    <table id="data">
        <p><%=message%></p>
        <%=tableContent%>
    </table>
</div>

</body>
</html>
