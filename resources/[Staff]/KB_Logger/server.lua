function DiscordLog(webhook, titel, bericht, mention, source)
    local WebHook = webhook


    local discordInfo = {
        ["color"] = 16756480,
        ["title"] = titel,
        ["description"] = bericht,
        ["timestamp"] = os.date('%Y-%m-%d %H:%M'),
        ["footer"] = {
            ["text"] = "© Kronenburg Roleplay "
        }
    }

    if source then
        if mention then
            exports["KB_screenshot"]:requestCustomClientScreenshotUploadToDiscord(
                source,
                webhook,
                {
                    encoding = "png",
                    quality = 1
                },
                {
                    content = "@here!",
                    embeds = {
                        {
                            color = 16756480,
                            description = bericht,
                            title = titel,
                            timestamp = os.date('%Y-%m-%d %H:%M'),
                            footer = {
                                text = "© Kronenburg Roleplay"
                            }
                        }
                    }
                },
                30000,
                function(error)
                    if error then
                        return print("^1ERROR: " .. error)
                    end
                end
            )
        else
            exports["KB_screenshot"]:requestCustomClientScreenshotUploadToDiscord(
                source,
                webhook,
                {
                    encoding = "png",
                    quality = 1
                },
                {
                    embeds = {
                        {
                            color = 16756480,
                            description = bericht,
                            title = titel,
                            timestamp = os.date('%Y-%m-%d %H:%M'),
                            footer = {
                                text = "© Kronenburg Roleplay"
                            }
                        }
                    }
                },
                30000,
                function(error)
                    if error then
                        return print("^1ERROR: " .. error)
                    end
                end
            )
        end
    else
        if mention then
            PerformHttpRequest(WebHook, function(err, text, headers) end, 'POST', json.encode({ username = 'Kronenburg Roleplay', avatar_url = "https://cdn.discordapp.com/attachments/939313618036588614/939313650106253412/logo.png", content = "@here" }), { ['Content-Type'] = 'application/json' })
            PerformHttpRequest(WebHook, function(err, text, headers) end, 'POST', json.encode({ username = 'Kronenburg Roleplay', avatar_url = "https://cdn.discordapp.com/attachments/939313618036588614/939313650106253412/logo.png", embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
        else
            PerformHttpRequest(WebHook, function(err, text, headers) end, 'POST', json.encode({ username = 'Kronenburg Roleplay', avatar_url = "https://cdn.discordapp.com/attachments/939313618036588614/939313650106253412/logo.png", embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
        end
    end
end
