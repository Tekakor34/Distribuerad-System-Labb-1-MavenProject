<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" import="bo.ItemHandler" %>
<%
  request.setCharacterEncoding("UTF-8");

  if (session.getAttribute("user") != null) { response.sendRedirect("items.jsp"); return; }

  String u = request.getParameter("user"), p = request.getParameter("pass");
  String msg = "";
  if (u != null) {
    if (ItemHandler.login(u, p)) {
      session.setAttribute("user", u);
      response.sendRedirect("items.jsp");
      return;
    }
    msg = "Fel användarnamn eller lösenord";
  }
%>
<!DOCTYPE html>
<html lang="sv">
<head>
  <meta charset="UTF-8">
  <title>Logga in</title>
  <style>
     body { font-family: Arial, sans-serif; text-align: center; margin-top: 80px; }
       input { display: block; margin: 10px auto; padding: 8px; width: 220px; }
       .error { color: red; }
  </style>
</head>
<body>
  <form method="post">
    <h2>Logga in</h2>
    <% if (!msg.isEmpty()) { %><p class="error"><%= msg %></p><% } %>
    <input type="text" name="user" placeholder="Användarnamn" autofocus>
    <input type="password" name="pass" placeholder="Lösenord">
    <input type="submit" value="Logga in">
  </form>
</body>
</html>
