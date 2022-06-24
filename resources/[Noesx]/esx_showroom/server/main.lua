ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_showroom:getCars', function(source, cb)
    MySQL.Async.fetchAll(
      "SELECT name, model FROM vehicles ORDER BY category = 'imports' DESC, price DESC",
	  { ['@wtf'] = '???' },
      function (results)
        local cars = {}

        for i=1, #results, 1 do
          table.insert(cars, {
            name = results[i].name,
            model = results[i].model,
          })
        end

        cb(cars)
      end
    )
end)
