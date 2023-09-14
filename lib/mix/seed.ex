defmodule Mix.Tasks.Seed do
  use Mix.Task

  @shortdoc "Resets & seeds the DB."
  def run(_) do
    Mix.Task.run("app.start")
    drop_tables()
    create_tables()
    seed_data()
  end

  defp drop_tables() do
    IO.puts("Dropping tables")
    Postgrex.query!(DB, "DROP TABLE IF EXISTS fruits", [], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "DROP TABLE IF EXISTS users", [], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "DROP TABLE IF EXISTS pizzas", [], pool: DBConnection.ConnectionPool)
  end

  defp create_tables() do
    IO.puts("Creating tables")

    Postgrex.query!(
      DB,
      "Create TABLE fruits (id SERIAL, name VARCHAR(255) NOT NULL, tastiness INTEGER NOT NULL)",
      [],
      pool: DBConnection.ConnectionPool
    )

    Postgrex.query!(
      DB,
      "CREATE TABLE pizzas (
        id SERIAL PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        Tomatsas BOOLEAN DEFAULT FALSE,
        Mozzarella BOOLEAN DEFAULT FALSE,
        Basilika BOOLEAN DEFAULT FALSE,
        Skinka BOOLEAN DEFAULT FALSE,
        Svamp BOOLEAN DEFAULT FALSE,
        Paprika BOOLEAN DEFAULT FALSE,
        Aubergine BOOLEAN DEFAULT FALSE,
        Zucchini BOOLEAN DEFAULT FALSE,
        Kronartskocka BOOLEAN DEFAULT FALSE,
        Parmesan BOOLEAN DEFAULT FALSE,
        Pecorino BOOLEAN DEFAULT FALSE,
        Gorgonzola BOOLEAN DEFAULT FALSE,
        Salami BOOLEAN DEFAULT FALSE,
        Chili BOOLEAN DEFAULT FALSE,
        Oliver BOOLEAN DEFAULT FALSE
      )",
      [],
      pool: DBConnection.ConnectionPool
    )
  end

  def insertPizza(name, opts \\ []) do
    default_ingredients = %{
      Tomatsas: false,
      Mozzarella: false,
      Basilika: false,
      Skinka: false,
      Svamp: false,
      Paprika: false,
      Aubergine: false,
      Zucchini: false,
      Kronartskocka: false,
      Parmesan: false,
      Pecorino: false,
      Gorgonzola: false,
      Salami: false,
      Chili: false,
      Oliver: false
    }

    ingredients = Map.merge(default_ingredients, Enum.into(opts, %{}))

    tomatsas = ingredients[:Tomatsas]
    mozzarella = ingredients[:Mozzarella]
    basilika = ingredients[:Basilika]
    skinka = ingredients[:Skinka]
    svamp = ingredients[:Svamp]
    paprika = ingredients[:Paprika]
    aubergine = ingredients[:Aubergine]
    zucchini = ingredients[:Zucchini]
    kronartskocka = ingredients[:Kronartskocka]
    parmesan = ingredients[:Parmesan]
    pecorino = ingredients[:Pecorino]
    gorgonzola = ingredients[:Gorgonzola]
    salami = ingredients[:Salami]
    chili = ingredients[:Chili]
    oliver = ingredients[:Oliver]

    Postgrex.query!(
      DB,
      """
      INSERT INTO pizzas(name, Tomatsas, Mozzarella, Basilika, Skinka, Svamp, Paprika, Aubergine, Zucchini, Kronartskocka, Parmesan, Pecorino, Gorgonzola, Salami, Chili, Oliver)
      VALUES($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16)
      """,
      [
        name,
        tomatsas,
        mozzarella,
        basilika,
        skinka,
        svamp,
        paprika,
        aubergine,
        zucchini,
        kronartskocka,
        parmesan,
        pecorino,
        gorgonzola,
        salami,
        chili,
        oliver
      ],
      pool: DBConnection.ConnectionPool
    )
  end

  defp seed_data() do
    IO.puts("Seeding data")

    Postgrex.query!(DB, "INSERT INTO fruits(name, tastiness) VALUES($1, $2)", ["Apple", 5],
      pool: DBConnection.ConnectionPool
    )

    Postgrex.query!(DB, "INSERT INTO fruits(name, tastiness) VALUES($1, $2)", ["Pear", 4],
      pool: DBConnection.ConnectionPool
    )

    Postgrex.query!(DB, "INSERT INTO fruits(name, tastiness) VALUES($1, $2)", ["Banana", 7],
      pool: DBConnection.ConnectionPool
    )

    insertPizza("Margherita", Tomatsas: true, Mozzarella: true, Basilika: true)

    insertPizza("Capricciosa",
      Tomatsas: true,
      Mozzarella: true,
      Skinka: true,
      Svamp: true,
      kronartskocka: true
    )

    insertPizza("Marinara", Tomatsas: true)

    insertPizza("Quattro formaggi",
      Tomatsas: true,
      Mozzarella: true,
      Parmensan: true,
      Pecorino: true,
      Gorgonzola: true
    )

    insertPizza("Prosciutto e funghi",
      Tomatsas: true,
      Mozzarella: true,
      Skinka: true,
      Svamp: true
    )

    insertPizza("Ortolana",
      Tomatsas: true,
      Mozzarella: true,
      Paprika: true,
      Aubergine: true,
      Zucchini: true
    )

    insertPizza("Quattro stagioni",
      Tomatsas: true,
      Mozzarella: true,
      Skinka: true,
      Svamp: true,
      Kronartskocka: true,
      Oliver: true
    )

    insertPizza("Diavola",
      Tomatsas: true,
      Mozzarella: true,
      Salami: true,
      Paprika: true,
      Chili: true
    )
  end
end
