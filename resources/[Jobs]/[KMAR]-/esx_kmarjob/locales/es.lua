﻿--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
Locales['es'] = {
  -- Cloakroom
  ['cloakroom'] = 'Taquilla',
  ['citizen_wear'] = 'Ropa civil',
  ['police_wear'] = 'Ropa CNP',
  ['sheriff_wear'] = 'Ropa Oficial',
  ['lieutenant_wear'] = 'Ropa Teniente',
  ['gilet_wear'] = 'orange reflective jacket',
  ['bullet_wear'] = 'bulletproof vest',
  ['no_outfit'] = 'there\'s no uniform that fits you!',
  ['open_cloackroom'] = 'Presionar ~INPUT_CONTEXT~ para abrir la taquilla',
  -- Armory
  ['remove_object'] = 'take object',
  ['deposit_object'] = 'deposit object',
  ['get_weapon'] = 'Coger arma',
  ['put_weapon'] = 'Depositar arma',
  ['buy_weapons'] = 'Comprar armas',
  ['armory'] = 'Arsenal',
  ['open_armory'] = 'Presionarr ~INPUT_CONTEXT~ para acceder a la armeria',
  -- Vehicles
  ['vehicle_menu'] = 'Vehículo',
  ['vehicle_out'] = 'Ya tienes un vehículo fuera',
  ['vehicle_spawner'] = 'Presionar ~INPUT_CONTEXT~ para sacar un vehículo',
  ['store_vehicle'] = 'Presionar ~INPUT_CONTEXT~ para guardar un vehículo',
  ['service_max'] = 'Servicio completado: %s/%s',
  -- Action Menu
  ['citizen_interaction'] = 'Interacción ciudadana',
  ['vehicle_interaction'] = 'Interacción vehículo',
  ['object_spawner'] = 'Colocar objetos',

  ['id_card'] = 'Documento de identidad',
  ['search'] = 'Buscar',
  ['handcuff'] = 'Poner/quitar Esposas',
  ['drag'] = 'escoltar',
  ['put_in_vehicle'] = 'Meter en el vehículo',
  ['out_the_vehicle'] = 'Sacar del vehículo',
  ['fine'] = 'Multa',
  ['license_check'] = 'manage license',
  ['license_revoke'] = 'revoke license',
  ['license_revoked'] = 'your ~b~%s~s~ has been ~y~revoked~s~!',
  ['licence_you_revoked'] = 'you revoked a ~b~%s~s~ which belonged to ~y~%s~s~',
  ['no_players_nearby'] = 'No hay jugadores cerca',
  -- Vehicle interaction
  ['vehicle_info'] = 'Información del vehículo',
  ['pick_lock'] = 'Forzar coche',
  ['vehicle_unlocked'] = 'Vehículo desbloqueado~s~',
  ['no_vehicles_nearby'] = 'No hay vehículos cerca',
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
  ['traffic_interaction'] = 'Rutas de interacción',
  ['cone'] = 'Cono',
  ['barrier'] = 'Barrera',
  ['spikestrips'] = 'Grada',
  ['box'] = 'Caja',
  ['cash'] = 'Dinero',
  -- ID Card Menu
  ['name'] = 'nombre: %s',
  ['bac'] = 'alcoolemia: %s',
  -- Body Search Menu
  ['guns_label'] = '--- Armas ---',
  ['inventory_label'] = '--- Inventario ---',
  ['confiscate'] = 'confiscar %s',
  ['confiscate_inv'] = 'confiscar %sx %s',
  ['confiscate_dirty'] = 'confiscar dinero negro: <span style="color:red;">€%s</span>',
  ['you_confiscated'] = 'you confiscated ~y~%sx~s~ ~b~%s~s~ from ~b~%s~s~',
  ['got_confiscated'] = '~y~%sx~s~ ~b~%s~s~ were confiscated by ~y~%s~s~',
  ['you_confiscated_account'] = 'you confiscated ~g~€%s~s~ (%s) from ~b~%s~s~',
  ['got_confiscated_account'] = '~g~€%s~s~ (%s) was confiscated by ~y~%s~s~',
  ['you_confiscated_weapon'] = 'you confiscated ~b~%s~s~ from ~b~%s~s~ with ~o~%s~s~ bullets',
  ['got_confiscated_weapon'] = 'your ~b~%s~s~ with ~o~%s~s~ bullets was confiscated by ~y~%s~s~',
  ['traffic_offense'] = 'Delito de tráfico',
  ['minor_offense'] = 'Delito menor',
  ['average_offense'] = 'Delito medio',
  ['major_offense'] = 'Delito grave',
  ['fine_total'] = 'Multa total: %s',
  -- Vehicle Info Menu
  ['plate'] = 'n°: %s',
  ['owner_unknown'] = 'propietario: Desconocido',
  ['owner'] = 'propietario: %s',
  -- Weapons Menus
  ['get_weapon_menu'] = 'Arsenal - Coger armas',
  ['put_weapon_menu'] = 'Arsenal - Depositar armas',
  ['buy_weapon_menu'] = 'Arsenal - Comprar armas',
  ['not_enough_money'] = 'No tienes suficiente dinero',
  -- Boss Menu
  ['take_company_money'] = 'Retirar dinero de la empresa',
  ['deposit_money'] = 'Depositar dinero en la empresa',
  ['amount_of_withdrawal'] = 'Cantidad a retirar',
  ['invalid_amount'] = 'Cantidad inválida',
  ['amount_of_deposit'] = 'Cantidad a depositar',
  ['open_bossmenu'] = 'Presionar ~INPUT_CONTEXT~ para abrir el menú',
  ['quantity_invalid'] = 'Cantidad invalida',
  ['have_withdrawn'] = 'Has retirado x',
  ['added'] = 'Has metido x',
  ['quantity'] = 'Cantidad',
  ['inventory'] = 'inventario',
  ['police_stock'] = 'Almacen Policial',
  -- Misc
  ['remove_prop'] = 'Presionar ~INPUT_CONTEXT~ para eliminar el objeto',
  ['map_blip'] = 'Comisaría de policía',
  ['unrestrained_timer'] = 'you feel your handcuffs slowly losing grip and fading away.',
  -- Notifications
  ['alert_police'] = 'Alerta policia',
}
