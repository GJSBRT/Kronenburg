﻿--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
Locales['br'] = {
  -- Cloackroom
  ['cloakroom'] = 'Vestiário',
  ['citizen_wear'] = 'Roupa casual',
  ['police_wear'] = 'Uniforme da Polícia',
  ['sheriff_wear'] = 'sheriff Outfit',
  ['lieutenant_wear'] = 'Swatt outfit ',
  ['gilet_wear'] = 'orange reflective jacket',
  ['bullet_wear'] = 'bulletproof vest',
  ['no_outfit'] = 'there\'s no uniform that fits you!',
  ['open_cloackroom'] = 'Pressione ~INPUT_CONTEXT~ para se trocar',
  -- Armory
  ['remove_object'] = 'take object',
  ['deposit_object'] = 'deposit object',
  ['get_weapon'] = 'Pegar arma',
  ['put_weapon'] = 'Entregar arma',
  ['buy_weapons'] = 'Comprar armas',
  ['armory'] = 'Arsenal',
  ['open_armory'] = 'Pressione ~INPUT_CONTEXT~ para acessar o arsenal',
  -- Vehicles
  ['vehicle_menu'] = 'Veículo',
  ['vehicle_out'] = 'Já existe um carro fora da garagem',
  ['vehicle_spawner'] = 'Pressione ~INPUT_CONTEXT~ para escolher um veículo',
  ['store_vehicle'] = 'Pressione ~INPUT_CONTEXT~ para guardar o veículo',
  ['service_max'] = 'maximo de oficiais em serviço: %s/%s',
  -- Action Menu
  ['citizen_interaction'] = 'Interagir com o cidadão',
  ['vehicle_interaction'] = 'Interagir com o veículo',
  ['object_spawner'] = 'Interagir com as rodovias',

  ['id_card'] = 'Carteira de identidade',
  ['search'] = 'Procurar',
  ['handcuff'] = 'Algemar / Soltar',
  ['drag'] = 'drag',
  ['put_in_vehicle'] = 'Colocar no veículo',
  ['out_the_vehicle'] = 'take out of vehicle',
  ['fine'] = 'Multa',
  ['license_check'] = 'manage license',
  ['license_revoke'] = 'revoke license',
  ['license_revoked'] = 'your ~b~%s~s~ has been ~y~revoked~s~!',
  ['licence_you_revoked'] = 'you revoked a ~b~%s~s~ which belonged to ~y~%s~s~',
  ['no_players_nearby'] = 'Nenhum jogador nas proximidades',
  -- Vehicle interaction
  ['vehicle_info'] = 'Informações',
  ['pick_lock'] = 'Trancar veículo',
  ['vehicle_unlocked'] = 'Veículo ~g~destravado~s~',
  ['no_vehicles_nearby'] = 'Nenhum veículo nas proximidades',
  ['impound'] = 'apreender carro',
  ['impound_prompt'] = 'Pressione ~INPUT_CONTEXT~ para cancelar a ~y~apreender~s~',
  ['impound_canceled'] = 'you canceled the impound',
  ['impound_canceled_moved'] = 'o apreender foi cancelado porque o veículo mudou',
  ['impound_successful'] = 'você apreendeu o veículo',
  ['search_database'] = 'informação do veículo',
  ['search_database_title'] = 'informações do veículo - pesquisa com número de registro',
  ['search_database_error_invalid'] = 'que ~r~não~s~ é um número de registro ~y~válido~s~',
  ['search_database_error_not_found'] = 'esse número de ~y~registror~s~ ~r~não~s~ está registrado em um veículo!',
  ['search_database_found'] = 'o veículo está ~y~registrado~s~ para ~b~%s~s~',
  -- Traffic interaction
  ['traffic_interaction'] = 'Interagir com as rodovias',
  ['cone'] = 'Cones',
  ['barrier'] = 'Barreira',
  ['spikestrips'] = 'Fita de pregos',
  ['box'] = 'Caixa',
  ['cash'] = 'Caixa de dinheiro',
  -- ID Card Menu
  ['name'] = 'Nome: %s',
  ['bac'] = 'BAC: %s',
  -- Body Search Menu
  ['guns_label'] = '--- Armas ---',
  ['inventory_label'] = '--- Inventário ---',
  ['confiscate'] = 'confiscar %s',
  ['confiscate_inv'] = 'Confiscar %sx %s',
  ['confiscate_dirty'] = 'Confiscar dinheiro sujo: <span style="color:red;">$%s</span>',
  ['you_confiscated'] = 'you confiscated ~y~%sx~s~ ~b~%s~s~ from ~b~%s~s~',
  ['got_confiscated'] = '~y~%sx~s~ ~b~%s~s~ were confiscated by ~y~%s~s~',
  ['you_confiscated_account'] = 'you confiscated ~g~$%s~s~ (%s) from ~b~%s~s~',
  ['got_confiscated_account'] = '~g~$%s~s~ (%s) was confiscated by ~y~%s~s~',
  ['you_confiscated_weapon'] = 'you confiscated ~b~%s~s~ from ~b~%s~s~ with ~o~%s~s~ bullets',
  ['got_confiscated_weapon'] = 'your ~b~%s~s~ with ~o~%s~s~ bullets was confiscated by ~y~%s~s~',
  ['traffic_offense'] = 'Infrações de transito',
  ['minor_offense'] = 'Infração leve',
  ['average_offense'] = 'Infração média',
  ['major_offense'] = 'Infração grave',
  ['fine_total'] = 'multa: %s',
  -- Vehicle Info Menu
  ['plate'] = 'placa: %s',
  ['owner_unknown'] = 'proprietário: Desconhecido',
  ['owner'] = 'proprietário: %s',
  -- Weapons Menus
  ['get_weapon_menu'] = 'Arsenal - Pegar arma',
  ['put_weapon_menu'] = 'Arsenal - Entregar arma',
  ['buy_weapon_menu'] = 'Arsenal - Comprar armas',
  ['not_enough_money'] = 'Você não tem dinheiro suficiente',
  -- Boss Menu
  ['take_company_money'] = 'Retirar o dinheiro da empresa',
  ['deposit_money'] = 'Depositar dinheiro',
  ['amount_of_withdrawal'] = 'Quantidade de retirada',
  ['invalid_amount'] = 'Quantidade inválida',
  ['amount_of_deposit'] = 'Quantidade de depósito',
  ['open_bossmenu'] = 'Pressione ~INPUT_CONTEXT~ para abrir o menu',
  -- Misc
  ['remove_prop'] = 'Pressione ~INPUT_CONTEXT~ para remover o objeto',
  ['map_blip'] = 'Departamento de Polícia',
  ['unrestrained_timer'] = 'you feel your handcuffs slowly losing grip and fading away.',
  -- Notifications
  ['alert_police'] = 'Alerta da Polícia',
}
