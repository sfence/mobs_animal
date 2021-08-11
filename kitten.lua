
local S = mobs.intllib
local hairball = minetest.settings:get("mobs_hairball")

-- Kitten by Jordach / BFD

mobs:register_mob("hades_animals:kitten", {
stepheight = 0.6,
	type = "animal",
specific_attack = {"hades_animals:rat"},
damage = 1,
attack_type = "dogfight",
attack_animals = true, -- so it can attack rat
attack_players = false,
reach = 1,
stepheight = 1.1,
	passive = false,
	hp_min = 5,
	hp_max = 10,
	armor = 200,
	collisionbox = {-0.3, -0.3, -0.3, 0.3, 0.1, 0.3},
	visual = "mesh",
	visual_size = {x = 0.5, y = 0.5},
	mesh = "mobs_kitten.b3d",
	textures = {
		{"mobs_kitten_striped.png"},
		{"mobs_kitten_splotchy.png"},
		{"mobs_kitten_ginger.png"},
		{"mobs_kitten_sandy.png"},
	},
	makes_footstep_sound = false,
	sounds = {
		random = "mobs_kitten",
	},
	walk_velocity = 0.6,
	walk_chance = 15,
	run_velocity = 2,
	runaway = true,
	jump = false,
	drops = {
		{name = "hades_farming:string", chance = 1, min = 0, max = 1},
	},
	water_damage = 0,
	lava_damage = 5,
	fear_height = 3,
	animation = {
		speed_normal = 42,
		stand_start = 97,
		stand_end = 192,
		walk_start = 0,
		walk_end = 96,
		stoodup_start = 0,
		stoodup_end = 0,
	},
	follow = {
		"hades_animals:rat", "ethereal:fish_raw", "mobs_fish:clownfish",
		"mobs_fish:tropical", "xocean:fish_edible"
	},
	view_range = 8,

	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 4, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 50, 50, 90, false, nil) then return end

		-- by right-clicking owner can switch between staying and walking
		if self.owner and self.owner == clicker:get_player_name() then

			if self.order ~= "stand" then
				self.order = "stand"
				self.state = "stand"
				self.object:set_velocity({x = 0, y = 0, z = 0})
				mobs:set_animation(self, "stand")
			else
				self.order = ""
				mobs:set_animation(self, "stoodup")
			end
		end
	end,

	do_custom = function(self, dtime)

		if hairball == "false" then
			return
		end

		self.hairball_timer = (self.hairball_timer or 0) + dtime
		if self.hairball_timer < 10 then
			return
		end
		self.hairball_timer = 0

		if self.child
		or math.random(1, 250) > 1 then
			return
		end

		local pos = self.object:get_pos()

		minetest.add_item(pos, "mobs:hairball")

		minetest.sound_play("default_dig_snappy", {
			pos = pos,
			gain = 1.0,
			max_hear_distance = 5,
		})
	end,
})


local spawn_on = "default:dirt_with_grass"

if minetest.get_modpath("ethereal") then
	spawn_on = "ethereal:grove_dirt"
end

if not mobs.custom_spawn_animal then
mobs:spawn({
	name = "hades_animals:kitten",
	nodes = {spawn_on},
	neighbors = {"group:grass"},
	min_light = 14,
	interval = 60,
	chance = 10000, -- 22000
	min_height = 5,
	max_height = 50,
	day_toggle = true,
})
end


mobs:register_egg("hades_animals:kitten", S("Kitten"), "mobs_kitten_inv.png", 0)

minetest.override_item("hades_animals:kitten", {
    _tt_help = "Eat rat, raw fish, clown fish, tropical fish and edible fish..",
  })

mobs:alias_mob("mobs:kitten", "hades_animals:kitten") -- compatibility


local hairball_items = {
	"hades_core:stick", "hades_core:coal_lump", "hades_core:dry_shrub", "flowers:rose",
	"hades_animals:rat", "hades_core:grass_1", "hades_farming:seed_wheat", "dye:green", "",
	"hades_farming:seed_cotton", "hades_core:flint", "hades_core:sapling", "dye:white", "",
	"hades_core:clay_lump", "hades_core:paper", "hades_waterplants:waterlily", "dye:red", "",
	"hades_farming:string", "mobs:chicken_feather", "hades_core:orange_sapling", "",
	"hades_core:banana_sapling", "hades_core:copper_lump", "hades_core:iron_lump", "",
	"dye:black", "dye:brown", "hades_core:obsidian_shard", "hades_core:tin_lump"
}

minetest.register_craftitem(":mobs:hairball", {
	description = S("Hairball"),
	inventory_image = "mobs_hairball.png",
	on_use = function(itemstack, user, pointed_thing)

		local pos = user:get_pos()
		local dir = user:get_look_dir()
		local newpos = {x = pos.x + dir.x, y = pos.y + dir.y + 1.5, z = pos.z + dir.z}
		local item = hairball_items[math.random(1, #hairball_items)]

		if item ~= "" then
			minetest.add_item(newpos, {name = item})
		end

		minetest.sound_play("default_place_node_hard", {
			pos = newpos,
			gain = 1.0,
			max_hear_distance = 5,
		})

		itemstack:take_item()

		return itemstack
	end,
})
