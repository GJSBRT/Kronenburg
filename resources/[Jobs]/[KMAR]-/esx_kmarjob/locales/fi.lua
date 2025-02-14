﻿--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
Locales['fi'] = {
  -- Cloakroom
  ['cloakroom'] = 'vaatelokero',
  ['citizen_wear'] = 'siviiliasu',
  ['police_wear'] = 'poliisiasu',
  ['sheriff_wear'] = 'sheriffiasu',
  ['lieutenant_wear'] = 'swattiasu',
  ['gilet_wear'] = 'huomioliivi',
  ['bullet_wear'] = 'Luotiliivi',
  ['no_outfit'] = 'täällä ei ole sinulle sopivaa asua',
  ['open_cloackroom'] = 'paina ~INPUT_CONTEXT~ vaihtaaksesi ~y~vaatteita~s~.',
  -- Armory
  ['remove_object'] = 'ota esine',
  ['deposit_object'] = 'talleta esine',
  ['get_weapon'] = 'ota ase',
  ['put_weapon'] = 'laita ase pois',
  ['buy_weapons'] = 'osta aseita',
  ['armory'] = 'asevarasto',
  ['open_armory'] = 'paina ~INPUT_CONTEXT~ avataksesi asevarasto',
  -- Vehicles
  ['vehicle_menu'] = 'ajoneuvo',
  ['vehicle_out'] = 'ajoneuvo on jo ulkona tallista',
  ['vehicle_spawner'] = 'paina ~INPUT_CONTEXT~ ottaaksesi auton ulos',
  ['store_vehicle'] = 'paina ~INPUT_CONTEXT~ laittaaksesi auto talliin',
  ['service_max'] = 'maksimi määrä poliiseja: %s/%s',
  -- Action Menu
  ['citizen_interaction'] = 'siviilin vuorovaikutus',
  ['vehicle_interaction'] = 'ajoneuvon vuorovaikutus',
  ['object_spawner'] = 'objekti spawneri',

  ['id_card'] = 'Henkilöllisyystodistus',
  ['search'] = 'tutki',
  ['handcuff'] = 'Raudat On/Off',
  ['drag'] = 'raahaa',
  ['put_in_vehicle'] = 'laita ajoneuvoon',
  ['out_the_vehicle'] = 'ota ulos ajoneuvosta',
  ['fine'] = 'sakko',
  ['license_check'] = 'hallitse lisenssejä',
  ['license_revoke'] = 'kumoa lisenssi',
  ['license_revoked'] = 'sinun ~b~%s~s~ ~y~kumottiin~s~!',
  ['licence_you_revoked'] = 'sinä kumosit ~b~%s~s~ mikä kuului henkilölle ~y~%s~s~',
  ['no_players_nearby'] = 'ei pelaajia lähettyvillä',
  -- Vehicle interaction
  ['vehicle_info'] = 'ajoneuvon tiedot',
  ['pick_lock'] = 'tiirikoi ovet',
  ['vehicle_unlocked'] = 'ajoneuvo ~g~Avattu~s~',
  ['no_vehicles_nearby'] = 'ei ajoneuvoja lähettyvillä',
  ['impound'] = 'takavarikoi ajoneuvo',
  ['impound_prompt'] = 'paina ~INPUT_CONTEXT~ peruaksesi ~y~takavarikointi~s~',
  ['impound_canceled'] = 'sinä peruit takavarikoinnin',
  ['impound_canceled_moved'] = 'takavarikointi peruuntui koska ajoneuvo liikku',
  ['impound_successful'] = 'takavarikoit ajoneuvon',
  ['search_database'] = 'ajoneuvon tiedot',
  ['search_database_title'] = 'ajoneuvon tiedot - etsi rekisterinumerolla',
  ['search_database_error_invalid'] = 'tämä ~r~ei ole~s~ ~y~voimassa oleva~s~ rekisterinumero',
  ['search_database_error_not_found'] = 'tämä ~y~rekisterinumero~s~ ~r~ei~s~ ole rekistöröity ajoneuvoon!',
  ['search_database_found'] = 'ajoneuvo on ~y~rekistöröity~s~ henkilölle ~b~%s~s~',
  -- Traffic interaction
  ['traffic_interaction'] = 'Liikenne vuorovaikutus',
  ['cone'] = 'kartio',
  ['barrier'] = 'este',
  ['spikestrips'] = 'piikkimatto',
  ['box'] = 'laatikko',
  ['cash'] = 'rahalaatikko',
  -- ID Card Menu
  ['name'] = 'nimi: %s',
  ['bac'] = 'alkometri: %s',
  -- Body Search Menu
  ['guns_label'] = '--- Aseet ---',
  ['inventory_label'] = '--- Reppu ---',
  ['confiscate'] = 'takavarikoi %s',
  ['confiscate_inv'] = 'takavarikoi %sx %s',
  ['confiscate_dirty'] = 'takavarikoi likainen raha: <span style="color:red;">€%s</span>',
  ['you_confiscated'] = 'you confiscated ~y~%sx~s~ ~b~%s~s~ from ~b~%s~s~',
  ['got_confiscated'] = '~y~%sx~s~ ~b~%s~s~ were confiscated by ~y~%s~s~',
  ['you_confiscated_account'] = 'you confiscated ~g~$%s~s~ (%s) from ~b~%s~s~',
  ['got_confiscated_account'] = '~g~$%s~s~ (%s) was confiscated by ~y~%s~s~',
  ['you_confiscated_weapon'] = 'you confiscated ~b~%s~s~ from ~b~%s~s~ with ~o~%s~s~ bullets',
  ['got_confiscated_weapon'] = 'your ~b~%s~s~ with ~o~%s~s~ bullets was confiscated by ~y~%s~s~',
  ['traffic_offense'] = 'liikenne rikokset',
  ['minor_offense'] = 'lievät rikokset',
  ['average_offense'] = 'keskisuuret rikokset',
  ['major_offense'] = 'vakavat rikokset',
  ['fine_total'] = 'sakko: %s',
  --Vehicle Info Menu
  ['plate'] = 'kilpi: %s',
  ['owner_unknown'] = 'omistaja: Tuntematon',
  ['owner'] = 'omistaja: %s',
  -- Weapons Menus
  ['get_weapon_menu'] = 'asevarasto - Ota ase',
  ['put_weapon_menu'] = 'asevarasto - Laita ase pois',
  ['buy_weapon_menu'] = 'asevarasto - Osta aseet',
  ['not_enough_money'] = 'sinulla ei ole tarpeeksi rahaa',
  --Boss Menu
  ['take_company_money'] = 'nosta yrityksen varoja',
  ['deposit_money'] = 'talleta rahaa',
  ['amount_of_withdrawal'] = 'noston määrä',
  ['invalid_amount'] = 'virheellinen summa',
  ['amount_of_deposit'] = 'talletuksen määrä',
  ['open_bossmenu'] = 'paina ~INPUT_CONTEXT~ avataksesi valikon',
  ['quantity_invalid'] = 'invalid quantity',
  ['have_withdrawn'] = 'sinä nostit x',
  ['added'] = 'sinä lisäsit varastoon x',
  ['quantity'] = 'määrä',
  ['inventory'] = 'varasto',
  ['police_stock'] = 'Poliisin Varasto',
  -- Misc
  ['remove_prop'] = 'Paina ~INPUT_CONTEXT~ poistaaksesi objektin',
  ['map_blip'] = 'Poliisilaitos',
  ['unrestrained_timer'] = 'you feel your handcuffs slowly losing grip and fading away.',
  -- Notifications
  ['alert_police'] = 'hälyytys Poliisi',
}