<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP Page</title>
</head>
<body><% String username=request.getParameter("username"); String password=request.getParameter("password"); if((username.equals("harikrishna") && password.equals("Ma1nH00nPand1t$"))) { session.setAttribute("username",username); response.sendRedirect("Home.jsp"); } else response.sendRedirect("Error.jsp"); %></body>
</html>
