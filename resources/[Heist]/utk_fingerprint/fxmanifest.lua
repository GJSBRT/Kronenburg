--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
fx_version "adamant"

game "gta5"

files {
    "movies/script.js",
    "movies/style.css",
    "movies/intro.gif",
    "movies/success.gif",
    "movies/fail.gif",
    "movies/blank.png",
    "movies/movie.html",
}

ui_page "movies/movie.html"

client_script "client.lua"

dependency "utk_hackdependency"