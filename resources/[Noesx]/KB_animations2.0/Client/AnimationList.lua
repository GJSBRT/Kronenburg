--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
DP = {}

-- Alle animaties in het zitmenu
DP.SitEmotes = {

   ["sit"] = {"anim@amb@business@bgen@bgen_no_work@", "sit_phone_phoneputdown_idle_nowork", "Zitten", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit2"] = {"rcm_barry3", "barry_3_sit_loop", "Zitten 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit3"] = {"amb@world_human_picnic@male@idle_a", "idle_a", "Zitten 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit4"] = {"amb@world_human_picnic@female@idle_a", "idle_a", "Zitten 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit5"] = {"anim@heists@fleeca_bank@ig_7_jetski_owner", "owner_idle", "Zitten 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit6"] = {"timetable@jimmy@mics3_ig_15@", "idle_a_jimmy", "Zitten 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit7"] = {"anim@amb@nightclub@lazlow@lo_alone@", "lowalone_base_laz", "Zitten 7", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit8"] = {"timetable@jimmy@mics3_ig_15@", "mics3_15_base_jimmy", "Zitten 8", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit9"] = {"amb@world_human_stupor@male@idle_a", "idle_a", "Zitten 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitsad"] = {"anim@amb@business@bgen@bgen_no_work@", "sit_phone_phoneputdown_sleeping-noworkfemale", "Verdrietig Zitten", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitscared"] = {"anim@heists@ornate_bank@hostages@hit", "hit_loop_ped_b", "Angstig Zitten", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitscared2"] = {"anim@heists@ornate_bank@hostages@ped_c@", "flinch_loop", "Angstig Zitten 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitscared3"] = {"anim@heists@ornate_bank@hostages@ped_e@", "flinch_loop", "Angstig Zitten 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitdrunk"] = {"timetable@amanda@drunk@base", "base", "Dronken Zitten", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchair"] = {"ScenarioObject", "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER", "Zitten Stoel"},

   ["sitchair2"] = {"timetable@ron@ig_5_p3", "ig_5_p3_base", "Zitten Stoel 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchair3"] = {"timetable@reunited@ig_10", "base_amanda", "Zitten Stoel 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchair4"] = {"timetable@ron@ig_3_couch", "base", "Zitten Stoel 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchair5"] = {"timetable@jimmy@mics3_ig_15@", "mics3_15_base_tracy", "Zitten Stoel 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchair6"] = {"timetable@maid@couch@", "base", "Zitten Stoel 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchairside"] = {"timetable@ron@ron_ig_2_alt1", "ig_2_alt1_base", "Zitten Stoel Zijkant", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["campingstoel"]    = { "timetable@ron@ig_5_p3", "ig_5_p3_base", "Campingstoel", AnimationOptions = {
    Prop          = "prop_skid_chair_02",
    PropBone      = 0,
    PropPlacement = { 0.025, -0.2, -0.1, 45.0, -5.0, 180.0 },
    EmoteLoop     = true,
    EmoteMoving   = false,
    }},
    ["campingstoel2"]    = { "timetable@reunited@ig_10", "base_amanda", "Campingstoel 2", AnimationOptions = {
    Prop          = "prop_skid_chair_02",
    PropBone      = 0,
    PropPlacement = { 0.025, -0.15, -0.1, 45.0, 5.0, 180.0 },
    EmoteLoop     = true,
    EmoteMoving   = false,
    }},
    ["campingstoel3"]    = { "timetable@ron@ig_3_couch", "base", "Campingstoel 3", AnimationOptions = {
    Prop          = "prop_skid_chair_02",
    PropBone      = 0,
    PropPlacement = { -0.05, 0.0, -0.2, 5.0, 0.0, 180.0 },
    EmoteLoop     = true,
    EmoteMoving   = false,
    }},
}




DP.WaveEmotes = {
    ["wave4"] = {"random@mugging5", "001445_01_gangintimidation_1_female_idle_b", "Zwaaien 4", AnimationOptions =
    {
        EmoteMoving = true,
        EmoteDuration = 3000,
    }},
    ["wave2"] = {"anim@mp_player_intcelebrationfemale@wave", "wave", "Zwaaien 2", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["wave3"] = {"friends@fra@ig_1", "over_here_idle_a", "Zwaaien 3", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["wave"] = {"friends@frj@ig_1", "wave_a", "Zwaaien", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["wave5"] = {"friends@frj@ig_1", "wave_b", "Zwaaien 5", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["wave6"] = {"friends@frj@ig_1", "wave_c", "Zwaaien 6", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["wave7"] = {"friends@frj@ig_1", "wave_d", "Zwaaien 7", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["wave8"] = {"friends@frj@ig_1", "wave_e", "Zwaaien 8", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["wave9"] = {"gestures@m@standing@casual", "gesture_hello", "Zwaaien 9", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["whistle"] = {"taxi_hail", "hail_taxi", "Fluiten", AnimationOptions =
    {
        EmoteMoving = true,
        EmoteDuration = 1300,
    }},
    ["whistle2"] = {"rcmnigel1c", "hailing_whistle_waive_a", "Fluiten 2", AnimationOptions =
    {
        EmoteMoving = true,
        EmoteDuration = 2000,
    }},
    ["namaste"] = {"timetable@amanda@ig_4", "ig_4_base", "Chinese Groet", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["bow"] = {"anim@arena@celeb@podium@no_prop@", "regal_c_1st", "Buiging", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["bow2"] = {"anim@arena@celeb@podium@no_prop@", "regal_a_1st", "Buiging 2", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["handshake"] = {"mp_ped_interaction", "handshake_guy_a", "Handschudden", AnimationOptions =
    {
        EmoteMoving = true,
        EmoteDuration = 3000
    }},
    ["handshake2"] = {"mp_ped_interaction", "handshake_guy_b", "Handschudden 2", AnimationOptions =
    {
        EmoteMoving = true,
        EmoteDuration = 3000
    }},
    ["hug"] = {"mp_ped_interaction", "kisses_guy_a", "Knuffel"},
    ["hug2"] = {"mp_ped_interaction", "kisses_guy_b", "Knuffel 2"},
    ["hug3"] = {"mp_ped_interaction", "hugs_guy_a", "Knuffel 3"},
}


DP.WorkEmotes = {
    ["janitor"] = {"Scenario", "WORLD_HUMAN_JANITOR", "Schoonmaken"},
    ["weld"] = {"Scenario", "WORLD_HUMAN_WELDING", "Lassen"},
    ["drill"] = {"Scenario", "WORLD_HUMAN_CONST_DRILL", "Drillboor"},
   ["wateringcan"] = {"weapons@misc@jerrycan@franklin", "idle", "Gieter dragen", AnimationOptions =
   {
      Prop = "prop_wateringcan",
      PropBone = 28422,
      PropPlacement = {0.4000, 0.0000, 0.0000, 0.0000, -90.0000, 70.0000},
      EmoteLoop = true,
      EmoteMoving = true,
   }},
    ["shinetorch"] = {"Scenario", "WORLD_HUMAN_SECURITY_SHINE_TORCH", "Zaklamp Schijnen"},
    ["mechanic"] = {"mini@repair", "fixing_a_ped", "Monteur", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["mechanic2"] = {"amb@world_human_vehicle_mechanic@male@base", "idle_a", "Monteur 2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["mechanic3"] = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", "Monteur 3", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["mechanic4"] = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", "Monteur 4", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["fishing1"] = {"amb@world_human_stand_fishing@idle_a", "idle_a", "Vissen", AnimationOptions =
    {
       Prop = 'prop_fishing_rod_01',
       PropBone = 60309,
       PropPlacement = {0.0,0.0,0.0,0.0,0.0,0.0},
       EmoteLoop = true,
       EmoteMoving = false,
    }},
    ["fishing2"] = {"amb@world_human_stand_fishing@idle_a", "idle_b", "Vissen 2", AnimationOptions =
    {
       Prop = 'prop_fishing_rod_01',
       PropBone = 60309,
       PropPlacement = {0.0,0.0,0.0,0.0,0.0,0.0},
       EmoteLoop = true,
       EmoteMoving = false,
    }},
    ["fishing3"] = {"amb@world_human_stand_fishing@idle_a", "idle_c", "Vissen 3", AnimationOptions =
    {
       Prop = 'prop_fishing_rod_01',
       PropBone = 60309,
       PropPlacement = {0.0,0.0,0.0,0.0,0.0,0.0},
       EmoteLoop = true,
       EmoteMoving = false,
    }},
    ["radio"] = {"random@arrests", "generic_radio_chatter", "Radio", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["cop2"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Agent 2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["cop3"] = {"amb@code_human_police_investigate@idle_a", "idle_b", "Agent 3", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["cop4"] = {"amb@code_human_police_investigate@idle_b", "idle_e", "Agent 4", AnimationOptions =
    {
        EmoteLoop = false,
        EmoteMoving = false,
    }},
    ["cop5"] = {"amb@code_human_police_investigate@idle_b", "idle_f", "Agent 5", AnimationOptions =
    {
        EmoteLoop = false,
        EmoteMoving = false,
    }},
    ["cop6"] = {"cellphone@", "cellphone_text_read_base", "Agent 6", AnimationOptions =
    {
       Prop = "prop_casey_sec_id",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
    }},
    ["cop"] = {"Scenario", "WORLD_HUMAN_COP_IDLES", "Agent"},
    ["copbeacon"] = {"MaleScenario", "WORLD_HUMAN_CAR_PARK_ATTENDANT", "Verkeer begeleiden"},
    ["dj"] = {"anim@amb@nightclub@djs@dixon@", "dixn_dance_cntr_open_dix", "DJ", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},    
    ["microphone"] = {"anim@amb@nightclub@lazlow@ig1_vip@","clubvip_dlg_cloeparker_laz", "Microfoon 1", AnimationOptions =
    {
        Prop = "ba_prop_battle_mic",
        PropBone = 28422,
        PropPlacement = {0.0000, 0.0000, 0.0000, 0.0000, 0.0000,0.0000},
        EmoteMoving = true,
        EmoteLoop = true
    }},
    ["microphone2"] = {"anim@amb@nightclub@lazlow@ig1_vip@","clubvip_dlg_januarynastasavasq_laz", "Microfoon 2", AnimationOptions =
    {
        Prop = "ba_prop_battle_mic",
        PropBone = 28422,
        PropPlacement = {0.0000, 0.0000, 0.0000, 0.0000, 0.0000,0.0000},
        EmoteMoving = true,
        EmoteLoop = true
    }},
    ["microphone3"] = {"anim@amb@nightclub@lazlow@ig1_vip@","clubvip_dlg_tonymctony_laz", "Microfoon 3", AnimationOptions =
    {
        Prop = "ba_prop_battle_mic",
        PropBone = 28422,
        PropPlacement = {0.0000, 0.0000, 0.0000, 0.0000, 0.0000,0.0000},
        EmoteMoving = true,
        EmoteLoop = true
    }},
    ["microphone4"] = {"anim@amb@nightclub@lazlow@ig1_vip@","clubvip_dlg_tylerdixon_laz", "Microfoon 4", AnimationOptions =
    {
        Prop = "ba_prop_battle_mic",
        PropBone = 28422,
        PropPlacement = {0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
        EmoteMoving = true,
        EmoteLoop = true
    }},
    ["microphone5"] = {"anim@amb@nightclub@lazlow@ig1_vip@","clubvip_dlg_kerrymacintosh_laz", "Microfoon 5", AnimationOptions =
    {
        Prop = "ba_prop_battle_mic",
        PropBone = 28422,
        PropPlacement = {0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
        EmoteMoving = true,
        EmoteLoop = true
    }},
    ["cpr"] = {"mini@cpr@char_a@cpr_str", "cpr_pumpchest", "Reanimeren", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["cpr2"] = {"mini@cpr@char_a@cpr_str", "cpr_pumpchest", "Reanimeren 2", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["guard"] = {"anim@amb@nightclub@peds@", "amb_world_human_stand_guard_male_base", "Beveiligen", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
        RemoveWeapon = false,
    }},
    ["guard2"] = {"anim@miss@low@fin@vagos@", "idle_ped06", "Beveiligen 2", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    -- ["guard3"] = {"anim@scripted@anim_yacht@yacht_ig1_hostage@", "leader_idle_leader", "Beveiligen 3", AnimationOptions =
    -- {
    --     EmoteLoop = true,
    --     EmoteMoving = false,
    -- }},
    ["guard4"] = {"oddjobs@assassinate@guard","unarmed_earpiece_b", "Beveiligen 4", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["hammer"] = {"Scenario", "WORLD_HUMAN_HAMMERING", "Timmeren"},
    ["inspect"] = {"random@train_tracks", "idle_e", "Inspect"},
    ["uncuff"] = {"mp_arresting", "a_uncuff", "Unboeien", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["stickup"] = {"random@countryside_gang_fight", "biker_02_stickup_loop", "Pistool Richten", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
        RemoveWeapon = false,
    }},
    ["reaching"] = {"move_m@intimidation@cop@unarmed", "idle", "Holster", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
        RemoveWeapon = false,
    }},
    ["leafblower"] = {"MaleScenario", "WORLD_HUMAN_GARDENER_LEAF_BLOWER", "Bladblazer"},
    ["maid"] = {"Scenario", "WORLD_HUMAN_MAID_CLEAN", "Schoonmaakster"},
    ["medic"] = {"Scenario", "CODE_HUMAN_MEDIC_TEND_TO_DEAD", "Ambulancier"},
    ["musician"] = {"MaleScenario", "WORLD_HUMAN_MUSICIAN", "Musikant"},
   ["streetartist"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Straatartiest", AnimationOptions =
   {
    Prop = 'prop_acc_guitar_01',
    PropBone = 24818,
    PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
    SecondProp = 'prop_busker_hat_01',
    SecondPropBone = 52301,
    SecondPropPlacement = {1.1000, 0.2640, -0.0400, -90.0000, 0.0000, 20.0000},
    EmoteLoop = true,
    EmoteMoving = false,
   }},
    ["notepad2"] = {"Scenario", "CODE_HUMAN_MEDIC_TIME_OF_DEATH", "Notitieboekje 2"},
    ["prosthigh"] = {"Scenario", "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS", "Prostitiuee High"},
    ["prostlow"] = {"Scenario", "WORLD_HUMAN_PROSTITUTE_LOW_CLASS", "Prostitiuee Low"},
    ["medic2"] = {"amb@medic@standing@tendtodead@base", "base", "Ambulancier 2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["lawyer"] = {"move_m@intimidation@cop@unarmed", "idle", "Advocaat", AnimationOptions =
    {
       Prop = "prop_cs_binder_01",
       PropBone = 28422,
       PropPlacement = {0.0, 0.09, -0.03, 34.5292489, -8.7984452, -6.1132488},
       EmoteLoop = true,
       EmoteMoving = true,
    }},
    ["lawyer2"] = {"cellphone@", "cellphone_text_read_base", "Advocaat 2", AnimationOptions =
    {
        Prop = 'p_ringbinder_01_s',
        PropBone = 28422,
        PropPlacement = {0.0, -0.04, 0.0, 85.0000, 0.0, 0.0},
        EmoteMoving = true,
        EmoteLoop = true
    }},
    ["wood"] = {"move_m@intimidation@cop@unarmed", "idle", "Hout Dragen", AnimationOptions =
    {
       Prop = "prop_fncwood_14a",
       PropBone = 57005,
       PropPlacement = {-0.15, 0.4  , 0.4, 144.9999998, 0, 0},
       EmoteLoop = true,
       EmoteMoving = true,
    }},
   ["vrehbo"] = {"move_weapon@jerrycan@generic", "idle", "Veiligheidsregio EHBO Koffer", AnimationOptions =
   {
       Prop = "prop_security_case_02",
       PropBone = 28422,
       PropPlacement = {0.0000, 0.0000, 0.0000, 0.0000, -90.0000, 90.0000},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["vrlifepack"] = {"move_weapon@jerrycan@generic", "idle", "Veiligheidsregio Lifepack", AnimationOptions =
   {
       Prop = "prop_ld_case_01",
       PropBone = 28422,
       PropPlacement = {0.0800, 0.0000, 0.0000, 0.0000, -90.0000, 90.0000},
       EmoteLoop = true,
       EmoteMoving = true,
   }}, 
   ["vraed"] = {"move_weapon@jerrycan@generic", "idle", "Veiligheidsregio AED", AnimationOptions =
   {
       Prop = "prop_security_case_01",
       PropBone = 28422,
       PropPlacement = {0.0800, 0.0000, -0.0100, 0.0000, -90.0000, 90.0000},
       EmoteLoop = true,
       EmoteMoving = true,
   }}, 
   ["vrlucas"] = {"move_p_m_zero_rucksack", "idle", "Veiligheidsregio Lucas", AnimationOptions =
   {
       Prop = "prop_michael_backpack",
       PropBone = 24818,
       PropPlacement = {0.0, 0.48, -0.03, -90.0, 90.0, 180.0},
       EmoteMoving = true,
       EmoteLoop = true
   }}, 
   ["vrlucas2"] = {"anim@gangops@morgue@table@", "body_search", "Veiligheidsregio Lucas 2", AnimationOptions =
   {
       Prop = "prop_ld_health_pack",
       PropBone = SKEL_ROOT,
       PropPlacement = {0.0000, -0.1400, 0.2600, -70.0000, 0.0000, 0.0000},
       EmoteMoving = false,
       EmoteLoop = true
   }}, 
   ["vrtraumatas"] = {"move_weapon@jerrycan@generic", "idle", "Veiligheidsregio Traumatas", AnimationOptions =
   {
      Prop = "prop_beachbag_01",
      PropBone = 57005,
      PropPlacement = {0.43, 0.0, 0.03, 0.0, 263.0, 75.0},
      EmoteLoop = true,
      EmoteMoving = true,
   }},
   ["vrtafel"] = {"anim@gangops@morgue@table@","player_search", "Veiligheidsregio behandelen op operatietafel", AnimationOptions =
   {
       EmoteLoop = false,
   }},
   ["guncase"] = {"move_weapon@jerrycan@generic", "idle", "Wapenkoffer Sniper", AnimationOptions =
   {
      Prop = "prop_gun_case_01",
      PropBone = 28422,
      PropPlacement = {0.0600, 0.0000, 0.0000, 0.0000, 0.0000, -90.0000},
      EmoteLoop = true,
      EmoteMoving = true,
   }},
--[[  ["vrscalpel"] = {"bz@give_love@anim", "bz_give", "Veiligheidsregio Scalpel", AnimationOptions =
  {
      Prop = "v_res_r_silvrtray",
      PropBone = 28422,
      PropPlacement = {0.1180, -0.1000, 0.0000, 90.0000, 0.0000, -10.0000},
      SecondProp = 'prop_scalpel',
      SecondPropBone = 28422,
      SecondPropPlacement = {0.2000, -0.1300, 0.0000, 90.0000, -100.0000, 0.0000},
      EmoteLoop = true,
      EmoteMoving = true,
  }},]]
   --[[["lucas2"] = {"missheistdocksprep1hold_cellphone", "static", "Ambulance Lucas - 2", AnimationOptions =
   {
       Prop = "prop_ld_health_pack",
       PropBone = 57005,
       PropPlacement = {0.15, 0.0, -0.02, -20.0, 280.0, 53.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},]]
   -- Pion
   ["pionhoudvast"] = {"move_weapon@jerrycan@generic", "idle", "Pion Vasthouden", AnimationOptions =
   {
       Prop = "prop_roadcone02a",
       PropBone = 28422,
       PropPlacement = {0.6500, 0.1100, -0.0100, 10.0000, -90.0000, 0.0000},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
-- ANWB ANIMATIES --
   ["anwbkoffer"] = {"move_weapon@jerrycan@generic", "idle", "ANWB Gereedschapskist", AnimationOptions =
   {
       Prop = "prop_toolchest_01",
       PropBone = 57005,
       PropPlacement = {0.4750, 0.0100, 0.0000, 0.0000, -91.0000, 80.0000},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["anwbmotorkap"] = {"veh@lo_res_idles", "bus_driver", "ANWB Motorkap Pakken", AnimationOptions =
   {
      Prop = "prop_sacktruck_02a",
      PropBone = 28422,
      PropPlacement = {0.1500, -0.9100, -1.0000, -90.0000, 88.0000, 39.9000},
      SecondProp = 'prop_car_bonnet_01',
      SecondPropBone = 28422,
      SecondPropPlacement = {0.3200, -0.9000, -0.9100, -89.3970, 69.6212, 38.8274},
      EmoteLoop = true,
      EmoteMoving = true,
   }},
   ["anwbdeur"] = {"veh@lo_res_idles", "bus_driver", "ANWB Deur Pakken", AnimationOptions =
   {
      Prop = "prop_sacktruck_02a",
      PropBone = 28422,
      PropPlacement = {0.1500, -0.9100, -1.0000, -90.0000, 88.0000, 39.9000},
      SecondProp = 'imp_prop_impexp_car_door_04a',
      SecondPropBone = 28422,
      SecondPropPlacement = {0.3000, -0.8000, -0.2300, -129.4000, -180.0000, 6.0000},
      EmoteLoop = true,
      EmoteMoving = true,
   }},
  ["anwbbumper"] = {"anim@heists@box_carry@", "idle", "ANWB Bumper Pakken", AnimationOptions =
  {
      Prop = "prop_bumper_04",
      PropBone = 28422,
      PropPlacement = {0.0000, 0.1400, 0.0400, 0.0000, 0.0000, 6.0000},
      EmoteLoop = true,
      EmoteMoving = true,
  }},
  ["anwbwiel"] = {"anim@heists@box_carry@", "idle", "ANWB Reservewiel Pakken", AnimationOptions =
  {
      Prop = "prop_rub_tyre_01",
      PropBone = 60309,
      PropPlacement = {0.125, 0.13, 0.255, -345.0, 330.0, 0.0},
      EmoteLoop = true,
      EmoteMoving = true,
  }},
  ["anwbvelg"] = {"anim@heists@box_carry@", "idle", "ANWB Velg Dragen", AnimationOptions =
  {
      Prop = "prop_wheel_rim_04",
      PropBone = 60309,
      PropPlacement = {0.125, 0.13, 0.255, 190.0, 330.0, 0.0},
      EmoteLoop = true,
      EmoteMoving = true,
   }}, 
   ["anwbliggen"] = {"Scenario", "WORLD_HUMAN_VEHICLE_MECHANIC", "ANWB Liggen onder voertuig", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["clean"] = {"timetable@floyd@clean_kitchen@base", "base", "Schoonmaken", AnimationOptions =
   {
       Prop = "prop_sponge_01",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, -0.01, 90.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["clean2"] = {"amb@world_human_maid_clean@", "base", "Schoonmaken 2", AnimationOptions =
   {
       Prop = "prop_sponge_01",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, -0.01, 90.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["notepad"] = {"missheistdockssetup1clipboard@base", "base", "Notiteboekje", AnimationOptions =
   {
       Prop = 'prop_notepad_01',
       PropBone = 18905,
       PropPlacement = {0.1, 0.02, 0.05, 10.0, 0.0, 0.0},
       SecondProp = 'prop_pencil_01',
       SecondPropBone = 58866,
       SecondPropPlacement = {0.11, -0.02, 0.001, -120.0, 0.0, 0.0},
       -- EmoteLoop is used for emotes that should loop, its as simple as that.
       -- Then EmoteMoving is used for emotes that should only play on the upperbody.
       -- The code then checks both values and sets the MovementType to the correct one
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["clipboard"] = {"missfam4", "base", "Clipboard", AnimationOptions =
   {
       Prop = 'p_amb_clipboard_01',
       PropBone = 36029,
       PropPlacement = {0.16, 0.08, 0.1, -130.0, -50.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["clipboard2"] = {"anim@amb@business@bgen@bgen_inspecting@", "inspecting_high_lookingaround_inspector", "Clipboard 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
       Prop = "p_amb_clipboard_01",
       PropBone = 36029,
       PropPlacement = {0.1600, 0.0800, 0.0390, -130.0000, -40.0000, 0.0000},
       SecondProp = 'prop_pencil_01',
       SecondPropBone = 58866,
       SecondPropPlacement = {0.0800, -0.0400, 0.0180, -120.0000, 0.0000, 0.0000},
   }},    
   ["clipboard3"] = {"anim@amb@business@bgen@bgen_inspecting@", "inspecting_med_counting_02_inspector", "Clipboard 3", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
       Prop = "p_amb_clipboard_01",
       PropBone = 36029,
       PropPlacement = {0.1600, 0.0800, 0.0390, -130.0000, -40.0000, 0.0000},
       SecondProp = 'prop_pencil_01',
       SecondPropBone = 58866,
       SecondPropPlacement = {0.0800, -0.0400, 0.0180, -120.0000, 0.0000, 0.0000},
   }},
    ["mop"] = {"missfbi4prepp1", "idle", "Dweil", AnimationOptions =
    {
       Prop = "prop_cs_mop_s",
       PropBone = 28422,
       PropPlacement = {-0.0200,-0.0600,-0.2000, -13.377, 10.3568, 17.9681},
       EmoteLoop = true,
       EmoteMoving = true,
    }},
    ["mop2"] = {"move_mop", "idle_scrub_small_player", "Dweil 2", AnimationOptions =
    {
       Prop = "prop_cs_mop_s",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.1200, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
    }},
    -- ["rake"] = {"anim@amb@drug_field_workers@rake@male_a@base", "base", "Hark", AnimationOptions =
    -- {
    --    Prop = "prop_tool_rake",
    --    PropBone = 28422,
    --    PropPlacement = {0.0, 0.0, -0.0300, 0.0, 0.0, 0.0},
    --    EmoteLoop = true,
    -- }},
    -- ["rake2"] = {"anim@amb@drug_field_workers@rake@male_a@idles", "idle_b", "Hark 2", AnimationOptions =
    -- {
    --    Prop = "prop_tool_rake",
    --    PropBone = 28422,
    --    PropPlacement = {0.0, 0.0, -0.0300, 0.0, 0.0, 0.0},
    --    EmoteLoop = true,
    -- }},
    -- ["rake3"] = {"anim@amb@drug_field_workers@rake@male_b@base", "base", "Hark 3", AnimationOptions =
    -- {
    --    Prop = "prop_tool_rake",
    --    PropBone = 28422,
    --    PropPlacement = {0.0, 0.0, -0.0300, 0.0, 0.0, 0.0},
    --    EmoteLoop = true,
    -- }},
    -- ["rake4"] = {"anim@amb@drug_field_workers@rake@male_b@idles", "idle_d", "Hark 4", AnimationOptions =
    -- {
    --    Prop = "prop_tool_rake",
    --    PropBone = 28422,
    --    PropPlacement = {0.0, 0.0, -0.0300, 0.0, 0.0, 0.0},
    --    EmoteLoop = true,
    -- }},
    -- ["broom"] = {"anim@amb@drug_field_workers@rake@male_a@base", "base", "Bezemen", AnimationOptions =
    -- {
    --    Prop = "prop_tool_broom",
    --    PropBone = 28422,
    --    PropPlacement = {-0.0100, 0.0400, -0.0300, 0.0, 0.0, 0.0},
    --    EmoteLoop = true,
    -- }},
    -- ["broom2"] = {"anim@amb@drug_field_workers@rake@male_a@idles", "idle_b", "Bezemen 2", AnimationOptions =
    -- {
    --    Prop = "prop_tool_broom",
    --    PropBone = 28422,
    --    PropPlacement = {-0.0100, 0.0400, -0.0300, 0.0, 0.0, 0.0},
    --    EmoteLoop = true,
    -- }},
    -- ["broom3"] = {"anim@amb@drug_field_workers@rake@male_b@base", "base", "Bezemen 3", AnimationOptions =
    -- {
    --    Prop = "prop_tool_broom",
    --    PropBone = 28422,
    --    PropPlacement = {-0.0100, 0.0400, -0.0300, 0.0, 0.0, 0.0},
    --    EmoteLoop = true,
    -- }},
    -- ["broom4"] = {"anim@amb@drug_field_workers@rake@male_b@idles", "idle_d", "Bezemen 4", AnimationOptions =
    -- {
    --    Prop = "prop_tool_broom",
    --    PropBone = 28422,
    --    PropPlacement = {-0.0100, 0.0400, -0.0300, 0.0, 0.0, 0.0},
    --    EmoteLoop = true,
    -- }},
    ["shovel"] = {"move_mop", "idle", "Schep", AnimationOptions =
    {
       Prop = "prop_tool_shovel2",
       PropBone = 18905,
       PropPlacement = {0.4000, -0.7700, 0.3200, -110.4488, 73.7169, -15.4016},
       EmoteLoop = true,
       EmoteMoving = true,
    }},
    ["dig"] = {"random@burial", "a_burial", "Graven met schep", AnimationOptions =
    {
       Prop = "prop_tool_shovel2",
       PropBone = 28422,
       PropPlacement = {-0.0200, -0.0700, -0.9000, 0.0000, 0.0000, 0.0000},
       EmoteLoop = true,
       EmoteMoving = false,
    }},
}

DP.FoodEmotes = {
    ["coffee"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Koffie", AnimationOptions =
    {
        Prop = 'p_amb_coffeecup_01',
        PropBone = 28422,
        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
   ["cocktail"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Cocktail", AnimationOptions =
   {
       Prop = 'prop_cocktail',
       PropBone = 18905,
       PropPlacement = {0.0600, -0.0400, 0.0800, -100.0000, 0.0000, -10.0000},
       EmoteMoving = true,
       EmoteLoop = true
   }},
    ["candy"] = {"mp_player_inteat@pnq", "loop", "Snoep", AnimationOptions =
    {
       Prop = 'prop_candy_pqs',
       PropBone = 60309,
       PropPlacement = {-0.0300, 0.0180, 0.0, 180.0, 180.0, -88.099},
       EmoteMoving = true,
    }},
    ["whiskey"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Whiskey Glas", AnimationOptions =
    {
        Prop = 'prop_drink_whisky',
        PropBone = 28422,
        PropPlacement = {0.01, -0.01, -0.06, 0.0, 0.0, 0.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["whiskeyb"] = {"amb@world_human_drinking@beer@male@idle_a", "idle_a", "Whiskey Fles", AnimationOptions =
    {
       Prop = 'ba_prop_battle_whiskey_bottle_2_s',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.05, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
    }},
    ["beer"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Bier", AnimationOptions =
    {
        Prop = 'prop_amb_beer_bottle',
        PropBone = 28422,
        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["beerbox"] = {"move_weapon@jerrycan@generic", "idle", "Sixpack Bier 1", AnimationOptions =
    {
       Prop = "v_ret_ml_beerdus",
       PropBone = 57005,
       PropPlacement = {0.22, 0.0, 0.0, 0.0, 266.0, 48.0},
       EmoteLoop = true,
       EmoteMoving = true,
    }},
    ["beerbox2"] = {"move_weapon@jerrycan@generic", "idle", "Sixpack Bier 2", AnimationOptions =
    {
       Prop = "v_ret_ml_beeram",
       PropBone = 57005,
       PropPlacement = {0.22, 0.0, 0.0, 0.0, 266.0, 48.0},
       EmoteLoop = true,
       EmoteMoving = true,
    }},
    ["beerbox3"] = {"move_weapon@jerrycan@generic", "idle", "Sixpack Bier 3", AnimationOptions =
    {
       Prop = "v_ret_ml_beerpride",
       PropBone = 57005,
       PropPlacement = {0.22, 0.0, 0.0, 0.0, 266.0, 48.0},
       EmoteLoop = true,
       EmoteMoving = true,
    }},
    ["beerbox4"] = {"move_weapon@jerrycan@generic", "idle", "Sixpack Bier 4", AnimationOptions =
    {
       Prop = "v_ret_ml_beerbar",
       PropBone = 57005,
       PropPlacement = {0.22, 0.0, 0.0, 0.0, 266.0, 60.0},
       EmoteLoop = true,
       EmoteMoving = true,
    }},
    ["cup"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Beker", AnimationOptions =
    {
        Prop = 'prop_plastic_cup_02',
        PropBone = 28422,
        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["donut"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Donut", AnimationOptions =
    {
        Prop = 'prop_amb_donut',
        PropBone = 18905,
        PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
        EmoteMoving = true,
    }},
    ["burger"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Burger", AnimationOptions =
    {
        Prop = 'prop_cs_burger_01',
        PropBone = 18905,
        PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
        EmoteMoving = true,
    }},
    ["sandwich"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Sandwich", AnimationOptions =
    {
        Prop = 'prop_sandwich_01',
        PropBone = 18905,
        PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
        EmoteMoving = true,
    }},
    ["soda"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Soda", AnimationOptions =
    {
        Prop = 'prop_ecola_can',
        PropBone = 28422,
        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 130.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["egobar"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Chocoladereep", AnimationOptions =
    {
        Prop = 'prop_choc_ego',
        PropBone = 60309,
        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        EmoteMoving = true,
    }},
    ["wine"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Wijn", AnimationOptions =
    {
        Prop = 'prop_drink_redwine',
        PropBone = 18905,
        PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
        EmoteMoving = true,
        EmoteLoop = true
    }},
    ["flute"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Champagne glas", AnimationOptions =
    {
        Prop = 'prop_champ_flute',
        PropBone = 18905,
        PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
        EmoteMoving = true,
        EmoteLoop = true
    }},
    ["champagne"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Champagne", AnimationOptions =
    {
        Prop = 'prop_drink_champ',
        PropBone = 18905,
        PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
        EmoteMoving = true,
        EmoteLoop = true
    }},
   ["champagnespray"] = {"anim@mp_player_intupperspray_champagne", "idle_a", "Champagne Spray", AnimationOptions =
   {
       Prop = 'ba_prop_battle_champ_open',
       PropBone = 28422,
       PropPlacement = {0.0,0.0,0.0,0.0,0.0,0.0},
       EmoteMoving = true,
       EmoteLoop = true,
       PtfxAsset = "scr_ba_club",
       PtfxName = "scr_ba_club_champagne_spray",
       PtfxPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['makeitrain'],
       PtfxWait = 500,
   }},
    ["bbq"] = {"MaleScenario", "PROP_HUMAN_BBQ", "BBQ"},
    ["drink"] = {"mp_player_inteat@pnq", "loop", "Drinken", AnimationOptions =
    {
        EmoteMoving = true,
        EmoteDuration = 2500,
    }},
    ["eat"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Eten", AnimationOptions =
    {
        EmoteMoving = true,
        EmoteDuration = 3000,
    }},
    ["carryfoodtray"] = {"anim@heists@box_carry@", "idle", "Dienblad dragen", AnimationOptions =
   {
      Prop = "prop_food_bs_tray_03",
      PropBone = 28422,
      PropPlacement = {0.0100, -0.0400, -0.1390,20.0000007, 0.0, 0.0},
      EmoteLoop = true,
      EmoteMoving = true,
    }},
    ["carryfoodtray2"] = {"anim@heists@box_carry@", "idle", "Dienblad dragen 2", AnimationOptions =
   {
      Prop = "prop_food_bs_tray_02",
      PropBone = 28422,
      PropPlacement = {0.0100, -0.0400, -0.1390,20.0000007, 0.0, 0.0},
      EmoteLoop = true,
      EmoteMoving = true,
   }},
    ["carryfoodtray3"] = {"anim@heists@box_carry@", "idle", "Dienblad dragen 3", AnimationOptions =
   {
      Prop = "prop_food_cb_tray_02",
      PropBone = 28422,
      PropPlacement = {0.0100, -0.0400, -0.1390,20.0000007, 0.0, 0.0},
      EmoteLoop = true,
      EmoteMoving = true,
     }},
    ["carryfoodtray4"] = {"anim@heists@box_carry@", "idle", "Dienblad dragen 4", AnimationOptions =
   {
      Prop = "prop_food_tray_02",
      PropBone = 28422,
      PropPlacement = {0.0100, -0.0400, -0.1390,20.0000007, 0.0, 0.0},
      EmoteLoop = true,
      EmoteMoving = true,
     }},
    ["carryfoodtray5"] = {"anim@heists@box_carry@", "idle", "Dienblad dragen 5", AnimationOptions =
   {
      Prop = "prop_food_tray_03",
      PropBone = 28422,
      PropPlacement = {0.0100, -0.0400, -0.1390,20.0000007, 0.0, 0.0},
      EmoteLoop = true,
      EmoteMoving = true,
   }},
    ["carryfoodtray6"] = {"anim@heists@box_carry@", "idle", "Dienblad dragen 6", AnimationOptions =
   {
      Prop = "prop_food_bs_tray_02",
      PropBone = 57005,
      PropPlacement = {0.2500, 0.1000, 0.0700,-110.5483936, 73.3529273, -16.338362},
	  SecondProp = 'prop_food_bs_tray_03',
      SecondPropBone =18905,
      SecondPropPlacement = {0.2200, 0.1300, -0.1000, -127.7725487, 110.2074758, -3.5886263},
      EmoteLoop = true,
      EmoteMoving = true,
    }},
    ["carryfoodtray7"] = {"anim@heists@box_carry@", "idle", "Dienblad dragen 7", AnimationOptions =
   {
      Prop = "prop_food_cb_tray_02",
      PropBone = 57005,
      PropPlacement = {0.2500, 0.1000, 0.0700,-110.5483936, 73.3529273, -16.338362},
	  SecondProp = 'prop_food_cb_tray_02',
      SecondPropBone =18905,
      SecondPropPlacement = {0.2200, 0.1300, -0.1000, -127.7725487, 110.2074758, -3.5886263},
      EmoteLoop = true,
      EmoteMoving = true,
    }},
    ["carryfoodtray8"] = {"anim@heists@box_carry@", "idle", "Dienblad dragen 8", AnimationOptions =
   {
      Prop = "prop_food_tray_02",
      PropBone = 57005,
      PropPlacement = {0.2500, 0.1000, 0.0700,-110.5483936, 73.3529273, -16.338362},
	  SecondProp = 'prop_food_tray_03',
      SecondPropBone =18905,
      SecondPropPlacement = {0.2200, 0.1300, -0.1000, -127.7725487, 110.2074758, -3.5886263},
      EmoteLoop = true,
      EmoteMoving = true,
     }},
    ["carryfoodtray9"] = {"anim@heists@box_carry@", "idle", "Dienblad dragen 9", AnimationOptions =
   {
      Prop = "prop_food_tray_02",
      PropBone = 57005,
      PropPlacement = {0.2500, 0.1000, 0.0700,-110.5483936, 73.3529273, -16.338362},
	  SecondProp = 'prop_food_tray_02',
      SecondPropBone =18905,
      SecondPropPlacement = {0.2200, 0.1300, -0.1000, -127.7725487, 110.2074758, -3.5886263},
      EmoteLoop = true,
      EmoteMoving = true,
    }},
    ["carryfoodtray10"] = {"anim@move_f@waitress", "idle", "Dienblad dragen 10", AnimationOptions =
    {
       Prop = "prop_food_bs_tray_02",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0200,0.0,0.0,0.0},
       EmoteLoop = true,
       EmoteMoving = true,
    }},
    ["carryfoodtray11"] = {"anim@move_f@waitress", "idle", "Dienblad dragen 11", AnimationOptions =
    {
       Prop = "prop_food_bs_tray_03",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0200,0.0,0.0,0.0},
       EmoteLoop = true,
       EmoteMoving = true,
    }},
--    ["beans"] = {"anim@scripted@island@special_peds@pavel@hs4_pavel_ig5_caviar_p1", "base_idle", "Bonen", AnimationOptions =
--    {
--       Prop = "h4_prop_h4_caviar_tin_01a",
--       PropBone = 60309,
--       PropPlacement = {0.0, 0.0300, 0.0100,0.0,0.0,0.0},
--       SecondProp = 'h4_prop_h4_caviar_spoon_01a',
--       SecondPropBone = 28422,
--       SecondPropPlacement = {0.0,0.0,0.0,0.0,0.0,0.0},
--       EmoteLoop = true,
--       EmoteMoving = true,
--    }},
--    ["beans2"] = {"anim@scripted@submarine@special_peds@pavel@hs4_pavel_ig5_caviar_p1","base_idle", "Bonen 2", AnimationOptions =
--    {
--       Prop = "h4_prop_h4_caviar_tin_01a",
--       PropBone = 60309,
--       PropPlacement = {0.0, 0.0300, 0.0100,0.0,0.0,0.0},
--       SecondProp = 'h4_prop_h4_caviar_spoon_01a',
--       SecondPropBone = 28422,
--       SecondPropPlacement = {0.0,0.0,0.0,0.0,0.0,0.0},
--       EmoteLoop = true,
--       EmoteMoving = false,
--    }},
    -- ["champw"] = {"anim@move_f@waitress", "idle", "Champagne Ober", AnimationOptions =
    -- {
    --    Prop = "vw_prop_vw_tray_01a",
    --    PropBone = 28422,
    --    PropPlacement = {0.0, 0.0, 0.0100,0.0,0.0,0.0},
    --    SecondProp = 'prop_champ_cool',
    --    SecondPropBone = 28422,
    --    SecondPropPlacement = {0.0,0.0,0.010,0.0,0.0,0.0},
    --    EmoteLoop = true,
    --    EmoteMoving = true,
    -- }},
	["carrypizza"] = {"anim@heists@box_carry@", "idle", "Pizzadoos dragen", AnimationOptions =
   {
      Prop = "prop_pizza_box_02",
      PropBone = 28422,
      PropPlacement = {0.0100, -0.1000, -0.1590,20.0000007, 0.0, 0.0},
      EmoteLoop = true,
      EmoteMoving = true,
   }},
    ["carryfoodbag"] = {"move_weapon@jerrycan@generic", "idle", "Zak met eten dragen", AnimationOptions =
   {
      Prop = "prop_food_bs_bag_01",
      PropBone = 57005,
      PropPlacement = {0.3300, 0.0, -0.0300, 0.0017365, -79.9999997, 110.0651988},
      EmoteLoop = true,
      EmoteMoving = true,
     }},
    ["carryfoodbag2"] = {"move_weapon@jerrycan@generic", "idle", "Zak met eten dragen 2", AnimationOptions =
   {
      Prop = "prop_food_cb_bag_01",
      PropBone = 57005,
      PropPlacement = {0.3800, 0.0, -0.0300, 0.0017365, -79.9999997, 110.0651988},
      EmoteLoop = true,
      EmoteMoving = true,
    }},
    ["carryfoodbag3"] = {"move_weapon@jerrycan@generic", "idle", "Zak met eten dragen 3", AnimationOptions =
   {
      Prop = "prop_food_bag1",
      PropBone = 57005,
      PropPlacement = {0.3800, 0.0, -0.0300, 0.0017365, -79.9999997, 110.0651988},
      EmoteLoop = true,
      EmoteMoving = true,
    }},
}

DP.LeanEmotes = {
    ["lean"] = {"Scenario", "WORLD_HUMAN_LEANING", "Leunen"},
    ["lean2"] = {"amb@world_human_leaning@female@wall@back@hand_up@idle_a", "idle_a", "Leunen 2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["lean3"] = {"amb@world_human_leaning@female@wall@back@holding_elbow@idle_a", "idle_a", "Leunen 3", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["lean4"] = {"amb@world_human_leaning@male@wall@back@foot_up@idle_a", "idle_a", "Leunen 4", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["lean5"] = {"amb@world_human_leaning@male@wall@back@hands_together@idle_b", "idle_b", "Leunen 5", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["leanflirt"] = {"random@street_race", "_car_a_flirt_girl", "Leunen Flirt", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["leanbar2"] = {"amb@prop_human_bum_shopping_cart@male@idle_a", "idle_c", "Leunen Bar 2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["leanbar3"] = {"anim@amb@nightclub@lazlow@ig1_vip@", "clubvip_base_laz", "Leunen Bar 3", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["leanbar4"] = {"anim@heists@prison_heist", "ped_b_loop_a", "Leunen Bar 4", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["leanhigh"] = {"anim@mp_ferris_wheel", "idle_a_player_one", "Leunen High", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["leanhigh2"] = {"anim@mp_ferris_wheel", "idle_a_player_two", "Leunen High 2", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["leanside"] = {"timetable@mime@01_gc", "idle_a", "Leunen Zijkant", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["leanside2"] = {"misscarstealfinale", "packer_idle_1_trevor", "Leunen Zijkant 2", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["leanside3"] = {"misscarstealfinalecar_5_ig_1", "waitloop_lamar", "Leunen Zijkant 3", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["leanside4"] = {"misscarstealfinalecar_5_ig_1", "waitloop_lamar", "Leunen Zijkant 4", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["leanside5"] = {"rcmjosh2", "josh_2_intp1_base", "Leunen Zijkant 5", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["lean"] = {"Scenario", "WORLD_HUMAN_LEANING", "Leunen"},
    ["leanbar"] = {"Scenario", "PROP_HUMAN_BUM_SHOPPING_CART", "Leunen Bar"},
    ["passout"] = {"missarmenian2", "drunk_loop", "Bewusteloos Vallen", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["passout2"] = {"missarmenian2", "corpse_search_exit_ped", "Bewusteloos Vallen 2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["passout3"] = {"anim@gangops@morgue@table@", "body_search", "Bewusteloos Vallen 3", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["passout4"] = {"mini@cpr@char_b@cpr_def", "cpr_pumpchest_idle", "Bewusteloos Vallen 4", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["passout5"] = {"random@mugging4", "flee_backward_loop_shopkeeper", "Bewusteloos Vallen 5", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["passout6"] = {"missheist_jewel", "gassed_npc_customer1", "Bewusteloos Vallen 6", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["passout7"] = {"missheist_jewel", "gassed_npc_customer2", "Bewusteloos Vallen 7", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["passout8"] = {"missheist_jewel", "gassed_npc_customer3", "Bewusteloos Vallen 8", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["passout9"] = {"missheist_jewel", "gassed_npc_customer4", "Bewusteloos Vallen 9", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["passout10"] = {"missheist_jewel", "gassed_npc_guard", "Bewusteloos Vallen 10", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["sunbathe"] = {"amb@world_human_sunbathe@male@back@base", "base", "Zonnen", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["sunbathe2"] = {"amb@world_human_sunbathe@female@back@base", "base", "Zonnen 2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["sniper"] = {"missfbi3_sniping", "prone_michael", "Sniperpositie", AnimationOptions =
    {
        EmoteLoop = true,
        RemoveWeapon = false,
    }},
    ["sniper2"] = {"missfbi2", "franklin_sniper_crouch", "Sniperpositie 2", AnimationOptions =
    {
        EmoteLoop = true,
        RemoveWeapon = false,
    }},
    ["crouchaim"] = {"combat@chg_stance", "crouch", "Gebukt richten", AnimationOptions =
    {
        EmoteLoop = true,
        RemoveWeapon = false,
    }},
    ["cloudgaze"] = {"switch@trevor@annoys_sunbathers", "trev_annoys_sunbathers_loop_girl", "Flauwvallen", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["cloudgaze2"] = {"switch@trevor@annoys_sunbathers", "trev_annoys_sunbathers_loop_guy", "Flauwvallen 2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["prone"] = {"missfbi3_sniping", "prone_dave", "Liggen Denken", AnimationOptions =
    {
        EmoteLoop = true,
    }},
}

DP.WaitEmotes = {
    ["cuffed"] = {"random@burial","b_burial", "Geboeid op de grond", AnimationOptions =
    {
        Prop = "hei_prop_zip_tie_positioned",
        PropBone = 60309,
        PropPlacement = {0.000, -0.0500, 0.0600, 90.0000, 100.0000, 210.0000},
        EmoteMoving = false,
        EmoteLoop = true
    }},
    ["wait3"] = {"amb@world_human_hang_out_street@female_hold_arm@idle_a", "idle_a", "Wachten 3", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["wait4"] = {"amb@world_human_hang_out_street@Female_arm_side@idle_a", "idle_a", "Wachten 4", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["wait5"] = {"missclothing", "idle_storeclerk", "Wachten 5", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["wait6"] = {"timetable@amanda@ig_2", "ig_2_base_amanda", "Wachten 6", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["wait7"] = {"rcmnigel1cnmt_1c", "base", "Wachten 7", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["wait8"] = {"rcmjosh1", "idle", "Wachten 8", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["wait9"] = {"rcmjosh2", "josh_2_intp1_base", "Wachten 9", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["wait10"] = {"timetable@amanda@ig_3", "ig_3_base_tracy", "Wachten 10", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["wait11"] = {"misshair_shop@hair_dressers", "keeper_base", "Wachten 11", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["idle"] = {"anim@heists@heist_corona@team_idles@male_a", "idle", "Nutteloos", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["idle8"] = {"amb@world_human_hang_out_street@male_b@idle_a", "idle_b", "Nutteloos 8"},
    ["idle9"] = {"friends@fra@ig_1", "base_idle", "Nutteloos 9", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["idle10"] = {"mp_move@prostitute@m@french", "idle", "Nutteloos 10", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["idle11"] = {"random@countrysiderobbery", "idle_a", "Nutteloos 11", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["idle2"] = {"anim@heists@heist_corona@team_idles@female_a", "idle", "Nutteloos 2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["idle3"] = {"anim@heists@humane_labs@finale@strip_club", "ped_b_celebrate_loop", "Nutteloos 3", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["idle4"] = {"anim@mp_celebration@idles@female", "celebration_idle_f_a", "Nutteloos 4", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["idle5"] = {"anim@mp_corona_idles@female_b@idle_a", "idle_a", "Nutteloos 5", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["idle6"] = {"anim@mp_corona_idles@male_c@idle_a", "idle_a", "Nutteloos 6", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["idle7"] = {"anim@mp_corona_idles@male_d@idle_a", "idle_a", "Nutteloos 7", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["idle8"] = {"random@shop_tattoo", "_idle_c", "Nutteloos 8", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["idledrunk"] = {"random@drunk_driver_1", "drunk_driver_stand_loop_dd1", "Nutteloos Dronken", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["idledrunk2"] = {"random@drunk_driver_1", "drunk_driver_stand_loop_dd2", "Nutteloos Dronken 2", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["idledrunk3"] = {"missarmenian2", "standing_idle_loop_drunk", "Nutteloos Dronken 3", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["wait"] = {"random@shop_tattoo", "_idle_a", "Wachten", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["wait2"] = {"missbigscore2aig_3", "wait_for_van_c", "Wachten 2", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["wait12"] = {"rcmjosh1", "idle", "Wachten 12", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["wait13"] = {"rcmnigel1a", "base", "Wachten 13", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["think5"] = {"mp_cp_welcome_tutthink", "b_think", "Denken 5", AnimationOptions =
    {
        EmoteMoving = true,
        EmoteDuration = 2000,
    }},
    ["think"] = {"misscarsteal4@aliens", "rehearsal_base_idle_director", "Denken", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["think3"] = {"timetable@tracy@ig_8@base", "base", "Denken 3", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
 
    ["think2"] = {"missheist_jewelleadinout", "jh_int_outro_loop_a", "Denken 2", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["think4"] = {"anim@amb@casino@hangout@ped_male@stand@02b@idles", "idle_a", "Denken 4", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["crossarms"] = {"amb@world_human_hang_out_street@female_arms_crossed@idle_a", "idle_a", "Armen over elkaar", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["crossarms2"] = {"amb@world_human_hang_out_street@male_c@idle_a", "idle_b", "Armen over elkaar 2", AnimationOptions =
    {
        EmoteMoving = true,
    }},
    ["crossarms3"] = {"anim@heists@heist_corona@single_team", "single_team_loop_boss", "Armen over elkaar 3", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["crossarms4"] = {"random@street_race", "_car_b_lookout", "Armen over elkaar 4", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["crossarms5"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Armen over elkaar 5", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["foldarms2"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Armen over elkaar 8", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["crossarms6"] = {"random@shop_gunstore", "_idle", "Armen over elkaar 6", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["foldarms"] = {"anim@amb@business@bgen@bgen_no_work@", "stand_phone_phoneputdown_idle_nowork", "Armen over elkaar 7", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["crossarmsside"] = {"rcmnigel1a_band_groupies", "base_m2", "Armen over elkaar Zijkant", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["armsback"] = {"anim@miss@low@fin@vagos@", "idle_ped06", "Armen op je rug", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["hangout"] = {"Scenario", "WORLD_HUMAN_HANG_OUT_STREET", "Armen over elkaar 9"},
    ["impatient"] = {"random@shop_tattoo", "_impatient_a", "Ongeduldig", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["impatient2"] = {"random@shop_tattoo", "_impatient_b", "Ongeduldig 2", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["impatient3"] = {"random@shop_tattoo", "_impatient_c", "Ongeduldig 3", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = false,
    }},
}







DP.Expressions = {
   ["Boos"] = {"Expression", "mood_angry_1"},
   ["Dronken"] = {"Expression", "mood_drunk_1"},
   ["Dom"] = {"Expression", "pose_injured_1"},
   ["Geëlektrocuteerd"] = {"Expression", "electrocuted_1"},
   ["Knorrig"] = {"Expression", "effort_1"},
   ["Knorrig 2"] = {"Expression", "mood_drivefast_1"},
   ["Knorrig 3"] = {"Expression", "pose_angry_1"},
   ["Blij"] = {"Expression", "mood_happy_1"},
   ["Gewond"] = {"Expression", "mood_injured_1"},
   ["Blijdschap"] = {"Expression", "mood_dancing_low_1"},
   ["Verbaasd"] = {"Expression", "smoking_hold_1"},
   ["Nooit Knipperen"] = {"Expression", "pose_normal_1"},
   ["Knipoog"] = {"Expression", "pose_aiming_1"},
   ["Geshocked"] = {"Expression", "shocked_1"},
   ["Geshocked 2"] = {"Expression", "shocked_2"},
   ["Slapen"] = {"Expression", "mood_sleeping_1"},
   ["Slapen 2"] = {"Expression", "dead_1"},
   ["Slapen 3"] = {"Expression", "dead_2"},
   ["Arrogant"] = {"Expression", "mood_smug_1"},
   ["Bedenkelijk"] = {"Expression", "mood_aiming_1"},
   ["Gestrest"] = {"Expression", "mood_stressed_1"},
   ["Sukkelig"] = {"Expression", "mood_sulk_1"},
   ["Raar"] = {"Expression", "effort_2"},
   ["Raar 2"] = {"Expression", "effort_3"},
}

DP.Walks = {
  ["Aliën"] = {"move_m@alien"},
  ["Gepantserd"] = {"anim_group_move_ballistic"},
  ["Arrogant"] = {"move_f@arrogant@a"},
  ["Dapper"] = {"move_m@brave"},
  ["Casual"] = {"move_m@casual@a"},
  ["Casual 2"] = {"move_m@casual@b"},
  ["Casual 3"] = {"move_m@casual@c"},
  ["Casual 4"] = {"move_m@casual@d"},
  ["Casual 5"] = {"move_m@casual@e"},
  ["Casual 6"] = {"move_m@casual@f"},
  ["Chichi"] = {"move_f@chichi"},
  ["Zelfverzekerd"] = {"move_m@confident"},
  ["Normaal Vrouw"] = {"move_f@multiplayer"},
  ["Normaal Man"] = {"move_m@multiplayer"},
  ["Dronken"] = {"move_m@drunk@a"},
  ["Dronken"] = {"move_m@drunk@slightlydrunk"},
  ["Dronken 2"] = {"move_m@buzzed"},
  ["Dronken 3"] = {"move_m@drunk@verydrunk"},
  ["Vrouwelijk"] = {"move_f@femme@"},
  ["Breed"] = {"move_characters@franklin@fire"},
  ["Breed 2"] = {"move_characters@michael@fire"},
  ["Breed 3"] = {"move_m@fire"},
  ["Vluchten"] = {"move_f@flee@a"},
  ["Franklin"] = {"move_p_m_one"},
  ["Gangster"] = {"move_m@gangster@generic"},
  ["Gangster 2"] = {"move_m@gangster@ng"},
  ["Gangster 3"] = {"move_m@gangster@var_e"},
  ["Gangster 4"] = {"move_m@gangster@var_f"},
  ["Gangster 5"] = {"move_m@gangster@var_i"},
  ["Grooving"] = {"anim@move_m@grooving@"},
  ["Bewaker"] = {"move_m@prison_gaurd"},
  ["Handboeien"] = {"move_m@prisoner_cuffed"},
  ["Hakken"] = {"move_f@heels@c"},
  ["Hakken 2"] = {"move_f@heels@d"},
  ["Hiken"] = {"move_m@hiking"},
  ["Hipster"] = {"move_m@hipster@a"},
  ["Hobo"] = {"move_m@hobo@a"},
  ["Spoed"] = {"move_f@hurry@a"},
  ["Schoonmaker"] = {"move_p_m_zero_janitor"},
  ["Schoonmaker 2"] = {"move_p_m_zero_slow"},
  ["Joggen"] = {"move_m@jog@"},
  ["Lemar"] = {"anim_group_move_lemar_alley"},
  ["Lester"] = {"move_heist_lester"},
  ["Lester 2"] = {"move_lester_caneup"},
  ["Kruk"] = {"move_lester_caneup_kruk"},
  ["Kanibaal"] = {"move_f@maneater"},
  ["Michael"] = {"move_ped_bucket"},
  ["Rijk"] = {"move_m@money"},
  ["Gespierd"] = {"move_m@muscle@a"},
  ["Chique"] = {"move_m@posh@"},
  ["Chique 2"] = {"move_f@posh@"},
  ["Snel"] = {"move_m@quick"},
  ["Atleet"] = {"female_fast_runner"},
  ["Verdrietig"] = {"move_m@sad@a"},
  ["Chagrijnig"] = {"move_m@sassy"},
  ["Chagrijnig 2"] = {"move_f@sassy"},
  ["Bang"] = {"move_f@scared"},
  ["Sexy"] = {"move_f@sexy@a"},
  ["Duister"] = {"move_m@shadyped@a"},
  ["Langzaam"] = {"move_characters@jimmy@slow@"},
  ["Swagger"] = {"move_m@swagger"},
  ["Stoer"] = {"move_m@tough_guy@"},
  ["Stoer 2"] = {"move_f@tough_guy@"},
  ["Vuilnis"] = {"clipset@move@trash_fast_turn"},
  ["Vuilnis 2"] = {"missfbi4prepp1_garbageman"},
  ["Trevor"] = {"move_p_m_two"},
  ["Kast"] = {"move_m@bag"},
  -- I cant get these to work for some reason, if anyone knows a fix lmk
  --["Caution"] = {"move_m@caution"},
  --["Chubby"] = {"anim@move_m@chubby@a"},
  --["Crazy"] = {"move_m@crazy"},
  --["Joy"] = {"move_m@joy@a"},
  --["Power"] = {"move_m@power"},
  --["Sad2"] = {"anim@move_m@depression@a"},
  --["Sad3"] = {"move_m@depression@b"},
  --["Sad4"] = {"move_m@depression@d"},
  --["Wading"] = {"move_m@wading"},
}

DP.Shared = {
   --[emotename] = {dictionary, animation, displayname, targetemotename, additionalanimationoptions}
   -- you dont have to specify targetemoteanem, if you do dont it will just play the same animation on both.
   -- targetemote is used for animations that have a corresponding animation to the other player.
   ["handshake"] = {"mp_ped_interaction", "handshake_guy_a", "Handen schudden", "handshake2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
       SyncOffsetFront = 0.9
   }},
   ["handshake2"] = {"mp_ped_interaction", "handshake_guy_b", "Handen schudden 2", "handshake", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["bro"] = {"mp_ped_interaction", "hugs_guy_a", "Bro", "bro2", AnimationOptions =
   {
        SyncOffsetFront = 1.14
   }},
   ["bro2"] = {"mp_ped_interaction", "hugs_guy_b", "Bro 2", "bro", AnimationOptions =
   {
        SyncOffsetFront = 1.14
   }},
   ["give"] = {"mp_common", "givetake1_a", "Geven", "give2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000
   }},
   ["give2"] = {"mp_common", "givetake1_b", "Geven 2", "give", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000
   }},
   ["baseball"] = {"anim@arena@celeb@flat@paired@no_props@", "baseball_a_player_a", "Basketbal", "baseballthrow"},
   ["baseballthrow"] = {"anim@arena@celeb@flat@paired@no_props@", "baseball_a_player_b", "Basketbal Gooien", "baseball"},
   ["stickup"] = {"random@countryside_gang_fight", "biker_02_stickup_loop", "Stick Omhoog", "stickupscared", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["stickupscared"] = {"missminuteman_1ig_2", "handsup_base", "Politie en Boef", "stickup", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteLoop = true,
   }},
   ["punch"] = {"melee@unarmed@streamed_variations", "plyr_takedown_rear_lefthook", "Slaan", "punched"},
   ["punched"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_cross_r", "Geslagen", "punch"},
   ["headbutt"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_headbutt", "Kopstoot", "headbutted"},
   ["headbutted"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_headbutt", "Gekopstoot", "headbutt"},
   ["slap2"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_backslap", "Klap 2", "Slap 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["slap"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_slap", "Slap", "slapped", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["slapped"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_slap", "Geslapped", "slap"},
   ["slapped2"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_backslap", "Geslapped 2", "slap2"},
}

DP.Dances = {
   ["dancef"] = {"anim@amb@nightclub@dancers@solomun_entourage@", "mi_dance_facedj_17_v1_female^1", "Dans F", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center", "Dans F2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef3"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center_up", "Dans F3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef4"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v2_female^1", "Dans F4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef5"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v2_female^3", "Dans F5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef6"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center_up", "Dans F6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceslow2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "low_center", "Dans Langzaam 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceslow3"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "low_center_down", "Dans Langzaam 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceslow4"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "low_center", "Dans Langzaam 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance"] = {"anim@amb@nightclub@dancers@podium_dancers@", "hi_dance_facedj_17_v2_male^5", "Dans", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance2"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "high_center_down", "Dans 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance3"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", "high_center", "Dans 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance4"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "high_center_up", "Dans 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceupper"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "high_center", "Dans Upper", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["danceupper2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "high_center_up", "Dans Upper 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["danceshy"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", "low_center", "Dans Verlegen", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceshy2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "low_center_down", "Dans Verlegen 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceslow"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "low_center", "Dans Langzaam 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly9"] = {"rcmnigel1bnmt_1b", "dance_loop_tyler", "Dans Dom 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance6"] = {"misschinese2_crystalmazemcs1_cs", "dance_loop_tao", "Dans 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance7"] = {"misschinese2_crystalmazemcs1_ig", "dance_loop_tao", "Dans 7", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance8"] = {"missfbi3_sniping", "dance_m_default", "Dans 8", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly"] = {"special_ped@mountain_dancer@monologue_3@monologue_3a", "mnt_dnc_buttwag", "Dans Dom", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly2"] = {"move_clown@p_m_zero_idles@", "fidget_short_dance", "Dans Dom 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly3"] = {"move_clown@p_m_two_idles@", "fidget_short_dance", "Dans Dom 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly4"] = {"anim@amb@nightclub@lazlow@hi_podium@", "danceidle_hi_11_buttwiggle_b_laz", "Dans Dom 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly5"] = {"timetable@tracy@ig_5@idle_a", "idle_a", "Dans Dom 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly6"] = {"timetable@tracy@ig_8@idle_b", "idle_d", "Dans Dom 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance9"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "med_center_up", "Dans 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly8"] = {"anim@mp_player_intcelebrationfemale@the_woogie", "the_woogie", "Dans Dom 8", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["dancesilly7"] = {"anim@amb@casino@mini@dance@dance_solo@female@var_b@", "high_center", "Dans Dom 7", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["dance5"] = {"anim@amb@casino@mini@dance@dance_solo@female@var_a@", "med_center", "Dans 5", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["danceglowstick"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_13_mi_hi_sexualgriding_laz", "Dans Glowsticks", AnimationOptions =
   {
       Prop = 'ba_prop_battle_glowstick_01',
       PropBone = 28422,
       PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
       SecondProp = 'ba_prop_battle_glowstick_01',
       SecondPropBone = 60309,
       SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["danceglowstick2"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_12_mi_hi_bootyshake_laz", "Dans Glowsticks 2", AnimationOptions =
   {
       Prop = 'ba_prop_battle_glowstick_01',
       PropBone = 28422,
       PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
       SecondProp = 'ba_prop_battle_glowstick_01',
       SecondPropBone = 60309,
       SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
       EmoteLoop = true,
   }},
   ["danceglowstick3"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_09_mi_hi_bellydancer_laz", "Dans Glowsticks 3", AnimationOptions =
   {
       Prop = 'ba_prop_battle_glowstick_01',
       PropBone = 28422,
       PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
       SecondProp = 'ba_prop_battle_glowstick_01',
       SecondPropBone = 60309,
       SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
       EmoteLoop = true,
   }},
   ["dancehorse"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "dancecrowd_li_15_handup_laz", "Dans Paard", AnimationOptions =
   {
       Prop = "ba_prop_battle_hobby_horse",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["dancehorse2"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "crowddance_hi_11_handup_laz", "Dans Paard 2", AnimationOptions =
   {
       Prop = "ba_prop_battle_hobby_horse",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
   }},
   ["dancehorse3"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "dancecrowd_li_11_hu_shimmy_laz", "Dans Paard 3", AnimationOptions =
   {
       Prop = "ba_prop_battle_hobby_horse",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
   }},
   ["dj2"] = {"anim@amb@nightclub@djs@solomun@", "sol_idle_ctr_mid_a_sol", "DJ 2", AnimationOptions =
   {
      EmoteLoop = true,
      EmoteMoving = false,
   }},
   ["dj3"] = {"anim@amb@nightclub@djs@solomun@", "sol_dance_l_sol", "DJ 3", AnimationOptions =
   {
      EmoteLoop = true,
      EmoteMoving = false,
   }},
   ["dj4"] = {"anim@amb@nightclub@djs@black_madonna@", "dance_b_idle_a_blamadon", "DJ 4", AnimationOptions =
   {
      EmoteLoop = true,
      EmoteMoving = false,
   }},
   ["dj5"] = {"anim@amb@nightclub@djs@dixon@", "dixn_end_dix", "DJ 5", AnimationOptions =
   {
      EmoteLoop = true,
      EmoteMoving = false,
   }},
   ["dj5"] = {"anim@amb@nightclub@djs@dixon@", "dixn_idle_cntr_a_dix", "DJ 6", AnimationOptions =
   {
      EmoteLoop = true,
      EmoteMoving = false,
   }},
   ["dj6"] = {"anim@amb@nightclub@djs@dixon@", "dixn_idle_cntr_b_dix", "DJ 7", AnimationOptions =
   {
      EmoteLoop = true,
      EmoteMoving = false,
   }},
   ["dj7"] = {"anim@amb@nightclub@djs@dixon@", "dixn_idle_cntr_g_dix", "DJ 8", AnimationOptions =
   {
      EmoteLoop = true,
      EmoteMoving = false,
   }},
   ["dj8"] = {"anim@amb@nightclub@djs@dixon@", "dixn_idle_cntr_gb_dix", "DJ 8", AnimationOptions =
   {
      EmoteLoop = true,
      EmoteMoving = false,
   }},
   ["dj9"] = {"anim@amb@nightclub@djs@dixon@", "dixn_sync_cntr_j_dix", "DJ 9", AnimationOptions =
   {
      EmoteLoop = true,
      EmoteMoving = false,
   }},
--    ["danceclub"] = {"anim@amb@nightclub_island@dancers@beachdance@", "hi_idle_a_m03", "Dans Club", AnimationOptions =
--    {
--       EmoteLoop = true
--    }},
--    ["danceclub2"] = {"anim@amb@nightclub_island@dancers@beachdance@", "hi_idle_a_m05", "Dans Club 2", AnimationOptions =
--    {
--       EmoteLoop = true
--    }},
--    ["danceclub3"] = {"anim@amb@nightclub_island@dancers@beachdance@", "hi_idle_a_m02", "Dans Club 3", AnimationOptions =
--    {
--       EmoteLoop = true
--    }},
--    ["danceclub4"] = {"anim@amb@nightclub_island@dancers@beachdance@", "hi_idle_b_f01", "Dans Club 4", AnimationOptions =
--    {
--       EmoteLoop = true
--    }},
--    ["danceclub5"] = {"anim@amb@nightclub_island@dancers@club@", "hi_idle_a_f02", "Dans Club 5", AnimationOptions =
--    {
--       EmoteLoop = true
--    }},
--    ["danceclub6"] = {"anim@amb@nightclub_island@dancers@club@", "hi_idle_b_m03", "Dans Club 6", AnimationOptions =
--    {
--       EmoteLoop = true
--    }},
--    ["danceclub7"] = {"anim@amb@nightclub_island@dancers@club@", "hi_idle_d_f01", "Dans Club 7", AnimationOptions =
--    {
--       EmoteLoop = true
--    }},
   ["danceclub8"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_female^2", "Dans Club 8", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["danceclub9"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_female^3", "Dans Club 9", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["danceclub10"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_female^4", "Dans Club 10", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["danceclub11"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_male^1", "Dans Club 11", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["danceclub12"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_male^2", "Dans Club 12", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["danceclub13"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_male^3", "Dans Club 13", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["danceclub14"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_male^3", "Dans Club 14", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["danceclub15"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_female^3", "Dans Club 15", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["danceclub16"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_female^5", "Dans Club 16", AnimationOptions =
   {
      EmoteLoop = true
   }},
   ["danceclub17"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_15_v1_male^1", "Dans Club 17", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["danceclub18"] = {"anim@amb@nightclub@dancers@club_ambientpeds@", "li-mi_amb_club_06_base_female^5", "Dans Club 18", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["danceclub19"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_male^6", "Dans Club 19", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["danceclub20"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v2_male^2", "Dans Club 20", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["danceclub21"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v2_male^4", "Dans Club 21", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["danceclub22"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v2_female^2", "Dans Club 22", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["danceclub23"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v2_male^3", "Dans Club 23", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["danceclub24"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v2_male^4", "Dans Club 24", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["danceclub25"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_13_v2_male^3", "Dans Club 25", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["danceclub26"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_13_v2_male^6", "Dans Club 26", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["danceclub27"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_13_v2_female^4", "Dans Club 27", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["danceclub28"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_13_v2_male^2", "Dans Club 28", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["danceclub29"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_15_v1_male^2", "Dans Club 29", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["danceclub30"] = {"anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_15_v2_male^6", "Dans Club 30", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
--    ["dancedrink"] = {"anim@amb@nightclub_island@dancers@beachdanceprop@", "mi_idle_c_m01", "Dans Drink (Bier)", AnimationOptions =
--    {
--       Prop = 'prop_beer_amopen',
--       PropBone = 28422,
--       PropPlacement = {0.0, 0.00,0.0, 0.0, 0.0, 20.00},
--       EmoteLoop = true,
--       EmoteMoving = false,
--    }},
--    ["dancedrink2"] = {"anim@amb@nightclub_island@dancers@beachdanceprop@", "mi_loop_f1", "Dans Drink 2 (Wijn)", AnimationOptions =
--    {
--       Prop = 'p_wine_glass_s',
--       PropBone = 28422,
--       PropPlacement = {0.0, 0.0,-0.0900, 0.0, 0.0, 0.00},
--       EmoteLoop = true,
--       EmoteMoving = false,
--    }},
--    ["dancedrink3"] = {"anim@amb@nightclub_island@dancers@beachdanceprop@", "mi_loop_m04", "Dans Drink 3 (Whiskey)", AnimationOptions =
--    {
--       Prop = 'ba_prop_battle_whiskey_opaque_s',
--       PropBone = 28422,
--       PropPlacement = {-0.0100, 0.00,0.0, 0.0, 0.0, 10.00},
--       EmoteLoop = true,
--       EmoteMoving = false,
--    }},
--    ["dancedrink4"] = {"anim@amb@nightclub_island@dancers@beachdanceprops@male@", "mi_idle_b_m04", "Dans Drink 4 (Whiskey)", AnimationOptions =
--    {
--       Prop = 'ba_prop_battle_whiskey_opaque_s',
--       PropBone = 28422,
--       PropPlacement = {-0.0100, 0.00,0.0, 0.0, 0.0, 10.00},
--       EmoteLoop = true,
--       EmoteMoving = false,
--    }},
--    ["dancedrink5"] = {"anim@amb@nightclub_island@dancers@crowddance_single_props@", "hi_dance_prop_09_v1_female^3", "Dans Drink 5 (Wijn)", AnimationOptions =
--    {
--       Prop = 'p_wine_glass_s',
--       PropBone = 28422,
--       PropPlacement = {0.0, 0.0,-0.0900, 0.0, 0.0, 0.00},
--       EmoteLoop = true,
--       EmoteMoving = false,
--    }},
--    ["dancedrink6"] = {"anim@amb@nightclub_island@dancers@crowddance_single_props@", "hi_dance_prop_09_v1_male^3", "Dans Drink 6 (Bier)", AnimationOptions =
--    {
--       Prop = 'prop_beer_logopen',
--       PropBone = 28422,
--       PropPlacement = {0.0090, 0.0010,-0.0310, 180.0, 180.0, -69.99},
--       EmoteLoop = true,
--       EmoteMoving = false,
--    }},
--    ["dancedrink7"] = {"anim@amb@nightclub_island@dancers@crowddance_single_props@", "hi_dance_prop_11_v1_female^3", "Dans Drink 7 (Wijn)", AnimationOptions =
--    {
--       Prop = 'p_wine_glass_s',
--       PropBone = 28422,
--       PropPlacement = {0.0, 0.0,-0.0900, 0.0, 0.0, 0.00},
--       EmoteLoop = true,
--       EmoteMoving = false,
--    }},
--    ["dancedrink8"] = {"anim@amb@nightclub_island@dancers@crowddance_single_props@", "hi_dance_prop_11_v1_female^1", "Dans Drink 8 (Wijn)", AnimationOptions =
--    {
--       Prop = 'p_wine_glass_s',
--       PropBone = 28422,
--       PropPlacement = {0.0, 0.0,-0.0900, 0.0, 0.0, 0.00},
--       EmoteLoop = true,
--       EmoteMoving = false,
--    }},
   ["lapdance5"] = {"oddjobs@assassinate@multi@yachttarget@lapdance", "yacht_ld_f", "Lapdance 5", AnimationOptions =
   {
      EmoteLoop = true,
   }},
   ["lapdancewith"] = {"mini@strip_club@lap_dance_2g@ld_2g_p3", "ld_2g_p3_s2", "Lapdance Met", AnimationOptions =
   {
      EmoteLoop = true,
   }},
   ["lapdancewith2"] = {"mini@strip_club@lap_dance_2g@ld_2g_p2", "ld_2g_p2_s2", "Lapdance Met 2", AnimationOptions =
   {
      EmoteLoop = true,
   }},
   ["lapdancewith3"] = {"mini@strip_club@lap_dance_2g@ld_2g_p1", "ld_2g_p1_s2", "Lapdance Met 3", AnimationOptions =
   {
      EmoteLoop = true,
   }},
   ["lapchair"] = {"mini@strip_club@lap_dance@ld_girl_a_song_a_p1", "ld_girl_a_song_a_p1_f", "Lapdance Stoel", AnimationOptions =
   {
      EmoteLoop = true,
   }},
   ["lapchair2"] = {"mini@strip_club@lap_dance@ld_girl_a_song_a_p2", "ld_girl_a_song_a_p2_f", "Lapdance Stoel 2", AnimationOptions =
   {
      EmoteLoop = true,
   }},
   ["lapchair3"] = {"mini@strip_club@lap_dance@ld_girl_a_song_a_p3", "ld_girl_a_song_a_p3_f", "Lapdance Stoel 3", AnimationOptions =
   {
      EmoteLoop = true,
   }},
}

DP.VehicleEmotes = {
    ["sitlow"] = {"anim@veh@lowrider@std@ds@arm@base", "sit_low_lowdoor", "Sit Lowrider", AnimationOptions =
    {
       EmoteLoop = true,
    }},
    ["lapchair3"] = {"mini@strip_club@lap_dance@ld_girl_a_song_a_p3", "ld_girl_a_song_a_p3_f", "Lapdance Stoel 3", AnimationOptions =
    {
       EmoteLoop = true,
    }},



}

DP.Emotes = {
    ["give"] = {"mp_common", "givetake1_a", "Geven", AnimationOptions =
    {
        EmoteMoving = true,
        EmoteDuration = 1000,
   }},
   ["sheesh"] = {"custom@sheeeeesh", "sheeeeesh", "Sheesh", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000,
       EmoteLoop = false,
   }},
   ["cantsee"] = {"custom@cant_see", "cant_see", "John Cena", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 8000,
   }},
   ["dab"] = {"custom@dab", "dab", "Dab", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = false,
   }},
   ["priest"] = {"pro_mcs_7_concat-0", "cs_priest_dual-0", "Priester", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["shower1"] = {"mp_safehouseshower@female@", "shower_idle_a", "Douchen 1", AnimationOptions =
   {
      EmoteMoving = false,
      EmoteLoop = true,
   }},
   ["shower2"] = {"mp_safehouseshower@female@", "shower_idle_b", "Douchen 2", AnimationOptions =
   {
      EmoteMoving = false,
      EmoteLoop = true,
   }},
   ["shower3"] = {"mp_safehouseshower@male@", "male_shower_idle_a", "Douchen 3", AnimationOptions =
   {
      EmoteMoving = false,
      EmoteLoop = true,
   }},
   ["shower4"] = {"mp_safehouseshower@male@", "male_shower_idle_b", "Douchen 4", AnimationOptions =
   {
      EmoteMoving = false,
      EmoteLoop = true,
   }},
   ["shower5"] = {"mp_safehouseshower@male@", "male_shower_idle_c", "Douchen 5", AnimationOptions =
   {
      EmoteMoving = false,
      EmoteLoop = true,
   }},
   ["shower6"] = {"mp_safehouseshower@male@", "male_shower_idle_d", "Douchen 6", AnimationOptions =
   {
      EmoteMoving = false,
      EmoteLoop = true,
   }},
   ["beast"] = {"anim@mp_fm_event@intro", "beast_transform", "Beest", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 5000,
   }},
   ["chill"] = {"switch@trevor@scares_tramp", "trev_scares_tramp_idle_tramp", "Chill", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["pullover"] = {"misscarsteal3pullover", "pull_over_right", "Aan de kant", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1300,
   }},
   ["airguitar"] = {"anim@mp_player_intcelebrationfemale@air_guitar", "air_guitar", "Air Gitaar"},
   ["airsynth"] = {"anim@mp_player_intcelebrationfemale@air_synth", "air_synth", "Air Synthesizer"},
   ["argue"] = {"misscarsteal4@actor", "actor_berating_loop", "Discussie", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["argue2"] = {"oddjobs@assassinate@vice@hooker", "argue_a", "Discussie 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bartender"] = {"anim@amb@clubhouse@bar@drink@idle_a", "idle_a_bartender", "Bartender", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["blowkiss"] = {"anim@mp_player_intcelebrationfemale@blow_kiss", "blow_kiss", "Lucht Kus"},
   ["blowkiss2"] = {"anim@mp_player_intselfieblow_kiss", "exit", "Lucht Kus 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000
   }},
   ["curtsy"] = {"anim@mp_player_intcelebrationpaired@f_f_sarcastic", "sarcastic_left", "Buiging"},
   ["bringiton"] = {"misscommon@response", "bring_it_on", "Bring It On", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["hurryup"] = {"missarmenian2", "lamar_impatient_a", "Opschieten", AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = true,
   }},
   ["hurryup2"] = {"missarmenian2", "lamar_impatient_b", "Opschieten 2", AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = true,
   }},
   ["hurryup3"] = {"missarmenian2", "lamar_impatient_c", "Opschieten 3", AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = true,
   }},
   ["comeatmebro"] = {"mini@triathlon", "want_some_of_this", "Come at me bro", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000
   }},
   ["damn"] = {"gestures@m@standing@casual", "gesture_damn", "Damn", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["damn2"] = {"anim@am_hold_up@male", "shoplift_mid", "Damn 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["pointdown"] = {"gestures@f@standing@casual", "gesture_hand_down", "Naar beneden wijzen", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
    ["surrender"] = {"random@arrests@busted", "idle_a", "Overgeven", AnimationOptions =
    {
        EmoteLoop = true,
    }},
    ["handsonhead"] = {"random@arrests@busted", "idle_c", "Handen op je achterhoofd", AnimationOptions =
    {
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["surrender2"] = {"anim@mp_player_intuppersurrender", "idle_a", "Overgeven 2", AnimationOptions =
    {
    EmoteMoving = true,
    EmoteLoop = true,
    }},
    ["surrender3"] = {"anim@mp_player_intuppersurrender", "idle_a_fp", "Overgeven 3", AnimationOptions =
    {
    EmoteMoving = true,
    EmoteLoop = true,
    }},
    ["surrender4"] = {"misscarsteal2chad_garage", "chad_parking_garage_handsuploop_chad", "Overgeven 4", AnimationOptions =
    {
    EmoteMoving = true,
    EmoteLoop = true,
    }},
    ["surrender5"] = {"mp_bank_heist_1", "f_cower_02", "Overgeven 5", AnimationOptions =
    {
    EmoteMoving = false,
    EmoteLoop = true,
    }},
   ["surrender6"] = {"mp_bank_heist_1", "m_cower_01", "Overgeven 6", AnimationOptions =
    {
    EmoteMoving = false,
    EmoteLoop = true,
    }},
   ["surrender7"] = {"mp_bank_heist_1", "m_cower_02", "Overgeven 7", AnimationOptions =
    {
    EmoteMoving = false,
    EmoteLoop = true,
    }},
    ["surrender8"] = {"anim@heists@fleeca_bank@hostages@ped_d@", "flinch_loop", "Overgeven 8", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    ["surrender9"] = {"anim@heists@ornate_bank@hostages@cashier_a@", "flinch_loop", "Overgeven 9", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    ["surrender10"] = {"anim@heists@ornate_bank@hostages@ped_a@", "flinch_loop", "Overgeven 10", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    ["surrender11"] = {"anim@heists@ornate_bank@hostages@ped_b@", "flinch_loop", "Overgeven 11", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    ["surrender12"] = {"anim@heists@ornate_bank@hostages@ped_d@", "flinch_loop", "Overgeven 12", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    ["surrender13"] = {"anim@heists@ornate_bank@hostages@ped_f@", "flinch_loop", "Overgeven 13", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    ["surrender14"] = {"anim@heists@ornate_bank@hostages@ped_h@", "flinch_loop", "Overgeven 14", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    ["surrender15"] = {"anim@move_hostages@male", "male_idle", "Overgeven 15", AnimationOptions =
    {
        EmoteMoving = false,
        EmoteLoop = true,
    }},
    ["aiminjured"] = {"weapons@pistol@injured", "aim_med_loop", "Gewond Richten", AnimationOptions =
    {
        EmoteLoop = true,
        RemoveWeapon = false,
        EmoteMoving = true,
    }},
    ["aimup"] = {"move_weapon@pistol@cope", "idle", "Omhoog Richten", AnimationOptions =
    {
        EmoteLoop = true,
        RemoveWeapon = false,
        EmoteMoving = true,
    }},
    ["aimgangster"] = {"combat@aim_variations@1h@gang", "aim_variation_a", "Gangster Richten", AnimationOptions =
    {
        EmoteLoop = true,
        RemoveWeapon = false,
        EmoteMoving = true,
    }},
    ["aimonehanded"] = {"combat@aim_variations@1h@hillbilly", "aim_variation_a", "Met één hand Richten", AnimationOptions =
    {
        EmoteLoop = true,
        RemoveWeapon = false,
        EmoteMoving = true,
    }},
   ["facepalm2"] = {"anim@mp_player_intcelebrationfemale@face_palm", "face_palm", "Facepalm 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 8000
   }},
   ["facepalm"] = {"random@car_thief@agitated@idle_a", "agitated_idle_a", "Facepalm", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 8000
   }},
   ["facepalm3"] = {"missminuteman_1ig_2", "tasered_2", "Facepalm 3", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 8000
   }},
   ["facepalm4"] = {"anim@mp_player_intupperface_palm", "idle_a", "Facepalm 4", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["fallover"] = {"random@drunk_driver_1", "drunk_fall_over", "Dood Vallen"},
   ["fallover2"] = {"mp_suicide", "pistol", "Dood Vallen 2"},
   ["fallover3"] = {"mp_suicide", "pill", "Dood Vallen 3"},
   ["fallover4"] = {"friends@frf@ig_2", "knockout_plyr", "Dood Vallen 4"},
   ["fallover5"] = {"anim@gangops@hostage@", "victim_fail", "Dood Vallen 5"},
   ["fallasleep"] = {"mp_sleep", "sleep_loop", "Fall Asleep", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["fightme"] = {"anim@deathmatch_intros@unarmed", "intro_male_unarmed_c", "Kom Vechten"},
   ["fightme2"] = {"anim@deathmatch_intros@unarmed", "intro_male_unarmed_e", "Kom Vechten 2"},
   ["finger"] = {"anim@mp_player_intselfiethe_bird", "idle_a", "Middelvinger", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["finger2"] = {"anim@mp_player_intupperfinger", "idle_a_fp", "Middelvinger 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["finger3"] = {"anim@mp_player_intcelebrationfemale@finger", "finger", "Middelvinger 3", AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = true,
   }},
   ["wanker"] = {"anim@mp_player_intselfiewank", "idle_a", "Wanker", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = false
   }},
   ["italiankiss"] = {"anim@mp_player_intcelebrationfemale@finger_kiss", "finger_kiss", "Italiaanse Kus", AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = true,
   }},
   ["italiankiss2"] = {"anim@mp_player_intcelebrationmale@finger_kiss", "finger_kiss", "Italiaanse Kus 2", AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = true,
   }},

   ["hiking"] = {"move_m@hiking", "idle", "Hiken", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jazzhands"] = {"anim@mp_player_intcelebrationfemale@jazz_hands", "jazz_hands", "Jazzhands", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 6000,
   }},
   ["jog2"] = {"amb@world_human_jog_standing@male@idle_a", "idle_a", "Joggen 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jog3"] = {"amb@world_human_jog_standing@female@idle_a", "idle_a", "Joggen 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jog4"] = {"amb@world_human_power_walker@female@idle_a", "idle_a", "Joggen 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jog5"] = {"move_m@joy@a", "walk", "Joggen 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jumpingjacks"] = {"timetable@reunited@ig_2", "jimmy_getknocked", "Jumping Jacks", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["duck"] = {"move_avoidance@generic_m", "react_right_side_dive_front", "Wegduiken", AnimationOptions =
       {
           EmoteMoving = false,
           EmoteDuration = 5000,
       }},
   ["kneel2"] = {"rcmextreme3", "idle", "Knielen 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kneel3"] = {"amb@world_human_bum_wash@male@low@idle_a", "idle_a", "Knielen 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["knock"] = {"timetable@jimmy@doorknock@", "knockdoor_idle", "Aankloppen", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["knock2"] = {"missheistfbi3b_ig7", "lift_fibagent_loop", "Aankloppen 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["knucklecrunch"] = {"anim@mp_player_intcelebrationfemale@knuckle_crunch", "knuckle_crunch", "Knokkels Knakken", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lapdance"] = {"mp_safehouse", "lap_dance_girl", "Lapdance"},

   ["me"] = {"gestures@f@standing@casual", "gesture_me_hard", "Ik", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["meditate"] = {"rcmcollect_paperleadinout@", "meditiate_idle", "Mediteren", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
   }},
   ["meditate2"] = {"rcmepsilonism3", "ep_3_rcm_marnie_meditating", "Mediteren 2", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
   }},
   ["meditate3"] = {"rcmepsilonism3", "base_loop", "Mediteren 3", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
   }},
   ["meditate4"] = {"rcmcollect_paperleadinout@", "meditiate_idle", "Mediteren 4", AnimationOptions =
   {
       Prop = "prop_yoga_mat_01",
       PropBone = SKEL_ROOT,
       PropPlacement = {0.0000, 0.1900, -0.1800, 0.0000, 1.0000, 0.0000},
       EmoteLoop = true,
   }},
   ["meditate5"] = {"rcmepsilonism3", "ep_3_rcm_marnie_meditating", "Mediteren 5", AnimationOptions =
   {
       Prop = "prop_yoga_mat_02",
       PropBone = SKEL_ROOT,
       PropPlacement = {0.0000, 0.1800, -0.0900, 4.0000, 0.0000, 0.0000},
       EmoteLoop = true,
   }},
   ["meditate6"] = {"rcmepsilonism3", "base_loop", "Mediteren 6", AnimationOptions =
   {
       Prop = "prop_yoga_mat_03",
       PropBone = SKEL_ROOT,
       PropPlacement = {0.0000, 0.2000, -0.1700, -10.0000, 0.0000, 0.0000},
       EmoteLoop = true,
   }},
   ["metal"] = {"anim@mp_player_intincarrockstd@ps@", "idle_a", "Metal", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["no"] = {"anim@heists@ornate_bank@chat_manager", "fail", "Nee", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["no2"] = {"mp_player_int_upper_nod", "mp_player_int_nod_no", "Nee 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nosepick"] = {"anim@mp_player_intcelebrationfemale@nose_pick", "nose_pick", "Neus Pulken", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["noway"] = {"gestures@m@standing@casual", "gesture_no_way", "Nee, echt?", AnimationOptions =
   {
       EmoteDuration = 1500,
       EmoteMoving = true,
   }},
   ["ok"] = {"anim@mp_player_intselfiedock", "idle_a", "OK", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["outofbreath"] = {"re@construction", "out_of_breath", "Buiten Adem", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pickup"] = {"random@domestic", "pickup_low", "Pickup"},
   ["pickup2"] = {"anim@move_m@trash", "pickup", "Pickup2"},

   ["push"] = {"missfinale_c2ig_11", "pushcar_offcliff_f", "Duwen", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["push2"] = {"missfinale_c2ig_11", "pushcar_offcliff_m", "Duwen 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["point"] = {"gestures@f@standing@casual", "gesture_point", "Aanwijzen", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pointup"] = {"oddjobs@basejump@", "ped_a_loop", "Naar de lucht wijzen", AnimationOptions =
   {
   EmoteMoving = true,
   EmoteLoop = true,
   }},
   ["counting"] = {"special_ped@jane@monologue_5@monologue_5d", "brotheradrianhasshown_3", "Tellen", AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = false,
   }},
   ["checkwatch"] = {"anim@random@shop_clothes@watches", "idle_a", "Horloge Bekijken", AnimationOptions =
   {
   EmoteMoving = true,
   EmoteLoop = false,
   }},
   ["checkwatch2"] = {"anim@random@shop_clothes@watches", "idle_b", "Horloge Bekijken 2", AnimationOptions =
   {
   EmoteMoving = true,
   EmoteLoop = false,
   }},
   ["checkwatch3"] = {"anim@random@shop_clothes@watches", "idle_c", "Horloge Bekijken 3", AnimationOptions =
   {
   EmoteMoving = true,
   EmoteLoop = false,
   }},
   ["checkwatch4"] = {"anim@random@shop_clothes@watches", "idle_d", "Horloge Bekijken 4", AnimationOptions =
   {
   EmoteMoving = true,
   EmoteLoop = false,
   }},
   ["checkwatch5"] = {"anim@random@shop_clothes@watches", "idle_e", "Horloge Bekijken 5", AnimationOptions =
   {
   EmoteMoving = true,
   EmoteLoop = false,
   }},
   ["pushup"] = {"amb@world_human_push_ups@male@idle_a", "idle_d", "Pushup", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["countdown"] = {"random@street_race", "grid_girl_race_start", "Aftellen", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pointright"] = {"mp_gun_shop_tut", "indicate_right", "Naar rechts wijzen", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["salute"] = {"anim@mp_player_intincarsalutestd@ds@", "idle_a", "Saluut", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["salute2"] = {"anim@mp_player_intincarsalutestd@ps@", "idle_a", "Saluut 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["salute3"] = {"anim@mp_player_intuppersalute", "idle_a", "Saluut 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["scared"] = {"random@domestic", "f_distressed_loop", "Bang", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["scared2"] = {"random@homelandsecurity", "knees_loop_girl", "Bang 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["screwyou"] = {"misscommon@response", "screw_you", "F*ck You", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["shakeoff"] = {"move_m@_idles@shake_off", "shakeoff_1", "Afschudden", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3500,
   }},
   ["shot"] = {"random@dealgonewrong", "idle_a", "Schot", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sleep"] = {"timetable@tracy@sleep@", "idle_c", "Slapen", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["slump"] = {"Scenario", "WORLD_HUMAN_BUM_SLUMPED", "Liggen"},
   ["shrug"] = {"gestures@f@standing@casual", "gesture_shrug_hard", "De Schouders Ophalen", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000,
   }},
   ["shrug2"] = {"gestures@m@standing@casual", "gesture_shrug_hard", "De Schouders Ophalen 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000,
   }},
   ["situp"] = {"amb@world_human_sit_ups@male@idle_a", "idle_a", "Sit-Ups", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["clapangry"] = {"anim@arena@celeb@flat@solo@no_props@", "angry_clap_a_player_a", "Klappen Boos", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["slowclap3"] = {"anim@mp_player_intupperslow_clap", "idle_a", "Langzaam Klappen 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["clap"] = {"amb@world_human_cheering@male_a", "base", "Klappen", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["slowclap"] = {"anim@mp_player_intcelebrationfemale@slow_clap", "slow_clap", "Langzaam Klappen", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["slowclap2"] = {"anim@mp_player_intcelebrationmale@slow_clap", "slow_clap", "Langzaam Klappen 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smell"] = {"move_p_m_two_idles@generic", "fidget_sniff_fingers", "Ruiken", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["stumble"] = {"misscarsteal4@actor", "stumble", "Struikelen", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["stunned"] = {"stungun@standing", "damage", "Overdonderd", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["t"] = {"missfam5_yoga", "a2_pose", "T", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["t2"] = {"mp_sleep", "d_pose_180", "T 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["thumbsup3"] = {"anim@mp_player_intincarthumbs_uplow@ds@", "enter", "Duim Omhoog 3", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
   }},
   ["thumbsup2"] = {"anim@mp_player_intselfiethumbs_up", "idle_a", "Duim Omhoog 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["thumbsup"] = {"anim@mp_player_intupperthumbs_up", "idle_a", "Duim Omhoog", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["type"] = {"anim@heists@prison_heiststation@cop_reactions", "cop_b_idle", "Typen", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["type2"] = {"anim@heists@prison_heistig1_p1_guard_checks_bus", "loop", "Typen 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["type3"] = {"mp_prison_break", "hack_loop", "Typen 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["type4"] = {"mp_fbi_heist", "loop", "Typen 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["safecracking"] = {"mini@safe_cracking", "dial_turn_clock_fast_1", "Kluis Kraken", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["picklock"] = {"missheistfbisetup1", "hassle_intro_loop_f", "Slot Kraken", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteLoop = true,
   }},
   ["warmth"] = {"amb@world_human_stand_fire@male@idle_a", "idle_a", "Warmte", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cleanhands"] = {"missheist_agency3aig_23", "urinal_sink_loop", "Handen Wassen", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteLoop = true,
   }},
   ["cleanface"] = {"switch@michael@wash_face", "loop_michael", "Gezicht Wassen", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteLoop = true,
   }},
   ["buzz"] = {"anim@apt_trans@buzzer", "buzz_reg", "Aanbellen", AnimationOptions =
   {
      EmoteLoop = false,
      EmoteMoving = false,
   }},
   ["yeah"] = {"anim@mp_player_intupperair_shagging", "idle_a", "Yeah", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lift"] = {"random@hitch_lift", "idle_f", "Lift", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lol"] = {"anim@arena@celeb@flat@paired@no_props@", "laugh_a_player_b", "LOL", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lol2"] = {"anim@arena@celeb@flat@solo@no_props@", "giggle_a_player_b", "LOL 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["statue2"] = {"fra_0_int-1", "cs_lamardavis_dual-1", "Levend Standbeeld 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["statue3"] = {"club_intro2-0", "csb_englishdave_dual-0", "Levend Standbeeld 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gangsign"] = {"mp_player_int_uppergang_sign_a", "mp_player_int_gang_sign_a", "Gang Teken", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gangsign2"] = {"mp_player_int_uppergang_sign_b", "mp_player_int_gang_sign_b", "Gang Teken 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["petting"] = {"creatures@rottweiler@tricks@", "petting_franklin", "Aaien", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["crawl"] = {"move_injured_ground", "front_loop", "Kruipen", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["flip2"] = {"anim@arena@celeb@flat@solo@no_props@", "cap_a_player_a", "Salto 2"},
   ["flip"] = {"anim@arena@celeb@flat@solo@no_props@", "flip_a_player_a", "Salto"},
   ["slide"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_a_player_a", "Slide"},
   ["slide2"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_b_player_a", "Slide 2"},
   ["slide3"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_c_player_a", "Slide 3"},
   ["slugger"] = {"anim@arena@celeb@flat@solo@no_props@", "slugger_a_player_a", "Slugger"},
   ["flipoff"] = {"anim@arena@celeb@podium@no_prop@", "flip_off_a_1st", "Flikker Op", AnimationOptions =
   {
       EmoteMoving = true,
   }},
   ["flipoff2"] = {"anim@arena@celeb@podium@no_prop@", "flip_off_c_1st", "Flikker Op 2", AnimationOptions =
   {
       EmoteMoving = true,
   }},

   ["keyfob"] = {"anim@mp_player_intmenu@key_fob@", "fob_click", "Sleutelgat", AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = true,
       EmoteDuration = 1000,
   }},
   ["golfswing"] = {"rcmnigel1d", "swing_a_mark", "Golf Swing"},
   ["lapdance2"] = {"mini@strip_club@private_dance@idle", "priv_dance_idle", "Lapdance 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lapdance3"] = {"mini@strip_club@private_dance@part2", "priv_dance_p2", "Lapdance 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lapdance4"] = {"mini@strip_club@private_dance@part3", "priv_dance_p3", "Lapdance 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["twerk"] = {"switch@trevor@mocks_lapdance", "001443_01_trvs_28_idle_stripper", "Twerken", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["slap"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_slap", "Slappen", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["headbutt"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_headbutt", "Kopstoot"},
   ["fishdance"] = {"anim@mp_player_intupperfind_the_fish", "idle_a", "De Romana", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["peace"] = {"mp_player_int_upperpeace_sign", "mp_player_int_peace_sign", "Peace", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["peace2"] = {"anim@mp_player_intupperpeace", "idle_a", "Peace 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ledge"] = {"missfbi1", "ledge_loop", "Afgrond", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["airplane"] = {"missfbi1", "ledge_loop", "Lucht Vliegtuig", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["peek"] = {"random@paparazzi@peek", "left_peek_a", "Gluren", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["cough"] = {"timetable@gardener@smoking_joint", "idle_cough", "Hoesten", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["stretch"] = {"mini@triathlon", "idle_e", "Strekken", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["stretch2"] = {"mini@triathlon", "idle_f", "Strekken 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["stretch3"] = {"mini@triathlon", "idle_d", "Strekken 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["stretch4"] = {"rcmfanatic1maryann_stretchidle_b", "idle_e", "Strekken 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["celebrate"] = {"rcmfanatic1celebrate", "celebrate", "Vieren", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["punching"] = {"rcmextreme2", "loop_punching", "Slaan", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["superhero"] = {"rcmbarry", "base", "Superheld", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["superhero2"] = {"rcmbarry", "base", "Superheld 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["mindcontrol"] = {"rcmbarry", "mind_control_b_loop", "Hersenspoelen", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["mindcontrol2"] = {"rcmbarry", "bar_1_attack_idle_aln", "Hersenspoelen 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["clown"] = {"rcm_barry2", "clown_idle_0", "Clown", AnimationOptions =
   {
       EmoteLoop = true,

   }},
   ["clown2"] = {"rcm_barry2", "clown_idle_1", "Clown 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["clown3"] = {"rcm_barry2", "clown_idle_2", "Clown 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["clown4"] = {"rcm_barry2", "clown_idle_3", "Clown 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["clown5"] = {"rcm_barry2", "clown_idle_6", "Clown 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["tryclothes"] = {"mp_clothing@female@trousers", "try_trousers_neutral_a", "Proberen Kleding", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["tryclothes2"] = {"mp_clothing@female@shirt", "try_shirt_positive_a", "Proberen Kleding 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["tryclothes3"] = {"mp_clothing@female@shoes", "try_shoes_positive_a", "Proberen Kleding 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["nervous2"] = {"mp_missheist_countrybank@nervous", "nervous_idle", "Nerveus 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nervous"] = {"amb@world_human_bum_standing@twitchy@idle_a", "idle_c", "Nerveus", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nervous3"] = {"rcmme_tracey1", "nervous_loop", "Nerveus 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["loco"] = {"anim@mp_player_intupperyou_loco", "idle_a", "Loco", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["loco2"] = {"anim@mp_player_intcelebrationfemale@you_loco", "you_loco", "Loco 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["loco3"] = {"anim@mp_player_intincaryou_locobodhi@ds@", "idle_a", "Loco 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["threaten"] = {"random@atmrobberygen", "b_atm_mugging", "Bedreigen", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       RemoveWeapon = false,
   }},

   ["pull"] = {"random@mugging4", "struggle_loop_b_thief", "Trekken", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bird"] = {"random@peyote@bird", "wakeup", "Vogel"},
   ["chicken"] = {"random@peyote@chicken", "wakeup", "Kip", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bark"] = {"random@peyote@dog", "wakeup", "Blaffen"},
   ["rabbit"] = {"random@peyote@rabbit", "wakeup", "Konijn"},
   ["spiderman"] = {"missexile3", "ex03_train_roof_idle", "Spider-Man", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["boi"] = {"special_ped@jane@monologue_5@monologue_5c", "brotheradrianhasshown_2", "BOI", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteDuration = 3000,
   }},
   ["adjust"] = {"missmic4", "michael_tux_fidget", "Aanpassen", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteDuration = 4000,
   }},
   ["handsup"] = {"missminuteman_1ig_2", "handsup_base", "Handen Omhoog", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteLoop = true,
   }},
   ["pee"] = {"misscarsteal2peeing", "peeing_loop", "Plassen", AnimationOptions =
   {
       EmoteStuck = true,
       PtfxAsset = "scr_amb_chop",
       PtfxName = "ent_anim_dog_peeing",
       PtfxNoProp = true,
       PtfxPlacement = {-0.05, 0.3, 0.0, 0.0, 90.0, 90.0, 1.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['pee'],
       PtfxWait = 3000,
   }},
   ["pee2"] = {"missbigscore1switch_trevor_piss", "piss_loop", "Plassen 2", AnimationOptions =
   {
       EmoteStuck = true,
       PtfxAsset = "scr_amb_chop",
       PtfxName = "ent_anim_dog_peeing",
       PtfxNoProp = true,
       PtfxPlacement = {-0.05, 0.3, 0.0, 0.0, 90.0, 90.0, 1.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['pee'],
       PtfxWait = 3000,
       EmoteMoving = false,
       EmoteLoop = true,
   }},
   ["poop"] = {"missfbi3ig_0", "shit_loop_trev", "Poepen", AnimationOptions =
   {
      EmoteMoving = false,
      EmoteLoop = true,
   }},
   ["poop2"] = {"missfbi3ig_0", "shit_loop_trev", "Poepen 2", AnimationOptions =
   {
      Prop = "prop_toilet_roll_01",
      PropBone = 28422,
      PropPlacement = {0.0700, -0.02000, -0.2100, 0,0, 0.0, 0.0},
      SecondProp = 'prop_big_shit_01',
      SecondPropBone = 0,
      SecondPropPlacement = {-0.0100, 0.0600, -0.1550, 101.3015175, 7.3512213,-29.2665794},
      EmoteLoop = true,
      EmoteMoving = false,
   }},
-----------------------------------------------------------------------------------------------------------
------ These are Scenarios, some of these dont work on women and some other issues, but still good to have.
-----------------------------------------------------------------------------------------------------------

   ["atm"] = {"Scenario", "PROP_HUMAN_ATM", "Pinnen"},
   ["bumbin"] = {"Scenario", "PROP_HUMAN_BUM_BIN", "Graaien"},
   ["bumsleep"] = {"Scenario", "WORLD_HUMAN_BUM_SLUMPED", "Slapen"},
   ["cheer"] = {"Scenario", "WORLD_HUMAN_CHEERING", "Juichen"},
   ["chinup"] = {"Scenario", "PROP_HUMAN_MUSCLE_CHIN_UPS", "Optrekken"},
   ["filmshocking"] = {"Scenario", "WORLD_HUMAN_MOBILE_FILM_SHOCKING", "Filmen Shockerend"},
   ["shush"] = {"anim@mp_player_intuppershush", "idle_a_fp", "Sussen", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = false
   }},
   ["flex"] = {"Scenario", "WORLD_HUMAN_MUSCLE_FLEX", "Uitrekken"},
   ["impatient"] = {"Scenario", "WORLD_HUMAN_STAND_IMPATIENT", "Ongeduldig"},
   ["jog"] = {"Scenario", "WORLD_HUMAN_JOG_STANDING", "Joggen"},
   ["kneel"] = {"Scenario", "CODE_HUMAN_MEDIC_KNEEL", "Knielen"},
   ["lookout"] = {"Scenario", "CODE_HUMAN_CROSS_ROAD_WAIT", "Uitkijken"},
   ["parkingmeter"] = {"Scenario", "PROP_HUMAN_PARKING_METER", "Parkeermeter"},
   ["party"] = {"Scenario", "WORLD_HUMAN_PARTYING", "Feest"},
   ["texting"] = {"Scenario", "WORLD_HUMAN_STAND_MOBILE", "Appen"},
   ["puddle"] = {"Scenario", "WORLD_HUMAN_BUM_WASH", "Plas"},
   ["record"] = {"Scenario", "WORLD_HUMAN_MOBILE_FILM_SHOCKING", "Opnemen"},
   ["selfie1"] = {"cellphone@self@trevor@", "throat_slit", "Selfie", AnimationOptions =
   {
       Prop = "prop_npc_phone_02",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["selfie2"] = {"cellphone@self@trevor@", "aggressive_finger", "Selfie 2", AnimationOptions =
   {
       Prop = "prop_npc_phone_02",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["selfie3"] = {"cellphone@self@franklin@", "west_coast", "Selfie 3", AnimationOptions =
   {
       Prop = "prop_npc_phone_02",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["selfie4"] = {"cellphone@self@franklin@", "peace", "Selfie 4", AnimationOptions =
   {
       Prop = "prop_npc_phone_02",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   -- Sitchair is a litte special, since you want the player to be seated correctly.
   -- So we set it as "ScenarioObject" and do TaskStartScenarioAtPosition() instead of "AtPlace"
   ["smoke"] = {"Scenario", "WORLD_HUMAN_SMOKING", "Roken"},
   ["smokeweed"] = {"MaleScenario", "WORLD_HUMAN_DRUG_DEALER", "Wiet Roken"},
   ["statue"] = {"Scenario", "WORLD_HUMAN_HUMAN_STATUE", "Levend Standbeeld"},
   --["sunbathe3"] = {"Scenario", "WORLD_HUMAN_SUNBATHE", "Zonnen 3"},
   ["windowshop"] = {"Scenario", "WORLD_HUMAN_WINDOW_SHOP_BROWSE", "Winkelraam"},
   ["yoga"] = {"Scenario", "WORLD_HUMAN_YOGA", "Yoga"},
   ["yoga2"] = {"timetable@denice@ig_1", "idle_b", "Yoga 2", AnimationOptions =
   {
      EmoteMoving = false,
      EmoteLoop = true,
   }},
   -- Custom Animaties hieronder
   ["slump"] = {"Scenario", "WORLD_HUMAN_BUM_SLUMPED", "Liggen"},
   ["bumstand"] = {"Scenario", "WORLD_HUMAN_BUM_STANDING", "Zwerver Pose"},
   -- CASINO DLC EMOTES (STREAMED)
   ["karate"] = {"anim@mp_player_intcelebrationfemale@karate_chops", "karate_chops", "Karate"},
   ["karate2"] = {"anim@mp_player_intcelebrationmale@karate_chops", "karate_chops", "Karate 2"},
   ["cutthroat"] = {"anim@mp_player_intcelebrationmale@cut_throat", "cut_throat", "Keel Doorsnijden"},
   ["cutthroat2"] = {"anim@mp_player_intcelebrationfemale@cut_throat", "cut_throat", "Keel Doorsnijden 2"},
   ["mindblown"] = {"anim@mp_player_intcelebrationmale@mind_blown", "mind_blown", "Mind Blown", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["mindblown2"] = {"anim@mp_player_intcelebrationfemale@mind_blown", "mind_blown", "Mind Blown 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["boxing"] = {"anim@mp_player_intcelebrationmale@shadow_boxing", "shadow_boxing", "Boksen", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["boxing2"] = {"anim@mp_player_intcelebrationfemale@shadow_boxing", "shadow_boxing", "Boksen 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["beatup"] = {"missheistdockssetup1ig_13@exit", "guard_beatup_rollidle_dockworker", "In Elkaar Geslagen", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteLoop = true,
   }},
   ["kick"] = {"misstrevor3_beatup", "guard_beatup_kickidle_guard1", "In elkaar trappen", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteLoop = true,
   }},
   ["kick2"] = {"misstrevor3_beatup", "guard_beatup_kickidle_guard2", "In elkaar trappen 2", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteLoop = true,
   }},
   ["kick3"] = {"misstrevor3_beatup", "guard_beatup_kickidle_dockworker", "In elkaar getrapt", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteLoop = true,
   }},
   ["stink"] = {"anim@mp_player_intcelebrationfemale@stinker", "stinker", "Stinken", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["adjusttie"] = {"clothingtie", "try_tie_positive_a", "Stropdas", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 5000
   }},
}

DP.PropEmotes = {
    ["umbrella"] = {"rcmnigel1d", "base_club_shoulder", "Paraplu", AnimationOptions =
    {
       Prop = "p_amb_brolly_01",
       PropBone = 28422,
       PropPlacement = {0.0700, 0.0100, 0.1100, 2.3402393, -150.9605721, 57.3374916},
       --
       EmoteLoop = true,
       EmoteMoving = true,
    }},
   ["box"] = {"anim@heists@box_carry@", "idle", "Doos", AnimationOptions =
   {
       Prop = "hei_prop_heist_box",
       PropBone = 60309,
       PropPlacement = {0.025, 0.08, 0.255, -145.0, 290.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["megaphone"] = {"anim@mp_player_intselfiethumbs_up", "idle_a", "Megafoon", AnimationOptions =
   {
       Prop = 'prop_megaphone_01',
       PropBone = 24818,
       PropPlacement = {0.2000, 0.2500, 0.1000, 90.0000, 0.0000, 90.0000},
       EmoteMoving = true,
       EmoteLoop = true
   }},    
   ["wandelstok"] = {"weapons@misc@jerrycan@mp_male", "idle", "Wandelstok", AnimationOptions =
   {
      Prop = "prop_cs_walking_stick",
      PropBone = 28422,
      PropPlacement = {0.0700, -0.0300, 0.0000, 0.0000, -90.0000, 0.0000},
      EmoteLoop = true,
      EmoteMoving = true,
  }},
   ["drugpackage"] = {"missheistdocksprep1hold_cellphone", "static", "Drugs Pakket", AnimationOptions =
   {
       Prop = "prop_drug_package_02",
       PropBone = 28422,
       PropPlacement = {0.1900, -0.0100, 0.0200, -135.7095, 6.1915, -14.9477},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
--    ["moneypackage"] = {"hs4_scp_bch-3", "a_f_y_beach_02^1_dual-3", "Geld Pakket", AnimationOptions =
--    {
--        Prop = "prop_poly_bag_money",
--        PropBone = 28422,
--        PropPlacement = {0.0600, -0.1100, -0.2600, -90.0000, -79.9999, -59.9999},
--        EmoteLoop = true,
--        EmoteMoving = true,
--    }},
   ["rose"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Roos", AnimationOptions =
   {
       Prop = "prop_single_rose",
       PropBone = 18905,
       PropPlacement = {0.13, 0.15, 0.0, -100.0, 0.0, -20.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smoke2"] = {"amb@world_human_aa_smoke@male@idle_a", "idle_c", "Sigaret Roken 2", AnimationOptions =
   {
       Prop = 'prop_cs_ciggy_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smoke3"] = {"amb@world_human_aa_smoke@male@idle_a", "idle_b", "Sigaret Roken 3", AnimationOptions =
   {
       Prop = 'prop_cs_ciggy_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smoke4"] = {"amb@world_human_smoking@female@idle_a", "idle_b", "Sigaret Roken 4", AnimationOptions =
   {
       Prop = 'prop_cs_ciggy_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bong"] = {"anim@safehouse@bong", "bong_stage3", "Bong", AnimationOptions =
   {
       Prop = 'hei_heist_sh_bong_01',
       PropBone = 18905,
       PropPlacement = {0.10,-0.25,0.0,95.0,190.0,180.0},
   }},
   ["syringe"] = {"missfbi3_syringe", "syringe_idle_player", "Spuit Inbrengen", AnimationOptions =
   {
       Prop = "prop_syringe_01",
       PropBone = 28422,
       PropPlacement = {0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["supermarket"] = {"anim@heists@box_carry@", "idle", "Supermarkt Winkelkarretje", AnimationOptions =
   {
       Prop = "prop_rub_trolley01a",
       PropBone = 28422,
       PropPlacement = {-0.0100, -0.5100, -0.7900, 13.0000, 0.0000, 0.0000},
       EmoteLoop = true,
       EmoteMoving = true,
   }},   
   ["supermarket2"] = {"weapons@misc@jerrycan@franklin", "idle", "Supermarkt Tasje", AnimationOptions =
   {
      Prop = "prop_carrier_bag_01",
      PropBone = 28422,
      PropPlacement = {0.2600, 0.0000, -0.0100, 0.0000, -90.0000, 0.0000},
      EmoteLoop = true,
      EmoteMoving = true,
   }},
   ["shoppingbag"] = {"move_weapon@jerrycan@generic", "idle", "Winkeltasjes", AnimationOptions =
   {
       Prop = "prop_shopping_bags01",
       PropBone = 28422,
       PropPlacement = {0.0400, 0.0000, -0.0200, 0.0000, -110.0000, 0.0000},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["sportbag"] = {"move_weapon@jerrycan@generic", "idle", "Sporttas", AnimationOptions =
   {
      Prop = "v_ret_gc_bag01",
      PropBone = 28422,
      PropPlacement = {0.3200, -0.0100, 0.0000, 0.0000, -90.0000, 90.0000},
      EmoteLoop = true,
      EmoteMoving = true,
   }},
   ["handbag"] = {"move_weapon@jerrycan@generic", "idle", "Handtas", AnimationOptions =
   {
      Prop = "prop_amb_handbag_01",
      PropBone = 28422,
      PropPlacement = {0.3600, 0.0000, 0.0000, -180.0000, 90.0000, 79.9999},
      EmoteLoop = true,
      EmoteMoving = true,
   }},
   ["handbag2"] = {"move_weapon@jerrycan@generic", "idle", "Handtas 2", AnimationOptions =
   {
      Prop = "v_ret_ps_bag_02",
      PropBone = 28422,
      PropPlacement = {0.5000, 0.0000, 0.0000, 00000, -90.0000, 90.0000},
      EmoteLoop = true,
      EmoteMoving = true,
   }},
   ["handbag3"] = {"move_weapon@jerrycan@generic", "idle", "Handtas 3", AnimationOptions =
   {
      Prop = "ba_prop_battle_bag_01a",
      PropBone = 28422,
      PropPlacement = {0.3700, 0.0000, 0.0000, -180.0000, 90.0000, 79.9999},
      EmoteLoop = true,
      EmoteMoving = true,
   }},
   ["handbag4"] = {"move_weapon@jerrycan@generic", "idle", "Handtas 4", AnimationOptions =
   {
      Prop = "xm_prop_x17_ld_case_01",
      PropBone = 28422,
      PropPlacement = {0.0900, 0.0000, 0.0000, -180.0000, 90.0000, 79.9999},
      EmoteLoop = true,
      EmoteMoving = true,
   }},
   ["boren"] = {"anim@heists@fleeca_bank@drilling", "drill_straight_end", "Boren", AnimationOptions =
   {
       Prop = "hei_prop_heist_drill",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
   }},
--    ["glassnijden"] = {"anim@scripted@heist@ig16_glass_cut@male@", "idle", "Glas Snijden", AnimationOptions =
--    {
--        Prop = "h4_prop_h4_cutter_01a",
--        PropBone = 28422,
--        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
--        EmoteLoop = true,
--    }},
["game"] = {"timetable@jimmy@ig_2@ig_2_p2", "ig_2_base", "Gamen", AnimationOptions =
   {
       Prop = "prop_controller_01",
       PropBone = 28422,
       PropPlacement = {-0.0300, 0.0300, -0.0300, 19.528, -9.768, -4.515},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["mugshot"] = {"mp_character_creation@customise@male_a", "loop", "Mugshot", AnimationOptions =
   {
       Prop = 'prop_police_id_board',
       PropBone = 58868,
       PropPlacement = {0.12, 0.24, 0.0, 5.0, 0.0, 70.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["churn"] = {"anim@heists@box_carry@", "idle", "Karn", AnimationOptions =
   {
       Prop = "prop_old_churn_01",
       PropBone = 28422,
       PropPlacement = {0.0000, -0.0700, -0.1700, 0.0, 0.0000, 0.0000},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cigar"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Sigaar", AnimationOptions =
   {
       Prop = 'prop_cigar_02',
       PropBone = 47419,
       PropPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["cigar2"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Sigaar 2", AnimationOptions =
   {
       Prop = 'prop_cigar_01',
       PropBone = 47419,
       PropPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["cigar3"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Sigaar 3", AnimationOptions =
   {
       Prop = 'prop_sh_cigar_01',
       PropBone = 47419,
       PropPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["guitar"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Gitaar", AnimationOptions =
   {
       Prop = 'prop_acc_guitar_01',
       PropBone = 24818,
       PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["guitar2"] = {"switch@trevor@guitar_beatdown", "001370_02_trvs_8_guitar_beatdown_idle_busker", "Gitaar 2", AnimationOptions =
   {
       Prop = 'prop_acc_guitar_01',
       PropBone = 24818,
       PropPlacement = {-0.05, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["guitarelectric"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Elektrische Gitaar", AnimationOptions =
   {
       Prop = 'prop_el_guitar_01',
       PropBone = 24818,
       PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["guitarelectric2"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Elektrische Gitaar 2", AnimationOptions =
   {
       Prop = 'prop_el_guitar_03',
       PropBone = 24818,
       PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["book"] = {"cellphone@", "cellphone_text_read_base", "Boek", AnimationOptions =
   {
       Prop = 'prop_novel_01',
       PropBone = 6286,
       PropPlacement = {0.15, 0.03, -0.065, 0.0, 180.0, 90.0}, -- This positioning isnt too great, was to much of a hassle
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["bouquet"] = {"impexp_int-0", "mp_m_waremech_01_dual-0", "Boeket Bloemen", AnimationOptions =
   {
       Prop = 'prop_snow_flower_02',
       PropBone = 24817,
       PropPlacement = {-0.29, 0.40, -0.02, -90.0, -90.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["teddy"] = {"impexp_int-0", "mp_m_waremech_01_dual-0", "Teddybeer", AnimationOptions =
   {
       Prop = 'v_ilev_mr_rasberryclean',
       PropBone = 24817,
       PropPlacement = {-0.20, 0.46, -0.016, -180.0, -90.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["backpack"] = {"move_p_m_zero_rucksack", "idle", "Rugtas", AnimationOptions =
   {
       Prop = 'p_michael_backpack_s',
       PropBone = 24818,
       PropPlacement = {0.07, -0.11, -0.05, 0.0, 90.0, 175.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["map"] = {"amb@world_human_tourist_map@male@base", "base", "Kaart", AnimationOptions =
   {
       Prop = 'prop_tourist_map_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["map2"] = {"amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a", "Kaart 2", AnimationOptions =
   {
      Prop = "prop_tourist_map_01",
      PropBone = 28422,
      PropPlacement = {-0.05, 0.0, 0.0, 0.0, 0.0, 0.0},
      EmoteLoop = true,
      EmoteMoving = true,
   }},
   ["makeitrain"] = {"anim@mp_player_intupperraining_cash", "idle_a", "Geld Laten Regenen", AnimationOptions =
   {
       Prop = 'prop_anim_cash_pile_01',
       PropBone = 60309,
       PropPlacement = {0.0, 0.0, 0.0, 180.0, 0.0, 70.0},
       EmoteMoving = true,
       EmoteLoop = true,
       PtfxAsset = "scr_xs_celebration",
       PtfxName = "scr_xs_money_rain",
       PtfxPlacement = {0.0, 0.0, -0.09, -80.0, 0.0, 0.0, 1.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['makeitrain'],
       PtfxWait = 500,
   }},
   ["camera"] = {"amb@world_human_paparazzi@male@base", "base", "Camera", AnimationOptions =
   {
       Prop = 'prop_pap_camera_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
       PtfxAsset = "scr_bike_business",
       PtfxName = "scr_bike_cfid_camera_flash",
       PtfxPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['camera'],
       PtfxWait = 200,
   }},
--    ["camera2"] = {"mic_4_int-0", "a_m_y_hipster_01-0", "Camera 2", AnimationOptions =
--    {
--    Prop = "ch_prop_ch_camera_01",
--    PropBone = 28422,
--    PropPlacement = {0.0400, 0.0100, -0.0500, -70.728, 86.714, 9.450},
--    EmoteLoop = true,
--    EmoteMoving = true,
--    PtfxAsset = "scr_bike_business",
--    PtfxName = "scr_bike_cfid_camera_flash",
--    PtfxPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0},
--    PtfxInfo = Config.Languages[Config.MenuLanguage]['camera'],
--    PtfxWait = 200,
-- }}, 
   ["joint"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Joint", AnimationOptions =
   {
       Prop = 'p_cs_joint_02',
       PropBone = 47419,
       PropPlacement = {0.015, -0.009, 0.003, 55.0, 0.0, 110.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["cig"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Sigaret in Mond", AnimationOptions =
   {
       Prop = 'prop_amb_ciggy_01',
       PropBone = 47419,
       PropPlacement = {0.015, -0.009, 0.003, 55.0, 0.0, 110.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},   
   ["briefcase"] = {"move_weapon@jerrycan@generic", "idle", "Koffer", AnimationOptions =
   {
      Prop = "hei_prop_hei_security_case",
      PropBone = 28422,
      PropPlacement = {0.2530, 0.0000, -0.0030, 0.0000, -90.0000, 90.0000},
      EmoteLoop = true,
      EmoteMoving = true,
   }},
   ["briefcase2"] = {"move_weapon@jerrycan@generic", "idle", "Koffer 2", AnimationOptions =
   {
      Prop = "hei_prop_heist_thermite_case",
      PropBone = 28422,
      PropPlacement = {0.2300, 0.0100, 0.0000, 0.0000, 0.0000, -90.0000},
      EmoteLoop = true,
      EmoteMoving = true,
   }},
   ["briefcase3"] = {"move_weapon@jerrycan@generic", "idle", "Koffer 3", AnimationOptions =
   {
      Prop = "prop_idol_case_02",
      PropBone = 28422,
      PropPlacement = {0.0600, 0.0100, 0.0000, 0.0000, 0.0000, -90.0000},
      EmoteLoop = true,
      EmoteMoving = true,
   }},
   ["briefcase4"] = {"move_weapon@jerrycan@generic", "idle", "Koffer 4", AnimationOptions =
   {
      Prop = "prop_ld_case_01_s",
      PropBone = 28422,
      PropPlacement = {0.0800, 0.0000, 0.0000, 0.0000, -90.0000, 90.0000},
      EmoteLoop = true,
      EmoteMoving = true,
   }},
   ["briefcase5"] = {"move_weapon@jerrycan@generic", "idle", "Koffer 5", AnimationOptions =
   {
      Prop = "prop_box_guncase_01a",
      PropBone = 28422,
      PropPlacement = {0.1600, 0.0000, -0.0500, 0.0000, 0.0000, -90.0000},
      EmoteLoop = true,
      EmoteMoving = true,
   }},
   ["briefcase6"] = {"move_weapon@jerrycan@generic", "idle", "Koffer 6", AnimationOptions =
   {
      Prop = "bkr_prop_biker_case_shut",
      PropBone = 28422,
      PropPlacement = {0.0900, 0.0000, 0.0100, 0.0000, 0.0000, -90.0000},
      EmoteLoop = true,
      EmoteMoving = true,
   }},
   ["tablet"] = {"amb@world_human_tourist_map@male@base", "base", "Tablet", AnimationOptions =
   {
       Prop = "prop_cs_tablet",
       PropBone = 28422,
       PropPlacement = {0.0, -0.03, 0.0, 20.0, -90.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["tablet2"] = {"amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a", "Tablet 2", AnimationOptions =
   {
       Prop = "prop_cs_tablet",
       PropBone = 28422,
       PropPlacement = {-0.05, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["phonecall"] = {"cellphone@", "cellphone_call_listen_base", "Telefoon Bellen", AnimationOptions =
   {
       Prop = "prop_npc_phone_02",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},   
   ["phonecall2"] = {"random@kidnap_girl", "ig_1_girl_on_phone_loop", "Telefoon Bellen 2", AnimationOptions =
   {
      Prop = "prop_phone_ing",
      PropBone = 28422,
      PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
      EmoteLoop = true,
      EmoteMoving = true,
   }},
   ["phone"] = {"cellphone@", "cellphone_text_read_base", "Telefoon", AnimationOptions =
   {
       Prop = "prop_npc_phone_02",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["boombox"] = {"move_weapon@jerrycan@generic", "idle", "Boombox", AnimationOptions =
   {
      Prop = "prop_boombox_01",
      PropBone = 57005,
      PropPlacement = {0.27, 0.0, 0.0, 0.0, 263.0, 58.0},
      EmoteLoop = true,
      EmoteMoving = true,
   }},
   ["toolbox"] = {"move_weapon@jerrycan@generic", "idle", "Toolbox", AnimationOptions =
   {
      Prop = "prop_tool_box_04",
      PropBone = 28422,
      PropPlacement = {0.3960, 0.0410, -0.0030, -90.00, 0.0, 90.00},
      EmoteLoop = true,
      EmoteMoving = true,
   }},
   ["toolbox2"] = {"move_weapon@jerrycan@generic", "idle", "Toolbox 2", AnimationOptions =
   {
      Prop = "imp_prop_tool_box_01a",
      PropBone = 28422,
      PropPlacement = {0.3700,0.0200, 0.0, 90.00, 0.0, -90.00},
      EmoteLoop = true,
      EmoteMoving = true,
   }},
--[[   ["saw"] = {"weapons@heavy@minigun", "aim_med_loop", "Beton Zaag", AnimationOptions =
   {
       Prop = "w_me_chainsaw",
       PropBone = 28422,
       PropPlacement = {0.3200, -0.0300, -0.0300, -79.8779, 1.5754, -8.8621},
       EmoteLoop = true,
       EmoteMoving = true,
   }},]]
   ["binbag"] = {"missfbi4prepp1", "_idle_garbage_man", "Vuilniszak", AnimationOptions =
   {
      Prop = "prop_cs_street_binbag_01",
      PropBone = 28422,
      PropPlacement = {0.0, 0.0400, -0.0200, 0.0, 0.0, 0.0},
      EmoteLoop = true,
      EmoteMoving = true,
   }},
   ["protest"] = {"rcmnigel1d", "base_club_shoulder", "Protesteren", AnimationOptions =
   {
      Prop = "prop_cs_protest_sign_01",
      PropBone = 57005,
      PropPlacement = {0.1820, 0.2400, 0.0600, -69.3774235, 5.9142048, -13.9572354},
      --
      EmoteLoop = true,
      EmoteMoving = true,
   }},
   ["binoculars"] = {"amb@world_human_binoculars@male@idle_b", "idle_f", "Verrekijker", AnimationOptions =
   {
      Prop = "prop_binoc_01",
      PropBone = 28422,
      PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
      --
      EmoteLoop = true,
      EmoteMoving = true,
   }},
    ["binoculars2"] = {"amb@world_human_binoculars@male@idle_a", "idle_c", "Verrekijker 2", AnimationOptions =
   {
      Prop = "prop_binoc_01",
      PropBone = 28422,
      PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
      --
      EmoteLoop = true,
      EmoteMoving = true,
   }},
   ["tennisplay"] = {"move_weapon@jerrycan@generic", "idle", "Tennis Spullen", AnimationOptions =
   {
      Prop = "prop_tennis_bag_01",
      PropBone = 57005,
      PropPlacement = {0.27, 0.0, 0.0, 91.0, 0.0, -82.9999951},
	  SecondProp = 'prop_tennis_rack_01',
      SecondPropBone = 60309,
      SecondPropPlacement = {0.0800, 0.0300, 0.0, -130.2907295, 3.8782324, 6.588224},
      EmoteLoop = true,
      EmoteMoving = true,
   }},
   ["weights"] = {"amb@world_human_muscle_free_weights@male@barbell@base", "base", "Gewichten", AnimationOptions =
   {
      Prop = "prop_curl_bar_01",
      PropBone = 28422,
      PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
      EmoteLoop = true,
      EmoteMoving = true,
  }},
   ["weights2"] = {"amb@world_human_muscle_free_weights@male@barbell@idle_a", "idle_d", "Gewichten 2", AnimationOptions =
   {
      Prop = "prop_curl_bar_01",
      PropBone = 28422,
      PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
      EmoteLoop = true,
      EmoteMoving = true,
  }},  
  ["weights3"] = {"amb@world_human_muscle_free_weights@male@barbell@base","base", "Gewichten 3", AnimationOptions =
  {
      Prop = "prop_barbell_01",
      PropBone = 57005,
      PropPlacement = {0.1000,0.0000,0.0000,0.0000,-80.0000,70.0000},
      SecondProp = "prop_barbell_01",
      SecondPropBone = 18905,
      SecondPropPlacement = {0.1000, 0.0000, 0.0000, 0.0000, 80.0000,70.0000},
      EmoteLoop = true,
      EmoteMoving = false,
  }},
   ["fuel"] = {"weapons@misc@jerrycan@", "fire", "Jerrycan legen", AnimationOptions =
   {
      Prop = "w_am_jerrycan",
      PropBone = 57005,
      PropPlacement = {0.1800, 0.1300, -0.2400, -165.8693883, -11.2122753, -32.9453021},
      EmoteLoop = true,
      EmoteMoving = true,
  }},
   ["fuelcarry"] = {"weapons@misc@jerrycan@franklin", "idle", "Jerrycan dragen", AnimationOptions =
   {
      Prop = "w_am_jerrycan",
      PropBone = 28422,
      PropPlacement = {0.26, 0.050, 0.0300, 80.00, 180.000, 79.99},
      EmoteLoop = true,
      EmoteMoving = true,
   }},
   ["jerrycan"] = {"missfbi3_waterboard", "waterboard_idle_player", "Jerrycan Bedreigen", AnimationOptions =
   {
       Prop = "prop_ld_jerrycan_01",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.19, 0.0, 0.0, 90.0000},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["hitchhike"] = {"random@hitch_lift", "idle_f", "Liften", AnimationOptions =
   {
      Prop = "w_am_jerrycan",
      PropBone = 18905,
      PropPlacement = {0.32, -0.0100, 0.0, -162.423, 74.83, 58.79},
	  SecondProp = 'p_michael_backpack_s',
      SecondPropBone = 40269,
      SecondPropPlacement = {-0.07, -0.21, -0.11, -144.93, 117.358, -6.16},
      EmoteLoop = true,
      EmoteMoving = true,
  }},
  ["conehead"] = {"move_m@drunk@verydrunk_idles@", "fidget_07", "Pion op hoofd ", AnimationOptions =
  {
     Prop = "prop_roadcone02b",
     PropBone = 31086,
     PropPlacement = {0.0500, 0.0200, -0.000, 30.0000004, 90.0, 0.0},
     --
     EmoteLoop = true,
     EmoteMoving = true,
  }},
  ["spray"] = {"switch@franklin@lamar_tagging_wall", "lamar_tagging_exit_loop_lamar", "Graffiti", AnimationOptions =
  {
    Prop = 'prop_cs_spray_can',
    PropBone = 28422,
    PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    EmoteLoop = true,
    EmoteMoving = false,
    PtfxAsset = "scr_playerlamgraff",
    PtfxName = "scr_lamgraff_paint_spray",
    PtfxPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
    PtfxInfo = Config.Languages[Config.MenuLanguage]['spray'],
    PtfxWait = 5000,
  }},
  ["spray2"] = {"switch@franklin@lamar_tagging_wall", "lamar_tagging_wall_loop_lamar", "Graffiti 2", AnimationOptions =
  {
    Prop = 'prop_cs_spray_can',
    PropBone = 28422,
    PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 130.0},
    EmoteLoop = true,
    EmoteMoving = true,
  }},   
  ["fireworks"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "dancecrowd_li_15_handup_laz", "Vuurwerk", AnimationOptions =
  {
      Prop = 'ind_prop_firework_01',
      PropBone = 28422,
      PropPlacement = {-0.005,0.0,0.2,360.0,360.0,0.0},
      EmoteMoving = true,
      EmoteLoop = true,
      PtfxAsset = "scr_indep_fireworks",
      PtfxName = "scr_indep_firework_fountain",
      PtfxPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
      PtfxInfo = Config.Languages[Config.MenuLanguage]['fireworks'],
      PtfxWait = 500,
  }},
  ["cart"] = {"anim@heists@box_carry@", "idle", "Kar met dozen", AnimationOptions =
  {
      Prop = "prop_sacktruck_02b",
      PropBone = "SKEL_Pelvis",
      PropPlacement = {-0.075, 0.90, -0.86, -20.0, -0.5, 181.0},
      EmoteLoop = true,
      EmoteMoving = true,
   }},
   ["cart2"] = {"anim@heists@box_carry@", "idle", "Kar", AnimationOptions =
   {
       Prop = "prop_sacktruck_02a",
       PropBone = "SKEL_Pelvis",
       PropPlacement = {-0.075, 0.90, -0.86, -20.0, -0.5, 181.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cart3"] = {"anim@amb@business@weed@weed_sorting_seated@", "base_sorter_left_sorter01", "Grote kar met ton", AnimationOptions =
   {
       Prop = "hei_prop_hei_warehousetrolly_02",
       PropBone = 28252,
       PropPlacement = {1.1800, -1.0300, -0.6500, -74.8670, 62.7487, 34.9640},
       SecondProp = 'prop_barrel_02a',
       SecondPropBone = 28252,
       SecondPropPlacement = {1.0000, -0.4000, -0.2000, -51.0000, 0.0000, 0.0000},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cart4"] = {"anim@amb@business@weed@weed_sorting_seated@", "base_sorter_left_sorter01", "Grote kar", AnimationOptions =
   {
       Prop = "hei_prop_hei_warehousetrolly_02",
       PropBone = 28252,
       PropPlacement = {1.1800, -1.0300, -0.6500, -74.8670, 62.7487, 34.9640},
       EmoteLoop = true,
       EmoteMoving = true,
    }},
    -- ["cart5"] = {"anim@amb@business@weed@weed_sorting_seated@", "base_sorter_left_sorter01", "Grote kar zonder was", AnimationOptions =
    -- {
    --     Prop = "ch_prop_ch_laundry_trolley_01a",
    --     PropBone = 28422,
    --     PropPlacement = {0.3600, -0.2800, -1.4400, -18.6478, 20.7897, -7.3611},
    --     EmoteLoop = true,
    --     EmoteMoving = true,
    --  }},
--    ["cart6"] = {"anim@amb@business@weed@weed_sorting_seated@", "base_sorter_left_sorter01", "Grote kar met was", AnimationOptions =
--    {
--        Prop = "ch_prop_ch_laundry_trolley_01b",
--        PropBone = 28422,
--        PropPlacement = {0.3600, -0.2800, -1.4400, -18.6478, 20.7897, -7.3611},
--        EmoteLoop = true,
--        EmoteMoving = true,
--     }},
    ["zwerver"] = {"anim@heists@box_carry@", "idle", "Zwerver Karretje", AnimationOptions =
    {
        Prop = "prop_skid_trolley_1",
        PropBone = 28422,
        PropPlacement = {0.0, -0.50, -0.80, 13.30, 0.30, 0.00},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["zwerver2"] = {"anim@heists@box_carry@", "idle", "Zwerver Karretje 2", AnimationOptions =
    {
        Prop = "prop_skid_trolley_2",
        PropBone = 28422,
        PropPlacement = {0.0, -0.50, -0.80, 13.30, 0.30, 0.00},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["zwerver3"] = {"timetable@tracy@sleep@", "idle_c", "Slapende Zwerver", AnimationOptions =
    {
        Prop = "prop_skid_box_01",
        PropBone = 31086,
        PropPlacement = {-1.2200, 0.280, -0.0900, 3.6164, 10.6275, -19.6834},
        EmoteLoop = true,
        EmoteMoving = false,
    }},
    ["beg"] = {"amb@world_human_bum_freeway@male@base", "base", "Zwerver 2", AnimationOptions =
    {
        Prop = 'prop_beggers_sign_03',
        PropBone = 58868,
        PropPlacement = {0.21, 0.17, 0.0, 5.0, 0.0, 40.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["beg2"] = {"amb@world_human_bum_freeway@male@base", "base", "Zwerver 3", AnimationOptions =
    {
        Prop = 'prop_beggers_sign_02',
        PropBone = 58868,
        PropPlacement = {0.21, 0.17, 0.0, 5.0, 0.0, 40.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["beg3"] = {"amb@world_human_bum_freeway@male@base", "base", "Zwerver 4", AnimationOptions =
    {
        Prop = 'prop_beggers_sign_04',
        PropBone = 58868,
        PropPlacement = {0.21, 0.17, 0.0, 5.0, 0.0, 40.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["vuilnisbak"] = {"anim@heists@box_carry@", "idle", "Vuilnisbak", AnimationOptions =
    {
        Prop = "prop_cs_bin_01",
        PropBone = "SKEL_Pelvis",
        PropPlacement = {-0.075, 1.1, -0.92, -20.0, -0.8, 181.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["vuilnisbak2"] = {"anim@heists@box_carry@", "idle", "Vuilnisbak 2", AnimationOptions =
    {
        Prop = "prop_cs_bin_03",
        PropBone = "SKEL_Pelvis",
        PropPlacement = {-0.075, 1.1, -0.92, -20.0, -0.8, 181.0},
        EmoteLoop = true,
        EmoteMoving = true,
    }},
    ["pump"] = {"missfbi4prepp1", "idle", "Pumpkin", AnimationOptions =
    {
       Prop = "prop_veg_crop_03_pump",
       PropBone = 28422,
       PropPlacement = {0.0200, 0.0600, -0.1200, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
    }},
    ["pump2"] = {"anim@heists@box_carry@", "idle", "Pumpkin 2", AnimationOptions =
    {
       Prop = "prop_veg_crop_03_pump",
       PropBone = 28422,
       PropPlacement = {0.0100, -0.16000, -0.2100, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
    }},
}