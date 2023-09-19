defmodule Pluggy.Order do
  def create(params) do
    name = params["namn"]
    phone = params["telefon"]
    order = Jason.decode!(params["order"])

    result =
      Postgrex.query!(DB, "SELECT COALESCE(MAX(orderId), 0) FROM orders", [])

    prev_order_id = hd(hd(result.rows))

    order
    |> Enum.with_index()
    |> Enum.each(fn {pizza, i} ->
      IO.inspect(pizza)

      Postgrex.query!(
        DB,
        "INSERT INTO orders (pizzaId,
        orderId,
        phone,
        customerName,
        pizzaName,
        Tomatsas,
        Mozzarella,
        Basilika,
        Skinka,
        Svamp,
        Paprika,
        Aubergine,
        Zucchini,
        Kronartskocka,
        Parmesan,
        Pecorino,
        Gorgonzola,
        Salami,
        Chili,
        Oliver,
        family,
        gluten )
        VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22)",
        [
          prev_order_id + 1,
          phone,
          name,
          pizza["name"],
          pizza["ingredients"]["tomatsas"],
          pizza["ingredients"]["mozzarella"],
          pizza["ingredients"]["basilika"],
          pizza["ingredients"]["skinka"],
          pizza["ingredients"]["svamp"],
          pizza["ingredients"]["paprika"],
          pizza["ingredients"]["aubergine"],
          pizza["ingredients"]["zucchini"],
          pizza["ingredients"]["kronartskocka"],
          pizza["ingredients"]["parmesan"],
          pizza["ingredients"]["pecorino"],
          pizza["ingredients"]["gorgonzola"],
          pizza["ingredients"]["salami"],
          pizza["ingredients"]["chili"],
          pizza["ingredients"]["oliver"],
          pizza["extras"]["Familjestorlek"],
          pizza["extras"]["Glutenfritt"]
        ],
        pool: DBConnection.ConnectionPool
      )
    end)
  end
end
