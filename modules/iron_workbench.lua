iron_workbench_layout  = {
  {7, 17},
  {7, 39},
  {30, 17},
  {30, 39},
  {99, 28, "Output"},
  {7, 66},
  {30, 66},
  {53, 66},
  {76, 66},
  {99, 66},
  {122, 66},
}

iron_workbench_info = {
  {"1. Iron Workbench Crafting Slots", "GREEN"},
  {"2. Iron Workbench Output Slots", "RED"},
  {"3. Extra Storage", "WHITE"},
}

iron_workbench_buttons = {
  "Help",
  "Target",
  "Close",
}

iron_workbench_tools = {
  "hammer1",
}

function iron_workbench_gui_tooltip(menu_id) 
  progress = math.floor((api_gp(menu_id, "p_start") / api_gp(menu_id, "p_end")) * 100)
  percent = tostring(progress) .. "%"
  return {
    {"Progress", "FONT_WHITE"},
    {percent, "FONT_BGREY"}
  }
end

function define_iron_workbench(menu_id)
  api_dp(menu_id, "working", false)
  api_dp(menu_id, "p_start", 0)
  api_dp(menu_id, "p_end", 5)

  api_define_gui(menu_id, "iron_workbench_progress_bar", 50, 31, "iron_workbench_gui_tooltip", "sprites/iron_workbench/iron_workbench_gui_arrow.png")
  api_dp(menu_id, "iron_workbench_progress_bar_sprite", api_get_sprite("ultra_item_iron_workbench_progress_bar"))

  fields = {"p_start", "p_end"}
  fields = api_sp(menu_id, "_fields", fields)
end

function draw_iron_workbench(menu_id)
  cam = api_get_cam()

  gui = api_get_inst(api_gp(menu_id, "iron_workbench_progress_bar"))
  spr = api_gp(menu_id, "iron_workbench_progress_bar_sprite")

  gx = gui["x"] - cam["x"]
  gy = gui["y"] - cam["y"]
  progress = (api_gp(menu_id, "p_start") / api_gp(menu_id, "p_end") * 47)
  api_draw_sprite_part(spr, 2, 0, 0, progress, 10, gx, gy)
  api_draw_sprite(spr, 1, gx, gy)

  if api_get_highlighted("ui") == gui["id"] then
    api_draw_sprite(spr, 0, gx, gy)
  end
end

function tick_iron_workbench(menu_id)
  if api_gp(menu_id, "working") == true then
    api_sp(menu_id, "p_start", api_gp(menu_id, "p_start") + 0.1)
    if api_gp(menu_id, "p_start") > api_gp(menu_id, "p_end") then
      api_sp(menu_id, "p_start", 0)
      input_slot_1 = api_get_slot(menu_id, 1)
      input_slot_2 = api_get_slot(menu_id, 2)
      input_slot_3 = api_get_slot(menu_id, 3)
      input_slot_4 = api_get_slot(menu_id, 4)
      output_slot = api_get_slot(menu_id, 5)

      if input_slot_1["item"] == "ultra_item_iron_ingot" then
        if input_slot_2["item"] == "" and input_slot_3["item"] == "" and input_slot_2["item"] == ""  then
          if input_slot_1["count"] >= 2 then
            api_slot_decr(input_slot_1["id"], 2)
            if output_slot["item"] == "" then
              api_slot_set(output_slot["id"], "ultra_item_iron_bar", 1)
            else
              api_slot_incr(output_slot["id"], 1)
            end
          end
        end
      elseif input_slot_2["item"] == "ultra_item_iron_rod"then
          if input_slot_1["item"] == "ultra_item_iron_ingot" then
            if input_slot_1["count"] >= 3 then
              api_slot_decr(input_slot_1["id"], 3)
              api_slot_decr(input_slot_2["id"], 2)
              if output_slot["item"] == "" then
                api_slot_set(output_slot["id"], "ultra_item_iron_axe", 1)
              else
                api_slot_incr(output_slot["id"], 1)
              end
            end
          end
      else
        api_sp(menu_id, "working", false)
        api_sp(menu_id, "p_start", 0)
      end
    end

    input_slot_1 = api_get_slot(menu_id, 1)
    input_slot_2 = api_get_slot(menu_id, 2)
    input_slot_3 = api_get_slot(menu_id, 3)
    input_slot_4 = api_get_slot(menu_id, 4)
    output_slot = api_get_slot(menu_id, 5)

    if input_slot_1["item"] == "" then
      if input_slot_2["item"] == "" then
        if input_slot_3["item"] == "" then
          if input_slot_4["item"] == "" then
            api_sp(menu_id, "working", false)
            api_sp(menu_id, "p_start", 0)
          end
        end
      end
    end
  end
end


function change_iron_workbench(menu_id)
  input_slot = api_slot_match_range(menu_id, {"ANY"}, {1,2,3,4}, true)
  if input_slot["item"] ~= "" then 
      api_sp(menu_id, "working", true)
  end
end

iron_workbench_scripts = {
define = "define_iron_workbench",
draw = "draw_iron_workbench",
tick = "tick_iron_workbench",
change = "change_iron_workbench",
}

iron_workbench_def = {
  id = "iron_workbench",
  name = "Iron Workbench",
  category = "machines",
  tooltip = "A Iron Workbench, used for crafting items that contain iron!",
  shop_key = false,
  shop_buy = 0,
  shop_sell = 0,
  layout = iron_workbench_layout,
  info = iron_workbench_info,
  buttons = iron_workbench_buttons,
  tools = iron_workbench_tools,
  nature = true,
  singular = true
}

function addIronWorkbench()
  api_define_menu_object(iron_workbench_def, "sprites/iron_workbench/iron_workbench.png", "sprites/iron_workbench/iron_workbench_menu.png", iron_workbench_scripts)
end

--[[
        if input_slot_2["item"] == "ultra_item_iron_rod"then
        if input_slot_1["item"] == "ultra_item_iron_ingot" then
          if input_slot_1["count"] >= 3 then
            api_slot_decr(input_slot_1["id"], 3)
            api_slot_decr(input_slot_2["id"], 2)
            if output_slot["item"] == "" then
              api_slot_set(output_slot["id"], "ultra_item_iron_axe", 1)
            else
              api_slot_incr(output_slot["id"], 1)
            end
          end
        end
      end
]]