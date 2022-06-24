-- ## 3dme : shared config file

Config = {
    language = 'en',
    visual = {
        color = { r = 255, g = 255, b = 255, a = 230 }, -- Text color
        font = 4, -- Text font
        time = 5000, -- Duration to display the text (in ms)
        scale = 0.5, -- Text scale
        dist = 10, -- Min. distance to draw 
    },
}

Languages = {
    ['en'] = {
        commandName = 'me',
        commandDescription = 'Display an action above your head.',
        commandSuggestion = {{ name = 'action', help = '"scratch his nose" for example.'}},
        prefix = ''
    },
    ['fr'] = {
        commandName = 'me',
        commandDescription = 'Affiche une action au dessus de votre tête.',
        commandSuggestion = {{ name = 'action', help = '"se gratte le nez" par exemple.'}},
        prefix = 'l\'individu '
    },
}
