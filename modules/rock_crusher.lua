rock_crusher_layout  = {
    {54, 40, "Input", {"stone"}},
    {7, 63, "Liquid Input", {"canister1", "canister2"}},
    {90, 17, "Output"},
    {113, 17, "Output"},
    {90, 40, "Output"},
    {113, 40, "Output"},
    {90, 63, "Output"},
    {113, 63, "Output"},
    {30, 63, "Liquid Output", {"canister1", "canister2"}},
}

rock_crusher_recipe = {
    {"ultra_item_charred_rock_gear", 2},
    {"ultra_item_charred_rock", 25},
    {"planks1", 30}
}

rock_crusher_info = {
    {"1. Water Tank", "GREEN"},
    {"2. Stone Input", "RED"},
    {"3. Ore Output", "WHITE"},
}

rock_crusher_buttons = {
    "Help",
    "Target",
    "Close",
}

rock_crusher_tools = {
    "hammer1",
}

rock_crusher_scripts = {
  define = "define_rock_crusher",
  draw = "draw_rock_crusher",
  tick = "tick_rock_crusher",
  change = "change_rock_crusher",
}

function define_rock_crusher(menu_id)
    api_define_tank(menu_id, 0, 2000, "water", 4, 14, "xlarge")
    api_dp(menu_id, "tank_amount", 0)
    api_dp(menu_id, "working", false)
    api_dp(menu_id, "p_start", 0)
    api_dp(menu_id, "p_end", 1)

    api_define_gui(menu_id, "rock_crusher_progress_bar", 74, 43, "rock_crusher_gui_tooltip", "sprites/rock_crusher/rock_crusher_gui_arrow.png")

    api_dp(menu_id, "rock_crusher_progress_bar_sprite", api_get_sprite("ultra_item_rock_crusher_progress_bar"))

    fields = {"tank_amount"}
    fields = api_sp(menu_id, "_fields", fields)
    fields = {"p_start", "p_end"}
    fields = api_sp(menu_id, "_fields", fields)
end

function draw_rock_crusher(menu_id)
    api_draw_tank(api_gp(menu_id, "tank_gui"))
    cam = api_get_cam()

    gui = api_get_inst(api_gp(menu_id, "rock_crusher_progress_bar"))
    spr = api_gp(menu_id, "rock_crusher_progress_bar_sprite")
  
    -- draw arrow "progress" block then cover up with arrow hole
    -- arrow sprite is 47x10
    gx = gui["x"] - cam["x"]
    gy = gui["y"] - cam["y"]
    progress = (api_gp(menu_id, "p_start") / api_gp(menu_id, "p_end") * 10)
    api_draw_sprite_part(spr, 2, 0, 0, progress, 10, gx, gy)
    api_draw_sprite(spr, 1, gx, gy)
  
    -- draw highlight if highlighted
    if api_get_highlighted("ui") == gui["id"] then
      api_draw_sprite(spr, 0, gx, gy)
    end
end

function tick_rock_crusher(menu_id)
    input_slot = api_slot_match_range(menu_id, {"ANY"}, {1}, true)
    slot_in = api_get_slot(menu_id, 9)
    slot_out = api_get_slot(menu_id, 2)
    if slot_in["item"] == "canister1" or slot_in["item"] == "canister2" then
        api_slot_drain(menu_id, 9)
    end
    if slot_out["item"] == "canister1" or slot_out["item"] == "canister2" then
        if api_gp(menu_id, "tank_amount") == 0 or api_gp(menu_id, "tank_type") == slot_out.stats["type"] then
        api_sp(menu_id, "tank_type", slot_out.stats["type"])
        api_slot_fill(menu_id, 2)
        end 
    end
    if input_slot ~= nil and api_gp(menu_id, "tank_amount") >= 10 then 
        api_sp(menu_id, "working", true)
    else
        api_sp(menu_id, "working", false)
        api_sp(menu_id, "p_start", 0)
    end

  if api_gp(menu_id, "working") == true then
    api_sp(menu_id, "p_start", api_gp(menu_id, "p_start") + 0.1)
    if api_gp(menu_id, "p_start") >= api_gp(menu_id, "p_end") then
        api_sp(menu_id, "p_start", 0)
        input_slot = api_slot_match_range(menu_id, {"ANY"}, {1}, true)
        if input_slot ~= nil and api_gp(menu_id, "tank_amount") >= 10 then
        api_slot_decr(input_slot["id"])
        api_sp(menu_id, "tank_amount", api_gp(menu_id, "tank_amount") - 10)
        ore_item = api_choose({"ultra_item_iron_ore", "stone"})
        output_slot = api_slot_match_range(menu_id, {"", ore_item}, {3, 4, 5, 6, 7}, true)
        if output_slot ~= nil then
            if output_slot["item"] == "" then
            api_slot_set(output_slot["id"], ore_item, 1)
            else 
            api_slot_incr(output_slot["id"], 1)
            end
        end
        input_slot = api_slot_match_range(menu_id, {"ANY"}, {1}, true)
      end
      if input_slot == nil or api_gp(menu_id, "tank_amount") < 10 then
        api_sp(menu_id, "working", false)
        api_sp(menu_id, "p_start", 0)
    end
    end
  end
end

function change_rock_crusher(menu_id)
    input_slot = api_slot_match_range(menu_id, {"ANY"}, {1}, true)
    slot_in = api_get_slot(menu_id, 9)
    slot_out = api_get_slot(menu_id, 2)
    if slot_in["item"] == "canister1" or slot_in["item"] == "canister2" then
        api_slot_drain(menu_id, 9)
    end
    if slot_out["item"] == "canister1" or slot_out["item"] == "canister2" then
        if api_gp(menu_id, "tank_amount") == 0 or api_gp(menu_id, "tank_type") == slot_out.stats["type"] then
        api_sp(menu_id, "tank_type", slot_out.stats["type"])
        api_slot_fill(menu_id, 2)
        end 
    end
    if input_slot ~= nil and api_gp(menu_id, "tank_amount") >= 10 then 
        api_sp(menu_id, "working", true)
    else
        api_sp(menu_id, "working", false)
        api_sp(menu_id, "p_start", 0)
    end
end

function rock_crusher_gui_tooltip(menu_id) 
    progress = math.floor((api_gp(menu_id, "p_start") / api_gp(menu_id, "p_end")) * 100)
    percent = tostring(progress) .. "%"
    return {
      {"Progress", "FONT_WHITE"},
      {percent, "FONT_BGREY"}
    }
  end

rock_crusher_def = {
    id = "rock_crusher",
    name = "Rock Crusher",
    category = "machines",
    tooltip = "A rock crusher, for turning rocks into ores!",
    shop_key = false,
    shop_buy = 0,
    shop_sell = 0,
    layout = rock_crusher_layout,
    info = rock_crusher_info,
    buttons = rock_crusher_buttons,
    tools = rock_crusher_tools,
    nature = true,
    singular = true
}

function addRockCrusher()
    api_define_menu_object(rock_crusher_def, "sprites/rock_crusher/rock_crusher.png", "sprites/rock_crusher/rock_crusher_menu.png", rock_crusher_scripts)
    api_define_recipe("t2", "ultra_item_rock_crusher", rock_crusher_recipe, 1)
end