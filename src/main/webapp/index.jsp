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
    body { margin: 0; height: 100vh; display: flex; justify-content: center; align-items: center;
           font-family: Arial, sans-serif; background: #f2f4f8; }
    form { width: 280px; padding: 30px; background: #fff; border-radius: 8px;
           box-shadow: 0 2px 10px rgba(0,0,0,0.15); }
    h2 { margin: 0 0 20px; text-align: center; }
    input { width: 100%; padding: 9px; margin-bottom: 14px; box-sizing: border-box; font-size: 15px; }
    input[type=submit] { background: #2d6cdf; color: #fff; border: 0; border-radius: 4px; cursor: pointer; }
    .error { color: #c00; text-align: center; margin: 0 0 14px; }
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
