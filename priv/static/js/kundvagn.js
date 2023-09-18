const order = getOrder()

generateOrderHtml(order)
addOrderInput(order)

function addOrderInput(order) {
    const orderForm = document.getElementById("order-form")    
    const orderInput = document.createElement("input")
    orderInput.setAttribute("type", "hidden")
    orderInput.setAttribute("name", "order")
    orderInput.setAttribute("value", JSON.stringify(order))
    orderForm.appendChild(orderInput)
}

function getOrder() {
    const order = localStorage.getItem("order");
    if (order) {
        return JSON.parse(localStorage.getItem("order"));
    } else {
        return []
    }
}

function generateOrderHtml(order) {
    const parent = document.getElementById("kundvagn-ul")

    order.forEach((pizza, id) => {
        const pizzaListItem = document.createElement("li")
        pizzaListItem.classList.add("kundvagn-pizza")
        parent.appendChild(pizzaListItem)
        
        const pizzaInfoDiv = document.createElement("div")
        pizzaListItem.appendChild(pizzaInfoDiv)
        
        const pizzaName = document.createElement("h1")
        pizzaName.classList.add("pizza-name")
        pizzaName.innerHTML = pizza.name
        pizzaInfoDiv.appendChild(pizzaName)
        
        if (Object.keys(pizza.ingredients).length > 0) {
            const ingredientsSubheading = document.createElement("h3")
            ingredientsSubheading.classList.add("order-subheading")
            ingredientsSubheading.innerHTML = "Ingredienser"
            pizzaInfoDiv.appendChild(ingredientsSubheading)
            
            const ingredients = document.createElement("ul")
            ingredients.classList.add("ingredients")
            pizzaInfoDiv.appendChild(ingredients)
            
            Object.entries(pizza.ingredients).filter(([key, value]) => value === true).map(([key, value]) => {
                let ingredient = document.createElement("li")
                ingredient.innerHTML = key.replaceAll("_", " ") // IS .REPLACEALL NEEDED?
                ingredients.appendChild(ingredient)
            })
        }
        
        const extrasArr = Object.entries(pizza.extras).filter(([key, value]) => value === true)
        const extrasLength = (extrasArr.length + 1) / 2

        if (extrasLength > 0) {
            const extrasSubheading = document.createElement("h3")
            extrasSubheading.classList.add("order-subheading")
            extrasSubheading.innerHTML = "Extra"
            pizzaInfoDiv.appendChild(extrasSubheading)
            
            const extras = document.createElement("ul")
            extras.classList.add("ingredients")
            pizzaInfoDiv.appendChild(extras)
            
            Object.entries(pizza.extras).filter(([key, value]) => value === true).map(([key, value]) => {
                let extra = document.createElement("li")
                extra.innerHTML = key.replaceAll("_", " ")
                extras.appendChild(extra)
            })
        }
        
        const buttonWrapper = document.createElement("div")
        buttonWrapper.classList.add("pizza-button-wrapper")
        pizzaListItem.appendChild(buttonWrapper)
        
        const customizeButton = document.createElement("button")
        customizeButton.classList.add("button-anpassa")
        customizeButton.setAttribute("type", "submit")
        customizeButton.innerHTML = "Anpassa"
        buttonWrapper.appendChild(customizeButton)
        customizeButton.addEventListener("click", () => {
            window.location = `/anpassa/${id}`
        })

        const removeButton = document.createElement("button")
        removeButton.classList.add("button-tabort")
        removeButton.setAttribute("type", "submit")
        removeButton.innerHTML = "Ta Bort"
        buttonWrapper.appendChild(removeButton)
        removeButton.addEventListener("click", () => {
            removePizza(order, id)
            window.location = "/kundvagn"
        })
    })
}

function removePizza(order, id) {
    order.splice(id, 1)
    localStorage.setItem("order", JSON.stringify(order))
}
