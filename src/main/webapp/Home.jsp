<html>
<head>
<style>
body {
  background-color: #87ceeb;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP Page</title>
</head>
<body><br/><br/><br/><br/><br/><center><h2><% String a=session.getAttribute("username").toString(); out.println("Hello "+a); %></h2><br/><br/><br/><br/><br/><br/><br/><a href="Logout.jsp">Logout</a></center></body>
</html>

<center>
 <h2>About</h2>
 <h3>Read more: https://harikrishnapalakila.com</h3>
</center>
