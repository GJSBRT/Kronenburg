# 22/07/2020
Added command to add door entries in-game.
Update to new credentials system.

# 27/07/2020
Fix for job list not retrieving correctly. Must add to es_extended functions.lua. Check notes below.
Added authorized items options to the door creation menu.
Added "reposition" option to doors creation menu. Use on big roller doors that don't position themselves correctly.

NOTE: As of 27/07/2020, you must add this command to ESX to retrieve the list of jobs properly.
Add to: es_extended/server/functions.lua:

  ESX.GetJobs = function()
    return ESX.Jobs
  end

# 24/08/2020
Added support for allhousing.
Added doors:remove command.
Updated SQL file for doors:remove command. Must include:
  `index` int(11) NOT NULL AUTO_INCREMENT

# 25/08/2020
Fix patch notes for last update.

# 28/08/2020
Fix bounding box poly matrix displaying incorrect triangle.

# 29/08/2020
Fix for setting minigame options (can break in = true) during creation ruining allhousing creation process.

# 30/08/2020
Fix for kashacters ID not being checked correctly against house door owner.
Added auto-center for door text.

# 31/08/2020
Fix for kashacters ID not being checked correctly on the server side also.

# 14/09/2020 (v1.0.5)
Fix for minigame defaults not being set automatically, causing errors.
Fix for doors:remove command.

# 19/09/2020 (v1.0.5)
Change door selection method to raycasting instead of nearest object to assist with setting large garage doors.