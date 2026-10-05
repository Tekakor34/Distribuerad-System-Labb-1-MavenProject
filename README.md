# Webshop – Distribuerade System, Labb 1

En enkel webbshop byggd med JSP, Java, Maven, Tomcat och MySQL. Användare loggar in, lägger varor i en shoppingkorg och tittar på korgen. Lösningen är uppdelad i en 3-lagersarkitektur.

## Funktioner

- Inloggning med användarnamn och lösenord (sessionshantering)
- Lista över varor
- Lägga varor i korgen (samma vara flera gånger ökar antalet)
- Visa korgen med antal, à-pris, summa per rad och totalsumma
- Tömma korgen
- Utloggning
- Korgen sparas i databasen per användare

## Teknik

| Del | Version |
|---|---|
| Java (JDK) | 24 (kompileras för Java 17, se `pom.xml`) |
| Byggverktyg | Maven |
| Webbserver | Apache Tomcat 11 |
| Servlet-API | Jakarta Servlet 6.1 |
| Databas | MySQL Server 9.5 |
| JDBC-drivrutin | `mysql-connector-j` 9.4.0 |

## Arkitektur

Anropen går bara neråt: presentation → affärslogik → data.

| Lager | Filer | Ansvar |
|---|---|---|
| Presentation | `index.jsp`, `items.jsp`, `cart.jsp`, `logout.jsp`, `ui/ItemInfo` | Visar sidor och tar emot indata |
| Affärslogik | `bo/ItemHandler`, `bo/Item` | Regler och mellanled mellan sidor och databas |
| Data | `db/ItemDB`, `db/DBManager` | All SQL och databasanslutning |

JSP-sidorna anropar bara `ItemHandler` och pratar aldrig med databasen direkt. All SQL finns i `ItemDB`, och alla frågor använder `PreparedStatement`.

### Projektstruktur

```
src/main
├── java
│   ├── bo
│   │   ├── Item.java
│   │   └── ItemHandler.java
│   ├── db
│   │   ├── DBManager.java
│   │   └── ItemDB.java
│   └── ui
│       └── ItemInfo.java
└── webapp
    ├── WEB-INF/web.xml
    ├── index.jsp      (inloggning)
    ├── items.jsp      (varor)
    ├── cart.jsp       (korgen)
    └── logout.jsp     (utloggning)
```

### Flöde: lägga en vara i korgen

1. Användaren klickar på "Lägg i korg" (`items.jsp?add=3`).
2. `items.jsp` anropar `ItemHandler.addToCart(user, 3)`.
3. `ItemHandler` kontrollerar via `ItemDB.getItem(3)` att varan finns.
4. `ItemDB.addToCart` kör `INSERT ... ON DUPLICATE KEY UPDATE quantity = quantity + 1`.
5. Sidan laddas om.

## Databas

Schemat heter `webshop` och har tre tabeller: `items`, `users` och `cart_items`. Kör följande i MySQL Workbench (markera allt och tryck Ctrl+Shift+Enter):

```sql
CREATE DATABASE IF NOT EXISTS webshop;
USE webshop;

CREATE TABLE items (
    id    INT AUTO_INCREMENT PRIMARY KEY,
    name  VARCHAR(100) NOT NULL,
    price DOUBLE NOT NULL
);

CREATE TABLE users (
    username VARCHAR(50) PRIMARY KEY,
    password VARCHAR(100) NOT NULL
);

CREATE TABLE cart_items (
    username VARCHAR(50) NOT NULL,
    item_id  INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    PRIMARY KEY (username, item_id),
    FOREIGN KEY (username) REFERENCES users(username),
    FOREIGN KEY (item_id)  REFERENCES items(id)
);

INSERT INTO items (name, price) VALUES
    ('Laptop', 8999.00),
    ('Headphones', 799.00),
    ('Keyboard', 499.00),
    ('Mouse', 249.00),
    ('Monitor', 2499.00);

INSERT INTO users (username, password) VALUES
    ('test', 'test123'),
    ('admin', 'admin123');
```

Den sammansatta primärnyckeln `(username, item_id)` i `cart_items` krävs för att `ON DUPLICATE KEY UPDATE` ska kunna öka antalet i stället för att skapa en ny rad.

### Anslutningsuppgifter

Anslutningen konfigureras i `src/main/java/db/DBManager.java`:

- URL: `jdbc:mysql://localhost:3306/webshop`
- Användare: `root`
- Lösenord: det lösenord du valde vid installationen av MySQL (ändra konstanten `PASS` om det skiljer sig)

## Köra projektet

1. Starta MySQL (Windows-tjänsten `MySQL95` ska vara "Running") och skapa databasen enligt ovan.
2. Bygg WAR-filen med Maven: `Lifecycle → package` (eller `mvn package`). Filen hamnar i `target/webshop.war`.
3. Stoppa Tomcat om den körs, och ta bort gammal `webshop.war` och mappen `webshop` i Tomcats `webapps`-mapp.
4. Kopiera `webshop.war` till Tomcats `webapps`-mapp.
5. Starta Tomcat (`bin/startup.bat` på Windows). `JAVA_HOME` måste peka på din JDK.
6. Öppna <http://localhost:8080/webshop/>.

### Testanvändare

| Användarnamn | Lösenord |
|---|---|
| `test` | `test123` |
| `admin` | `admin123` |

## Kända begränsningar

- Lösenord lagras i klartext i tabellen `users`. En riktig webbshop skulle hasha dem (t.ex. med bcrypt).
- Databasuppgifterna står direkt i koden i `DBManager`, inte i en konfigurationsfil.
- Varje databasanrop öppnar en ny anslutning. Ingen connection pool används.
- `getCartItems` gör en databasfråga per vara i korgen. Det kunde lösas med en enda `JOIN`.
- Ingen hantering av betalning eller beställning.

## Medlemmar
Alf Maximillian Cardinaux,
Robin Bagcivanci
