package bo;
import db.ItemDB;
import ui.ItemInfo;
import java.util.*;

public class ItemHandler {
    public static List<ItemInfo> getItems() {
        List<ItemInfo> out = new ArrayList<>();
        for (Item i : ItemDB.getAllItems()) out.add(new ItemInfo(i.getId(), i.getName(), i.getPrice()));
        return out;

    }

    public static boolean login(String user, String pass) { return ItemDB.checkLogin(user, pass); }

    // Korgen lagras i sessionen som Map<itemId, antal>
    public static void addToCart(String user, int itemId) {
        if (ItemDB.getItem(itemId) != null) ItemDB.addToCart(user, itemId);
    }

    public static List<ItemInfo> getCartItems(String user) {
        List<ItemInfo> out = new ArrayList<>();
        for (Map.Entry<Integer, Integer> e : ItemDB.getCart(user).entrySet()) {
            Item i = ItemDB.getItem(e.getKey());
            if (i != null) out.add(new ItemInfo(i.getId(), i.getName(), i.getPrice(), e.getValue()));
        }
        return out;
    }

    public static void clearCart(String user) {
        ItemDB.clearCart(user);
    }

}