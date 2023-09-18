defmodule Pluggy.Pizza do
  defstruct(
    id: nil,
    name: "",
    tomatsas: false,
    mozzarella: false,
    basilika: false,
    skinka: false,
    svamp: false,
    paprika: false,
    aubergine: false,
    zucchini: false,
    kronartskocka: false,
    parmesan: false,
    pecorino: false,
    gorgonzola: false,
    salami: false,
    chili: false,
    oliver: false
  )

  def all do
    Postgrex.query!(DB, "SELECT * FROM pizzas", [], pool: DBConnection.ConnectionPool).rows
    |> to_struct_list
  end

  defp to_struct_list(rows) do
    for [
          id,
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
        ] <- rows do
      %Pluggy.Pizza{
        id: id,
        name: name,
        tomatsas: tomatsas,
        mozzarella: mozzarella,
        basilika: basilika,
        skinka: skinka,
        svamp: svamp,
        paprika: paprika,
        aubergine: aubergine,
        zucchini: zucchini,
        kronartskocka: kronartskocka,
        parmesan: parmesan,
        pecorino: pecorino,
        gorgonzola: gorgonzola,
        salami: salami,
        chili: chili,
        oliver: oliver
      }
    end
  end
end
