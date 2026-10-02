package ui;

public class ItemInfo {
    private int id, quantity; private String name; private double price;
    public ItemInfo(int id, String name, double price) { this(id, name, price, 1); }
    public ItemInfo(int id, String name, double price, int quantity) {
        this.id = id; this.name = name; this.price = price; this.quantity = quantity;
    }
    public int getId() { return id; }
    public String getName() { return name; }
    public double getPrice() { return price; }
    public int getQuantity() { return quantity; }
}