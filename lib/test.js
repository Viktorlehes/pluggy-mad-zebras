const { Pool } = require("pg");

// Create a connection pool to your PostgreSQL database
const pool = new Pool({
  user: "postgres",
  host: "localhost",
  database: "postgres",
  password: "docker",
  port: 5432,
});

// Function to retrieve and format pizza data
async function getPizzaData() {
  try {
    // Query the Pizzas table to fetch all data
    const client = await pool.connect();
    const result = await client.query(
      "SELECT * FROM Pizzas WHERE name = 'margarita'"
    );
    client.release();

    console.log(result);

    // Format the data as JSON
    const bestallningar = result.rows.map((row) => {
      const pizza = {
        name: row.name,
        ingredients: {
          Tomatsås: row.tomatsås,
          Mozzarella: row.mozzarella,
          Basilika: row.basilika,
          Skinka: row.skinka,
          Svamp: row.svamp,
          Paprika: row.paprika,
          Aubergine: row.aubergine,
          Zucchini: row.zucchini,
          Kronartskocka: row.kronartskocka,
          Parmesan: row.parmesan,
          Pecorino: row.pecorino,
          Gorgonzola: row.gorgonzola,
          Salami: row.salami,
          Chili: row.chili,
          Oliver: row.oliver,
        },
      };
      return pizza;
    });

    const pizzaJSON = JSON.stringify(pizza); // The `null, 2` parameters make the output pretty-printed with 2-space indentation

    console.log(pizzaJSON);
  } catch (error) {
    console.error("Error fetching pizza data:", error);
  } finally {
    pool.end();
  }
}

getPizzaData();
