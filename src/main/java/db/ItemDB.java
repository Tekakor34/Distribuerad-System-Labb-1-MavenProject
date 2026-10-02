package db;
import bo.Item;
import java.sql.*;
import java.util.*;

public class ItemDB {
    public static List<Item> getAllItems() {
        List<Item> list = new ArrayList<>();
        try (Connection c = DBManager.getConnection();
             PreparedStatement ps = c.prepareStatement("SELECT id, name, price FROM items");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next())
                list.add(new Item(rs.getInt("id"), rs.getString("name"), rs.getDouble("price")));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public static Item getItem(int id) {
        try (Connection c = DBManager.getConnection();
             PreparedStatement ps = c.prepareStatement("SELECT id, name, price FROM items WHERE id=?")) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return new Item(rs.getInt(1), rs.getString(2), rs.getDouble(3));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public static boolean checkLogin(String user, String pass) {
        try (Connection c = DBManager.getConnection();
             PreparedStatement ps = c.prepareStatement("SELECT 1 FROM users WHERE username=? AND password=?")) {
            ps.setString(1, user);
            ps.setString(2, pass);
            try (ResultSet rs = ps.executeQuery()) { return rs.next(); }
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }
}