resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Polo Drugs Cayo Perico'

version '1.1.0'

client_scripts {
    "NativeUI/Wrapper/Utility.lua",

    "NativeUI/UIElements/UIVisual.lua",
    "NativeUI/UIElements/UIResRectangle.lua",
    "NativeUI/UIElements/UIResText.lua",
    "NativeUI/UIElements/Sprite.lua",
}

client_scripts {
    "NativeUI/UIMenu/elements/Badge.lua",
    "NativeUI/UIMenu/elements/Colours.lua",
    "NativeUI/UIMenu/elements/ColoursPanel.lua",
	"NativeUI/UIMenu/elements/StringMeasurer.lua",
	"NativeUI/UIMenu/panels/UIMenuStatisticsPanel.lua",

    "NativeUI/UIMenu/items/UIMenuItem.lua",

    "NativeUI/UIMenu/UIMenu.lua",
    "NativeUI/UIMenu/MenuPool.lua",
}


client_scripts {
    "NativeUI/NativeUI.lua",
}

client_scripts {
  '@es_extended/locale.lua',
    'client/cl_vente.lua',
    'client/utils.lua',
    'client/npc.lua',
    'client/menu.lua'

}

server_scripts {
  '@es_extended/locale.lua',
    'server/sv_vente.lua'
}