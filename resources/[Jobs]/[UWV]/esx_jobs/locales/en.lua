--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
Locales['en'] = {
  -- Global menus
  ['cloakroom']                 = 'Kleedkamer',
  ['cloak_change']              = 'Druk op ~INPUT_PICKUP~ om kleding aan te passen.',
  ['citizen_wear']              = 'Burgerkleding',
  ['job_wear']                  = 'Werk Kleding',
  ['bank_deposit_returned']     = 'Een borgsom van ~g~$%s~s~ werd aan jou teruggegeven.',
  ['bank_deposit_taken']        = 'Een borgsom van ~r~$%s~s~ werd van jou Gepakt.',
  ['foot_work']                 = 'Je moet te voet zijn om te kunnen werken.',
  ['next_point']                = 'Ga naar de volgende stap nadat u deze hebt voltooid.',
  ['not_your_vehicle']          = 'Dit is niet uw voertuig of u moet een chauffeur zijn.',
  ['in_vehicle']                = 'Je moet in een voertuig zitten.',
  ['wrong_point']               = 'Je bent niet op het juiste afleverpunt.',
  ['max_limit']                 = 'Je kunt niet meer dragen ~y~%s~s~',
  ['not_enough']                = 'Je hebt niet genoeg ~y~%s~s~ om deze taak voort te zetten.',
  ['spawn_veh']                 = 'Pak voertuig',
  ['spawn_veh_button']          = 'Druk op ~INPUT_PICKUP~ om een werkvoertuig te pakken.',
  ['spawn_truck_button']        = 'Druk op ~INPUT_PICKUP~ om een auto te pakken.',
  ['spawn_blocked']             = 'Een voertuig blokkeert het spawnpunt!',
  ['service_vh']                = 'Werkvoertuig',
  ['return_vh']                 = 'Voertuig terugbrengen',
  ['return_vh_button']          = 'Druk op ~INPUT_PICKUP~ om het voertuig terug te zetten.',
  ['delivery_point']            = 'Afleverpunt',
  ['delivery']                  = 'Levering',
  ['public_enter']              = 'Druk op ~INPUT_PICKUP~ om het gebouw binnen te gaan.',
  ['public_leave']              = 'Druk op ~INPUT_PICKUP~ om naar de ingang van het gebouw te gaan.',

  -- Lumber Jack job
  ['lj_locker_room']            = 'Houthakker kleding kamer',
  ['lj_mapblip']                = 'Hout stapel',
  ['lj_wood']                   = 'Hout',
  ['lj_pickup']                 = 'Druk op ~INPUT_PICKUP~ om hout te verzamelen.',
  ['lj_cutwood']                = 'Hout zagerij',
  ['lj_cutwood_button']         = 'Druk op ~INPUT_PICKUP~ om hout te zagen.',
  ['lj_board']                  = 'Planken',
  ['lj_planks']                 = 'Verpak planken',
  ['lj_cutwood']                = 'Hout zagen',
  ['lj_pick_boards']            = 'Druk op ~INPUT_PICKUP~ om planken te verzamelen.',
  ['lj_deliver_button']         = 'Druk op ~INPUT_PICKUP~ om planken af te leveren.',

  -- Fisherman
  ['fm_fish_locker']            = 'Vissers kleedkamer',
  ['fm_fish']                   = 'Vis',
  ['fm_fish_area']              = 'Vis plek',
  ['fm_fish_button']            = 'Druk op ~INPUT_PICKUP~ om te vissen.',
  ['fm_spawnboat_title']        = 'Boot pakken',
  ['fm_spawnboat']              = 'Druk op ~INPUT_PICKUP~ om een boot te pakken.',
  ['fm_boat_title']             = 'Boot',
  ['fm_boat_return_title']      = 'Boot terug brengen',
  ['fm_boat_return_button']     = 'Druk op ~INPUT_PICKUP~ om je boot in te leveren.',
  ['fm_deliver_fish']           = 'Druk op ~INPUT_PICKUP~ om je vis in te leveren.',

  -- Fuel
  ['f_oil_refiner']             = 'Olieraffinaderij kleedkamer',
  ['f_drill_oil']               = 'Boor naar olie',
  ['f_fuel']                    = 'Olie',
  ['f_drillbutton']             = 'Druk op ~INPUT_PICKUP~ om te boren.',
  ['f_fuel_refine']             = 'Olie raffineren',
  ['f_refine_fuel_button']      = 'Druk op ~INPUT_PICKUP~ om te verfijnen.',
  ['f_fuel_mixture']            = 'Meng geraffineerde olie',
  ['f_gas']                     = 'Gas',
  ['f_fuel_mixture_button']     = 'Druk op ~INPUT_PICKUP~ om de olie te mixen.',
  ['f_deliver_gas']             = 'Gas afleveren',
  ['f_deliver_gas_button']      = 'Druk op ~INPUT_PICKUP~ om gas in te leveren.',

  -- Miner
  ['m_miner_locker']            = 'Mijnwerkers kleedkamer',
  ['m_rock']                    = 'Steen',
  ['m_pickrocks']               = 'Druk op ~INPUT_PICKUP~ om stenen op te halen.',
  ['m_washrock']                = 'Steen wassen',
  ['m_rock_button']             = 'Druk op ~INPUT_PICKUP~ om stenen te wassen.',
  ['m_rock_smelting']           = 'Steen Smelten',
  ['m_copper']                  = 'Koper',
  ['m_sell_copper']             = 'Koper Verkoop',
  ['m_deliver_copper']          = 'Druk op ~INPUT_PICKUP~ om koper te verkopen.',
  ['m_iron']                    = 'Ijzer',
  ['m_sell_iron']               = 'Ijzer Verkoop',
  ['m_deliver_iron']            = 'Druk op ~INPUT_PICKUP~ om ijzer te verkopen.',
  ['m_gold']                    = 'Goud',
  ['m_sell_gold']               = 'Goud Verkoop',
  ['m_deliver_gold']            = 'Druk op ~INPUT_PICKUP~ om goud te verkopen.',
  ['m_diamond']                 = 'Diamant',
  ['m_sell_diamond']            = 'Diamant Verkoop',
  ['m_deliver_diamond']         = 'Druk op ~INPUT_PICKUP~ om diamant te verkopen.',
  ['m_melt_button']             = 'Druk op ~INPUT_PICKUP~ om steen te smelten.',

  -- Reporter
  ['reporter_name']             = 'Arcadius Nieuws',
  ['reporter_garage']           = 'Druk op ~INPUT_PICKUP~ om de garage in te gaan.',

  -- Slaughterer
  ['s_slaughter_locker']        = 'Slachter kleedkamer',
  ['s_hen']                     = 'Kippen ren',
  ['s_alive_chicken']           = 'Levende kippen',
  ['s_catch_hen']               = 'Druk op ~INPUT_PICKUP~ om levende kippen te vangen.',
  ['s_slaughtered_chicken']     = 'Kippen die verpakt moeten worden',
  ['s_chop_animal']             = 'Druk op ~INPUT_PICKUP~ om de kippen te slachten.',
  ['s_slaughtered']             = 'Slachters huis',
  ['s_package']                 = 'Verpakking',
  ['s_packagechicken']          = 'Verpakte kip',
  ['s_unpackaged']              = 'Kip dat nog verpakt moet worden',
  ['s_unpackaged_button']       = 'Druk op ~INPUT_PICKUP~ om de kippen te verpakken.',
  ['s_deliver']                 = 'Druk op ~INPUT_PICKUP~ om de kippen af te leveren.',

  -- Dress Designer
  ['dd_dress_locker']           = 'dress Designer\'s Locker Room',
  ['dd_wool']                   = 'wool',
  ['dd_pickup']                 = 'press ~INPUT_PICKUP~ to retrieve wool.',
  ['dd_fabric']                 = 'fabric',
  ['dd_makefabric']             = 'press ~INPUT_PICKUP~ to make fabric.',
  ['dd_clothing']               = 'clothing',
  ['dd_makeclothing']           = 'press ~INPUT_PICKUP~ to retrieve clothing.',
  ['dd_deliver_clothes']        = 'press ~INPUT_PICKUP~ to deliver the clothes.',
  }
