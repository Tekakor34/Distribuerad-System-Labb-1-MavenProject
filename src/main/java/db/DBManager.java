package db;
import java.sql.*;

public class DBManager {
    private static final String URL = "jdbc:mysql://localhost:3306/webshop?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USER = "root", PASS = "gurknisse?123";

    public static Connection getConnection() throws SQLException {
        try { Class.forName("com.mysql.cj.jdbc.Driver"); }
        catch (ClassNotFoundException e) { throw new SQLException(e); }
        return DriverManager.getConnection(URL, USER, PASS);
    }
}