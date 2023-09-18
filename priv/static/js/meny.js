function getOrder() {
  const order = localStorage.getItem("order");
  if (order) {
    return JSON.parse(localStorage.getItem("order"));
  } else {
    return [];
  }
}

function anpassa(buttonElement) {
  let pizzaJson = buttonElement.getAttribute("data-pizza");
  let pizza = JSON.parse(pizzaJson);
  order = getOrder();
  const current_pizza = {
    name: pizza.name,
    ingredients: {
      tomatsas: pizza.tomatsas,
      mozzarella: pizza.mozzarella,
      basilika: pizza.basilika,
      skinka: pizza.skinka,
      svamp: pizza.svamp,
      paprika: pizza.paprika,
      aubergine: pizza.aubergine,
      zucchini: pizza.zucchini,
      kronartskocka: pizza.kronartskocka,
      parmesan: pizza.parmesan,
      pecorino: pizza.pecorino,
      gorgonzola: pizza.gorgonzola,
      salami: pizza.salami,
      chili: pizza.chili,
      oliver: pizza.oliver,
    },
    extras: { Familjestorlek: false, Glutenfritt: false },
  };
  order.push(current_pizza);

  localStorage.setItem("order", JSON.stringify(order));

  let lastindex = order.length - 1;

  console.log(localStorage.getItem("order"));

  return (window.location.href = `/anpassa/${lastindex}`);
}

function laggIKundvagn(buttonElement) {
  let pizzaJson = buttonElement.getAttribute("data-pizza");
  let pizza = JSON.parse(pizzaJson);
  order = getOrder();
  const current_pizza = {
    name: pizza.name,
    ingredients: {
      tomatsas: pizza.tomatsas,
      mozzarella: pizza.mozzarella,
      basilika: pizza.basilika,
      skinka: pizza.skinka,
      svamp: pizza.svamp,
      paprika: pizza.paprika,
      aubergine: pizza.aubergine,
      zucchini: pizza.zucchini,
      kronartskocka: pizza.kronartskocka,
      parmesan: pizza.parmesan,
      pecorino: pizza.pecorino,
      gorgonzola: pizza.gorgonzola,
      salami: pizza.salami,
      chili: pizza.chili,
      oliver: pizza.oliver,
    },
    extras: { Familjestorlek: false, Glutenfritt: false },
  };
  order.push(current_pizza);

  localStorage.setItem("order", JSON.stringify(order));

  return window.location.reload();
}
