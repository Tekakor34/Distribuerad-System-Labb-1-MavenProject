<%@ page import="bo.ItemHandler" %>
<%
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
<html><body>
<h2>Logga in</h2><p style="color:red"><%= msg %></p>
<form method="post">
  Användare: <input name="user"><br>
  Lösenord: <input type="password" name="pass"><br>
  <input type="submit" value="Logga in">
</form>
</body></html>