MOD_NAME = "ultra_item"

MY_BOOK_MENU = nil
MY_BOOK_OBJ = nil

function register()
  return {
    name = MOD_NAME,
    hooks = {"ready", "tick"},
    modules = {"quests","items","furnace","rock_crusher", "power"}
  }
end

function init() 
  --api_set_devmode(true)
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
end

function tick()
  --api_log("Info", power)
  --addPower(1)
end