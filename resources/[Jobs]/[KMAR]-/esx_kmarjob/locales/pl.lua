﻿--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
Locales['pl'] = {
  -- Cloakroom
  ['cloakroom'] = 'Szatnia',
  ['citizen_wear'] = 'Ubranie Cywilne',
  ['police_wear'] = 'Mundur',
  ['sheriff_wear'] = 'Mundur Szeryfa',
  ['lieutenant_wear'] = 'Mundur Porucznika',
  ['gilet_wear'] = 'Kamizelka odblaskowa',
  ['bullet_wear'] = 'Kamizelka kuloodporna',
  ['no_outfit'] = 'Brak ubrania',
  ['open_cloackroom'] = 'Naciśnij ~INPUT_CONTEXT~ aby zmienić ~y~ubranie~s~.',
  -- Armory
  ['remove_object'] = 'Weź przedmiot',
  ['deposit_object'] = 'Zdeponuj przedmiot',
  ['get_weapon'] = 'Weź broń',
  ['put_weapon'] = 'Odłóż broń',
  ['buy_weapons'] = 'Kup Broń',
  ['armory'] = 'Zbrojownia',
  ['open_armory'] = 'Naciśnij ~INPUT_CONTEXT~ żeby uzyskać dostęp do zbrojowni',
  -- Vehicles
  ['vehicle_menu'] = 'Pojazdy',
  ['vehicle_out'] = 'Masz już pojazd poza garażem',
  ['vehicle_spawner'] = 'Naciśnij ~INPUT_CONTEXT~ żeby wziąć pojazd',
  ['store_vehicle'] = 'Naciśnij ~INPUT_CONTEXT~ żeby przechować pojazd',
  ['service_max'] = 'maksymalna ilość policjantów na służbie: %s/%s',
  -- Action Menu
  ['citizen_interaction'] = 'Interakcja z cywilami',
  ['vehicle_interaction'] = 'Interakcja z pojazdami',
  ['object_spawner'] = 'Przedmioty do postawienia',

  ['id_card'] = 'Dowód osobisty',
  ['search'] = 'Przeszukaj',
  ['handcuff'] = 'Zakuj/Rozkuj Kajdanki ',
  ['drag'] = 'Przemieść podejrzanego',
  ['put_in_vehicle'] = 'Wsadź do pojazdu',
  ['out_the_vehicle'] = 'Wyciągnij z pojazdu',
  ['fine'] = 'Mandaty',
  ['license_check'] = 'Zarządzaj licencjami',
  ['license_revoke'] = 'Uniewaźnij licencje',
  ['license_revoked'] = 'Twoja licencja ~b~%s~s~ została ~y~unieważniona~s~!',
  ['licence_you_revoked'] = 'Unieważniłeś ~b~%s~s~ które należały do ~y~%s~s~',
  ['no_players_nearby'] = 'Brak graczy w pobliżu',
  -- Vehicle interaction
  ['vehicle_info'] = 'Informacje o pojeździe',
  ['pick_lock'] = 'Odblokuj pojazd',
  ['vehicle_unlocked'] = 'Pojazd ~g~Odblokowany~s~',
  ['no_vehicles_nearby'] = 'Brak pojazdu w pobliżu',
  ['impound'] = 'Zajmij pojazd',
  ['impound_prompt'] = 'Naciśnij ~INPUT_CONTEXT~ żeby unieważnić ~y~zajęcie~s~',
  ['impound_canceled'] = 'Unieważniłeś/aś zajęcie',
  ['impound_canceled_moved'] = 'Zajęcie zostało anulowane, ponieważ pojazd przemieścił się',
  ['impound_successful'] = 'Zająłeś/aś pojazd',
  ['search_database'] = 'Informacje o pojeździe',
  ['search_database_title'] = 'Informacjeo pojeździe - przeszukaj używając numeru rejestracyjnego',
  ['search_database_error_invalid'] = 'To ~r~nie~s~ jest ~y~poprawny~s~ rnumer rejestracyjny',
  ['search_database_error_not_found'] = 'Ten ~y~numer rejestracyjny~s~  ~r~nie jest~s~ zarejestrowany do tego pojazdu!',
  ['search_database_found'] = 'Pojazd jest ~y~zarejestrowany~s~ do ~b~%s~s~',
  -- Traffic interaction
  ['traffic_interaction'] = 'Interakcje dla ruchu drogowego',
  ['cone'] = 'Pachołek',
  ['barrier'] = 'Barierka',
  ['spikestrips'] = 'Kolczatka',
  ['box'] = 'Pudła',
  ['cash'] = 'Paleta z pieniędzmi',
  -- ID Card Menu
  ['name'] = 'nazwa: %s',
  ['bac'] = 'BAC: %s',
  -- Body Search Menu
  ['guns_label'] = '--- Bronie ---',
  ['inventory_label'] = '--- Ekwipunek ---',
  ['confiscate'] = 'skonfiskuj %s',
  ['confiscate_inv'] = 'skonfiskuj %sx %s',
  ['confiscate_dirty'] = 'skonfiskuj brudne pieniądze: <span style="color:red;">$%s</span>',
  ['you_confiscated'] = 'you confiscated ~y~%sx~s~ ~b~%s~s~ from ~b~%s~s~',
  ['got_confiscated'] = '~y~%sx~s~ ~b~%s~s~ were confiscated by ~y~%s~s~',
  ['you_confiscated_account'] = 'you confiscated ~g~$%s~s~ (%s) from ~b~%s~s~',
  ['got_confiscated_account'] = '~g~$%s~s~ (%s) was confiscated by ~y~%s~s~',
  ['you_confiscated_weapon'] = 'you confiscated ~b~%s~s~ from ~b~%s~s~ with ~o~%s~s~ bullets',
  ['got_confiscated_weapon'] = 'your ~b~%s~s~ with ~o~%s~s~ bullets was confiscated by ~y~%s~s~',
  ['traffic_offense'] = 'Wykroczenia drogowe',
  ['minor_offense'] = 'Niewielkie wykroczenia',
  ['average_offense'] = 'Średnie wykroczenia',
  ['major_offense'] = 'Duże wykroczenia',
  ['fine_total'] = 'mandat: %s',
  -- Vehicle Info Menu
  ['plate'] = 'tablica rejestracyjna: %s',
  ['owner_unknown'] = 'właściciel: Nieznany',
  ['owner'] = 'właściciel: %s',
  -- Weapons Menus
  ['get_weapon_menu'] = 'Zbrojownia - Weź broń',
  ['put_weapon_menu'] = 'Zbrojownia - Odłóż broń',
  ['buy_weapon_menu'] = 'Zbrojownia - Kup broń',
  ['not_enough_money'] = 'Nie masz wystarczającej ilości pieniędzy',
  -- Boss Menu
  ['take_company_money'] = 'Wypłać firmowe pieniądze',
  ['deposit_money'] = 'Zdeponuj pieniądze',
  ['amount_of_withdrawal'] = 'Wartość wypłaty',
  ['invalid_amount'] = 'Nieprawidłowa wartość',
  ['amount_of_deposit'] = 'Wartość depozytu',
  ['open_bossmenu'] = 'Naciśnij ~INPUT_CONTEXT~ aby otworzyć menu',
  ['quantity_invalid'] = 'Nieprawidłowa ilość',
  ['have_withdrawn'] = 'Wypłaciłeś x',
  ['not_enough_in_society'] = 'Niewystarczająca ilość przedmiotu w społeczeństwie!',
  ['player_cannot_hold'] = '~r~Nie masz~w~ wystarczająco ~y~wolnego miejsca~w~ w ekwipunku!',
  ['added'] = 'Dodałeś x',
  ['quantity'] = 'Ilość',
  ['inventory'] = 'Ekwipunek',
  ['police_stock'] = 'Zapasy policji',
  -- Misc
  ['remove_prop'] = 'Naciśnij ~INPUT_CONTEXT~ aby usunąć ten obiekt',
  ['map_blip'] = 'Komisariat Policji',
  ['unrestrained_timer'] = 'you feel your handcuffs slowly losing grip and fading away.',
  -- Notifications
  ['alert_police'] = 'Ostrzeż policję',
}
