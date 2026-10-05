package bo;

import db.ItemDB;
import db.ItemRecord;
import java.util.*;

public class ItemHandler {

    public static List<Item> getItems() {
        List<Item> out = new ArrayList<>();
        for (ItemRecord r : ItemDB.getAllItems())
            out.add(new Item(r.getId(), r.getName(), r.getPrice()));
        return out;
    }

    public static boolean login(String user, String pass) {
        if (user == null || user.isEmpty() || pass == null || pass.isEmpty()) return false;
        return ItemDB.checkLogin(user, pass);
    }

    // Korgen lagras i databasen (tabellen cart_items), en rad per användare och vara
    public static void addToCart(String user, int itemId) {
        if (ItemDB.getItem(itemId) != null) ItemDB.addToCart(user, itemId);
    }

    public static List<Item> getCartItems(String user) {
        List<Item> out = new ArrayList<>();
        for (Map.Entry<Integer, Integer> e : ItemDB.getCart(user).entrySet()) {
            ItemRecord r = ItemDB.getItem(e.getKey());
            if (r != null) out.add(new Item(r.getId(), r.getName(), r.getPrice(), e.getValue()));
        }
        return out;
    }

    public static void clearCart(String user) {
        ItemDB.clearCart(user);
    }
}