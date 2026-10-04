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
    public static void addToCart(Map<Integer,Integer> cart, int itemId) {
        if (ItemDB.getItem(itemId) != null) cart.merge(itemId, 1, Integer::sum);
    }

    public static List<ItemInfo> getCartItems(Map<Integer,Integer> cart) {
        List<ItemInfo> out = new ArrayList<>();
        for (Map.Entry<Integer,Integer> e : cart.entrySet()) {
            Item i = ItemDB.getItem(e.getKey());
            if (i != null) out.add(new ItemInfo(i.getId(), i.getName(), i.getPrice(), e.getValue()));
        }
        return out;
    }
}