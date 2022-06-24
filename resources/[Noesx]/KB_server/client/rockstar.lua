local ESX = nil

-- ESX
-- Added this so you can include the rest of the Usage-stuff found on the GitHub page
Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(7)
  end
end)

RegisterCommand("rockstareditor", function(source)
  Rockstarmenu()
end, false)

function Rockstarmenu()
  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'Opnemen',
    {
      title    = 'Opnemen',
      align    = 'top-right',
      elements = {
        { label = "Start opnemen", value = 'record' },
        { label = "Stop opnemen en Opslaan", value = 'stopsave' },
        { label = "Stop opnemen", value = 'stopdiscard' },
        { label = "Rockstar Editor openen", value = 'open' },
      }
    },
    function(data, menu)

      if data.current.value == 'record' then
        StartRecording(1)
      elseif data.current.value == 'stopsave' then
        StopRecordingAndSaveClip()
      elseif data.current.value == 'stopdiscard' then
        StopRecordingAndDiscardClip()
      elseif data.current.value == 'open' then
        Bendezeker()
      end


    end,
    function(data, menu)

    menu.close()

    CurrentAction     = 'Opnemen'
    CurrentActionMsg  = 'Opnemen'
    CurrentActionData = { station = station }

  end
  )
end

function Bendezeker()
  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'Opnemen',
    {
      title    = 'Weet je het zeker?',
      align    = 'top-right',
      elements = {
        { label = "Ja", value = 'ja' },
        { label = "Nee", value = 'nee' },
      }
    },
    function(data, menu)

      if data.current.value == 'ja' then
        NetworkSessionLeaveSinglePlayer()
        ActivateRockstarEditor()
      elseif data.current.value == 'nee' then
        Rockstarmenu()
      end


    end,
    function(data, menu)

    menu.close()

    CurrentAction     = 'Opnemen'
    CurrentActionMsg  = 'Opnemen'
    CurrentActionData = { station = station }

  end
  )
end
