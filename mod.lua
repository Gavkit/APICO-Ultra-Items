MOD_NAME = "ultra_item"

MY_BOOK_MENU = nil
MY_BOOK_OBJ = nil

function register()
  return {
    name = MOD_NAME,
    hooks = {"ready", "tick"},
    modules = {"quests","items","furnace","rock_crusher"}
  }
end

function init() 
  api_set_devmode(true)
  api_log("init", "Ultra Items Has Been Loaded!")
  --addQuests()
  addItems()
  addRecipes()
  addFurnace()
  --addIronWorkbench()
  addRockCrusher()
  return "Success"
end

function ready()
  --first_quest = api_check_discovery("axe1")
  --if (first_quest == true) then
    --unlock = api_unlock_quest("my_new_quest")
  --end
end

function tick()
end