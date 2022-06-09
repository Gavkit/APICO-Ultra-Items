furnace_layout  = {
    {7, 17, "Input", {"ultra_item_iron_ore", "log"}},
    {7, 39, "Input", {"log"}},
    {76, 17, "Output"},
    {76, 39, "Output"},
    {7, 66},
    {30, 66},
    {53, 66},
    {76, 66},
}

furnace_info = {
    {"1. Furnace Input", "GREEN"},
    {"2. Furnace Output", "RED"},
    {"3. Extra Storage", "WHITE"},
}

furnace_buttons = {
    "Help",
    "Target",
    "Close",
}

furnace_tools = {
    "hammer1",
}

furnace_scripts = {
  define = "define_furnace",
  draw = "draw_furnace",
  tick = "tick_furnace",
  change = "change_furnace",
}

function define_furnace(menu_id)
  api_dp(menu_id, "working", false)
  api_dp(menu_id, "p_start", 0)
  api_dp(menu_id, "p_end", 5)

  api_define_gui(menu_id, "progress_bar", 27, 20, "furnace_gui_tooltip", "sprites/furnace/furnace_gui_arrow.png")
  api_dp(menu_id, "progress_bar_sprite", api_get_sprite("ultra_item_progress_bar"))

  fields = {"p_start", "p_end"}
  fields = api_sp(menu_id, "_fields", fields)
end

function draw_furnace(menu_id)
  cam = api_get_cam()

  gui = api_get_inst(api_gp(menu_id, "progress_bar"))
  spr = api_gp(menu_id, "progress_bar_sprite")

  gx = gui["x"] - cam["x"]
  gy = gui["y"] - cam["y"]
  progress = (api_gp(menu_id, "p_start") / api_gp(menu_id, "p_end") * 47)
  api_draw_sprite_part(spr, 2, 0, 0, progress, 10, gx, gy)
  api_draw_sprite(spr, 1, gx, gy)

  if api_get_highlighted("ui") == gui["id"] then
    api_draw_sprite(spr, 0, gx, gy)
  end
end

function furnace_gui_tooltip(menu_id) 
  progress = math.floor((api_gp(menu_id, "p_start") / api_gp(menu_id, "p_end")) * 100)
  percent = tostring(progress) .. "%"
  return {
    {"Progress", "FONT_WHITE"},
    {percent, "FONT_BGREY"}
  }
end

function tick_furnace(menu_id)
  if api_gp(menu_id, "working") == true then
    api_sp(menu_id, "p_start", api_gp(menu_id, "p_start") + 0.1)
    if api_gp(menu_id, "p_start") > api_gp(menu_id, "p_end") then
      api_sp(menu_id, "p_start", 0)
      input_slot_1 = api_get_slot(menu_id, 1)
      input_slot_2 = api_get_slot(menu_id, 2)
      output_slot_1 = api_get_slot(menu_id, 3)
      output_slot_2 = api_get_slot(menu_id, 4)
      if input_slot_1["item"] == "ultra_item_iron_ore" then
        api_slot_decr(input_slot_1["id"], 1)
        api_slot_decr(input_slot_2["id"], 1)
        if output_slot_1["item"] == "" or output_slot_1["item"] == "ultra_item_charcoal"then
          api_slot_set(output_slot_1["id"], "ultra_item_iron_ingot", 1)
        else
          api_slot_incr(output_slot_1["id"], 1)
        end
        if output_slot_2["item"] == "" then
          api_slot_set(output_slot_2["id"], "ultra_item_charcoal", 1)
        else
          api_slot_incr(output_slot_2["id"], 1)
        end
        input_slot = api_slot_match_range(menu_id, {"ANY"}, {1}, true)
        input_slot_11 = api_slot_match_range(menu_id, {"ANY"}, {2}, true)
        if input_slot == nil then
          api_sp(menu_id, "working", false)
          api_sp(menu_id, "p_start", 0)
        end
        if input_slot_11  == nil then
          api_sp(menu_id, "working", false)
          api_sp(menu_id, "p_start", 0)
        end
      end

      if input_slot_1["item"] == "log" then
        api_slot_decr(input_slot_1["id"], 1)
        api_slot_decr(input_slot_2["id"], 1)

        if output_slot_2["item"] == "" then
          api_slot_set(output_slot_2["id"], "ultra_item_charcoal", 2)
        else
          api_slot_incr(output_slot_2["id"], 2)
        end

        input_slot = api_slot_match_range(menu_id, {"ANY"}, {1}, true)
        input_slot_11 = api_slot_match_range(menu_id, {"ANY"}, {2}, true)
        if input_slot == nil then
          api_sp(menu_id, "working", false)
          api_sp(menu_id, "p_start", 0)
        end
        if input_slot_11  == nil then
          api_sp(menu_id, "working", false)
          api_sp(menu_id, "p_start", 0)
        end
      end
    end
  end
end

function change_furnace(menu_id)
  input_slot = api_slot_match_range(menu_id, {"ANY"}, {1}, true)
  input_slot_11 = api_slot_match_range(menu_id, {"ANY"}, {2}, true)
  if input_slot ~= nil then 
    if input_slot_11 ~= nil then
      api_sp(menu_id, "working", true)
    else 
      api_sp(menu_id, "working", false)
      api_sp(menu_id, "p_start", 0)
    end
  else 
    api_sp(menu_id, "working", false)
    api_sp(menu_id, "p_start", 0)
  end
end

furnace_def = {
    id = "furnace",
    name = "Furnace",
    category = "machines",
    tooltip = "A furnace, for smelting ores!",
    shop_key = false,
    shop_buy = 0,
    shop_sell = 0,
    layout = furnace_layout,
    info = furnace_info,
    buttons = furnace_buttons,
    tools = furnace_tools,
    nature = true,
    singular = true
}

furnace_recipe = {
    {"stone", 99},
    {"waterproof", 10}
}

function addFurnace()
  api_define_menu_object(furnace_def, "sprites/furnace/furnace.png", "sprites/furnace/furnace_menu.png", furnace_scripts)
  ui_define_recipe(furnace_recipe, "ultra_item_furnace", 1, 2)
end

