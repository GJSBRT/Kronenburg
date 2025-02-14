﻿--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
Locales['sv'] = {
  -- Cloakroom
  ['cloakroom'] = 'omklädningsrum',
  ['citizen_wear'] = 'civila kläder',
  ['police_wear'] = 'polisuniform',
  ['sheriff_wear'] = 'inspektöruniform',
  ['lieutenant_wear'] = 'insatsstyrka',
  ['gilet_wear'] = 'reflektiv väst',
  ['bullet_wear'] = 'skottsäker väst',
  ['no_outfit'] = 'det finns ingen uniform som passar dig!',
  ['open_cloackroom'] = 'tryck ~INPUT_CONTEXT~ för att välja ~y~kläder~s~.',
  -- Armory
  ['remove_object'] = 'Ta ut objekt',
  ['deposit_object'] = 'Lägg in objekt',
  ['get_weapon'] = 'Ta ut vapen',
  ['put_weapon'] = 'Lägg in vapen',
  ['buy_weapons'] = 'Köp in vapen',
  ['armory'] = 'Vapenförråd',
  ['open_armory'] = 'tryck ~INPUT_CONTEXT~ för att komma åt förrådet',
  -- Vehicles
  ['vehicle_menu'] = 'Bilar',
  ['vehicle_out'] = 'Det finns redan en bil ute!',
  ['vehicle_spawner'] = 'Tryck ~INPUT_CONTEXT~ för att ta ut en bil',
  ['store_vehicle'] = 'Tryck ~INPUT_CONTEXT~ för att parkera bilen',
  ['service_max'] = 'max antal poliser i tjänst: %s/%s',
  -- Action Menu
  ['citizen_interaction'] = 'Handlingar mot civila',
  ['vehicle_interaction'] = 'Handlingar på bilar',
  ['object_spawner'] = 'ta fram ett objekt',

  ['id_card'] = 'ID-Kort',
  ['search'] = 'sök igenom',
  ['handcuff'] = 'handbojor',
  ['drag'] = 'dra',
  ['put_in_vehicle'] = 'sätt in i fordon',
  ['out_the_vehicle'] = 'dra ut ur fordon',
  ['fine'] = 'Ge böter',
  ['license_check'] = 'se licenser',
  ['license_revoke'] = 'återkalla licenser',
  ['license_revoked'] = 'Ditt ~b~%s~s~ har blivit ~y~återkallat~s~!',
  ['licence_you_revoked'] = 'du återkallade ett ~b~%s~s~ som tillhörde ~y~%s~s~',
  ['no_players_nearby'] = 'det finns ingen i närheten',
  -- Vehicle interaction
  ['vehicle_info'] = 'fordon',
  ['pick_lock'] = 'bryt upp fordon',
  ['vehicle_unlocked'] = 'fordonet har ~g~låsts upp~s~',
  ['no_vehicles_nearby'] = 'inga fordon i närheten',
  ['impound'] = 'bärga fordonet',
  ['impound_prompt'] = 'tryck ~INPUT_CONTEXT~ för att avbryta ~y~bärgningen~s~',
  ['impound_canceled'] = 'du avbröt bärgningen',
  ['impound_canceled_moved'] = 'bärgningen avbröts på grund av att fordonet har rört sig',
  ['impound_successful'] = 'du har bärgat fordonet',
  ['search_database'] = 'fordonsuppgifter',
  ['search_database_title'] = 'fordonsuppgifter - sök med registreringsnummer',
  ['search_database_error_invalid'] = 'det är ~r~inte~s~ ett ~y~giltigt~s~ registreringsnummer',
  ['search_database_error_not_found'] = 'det ~y~registreringsnummeret~s~ är ~r~inte~s~ registrerat till något fordon!',
  ['search_database_found'] = 'detta fordon är ~y~registrerat~s~ till ~b~%s~s~',
  -- Traffic interaction
  ['traffic_interaction'] = 'trafiksåtgärder',
  ['cone'] = 'Kon',
  ['barrier'] = 'Barriär',
  ['spikestrips'] = 'Spikmatta',
  ['box'] = 'låda',
  ['cash'] = 'låda med pengar',
  -- ID Card Menu
  ['name'] ='namn: %s',
  ['bac'] = 'alkohol i blodet: %s',
  -- Body Search Menu
  ['guns_label'] = '--- Vapen ---',
  ['inventory_label'] = '--- Inventory ---',
  ['confiscate'] = 'beslagta %s',
  ['confiscate_inv'] = 'beslagta %sx %s',
  ['confiscate_dirty'] = 'beslagta svarta pengar: <span style="color:red;">$%s</span>',
  ['you_confiscated'] = 'du beslagtog ~y~%sx~s~ ~b~%s~s~ från ~b~%s~s~',
  ['got_confiscated'] = '~y~%sx~s~ ~b~%s~s~ beslagtogs av ~y~%s~s~',
  ['you_confiscated_account'] = 'du beslagtog ~g~$%s~s~ (%s) från ~b~%s~s~',
  ['got_confiscated_account'] = '~g~$%s~s~ (%s) beslagtogs av ~y~%s~s~',
  ['you_confiscated_weapon'] = 'du beslagtog ~b~%s~s~ från ~b~%s~s~ med ~o~%s~s~ skott',
  ['got_confiscated_weapon'] = 'din ~b~%s~s~ med ~o~%s~s~ skott beslagtogs av ~y~%s~s~',
  ['traffic_offense'] = 'brott mot trafikregler',
  ['minor_offense'] = 'mindre lagbrott',
  ['average_offense'] = 'medel lagbrott',
  ['major_offense'] = 'grovt lagbrott',
  ['fine_total'] = 'böter: %s',
  -- Vehicle Info Menu
  ['plate'] = 'reg nummer: %s',
  ['owner_unknown'] = 'ägare: Okänt',
  ['owner'] = 'ägare: %s',
  -- Weapons Menus
  ['get_weapon_menu'] = 'Vapenförråd - Ta vapen',
  ['put_weapon_menu'] = 'Vapenförråd - Lägg in vapen',
  ['buy_weapon_menu'] = 'Vapenförråd - Köp in vapen',
  ['not_enough_money'] = 'Du har inte tillräckligt mycket pengar',
  -- Boss Menu
  ['take_company_money'] = 'Ta ut företagspengar',
  ['deposit_money'] = 'Lägg in pengar till företaget',
  ['amount_of_withdrawal'] = 'Belopp att ta ut',
  ['invalid_amount'] = 'Otillgängligt belopp',
  ['amount_of_deposit'] = 'Belopp att lägga in',
  ['open_bossmenu'] = 'Tryck ~INPUT_CONTEXT~ för att öppna menyn',
  ['quantity_invalid'] = 'Otillgängligt antal',
  ['have_withdraw'] = 'Du har tagit ut x',
  ['added'] = 'Du la in x',
  ['quantity'] = 'Antal',
  ['inventory'] = 'Förråd',
  ['police_stock'] = 'Polisförråd',
  -- Misc
  ['remove_prop'] = 'tryck ~INPUT_CONTEXT~ för att ta bort obejektet',
  ['map_blip'] = 'Polisstation',
  ['unrestrained_timer'] = 'dina handklovar har försvunnit',
  -- Notifications
  ['alert_police'] = 'Meddela polisen',
}
