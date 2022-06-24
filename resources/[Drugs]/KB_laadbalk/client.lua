laadbalk = function(text, time)
    SendNUIMessage({
        action = 'open',
        label = text,
        time = time
    })
end

laadbalksluit = function()
    SendNUIMessage({
        action = 'close'
    })
end