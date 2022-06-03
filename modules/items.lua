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

iron_bar_recipe = {
    { item = "ultra_item_iron_ingot", amount = 2 },
}

charred_rock_def = {
    id = "charred_rock",
    name = "Charred Rock",
    category = "resources",
    tooltip = "Made by combining rock and charcoal!",
    shop_key = false,
    shop_buy = 0,
    shop_sell = 2,
}

charred_rock_recipe = {
    { item = "ultra_item_charcoal", amount = 2 },
    { item = "stone", amount = 5 }
}

charred_rock_gear_def = {
    id = "charred_rock_gear",
    name = "Charred Rock Gear",
    category = "components",
    tooltip = "Made by crafting together charred rock and waterproofing!",
    shop_key = false,   
    shop_buy = 0,
    shop_sell = 4,
}

charred_rock_gear_recipe = {
    { item = "ultra_item_charred_rock", amount = 3 },
    { item = "waterproof", amount = 1 }
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
    singular = true,
}

iron_axe_recipe = {
    { item = "ultra_item_iron_ingot", amount = 3 },
    { item = "ultra_item_iron_bar", amount = 2 },
    { item = "ultra_item_charred_rock", amount = 3 }
}

iron_pickaxe_def = {
    id = "iron_pickaxe",
    name = "Iron Pickaxe",
    category = "Decoration",
    tooltip = "This is a iron pickaxe!",
    shop_key = false,
    shop_buy = 0,
    shop_sell = 0,
    durability = 10000,
    singular = true,
}

iron_pickaxe_recipe = {
    { item = "ultra_item_iron_ingot", amount = 3 },
    { item = "ultra_item_iron_bar", amount = 2 },
    { item = "ultra_item_charred_rock", amount = 3 }
}

function addItems()
    api_define_item(charcoal_def, "sprites/resources/charcoal.png")
    api_define_item(iron_ore_def, "sprites/iron/iron_ore.png")
    api_define_item(iron_ingot_def, "sprites/iron/iron_ingot.png")
    api_define_item(iron_bar_def, "sprites/iron/iron_bar.png")
    api_define_item(charred_rock_def, "sprites/resources/charred_rock.png")
    api_define_item(charred_rock_gear_def, "sprites/components/charred_rock_gear.png")
    api_define_item(iron_axe_def, "sprites/iron/iron_axe.png")
    api_define_item(iron_pickaxe_def, "sprites/iron/iron_pickaxe.png")
end

function addRecipes()
    api_define_recipe('tools', "ultra_item_iron_bar", iron_bar_recipe, 2)
    api_define_recipe('tools', "ultra_item_charred_rock", charred_rock_recipe, 1)
    api_define_recipe('tools', "ultra_item_charred_rock_gear", charred_rock_gear_recipe, 1)
    api_define_recipe('tools', "ultra_item_iron_axe", iron_axe_recipe ,1)
    api_define_recipe('tools', "ultra_item_iron_pickaxe", iron_pickaxe_recipe, 1)
end