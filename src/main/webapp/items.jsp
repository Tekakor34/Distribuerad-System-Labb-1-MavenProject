<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"
            import="bo.ItemHandler, bo.Item, java.util.*" %>

<%

  String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("index.jsp");
        return;
    }

  if (request.getParameter("logout") != null) {
      session.invalidate();
      response.sendRedirect("index.jsp");
      return;
  }

  String add = request.getParameter("add");
  if (add != null) {
    try {
        ItemHandler.addToCart(user, Integer.parseInt(add));
    }
    catch (NumberFormatException e) {
        /* ogiltig id, ignoreras */
    }
    response.sendRedirect("items.jsp");
    return;
  }

     List<Item> items = ItemHandler.getItems();
        int cartCount = 0;
        for (Item c : ItemHandler.getCartItems(user)) cartCount += c.getQuantity();
  %>
<!DOCTYPE html>
<html lang="sv">
<head>
  <meta charset="UTF-8">
  <title>Webbshop</title>
  <style>
    body { font-family: Arial, sans-serif; max-width: 600px; margin: 40px auto; }
    table { width: 100%; border-collapse: collapse; }
    th, td { padding: 8px; text-align: left; border-bottom: 1px solid #ccc; }
  </style>
</head>
<body>
   <header>
     <h1>Webbshop</h1>
     <p>
       Inloggad som <b><%= user %></b> |
       <a href="cart.jsp">Visa korg (<%= cartCount %>)</a> |
       <a href="logout.jsp">Logga ut</a>
     </p>
   </header>

  <h2>Varor</h2>
  <% if (items.isEmpty()) { %>
    <p class="empty">Inga varor hittades. Kontrollera databasanslutningen (se Tomcat-loggen).</p>
  <% } else { %>
  <table>
    <tr><th>Namn</th><th class="num">Pris</th><th></th></tr>
     <% for (Item i : items) { %>
    <tr>
      <td><%= i.getName() %></td>
      <td class="num"><%= String.format("%.2f", i.getPrice()) %> kr</td>
      <td class="num"><a class="btn" href="items.jsp?add=<%= i.getId() %>">Lägg i korg</a></td>
    </tr>
    <% } %>
  </table>
  <% } %>
</body>
</html>
