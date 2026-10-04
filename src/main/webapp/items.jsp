<%@ page import="bo.ItemHandler, ui.ItemInfo, java.util.*" %>


<%

  if (session.getAttribute("user") == null) {
    response.sendRedirect("index.jsp"); return;
  }

  Map<Integer,Integer> cart = (Map<Integer,Integer>) session.getAttribute("cart");
  if (cart == null) {
    cart = new HashMap<>();
    session.setAttribute("cart", cart);
    }

  String add = request.getParameter("add");
  if (add != null) {
    ItemHandler.addToCart(cart, Integer.parseInt(add));
    response.sendRedirect("items.jsp");
    return;
  }
%>

<html><body>
<h2>Varor</h2>
<table border="1">
<% for (ItemInfo i : ItemHandler.getItems()) { %>
  <tr><td><%= i.getName() %></td><td><%= i.getPrice() %> kr</td>
      <td><a href="items.jsp?add=<%= i.getId() %>">Lägg i korg</a></td></tr>
<% } %>
</table>

<h2>Din korg</h2>
<table border="1">
<% double total = 0;
   for (ItemInfo i : ItemHandler.getCartItems(cart)) {
     total += i.getPrice() * i.getQuantity(); %>
  <tr><td><%= i.getName() %></td><td><%= i.getQuantity() %> st</td>
      <td><%= i.getPrice() * i.getQuantity() %> kr</td></tr>
<% } %>
</table>
<p>Totalt: <%= total %> kr</p>
</body></html>

<html><body>
<p>Inloggad som <%= session.getAttribute("user") %> | <a href="logout.jsp">Logga ut</a></p>
<h2>Varor</h2>