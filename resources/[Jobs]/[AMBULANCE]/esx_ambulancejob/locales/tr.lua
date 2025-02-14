﻿--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
Locales['tr'] = {
	-- Cloakroom
	['cloakroom'] = 'soyunma Odası',
	['ems_clothes_civil'] = 'sivil Kıyafetler',
	['ems_clothes_ems'] = 'acil Servis Kıyafetleri',
	-- Vehicles
	['ambulance'] = 'medikal',
	['helicopter_prompt'] = '~y~Helikopter~s~ için ~INPUT_CONTEXT~ tuşuna basın.',
	['garage_prompt'] = '~y~Araba Garajı~s~ için ~INPUT_CONTEXT~ tuşuna basın',
	['garage_title'] = 'araba Garajı',
	['garage_stored'] = 'garaja koyuldu',
	['garage_notstored'] = 'garajda değil',
	['garage_storing'] = 'arabayı çıkarmaya çalışıyoruz, etrafta oyuncu olmadığından emin olun.',
	['garage_has_stored'] = 'araba garaja koyuldu',
	['garage_has_notstored'] = 'yakında sahibi olunan araba yok',
	['garage_notavailable'] = 'araba garajda değil',
	['garage_blocked'] = 'kullanılabilir spawn noktası yok!',
	['garage_empty'] = 'garajda araba yok',
	['garage_released'] = 'arabanız garajdan çıkarıldı.',
	['garage_store_nearby'] = 'yakınlarda araba yok',
	['garage_storeditem'] = 'garajdaki arabalar',
	['garage_storeitem'] = 'arabayı garaja koy',
	['garage_buyitem'] = 'araba galerisi',
	['shop_item'] = '%s TL',
	['vehicleshop_title'] = 'araba Galerisi',
	['vehicleshop_confirm'] = 'bu arabayı almak istiyor musun?',
	['vehicleshop_bought'] = '~g~%s~s~ liraya ~y~%s~s~ alındı',
	['vehicleshop_money'] = 'bu araca paranız yetmiyor',
	['vehicleshop_awaiting_model'] = 'bu araba şuanda ~g~İNDİRME & YÜKLEME~s~ yapıyor',
	['confirm_no'] = 'hayır',
	['confirm_yes'] = 'evet',
	-- Action Menu
	['revive_inprogress'] = 'Canlanma sürüyor!',
	['revive_complete'] = '~y~%s~s~ canlandırıldı',
	['revive_complete_award'] = '~y~%s~s~ canlandırıldın ve ~g~$%s~s~ kazandın!',
	['revive_fail_offline'] = 'bu oyuncu artık online değil',
	['heal_inprogress'] = 'iyileştiriliyorsun!',
	['heal_complete'] = '~y~%s~s~ iyileştirildi',
	['no_players'] = 'yakınlarda oyuncu yok',
	['player_not_unconscious'] = 'bu oyuncunun bilinci yerinde!',
	['player_not_conscious'] = 'bu oyuncunun bilinci yerinde değil!',
	-- Boss Menu
	['boss_actions'] = 'baş Hekim',
	-- Misc
	['invalid_amount'] = '~r~Hatalı miktar',
	['actions_prompt'] = '~y~Kıyafet Değiştirmek~s~ için ~INPUT_CONTEXT~ tuşuna basın.',
	['deposit_amount'] = 'bırakılacak miktar',
	['money_withdraw'] = 'alınacak miktar',
	['fast_travel'] = '~INPUT_CONTEXT~ tuşuna basarak hızlı yolculuk edebilirsiniz.',
	['open_pharmacy'] = '~y~Eczane~s~ için ~INPUT_CONTEXT~ tuşuna basın.',
	['pharmacy_menu_title'] = 'eczane',
	['pharmacy_take'] = 'al <span style="color:blue;">%s</span>',
	['medikit'] = 'sağlık kiti',
	['bandage'] = 'bandaj',
	['max_item'] = 'zaten yeterince üzerinde var',
	-- F6 Menu
	['ems_menu'] = 'EMS Menu',
	['ems_menu_title'] = 'medikal - EMS Menu',
	['ems_menu_revive'] = 'oyuncuyu Canlandır',
	['ems_menu_putincar'] = 'araca koy',
	['ems_menu_small'] = 'küçük yaraları tedavi et',
	['ems_menu_big'] = 'ciddi yaraları tedavi et',
	-- Phone
	['alert_ambulance'] = 'hastane Acil Durum',
	-- Death
	['respawn_available_in'] = 'yeniden canlanmana ~b~%s dakika %s saniye~s~ kaldı',
	['respawn_bleedout_in'] = 'kanama ~b~%s dakika %s saniye~s~ boyunca devam edecek\n',
	['respawn_bleedout_prompt'] = 'yeniden canlanma için [~b~E~s~] basılı tut',
	['respawn_bleedout_fine'] = '~g~%s~s~ lira karşılığında canlanma için [~b~E~s~] basılı tut',
	['respawn_bleedout_fine_msg'] = 'yeniden doğmak için ~r~$%s~s~ ödediniz.',
	['distress_send'] = 'acile sinyal göndermek için [~b~G~s~] basın',
	['distress_sent'] = 'acil durum sinyali gönderildi!',
	['combatlog_message'] = 'daha önce öldüğünüzde sunucudan ayrıldığınız için zorunlu olarak yeniden doğdunuz.',
	-- Revive
	['revive_help'] = 'oyuncuyu canlandır',
	-- Item
	['used_medikit'] = '~y~1x~s~ sağlık kiti kullanıldı.',
	['used_bandage'] = '~y~1x~s~ bandaj kullanıldı.',
	['not_enough_medikit'] = '~b~sağlık kiti~s~ yok.',
	['not_enough_bandage'] = '~b~bandaj~s~. yok',
	['healed'] = 'tedavi görüldü.',
	-- Blips
	['blip_hospital'] = 'hastane',
	['blip_dead'] = 'bilinci kapalı oyuncu',
  }
