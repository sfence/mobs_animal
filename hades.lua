-- hades Revisited compatibility

local S = mobs.intllib

-- name tag
minetest.register_craftitem(":mobs:nametag", {
	description = S("Name Tag"),
	inventory_image = "mobs_nametag.png",
	groups = {flammable = 2}
})

if minetest.get_modpath("dye") and minetest.get_modpath("farming") then
	minetest.register_craft({
		type = "shapeless",
		output = "mobs:nametag",
		recipe = {"hades_core:paper", "dye:black", "hades_farming:string"}
	})
end

-- leather
minetest.register_craftitem(":mobs:leather", {
	description = S("Leather"),
	inventory_image = "mobs_leather.png",
	groups = {flammable = 2}
})

-- raw meat
minetest.register_craftitem(":mobs:meat_raw", {
	description = S("Raw Meat"),
	inventory_image = "mobs_meat_raw.png",
	on_use = minetest.item_eat(3),
	groups = {food_meat_raw = 1, flammable = 2, eatable = 3}
})

-- cooked meat
minetest.register_craftitem(":mobs:meat", {
	description = S("Meat"),
	inventory_image = "mobs_meat.png",
	on_use = minetest.item_eat(8),
	groups = {food_meat = 1, flammable = 2, food = 2, eatable = 8}
})

minetest.register_craft({
	type = "cooking",
	output = "mobs:meat",
	recipe = "mobs:meat_raw",
	cooktime = 5
})

-- lasso
--[[
minetest.register_tool(":mobs:lasso", {
	description = S("Lasso (right-click animal to put in inventory)"),
	inventory_image = "mobs_magic_lasso.png",
	groups = {flammable = 2}
})

if minetest.get_modpath("farming") then
	minetest.register_craft({
		output = "mobs:lasso",
		recipe = {
			{"hades_farming:string", "", "hades_farming:string"},
			{"", "hades_core:diamond", ""},
			{"hades_farming:string", "", "hades_farming:string"}
		}
	})
end
--]]

-- net
minetest.register_tool(":mobs:net", {
	description = S("Net (right-click animal to put in inventory)"),
	inventory_image = "mobs_net.png",
	groups = {flammable = 2}
})

if minetest.get_modpath("hades_extrafarming") then
	minetest.register_craft({
		output = "mobs:net",
		recipe = {
			{"group:stick", "", "group:stick"},
			{"group:stick", "", "group:stick"},
			{"hades_farming:string", "group:stick", "hades_farming:string"}
		}
	})
end

-- shears (right click to shear animal)
minetest.register_tool(":mobs:shears", {
	description = S("Steel Shears (right-click to shear)"),
	inventory_image = "mobs_shears.png",
	groups = {flammable = 2}
})

minetest.register_craft({
	output = "mobs:shears",
	recipe = {
		{"", "hades_core:steel_ingot", ""},
		{"", "group:stick", "hades_core:steel_ingot"}
	}
})

-- saddle
minetest.register_craftitem(":mobs:saddle", {
	description = S("Saddle"),
	inventory_image = "mobs_saddle.png",
	groups = {flammable = 2}
})

minetest.register_craft({
	output = "mobs:saddle",
	recipe = {
		{"mobs:leather", "mobs:leather", "mobs:leather"},
		{"mobs:leather", "hades_core:steel_ingot", "mobs:leather"},
		{"mobs:leather", "hades_core:steel_ingot", "mobs:leather"}
	}
})

