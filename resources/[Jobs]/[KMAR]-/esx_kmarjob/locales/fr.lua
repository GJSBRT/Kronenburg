﻿--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
Locales['fr'] = {
  -- Cloakroom
  ['cloakroom'] = 'vestiaire',
  ['citizen_wear'] = 'tenue Civil',
  ['police_wear'] = 'tenue Policier',
  ['sheriff_wear'] = 'tenue sheriff',
  ['lieutenant_wear'] = 'tenue Swatt',
  ['gilet_wear'] = 'gilet orange',
  ['bullet_wear'] = 'gilet pare-balles',
  ['no_outfit'] = 'il n\'y a pas d\'uniforme à votre taille...',
  ['open_cloackroom'] = 'appuyez sur ~INPUT_CONTEXT~ pour vous changer',
  -- Armory
  ['remove_object'] = 'prendre Objet',
  ['deposit_object'] = 'déposer objet',
  ['get_weapon'] = 'prendre Arme',
  ['put_weapon'] = 'déposer Arme',
  ['buy_weapons'] = 'acheter Armes',
  ['armory'] = 'armurerie',
  ['open_armory'] = 'appuyez sur ~INPUT_CONTEXT~ pour accéder à l\'armurerie',
  -- Vehicles
  ['vehicle_menu'] = 'véhicule',
  ['vehicle_out'] = 'il y a déja un véhicule de sorti',
  ['vehicle_spawner'] = 'appuyez sur ~INPUT_CONTEXT~ pour sortir un véhicule',
  ['store_vehicle'] = 'appuyez sur ~INPUT_CONTEXT~ pour ranger le véhicule',
  ['service_max'] = 'service complet: %s/%s',
  -- Action Menu
  ['citizen_interaction'] = 'interaction citoyen',
  ['vehicle_interaction'] = 'interaction véhicule',
  ['object_spawner'] = 'placer objets',

  ['id_card'] = 'carte d\'identité',
  ['search'] = 'fouiller',
  ['handcuff'] = 'menotter / Démenotter',
  ['drag'] = 'escorter',
  ['put_in_vehicle'] = 'mettre dans véhicule',
  ['out_the_vehicle'] = 'sortir du véhicule',
  ['fine'] = 'Amende',
  ['license_check'] = 'gérer les licences',
  ['license_revoke'] = 'révoquer la licence',
  ['license_revoked'] = 'votre ~b~%s~s~ a été ~y~révoqué~s~!',
  ['licence_you_revoked'] = 'vous avez révoqué un ~b~%s~s~ qui appartenait à ~y~%s~s~',
  ['no_players_nearby'] = 'aucun joueur à proximité',
  -- Vehicle interaction
  ['vehicle_info'] = 'infos véhicule',
  ['pick_lock'] = 'crocheter véhicule',
  ['vehicle_unlocked'] = 'véhicule ~g~déverouillé~s~',
  ['no_vehicles_nearby'] = 'aucun véhicule à proximité',
  ['impound'] = 'véhicule en fourrière',
  ['impound_prompt'] = 'appuyez sur ~INPUT_CONTEXT~ pour annuler la ~y~saisie du véhicule~s~',
  ['impound_canceled'] = 'vous avez annulé la saisie',
  ['impound_canceled_moved'] = 'la saisie a été annulée parce que le véhicule a déménagé',
  ['impound_successful'] = 'vous avez saisi le véhicule',
  ['search_database'] = 'vehicle information',
  ['search_database_title'] = 'informations sur le véhicule - recherche avec numéro d\'enregistrement',
  ['search_database_error_invalid'] = 'Ce n\'est ~r~pas~s~ un ~y~numéro d\'enregistrement valide~s~',
  ['search_database_error_not_found'] = 'ce ~y~numéro d\'enregistrement ~s~est~r~ pas ~s~ enregistré sur un véhicule!',
  ['search_database_found'] = 'le véhicule est ~y~enregistré~s~ à ~b~%s~s~',
  -- Traffic interaction
  ['traffic_interaction'] = 'interaction routière',
  ['cone'] = 'plot',
  ['barrier'] = 'barrière',
  ['spikestrips'] = 'herse',
  ['box'] = 'caisse',
  ['cash'] = 'caisse',
  -- ID Card Menu
  ['name'] = 'nom: %s',
  ['bac'] = 'alcoolémie: %s',
  -- Body Search Menu
  ['guns_label'] = '--- Armes ---',
  ['inventory_label'] = '--- Inventaire ---',
  ['confiscate'] = 'confisquer %s',
  ['confiscate_inv'] = 'confisquer %sx %s',
  ['confiscate_dirty'] = 'confisquer argent sale: <span style="color:red;">€%s</span>',
  ['you_confiscated'] = 'you confiscated ~y~%sx~s~ ~b~%s~s~ from ~b~%s~s~',
  ['got_confiscated'] = '~y~%sx~s~ ~b~%s~s~ were confiscated by ~y~%s~s~',
  ['you_confiscated_account'] = 'you confiscated ~g~€%s~s~ (%s) from ~b~%s~s~',
  ['got_confiscated_account'] = '~g~€%s~s~ (%s) was confiscated by ~y~%s~s~',
  ['you_confiscated_weapon'] = 'you confiscated ~b~%s~s~ from ~b~%s~s~ with ~o~%s~s~ bullets',
  ['got_confiscated_weapon'] = 'your ~b~%s~s~ with ~o~%s~s~ bullets was confiscated by ~y~%s~s~',
  ['traffic_offense'] = 'code de la route',
  ['minor_offense'] = 'délit mineur',
  ['average_offense'] = 'délit moyen',
  ['major_offense'] = 'délit grave',
  ['fine_total'] = 'amende: %s',
  -- Vehicle Info Menu
  ['plate'] = 'n°: %s',
  ['owner_unknown'] = 'propriétaire: Inconnu',
  ['owner'] = 'propriétaire: %s',
  -- Weapons Menus
  ['get_weapon_menu'] = 'armurerie - Prendre Arme',
  ['put_weapon_menu'] = 'armurerie - Déposer Arme',
  ['buy_weapon_menu'] = 'armurerie - Acheter Armes',
  ['not_enough_money'] = 'vous n\'avez pas assez d\'argent',
  -- Boss Menu
  ['take_company_money'] = 'retirer argent société',
  ['deposit_money'] = 'déposer argent',
  ['amount_of_withdrawal'] = 'montant du retrait',
  ['invalid_amount'] = 'montant invalide',
  ['amount_of_deposit'] = 'montant du dépôt',
  ['open_bossmenu'] = 'appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu',
  ['quantity_invalid'] = 'Quantité invalide',
  ['have_withdrawn'] = 'Vous avez retiré x',
  ['added'] = 'Vous avez ajouté x',
  ['quantity'] = 'Quantité',
  ['inventory'] = 'inventaire',
  ['police_stock'] = 'Police Stock',
  -- Misc
  ['remove_prop'] = 'appuyez sur ~INPUT_CONTEXT~ pour enlever l\'objet',
  ['map_blip'] = 'Commissariat',
  ['unrestrained_timer'] = 'you feel your handcuffs slowly losing grip and fading away.',
  -- Notifications
  ['alert_police'] = 'alerte police',
}
