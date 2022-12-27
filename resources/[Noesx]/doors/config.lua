--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
TriggerEvent("esx:getSharedObject", function(obj) ESX = obj; end)

AuthorizedItems = {
  keys_missionrow_pd_front    = "Mission Row Key (Front)",
  keys_master_key_single_use  = "Master Key (Single Use)",
  keys_master_key             = "Master Key",
}

-- Minigame Presets
Minigames = {
  ['Hacking'] = {
    item = 'hacking_laptop',
    options = {
      time        = {min = 10, max = 60, step = 2},
      letters     = {min = 02, max = 10, step = 1},
    }
  },
  ['Lockpick'] = {
    item = 'lockpick',
    options = {
      pins        = {min = 01, max = 10, step = 1},
    }
  },
  -- Uncomment minigames that you own/want to use.
  --[[
  ['LockpickV2'] = {
    item = 'lockpickv2'
  },
  ['Thermite'] = {
    item = 'thermite',
    options = {      
      difficulty   = {min = 0.1, max = 1.0, step = 0.1},
      speed_scale  = {min = 0.1, max = 2.0, step = 0.1},
      score_inc    = {min = 0.1, max = 1.0, step = 0.1},
    }
  },  
  ]]
}

-- Translate here.
Labels = {
  unlock            = "🔐",
  lock              = "🔓",
  do_unlock         = "",
  do_lock           = "",
  access_granted    = "~g~Toegang gegeven.~s~",
  access_denied     = "~r~Toegang afgewezen~s~",
  key_shop_3dtxt    = "[~g~E~s~] sleutel Shop",
  key_shop_helptxt  = "~INPUT_PICKUP~ sleutel Shop",
  key_shop_bliptxt  = "sleutel Shop",
  no_bank_acc       = "Could not find bank account.",
  police_warning    = "Iemand probeerd een deur open te breken op locatie: %s. \nPress ~INPUT_PICKUP~ to set GPS."
}
   
Controls = {
  TextOffset = {
    ["height"] = {
      codes = {81,82},
      text = "Height -/+",
    },
    ["forward"] = {
      codes = {172,173},
      text = "Forward/Back",
    },
    ["right"] = {
      codes = {174,175},
      text = "Right/Left",
    },
    ["done"] = {
      codes = {191},
      text = "Done",
    },
  },
}

