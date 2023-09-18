generateCustomizeHtml()

function generateCustomizeHtml() {
    const pizzaIndex = window.location.href.split("/").pop()
    let order = getOrder()
    let activePizza = order[pizzaIndex]
    let newIngredients = {}
    let newExtras = {}

    const parent = document.getElementById("customize-container")

    Object.entries(activePizza.ingredients).map(([ingredient, bool]) => {
    
        const checkboxLabel = document.createElement("label")
        checkboxLabel.classList.add("anpassaLabel")
        parent.appendChild(checkboxLabel)
        
        const checkbox = document.createElement("input")
        checkbox.setAttribute("type", "checkbox")
        if (bool) {
            checkbox.setAttribute("checked", "")
        }
        newIngredients[ingredient] = bool
        checkbox.classList.add("anpassaInput")
        checkboxLabel.appendChild(checkbox)
        checkbox.addEventListener("click", () => {
            newIngredients[ingredient] = !newIngredients[ingredient]
        })

        const ingredientElm = document.createElement("p")
        ingredientElm.innerHTML = ingredient
        checkboxLabel.appendChild(ingredientElm)
    })

    Object.entries(activePizza.extras).map(([extra, bool]) => {
        const checkboxLabel = document.createElement("label")
        checkboxLabel.classList.add("anpassaLabel")
        parent.appendChild(checkboxLabel)
        
        const checkbox = document.createElement("input")
        checkbox.setAttribute("type", "checkbox")
        if (bool) {
            checkbox.setAttribute("checked", "")
        }
        newExtras[extra] = bool
        checkbox.classList.add("anpassaInput")
        checkboxLabel.appendChild(checkbox)
        checkbox.addEventListener("click", () => {
            newExtras[extra] = !newExtras[extra]
        })

        const extraElm = document.createElement("p")
        extraElm.innerHTML = extra
        checkboxLabel.appendChild(extraElm)
    })

    const submit = document.createElement("input")
    submit.setAttribute("type", "submit")
    submit.setAttribute("value", "confirm")
    submit.addEventListener("click", () => {
        activePizza.ingredients = newIngredients
        activePizza.extras = newExtras
        order[pizzaIndex] = activePizza
        console.log(order)
        localStorage.setItem("order", JSON.stringify(order))
        window.location = "/meny"
    })
    parent.appendChild(submit)
}

function getOrder() {
    const order = localStorage.getItem("order");
    if (order) {
        return JSON.parse(localStorage.getItem("order"));
    } else {
        return []
    }
}
