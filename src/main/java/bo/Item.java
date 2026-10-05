package bo;

public class Item {
    private final int id, quantity;
    private final String name;
    private final double price;

    public Item(int id, String name, double price) {
        this(id, name, price, 1);
    }

    public Item(int id, String name, double price, int quantity) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
    }

    public int getId() { return id; }
    public String getName() { return name; }
    public double getPrice() { return price; }
    public int getQuantity() { return quantity; }
}