Config = {  
  -- ESX bank account name.
  BankAccountName = "bank",

  -- Warn police when a minigame/break in attempt has failed?
  WarnPoliceOnFail = true,

  -- Warn police wehn a minigame/break in attempt has succeeded?
  WarnPoliceOnSuccess = true,

  -- How long should we give the police to react to said notification? (Seconds).
  PoliceNotifyTimer = 15,

  -- Jobs to notify with above interactions.
  PoliceJobs = {
    police  = {min_rank = 0},
    kmar = {min_rank = 0},
  },

  -- These jobs can access any door that allows raid access.
  RaidAccess = {
    police   = {min_rank = 0},
    kmar  = {min_rank = 0},
  },

  -- Chunking effects MS usage with lots of doors.
  Chunking = {
    -- The acceptable range for doors to be considered for primary chunk.
    -- Reduce range to reduce MS.
    range     = 50.0,

    -- Timer: the time between re-chunks.
    -- Increase timer to reduce MS but also reduce overall "responsiveness" of mod.
    timer     = 5000,

    -- Movement: distance before chunking is reconsidered (overwriting timer).
    -- Increase movement to reduce MS, but too a high a value may cause unforseen effects with player teleportation.
    movement  = 50.0,
  },

  Shops = {
    -- Wouldn't use more then a few shops personally. Try your luck though.
    {
      -- Distance to interact.
      interact_dist = 2.0,

      -- Distance to consider for rendering.
      render_dist   = 20.0,

      -- Shop Location
      location = vector3(451.46771240234,-760.77416992188,-27.357772827148),

      -- Use 3D Text?
      draw_text     = false,
      text_to_draw  = Labels.key_shop_3dtxt,
      text_offset   = vector3(0.0,0.0,0.5),

      -- Use Help Text?
      draw_help     = false,
      help_to_draw  = Labels.key_shop_helptxt,

      -- Marker Info
      draw_marker   = false,
      marker_type   = 1,
      marker_color  = {r = 255,g = 255,b = 255,a = 50},
      marker_scale  = {x = 1.0,y = 1.0,z = 1.0},
      marker_offset = vector3(0.0,0.0,-1.0),

      -- Blip Info
      draw_blip         = false,
      blip_sprite       = 186,
      blip_color        = 0,
      blip_scale        = 0.8,
      blip_text         = Labels.key_shop_bliptxt,
      blip_display      = 2,
      blip_short_range  = false,
      blip_high_detail  = true,

      -- Content of Shop
      content = {
        {
          -- Item name (relevant to database item names).
          item_name  = "keys_missionrow_pd_front",

          -- Item label (purely for menu).
          item_label = "Mission Row PD Keys (Front)",

          -- Derp?
          item_price = 500,

          -- Is this item restricted to authorized jobs below?
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
  },

  Doors = {
    {
      -- Locked by default?
      locked = true,

      -- Can the door be unlocked/locked from inside vehicle?
      interact_in_veh = true,

      -- Distance to interact.
      dist = 3.0,

      -- Distance to render.
      draw = 9.0,

      -- Interact text location.
      text_loc = vector3(1844.998,2608.50,46.00),

      -- Can jobs from RaidAccess table lock/unlock this door uninhibited?
      allow_raid = true,

      -- Jobs that can unlock this door.
      -- NOTE: No need to put RaidAccess jobs in here if allow_raid is set to true above.
      -- NOTE: I only put them in here for an example.
      auth_jobs = {
        police    = {min_rank = 0},
        kmar  = {min_rank = 0},
      },

      -- Items that can unlock this door.
      auth_items = {
        keys_missionrow_pd_front    = {take_item = false},
        keys_master_key_single_use  = {take_item = false},
        keys_master_key             = {take_item = false},
      },

      -- Can this door be broken into?
      can_break = true,
      -- Items that can break this door.
      -- Key is item name, value is corresponding action.
      break_items = {
        lockpick        = {minigame = "Lockpick",   take_item = false, take_on_fail = true},
        hacking_laptop  = {minigame = "Hacking",    take_item = false, take_on_fail = true},
        --lockpickv2      = false,
        --thermite        = false,
      },

      -- Difficulty preset for hacking minigame on this door.
      -- NOTE: Only required if using hacking on this door.
      hacking_preset = {
        time    = 35,
        letters = 7,
      },

      -- Difficulty preset for lockpicking minigame on this door.
      -- NOTE: Only required if using lockpicking on this door.
      lockpick_preset = {
        pins = 4
      },

      -- Difficulty preset for thermite minigame on this door.
      -- NOTE: Only required if using thermite on this door.
      thermite_preset = {  
        difficulty        = 0.5,
        speed_scale       = 1.5,
        score_inc         = 0.5,
      },

      -- Door definitions
      objects = {
        -- Each door object held in its own table.
        {
          -- Reposition the door on lock? 
          -- I only used this on the large prison gates. Other large doors may need to be repositioned also.
           reposition = true,
          -- Specify the door objects model, location and target rotation while locked.
          door_model = GetHashKey('prop_gate_prison_01'),
          door_loc   = vector3(1844.998,2604.810,44.638),
          door_rot   = vector3(0.0,0.0,90.0),
        },
        {
          reposition = true,
          door_model = GetHashKey('prop_gate_prison_01'),
          door_loc   = vector3(1844.998,2604.810,44.638),
          door_rot   = vector3(0.0,0.0,90.0),
        },
      }
    },
    {
      locked = true,
      interact_in_veh = true,

      dist = 5.0,
      draw = 10.0,

      text_loc = vector3(1818.542,2608.512,46.011),

      allow_raid = true,
      auth_jobs = {
        police = {min_rank = 0},
        kmar = {min_rank = 0},
      },

      auth_items = {
        keys_master_key_single_use  = {take_item = false},
        keys_master_key             = {take_item = false},
      },

      can_break = true,
      break_items = {
        lockpick        = {minigame = "Lockpick",   take_item = false, take_on_fail = true},
        hacking_laptop  = {minigame = "Hacking",    take_item = false, take_on_fail = true},
        --lockpickv2      =false,
        --thermite        = false,
      },

      hacking_preset = {
        time    = 35,
        letters = 7,
      },

      lockpick_preset = {
        pins = 4
      },

      thermite_preset = {  
        difficulty        = 0.5,
        speed_scale       = 1.5,
        score_inc         = 0.5,
      },

      objects = {
        {
          reposition = true,
          door_model = GetHashKey('prop_gate_prison_01'),
          door_loc   = vector3(1818.542,2604.812,44.611),
          door_rot   = vector3(0.0,0.0,90.0),
        },
      }
    },
    {    

      dist = 0,
      draw = 0,  
      auth_jobs = {
        police = {min_rank = 0},
        kmar = {min_rank = 0},
      },
      break_items = {
        lockpick = false,
        thermite = {minigame = 'Thermite',take_on_fail = false,take_item = false},
        hacking_laptop = false,
        lockpickv2 = false,
      },
      locked = true,
      thermite_preset = {
        score_inc = 1,
        difficulty = 0.5,
        speed_scale = 0.5,
      },
      interact_in_veh = true,
      text_loc = vector3(22.14923, 6433.033, 31.37436),
      can_break = false,
      objects = {
        [1] = {
          door_rot = vector3(0, 0, 44.99994),
          door_loc = vector3(22.14923, 6433.033, 30.41879),
          reposition = false,
          door_model = -2007495856,
        },
      },
      allow_raid = false,
    }
  }
}

mLibs = exports["meta_libs"]