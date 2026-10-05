<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"
            import="bo.ItemHandler, bo.Item, java.util.*" %>
<%
  String user = (String) session.getAttribute("user");
  if (user == null) { response.sendRedirect("index.jsp"); return; }

  if (request.getParameter("clear") != null) {
    ItemHandler.clearCart(user);
    response.sendRedirect("cart.jsp");
    return;
  }

  List<Item> cartItems = ItemHandler.getCartItems(user);
  double total = 0;
%>
<!DOCTYPE html>
<html lang="sv">
<head>
  <meta charset="UTF-8">
  <title>Varukorg</title>
  <style>
 body {
    font-family: Arial, sans-serif; max-width: 600px; margin: 40px auto; }
    table { width: 100%; border-collapse: collapse; }
    th, td { padding: 8px; text-align: left; border-bottom: 1px solid #ccc; }
  </style>
</head>
<body>
  <header>
    <h1>Varukorg</h1>
    <div>Inloggad som <b><%= user %></b> | <a href="items.jsp?logout=1">Logga ut</a></div>
  </header>

  <p><a href="items.jsp">&larr; Tillbaka till produkter</a></p>

  <% if (cartItems.isEmpty()) { %>
    <p class="empty">Varukorg tom.</p>
  <% } else { %>
  <table>
    <tr><th>Namn</th><th class="num">Antal</th><th class="num">À-pris</th><th class="num">Summa</th></tr>
        <% for (Item i : cartItems) {
         double sum = i.getPrice() * i.getQuantity();
         total += sum; %>
    <tr>
      <td><%= i.getName() %></td>
      <td class="num"><%= i.getQuantity() %> st</td>
      <td class="num"><%= String.format("%.2f", i.getPrice()) %> kr</td>
      <td class="num"><%= String.format("%.2f", sum) %> kr</td>
    </tr>
    <% } %>
  </table>
  <p class="total">Total: <%= String.format("%.2f", total) %> kr</p>
  <a class="btn gray" href="cart.jsp?clear=1">Töm korgen</a>
  <% } %>
</body>
</html>