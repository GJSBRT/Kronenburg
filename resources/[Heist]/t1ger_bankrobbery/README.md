# T1GER BANK ROBBERY

### Contact
Author: T1GER#9080
Discord: https://discord.gg/FdHkq5q

### Requirements
- meta_libs v1.3+ [https://github.com/meta-hub/meta_libs/releases]
- fivem-drilling [https://github.com/t1ger-scripts/T1GER_Github/tree/master/fivem-drilling]
- **OPTIONAL** | mhacking [https://github.com/GHMatti/FiveM-Scripts/tree/master/mhacking]
- **OPTIONAL** | utk:fingerprint [https://github.com/utkuali/Finger-Print-Hacking-Game]

### Installation
1) Drag & drop the t1ger_bankrobbery into your `resources` server folder.
2) Configure the config file to your liking.
3) Import the SQL file into your database.
4) Install the required requirements and add to server config.
5) Add `start t1ger_bankrobbery` to your server config.
6) Make sure to read through the README!!!!

### Showcase
- https://youtu.be/nQz8y5OQyPM

### Protection
Do not touch or delete **protection_cl.lua** and **protection_sv.lua**. This is security. Upon deleting/corruption these, script will not work.

### MiniGames
As default I include mhacking and utk:fingerprint minigames. In config, if those are set to true, makes sure you have those minigames installed. 
If the config options are set to false, that means nothing happens and then you HAVE to add your own minigame.
You can always swap out the minigames and use something else, if u have any other minigames, just make sure to point back to the correct callback in client.lua.
Follow the optional links above to install the minigames.

### Police Count
Police Count is fetched every 30 seconds (optimized solution), so if you've set minimum cops to e.g. 3, restart the script, you'd notice it says BANK IN LOCKDOWN,
even though there is 3 cops online. All you have to do is wait 30 seconds and then you'd be able to continue. 
