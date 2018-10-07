-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
score = 0
attack = 0
defense = 0
spawnTimeBlue = 5000

numBlue = 0
numGreen = 0
numYellow = 0
numOrange = 0
numRed = 0
numPurple = 0

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- include the Corona "composer" module
local composer = require "composer"

-- load menu screen
composer.gotoScene( "menu" )