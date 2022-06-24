-- [[ Server Setup/Readme ]] --
# Config.lua
Read through the commenting in config.lua for more information about what each option does.
You will have to set your `BankAccountName` correctly, among other job names and ranks for this script to work properly.

# Adding Keys To Shops/Adding Shops
Keys must be created as items in your database.
Inside of the config.lua "Shops" table, you can add a new shop by copy pasting, and modifying the example given:
  {
    interact_dist = 2.0,
    render_dist   = 20.0,
    location      = vector3(451.46771240234,-760.77416992188,27.357772827148),

    draw_text     = true,
    text_to_draw  = Labels.key_shop_3dtxt,
    text_offset   = vector3(0.0,0.0,0.5),

    draw_help     = true,
    help_to_draw  = Labels.key_shop_helptxt,

    draw_marker   = true,
    marker_type   = 1,
    marker_color  = {r = 255,g = 255,b = 255,a = 50},
    marker_scale  = {x = 1.0,y = 1.0,z = 1.0},
    marker_offset = vector3(0.0,0.0,-1.0),

    draw_blip         = true,
    blip_sprite       = 186,
    blip_color        = 0,
    blip_scale        = 0.8,
    blip_text         = Labels.key_shop_bliptxt,
    blip_display      = 2,
    blip_short_range  = false,
    blip_high_detail  = true,

    content = {
      {
        item_name  = "keys_missionrow_pd_front",
        item_label = "Mission Row PD Keys (Front)",
        item_price = 500,

        restricted = true,
        auth_jobs = {
          police    = {min_rank = 0},
          mechanic  = {min_rank = 2},
        },
      },
      {
        item_name  = "keys_master_key",
        item_label = "Master Key",
        item_price = 150000,

        restricted = true,
        auth_jobs = {
          police    = {min_rank = 5},
        },
      },
      {
        item_name  = "keys_master_key_single_use",
        item_label = "Master Key (Single Use)",
        item_price = 50000,

        restricted = true,
        auth_jobs = {
          police    = {min_rank = 4},
        },
      },
    }
  },

The "contents" table related to the items that will be displayed inside of a shop.
Each key item is held within its own table (inside of the contents table), E.G:
  {
    item_name  = "keys_missionrow_pd_front",
    item_label = "Mission Row PD Keys (Front)",
    item_price = 500,

    restricted = true,
    auth_jobs = {
      police    = {min_rank = 0},
      mechanic  = {min_rank = 2},
    },
  },

# Adding Doors
Copy paste the given examples in config.lua and modify as you see fit. E.G:
  {
    locked = false,
    dist = 2.5,
    draw = 5.0,
    text_loc = vector3(434.747,-982.000,31.00),

    allow_raid = true,
    auth_jobs = {},

    auth_items = {
      keys_master_key_single_use  = {take_item = true},
      keys_master_key             = {take_item = false},
    },

    can_break = true,
    break_items = {
      lockpick        = {minigame = "Lockpick",   take_item = false, take_on_fail = true},
      lockpickv2      = {minigame = "LockpickV2", take_item = false, take_on_fail = true},
      hacking_laptop  = {minigame = "Hacking",    take_item = false, take_on_fail = true},
      thermite        = {minigame = "Thermite",   take_item = false, take_on_fail = false},
    },

    hacking_preset = {
      time    = 35,
      letters = 7,
    },

    lockpick_preset = {
      pins = 6
    },

    thermite_preset = {  
      difficulty        = 0.5,
      speed_scale       = 1.5,
      score_inc         = 0.5,
    },

    objects = {
      {
        reposition = false,
        door_model = GetHashKey('v_ilev_ph_door01'),
        door_loc   = vector3(434.747,-980.618,30.839),
        door_rot   = vector3(0.0,0.0,-90.0),
      },
      {
        reposition = false,
        door_model = GetHashKey('v_ilev_ph_door002'),
        door_loc   = vector3(434.747,-983.215,30.839),
        door_rot   = vector3(0.0,0.0,-90.0),
      },
    }
  },

Note: Each door "pair/group" can be placed in a single table, with multiple objects defined in the "objects" sub-table. Note example above.

NOTE: As of 22/07/2020, you can add doors via in-game command.
/doors:make
Must allow yourself ace permissions for commands to use this.

NOTE: As of 27/07/2020, you must add this command to ESX to retrieve the list of jobs properly.
Add to: es_extended/server/functions.lua:

  ESX.GetJobs = function()
    return ESX.Jobs
  end

-- [[ Store Information/Readme ]] --
# ModFreakz: Doors
# https://modit.store

# Support
Head to the link above, and click the contact-us tab for support.
Never expose your credentials to anybody outside of a private support ticket, opened from within the discord.
Support for installation is offered free of charge, but a response within a given time frame is never guaranteed.
We only support the installation on standard ESX versions.

# Info
This door script gives you far greater control over how you players can gain access through doorways.
You can restrict door usage to job type and rank, using items to unlock, or you can use basically any minigame with a callback.
Each door is highly configurable, allowing you to set values such as break-in minigame difficulties, raid access for certain jobs, and whether or not the door can be broken into using minigames.
Multiple door control from a single access point, with only one set of drawtext/interact text per set of doors.
A shop where you can sell keys is also included in this mod (and you can also add as many other shops as you might want), with a neat and functional UI frame.
Shop keys are also restricted by job rank and grade, allowing you to make job-specific keys available for purchase.
Configurable options for chunking of door locations, giving you greater control over resource responsiveness and resource usage.

# Requirements
es_extended
meta_libs (v1.3+) [https://github.com/meta-hub/meta_libs/releases]
mHacking Minigame [https://github.com/GHMatti/FiveM-Scripts/tree/master/mhacking]
Lockpicking V1 Minigame (Included with the mod).

# Optional Requirements
NOTE: There are not required to function, and are not included in the script by default.
Thermite Minigame.
Lockpicking V2 Minigame.

# Installation
Drag and drop "doors" folder into your resources directory.
Add "start doors" to your server.cfg.
Import the SQL files provided.
Check the credentials.lua and make sure you set the values correctly.
Your server may take up to 24 hours to receive authorization to use this mod.
You can check your server console for an authorization message to see whether or not you are able to use this mod.
The message will read something like "[doors]: Authorized." or "[doors]: Unauthorized".
You do not need to contact us during this time, and assuming you have set your credentials correctly, it will automatically authorize you after a given time.
If you have waited longer then 24 hours and still have not received authorization, contact us via the discord support link above.

# Notes
Minimal doors come pre-configured by default.
You will be responsible for deciding which doors to add, and adding to the config file yourself.

# Important
This script obfuscated and remote loaded on the server-side. 
This means you will not be able to modify the server side of the code, and you will always need the correct credentials in order for the script to work.
Please consider the implications of this (mainly the fact that you can't see or edit the server-side portion of this mod) before purchasing.