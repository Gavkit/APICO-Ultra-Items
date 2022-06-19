MOD_NAME = "ultra_item"

function register()
  return {
    name = MOD_NAME,
    hooks = {"ready", "tick"},
    modules = {"items","furnace","rock_crusher","power"}
  }
end

function init() 
  api_set_devmode(true)
  api_define_workbench("Ultra Items", {
    t1 = "Resources",
    t2 = "Machines",
    t3 = "Tools",
    t4 = "Empty",
    t5 = "Empty"
  })
  addItems()
  addFurnace()
  addRockCrusher()
  api_log("init", "Ultra Items Has Been Loaded!")
  return "Success"
end

function ready()
end

function tick()
end