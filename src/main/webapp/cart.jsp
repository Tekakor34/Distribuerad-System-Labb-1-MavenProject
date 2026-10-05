<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"
         import="bo.ItemHandler, ui.ItemInfo, java.util.*" %>
<%
  String user = (String) session.getAttribute("user");
  if (user == null) { response.sendRedirect("index.jsp"); return; }

  if (request.getParameter("clear") != null) {
    ItemHandler.clearCart(user);
    response.sendRedirect("cart.jsp");
    return;
  }

  List<ItemInfo> cartItems = ItemHandler.getCartItems(user);
  double total = 0;
%>
<!DOCTYPE html>
<html lang="sv">
<head>
  <meta charset="UTF-8">
  <title>Varukorg</title>
  <style>
    body { font-family: Arial, sans-serif; max-width: 600px; margin: 40px auto; padding: 0 15px; }
    header { display: flex; justify-content: space-between; align-items: center; }
    table { width: 100%; border-collapse: collapse; margin-bottom: 10px; }
    th, td { padding: 8px; text-align: left; border-bottom: 1px solid #ddd; }
    .num { text-align: right; }
    .btn { background: #2d6cdf; color: #fff; padding: 5px 10px; border-radius: 4px; text-decoration: none; }
    .gray { background: #777; }
    .total { text-align: right; font-weight: bold; }
    .empty { color: #777; }
  </style>
</head>
<body>
  <header>
    <h1>Cart</h1>
    <div>Inloggad som <b><%= user %></b> | <a href="items.jsp?logout=1">Logga ut</a></div>
  </header>

  <p><a href="items.jsp">&larr; Tillbaka till produkter</a></p>

  <% if (cartItems.isEmpty()) { %>
    <p class="empty">Varukorg tom.</p>
  <% } else { %>
  <table>
    <tr><th>Namn</th><th class="num">Antal</th><th class="num">À-pris</th><th class="num">Summa</th></tr>
    <% for (ItemInfo i : cartItems) {
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