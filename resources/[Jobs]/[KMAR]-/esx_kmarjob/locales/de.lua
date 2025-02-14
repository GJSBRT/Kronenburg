﻿--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
Locales['de'] = {
  -- Cloackroom
  ['cloakroom'] = 'Garderobe',
  ['citizen_wear'] = 'Zivilkleidung',
  ['police_wear'] = 'Arbeitskleidung',
  ['sheriff_wear'] = 'sheriff Outfit',
  ['lieutenant_wear'] = 'Swatt outfit ',
  ['gilet_wear'] = 'orange reflective jacket',
  ['bullet_wear'] = 'bulletproof vest',
  ['no_outfit'] = 'there\'s no uniform that fits you!',
  ['open_cloackroom'] = 'Drücke ~INPUT_CONTEXT~ um dich umzuziehen',
  -- Armory
  ['remove_object'] = 'take object',
  ['deposit_object'] = 'deposit object',
  ['get_weapon'] = 'Waffen holen',
  ['put_weapon'] = 'Waffen bringen',
  ['buy_weapons'] = 'Waffen kaufen',
  ['armory'] = 'Waffenkammer',
  ['open_armory'] = 'Drücke ~INPUT_CONTEXT~ um die Waffenkammer zu öffnen',
  -- Vehicles
  ['vehicle_menu'] = 'Fahrzeug',
  ['vehicle_out'] = 'es ist bereits ein Fahrzeug draussen',
  ['vehicle_spawner'] = 'Drücke ~INPUT_CONTEXT~ um ein Fahrzeug zu holen',
  ['store_vehicle'] = 'Drücke ~INPUT_CONTEXT~ um das Fahrzeug zu parken',
  ['service_max'] = 'max Polizisten im Dienst: %s/%s',
  -- Action Menu
  ['citizen_interaction'] = 'Zivilistenaktionen',
  ['vehicle_interaction'] = 'Fahrzeuginteraktionen',
  ['object_spawner'] = 'Objekt Spawner',

  ['id_card'] = 'ID Karte',
  ['search'] = 'Suche',
  ['handcuff'] = 'Festnehmen / Freilassen',
  ['drag'] = 'drag',
  ['put_in_vehicle'] = 'In Fahrzeug setzen',
  ['out_the_vehicle'] = 'take out of vehicle',
  ['fine'] = 'Strafe',
  ['license_check'] = 'manage license',
  ['license_revoke'] = 'revoke license',
  ['license_revoked'] = 'your ~b~%s~s~ has been ~y~revoked~s~!',
  ['licence_you_revoked'] = 'you revoked a ~b~%s~s~ which belonged to ~y~%s~s~',
  ['no_players_nearby'] = 'Keine Spieler in der Nähe',
  -- Vehicle interaction
  ['vehicle_info'] = 'Fahrzeug Info',
  ['pick_lock'] = 'Fahrzeug öffnen',
  ['vehicle_unlocked'] = 'Fahrzeug ~g~offen~s~',
  ['no_vehicles_nearby'] = 'Keine Fahrzeuge in der Nähe',
  ['impound'] = 'impound vehicle',
  ['impound_prompt'] = 'press ~INPUT_CONTEXT~ to cancel the ~y~impound~s~',
  ['impound_canceled'] = 'you canceled the impound',
  ['impound_canceled_moved'] = 'the impound has been canceled because the vehicle moved',
  ['impound_successful'] = 'you have impounded the vehicle',
  ['search_database'] = 'vehicle information',
  ['search_database_title'] = 'vehicle information - search with registration number',
  ['search_database_error_invalid'] = 'that is ~r~not~s~ a ~y~valid~s~ registration number',
  ['search_database_error_not_found'] = 'that ~y~registration number~s~ is ~r~not~s~ registered to an vehicle!',
  ['search_database_found'] = 'the vehicle is ~y~registered~s~ to ~b~%s~s~',
  -- Traffic interaction
  ['traffic_interaction'] = 'Straßeninteraktionen',
  ['cone'] = 'Hütchen',
  ['barrier'] = 'Barriere',
  ['spikestrips'] = 'Nagelband',
  ['box'] = 'Box',
  ['cash'] = 'Box mit Geld',
  -- ID Card Menu
  ['name'] = 'name: %s',
  ['bac'] = 'BAC: %s',
  -- Body Search Menu
  ['guns_label'] = '--- Waffen ---',
  ['inventory_label'] = '--- Inventar ---',
  ['confiscate'] = 'konfeszieren %s',
  ['confiscate_inv'] = 'konfeziere %sx %s',
  ['confiscate_dirty'] = 'schwarzgeld konfesziert: <span style="color:red;">$%s</span>',
  ['you_confiscated'] = 'you confiscated ~y~%sx~s~ ~b~%s~s~ from ~b~%s~s~',
  ['got_confiscated'] = '~y~%sx~s~ ~b~%s~s~ were confiscated by ~y~%s~s~',
  ['you_confiscated_account'] = 'you confiscated ~g~$%s~s~ (%s) from ~b~%s~s~',
  ['got_confiscated_account'] = '~g~$%s~s~ (%s) was confiscated by ~y~%s~s~',
  ['you_confiscated_weapon'] = 'you confiscated ~b~%s~s~ from ~b~%s~s~ with ~o~%s~s~ bullets',
  ['got_confiscated_weapon'] = 'your ~b~%s~s~ with ~o~%s~s~ bullets was confiscated by ~y~%s~s~',
  ['traffic_offense'] = 'Verkehrs vergehen',
  ['minor_offense'] = 'Geringes vergehen',
  ['average_offense'] = 'Normales vergehen',
  ['major_offense'] = 'Hohes vergehen',
  ['fine_total'] = 'strafe: %s',
  -- Vehicle Info Menu
  ['plate'] = 'plate: %s',
  ['owner_unknown'] = 'besitzer: Unbekannt',
  ['owner'] = 'besitzer: %s',
  -- Weapons Menus
  ['get_weapon_menu'] = 'Waffenkammer - Waffen nehmen',
  ['put_weapon_menu'] = 'Waffenkammer - Waffen bringen',
  ['buy_weapon_menu'] = 'Waffenkammer - Waffen kaufen',
  ['not_enough_money'] = 'Du hast nicht genug Geld',
  -- Boss Menu
  ['take_company_money'] = 'Firmengeld abheben',
  ['deposit_money'] = 'Geld einzahlen',
  ['amount_of_withdrawal'] = 'Betrag zum abheben',
  ['invalid_amount'] = 'ungültiger Betrag',
  ['amount_of_deposit'] = 'Betrag zum einzahlen',
  ['open_bossmenu'] = 'Drücke ~INPUT_CONTEXT~ um das Menü zu öffnen',
  -- Misc
  ['remove_prop'] = 'Drücke ~INPUT_CONTEXT~ um das Objekt zu entfernen',
  ['map_blip'] = 'Polizeistation',
  ['unrestrained_timer'] = 'you feel your handcuffs slowly losing grip and fading away.',
  -- Notifications
  ['alert_police'] = 'Polizei alamieren',
}
