Translations = {}

function _(str, ...) -- Translate string
    if Translations[Config.TranslationSelected] ~= nil then
        if Translations[Config.TranslationSelected][str] ~= nil then
            return string.format(Translations[Config.TranslationSelected][str], ...)
        else
            return 'Translation [' .. Config.TranslationSelected .. '][' .. str .. '] does not exist'
        end
    else
        return 'Locale [' .. Config.TranslationSelected .. '] does not exist'
    end
end

function _U(str, ...) -- Translate string first char uppercase
    return tostring(_(str, ...):gsub('^%l', string.upper))
end

Translations['en'] = {
    ['limit_exceed'] = 'Je inzet is te laag of te hoog voor deze tafel.',
    ['invalid_bet'] = 'Ongeldig inzetbedrag.',
    ['chair_used'] = 'Deze stoel is al bezet.',
    ['can_not_bet_because_started'] = 'Het spel is begonnen, u kunt niet meer inzetten.',
    ['not_enough_chips'] = 'U heeft niet genoeg chips om in te zetten.',
    ['input_place_bet'] = 'Hoeveel chips wil je inzetten?',
    -- help msg
    ['help_sit_rulett'] = '~INPUT_CONTEXT~ Ga aan de roulettetafel zitten.',
    ['help_rulett_all'] = '~INPUT_CELLPHONE_CANCEL~ Opstaan\n~INPUT_CONTEXT~ Verander camera\n~INPUT_LOOK_LR~ Selecteer nummer\n~INPUT_ATTACK~ Inzetten nummer\n~INPUT_CELLPHONE_UP~ Verhoog inzet\n~INPUT_CELLPHONE_DOWN~ Verlaag inzet\n~INPUT_JUMP~ Willekeurige hoeveelheid',
    -- nui
    ['starting_soon'] = 'Het spel begint binnenkort..',
    ['game_going_on'] = 'Het spel is bezig..',
    ['seconds'] = 'seconden.',
    -- formatted msg
    ['won_chips'] = 'U won %s chips. Multiplier: x%s',
    ['placed_bet'] = 'U heeft %s chips ingezet.'
}

Translations['hu'] = {
    ['limit_exceed'] = 'Túl nagy vagy túl alacsony a téted.',
    ['invalid_bet'] = 'Érvénytelen tét érték.',
    ['chair_used'] = 'Ez a szék foglalt.',
    ['can_not_bet_because_started'] = 'Már elkezdődött a játszma, nem rakhatsz tétet.',
    ['not_enough_chips'] = 'Nincs elég chipsed hogy megtedd a tétet.',
    ['input_place_bet'] = 'Tét megadása',
    -- help msg
    ['help_sit_rulett'] = '~INPUT_CONTEXT~ Leülés a rulett asztalhoz.',
    ['help_rulett_all'] = '~INPUT_CELLPHONE_CANCEL~ Felállás\n~INPUT_CONTEXT~ Kameranézet váltás.\n~INPUT_LOOK_LR~ Szám kiválasztása\n~INPUT_ATTACK~ Szám megrakása\n~INPUT_CELLPHONE_UP~ Tét emelése\n~INPUT_CELLPHONE_DOWN~ Tét csökkentése\n~INPUT_JUMP~ Tét megadása',
    -- nui
    ['starting_soon'] = 'Játék hamarosan kezdődik..',
    ['game_going_on'] = 'Játék jelenleg folyamatban..',
    ['seconds'] = 'másodperc.',
    -- formatted msg
    ['won_chips'] = 'Nyertél %s chipset.\n(Szorzó x%s)',
    ['placed_bet'] = 'Tét megrakva %s chipssel.'
}
