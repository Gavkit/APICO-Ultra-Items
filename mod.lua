MOD_NAME = "ultra_item"

function register()
  return {
    name = MOD_NAME,
    hooks = {"ready", "tick"},
    modules = {"items","furnace","rock_crusher","power","iron_workbench"}
  }
end

function init() 
  --api_set_devmode(true)
  api_log("init", "Ultra Items Has Been Loaded!")
  addItems()
  addFurnace()
  addRockCrusher()
  addIronWorkbench()
  return "Success"
end

function ready()
end

function tick()
end