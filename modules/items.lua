charcoal_def = {
    id = "charcoal",
    name = "Charcoal",
    category = "resources",
    tooltip = "What you get when you use logs as fuel!",
    shop_key = false,
    shop_buy = 0,
    shop_sell = 1,
}

iron_ore_def = {
    id = "iron_ore",
    name = "Iron Ore",
    category = "resources",
    tooltip = "Iron Ore, you can smelt it into iron in a furnace!",
    shop_key = false,
    shop_buy = 0,
    shop_sell = 1,
}

iron_ingot_def = {
    id = "iron_ingot",
    name = "Iron Ingot",
    category = "resources",
    tooltip = "Made by smelting iron ore with logs or charcoal!",
    shop_key = false,
    shop_buy = 0,
    shop_sell = 3,
}

iron_bar_def = {
    id = "iron_bar",
    name = "Iron Bar",
    category = "resources",
    tooltip = "Made by Hammering Iron in an Iron Workbench!",
    shop_key = false,
    shop_buy = 0,
    shop_sell = 4,
}

iron_axe_def = {
    id = "iron_axe",
    name = "Iron Axe",
    category = "Decoration",
    tooltip = "This is a iron axe!",
    shop_key = false,
    shop_buy = 0,
    shop_sell = 0,
    durability = 10000,
    singular = true
}

function addItems()
    api_define_item(charcoal_def, "sprites/resources/charcoal.png")
    api_define_item(iron_ore_def, "sprites/iron/iron_ore.png")
    api_define_item(iron_ingot_def, "sprites/iron/iron_ingot.png")
    api_define_item(iron_bar_def, "sprites/iron/iron_bar.png")
    api_define_item(iron_axe_def, "sprites/iron/iron_axe.png")
end