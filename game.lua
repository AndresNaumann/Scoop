local composer = require( "composer" )
local scene = composer.newScene()
local widget = require "widget"

local physics = require "physics"
physics.start()
physics.setGravity(0, 50)

local screenW, screenH, halfW = display.actualContentWidth, display.actualContentHeight, display.contentCenterX

local startX = math.random(100, display.contentWidth - 100)
local menuBtn
local upgradeBtn
local background
local borderR
local borderL
local borderBottom
local blue
score = 0
local blueTable = {}

attack = 0
defense = 0
spawnTimeBlue = 5000


----------------------------------------------------------------------------------------------------

local function onMenuBtnRelease()
	composer.removeScene("game")
	composer.removeScene("menu")
	composer.gotoScene("menu", "fade", 200)
	timer.cancel(ballTimer)
	return true
end

local function upgradeBtnRelease()
	composer.removeScene("game")
	composer.removeScene("upgrade")
	composer.gotoScene("upgrade", "fade", 200)
	timer.cancel(ballTimer)
	return true
end

local function blueBalls()
	local blue = display.newImage("blueball.png")
	blue.x = math.random(100, 900)
	blue.y = -100
	blue.width = 40
	blue.height = 40
	physics.addBody(blue, "dynamic", { bounce = 0.5, friction = 0.2, radius = 20})
	score = score + 1
	scoreText.text = score
	table.insert(blueTable, 1)
end

local function if10Blue()
	local tenBalls = blueTable[10]
	if score == 10 then
		display.remove(tenBalls)
		table.remove(blueTable, 10)
	end
end

if10Blue()

----------------------------------------------------------------------------------------------------
    
function scene:create( event )

	local sceneGroup = self.view

	physics.start()
	physics.pause()

	menuBtn = widget.newButton {
		defaultFile = ("menubtn.png"),
		height = 150, width = 250,
		onRelease = onMenuBtnRelease
	}

	menuBtn.x = display.contentWidth - 150
	menuBtn.y = 100

	upgradeBtn = widget.newButton {
		defaultFile = ("upgradebtn.png"),
		height = 99, width = 400,
		onRelease = upgradeBtnRelease
	}

	upgradeBtn.x = 220
	upgradeBtn.y = 103

----------------------------------------------------------------------------------------------------

	background = display.newImage("gamebackground.png")
	background.x = display.contentCenterX
	background.y = display.contentCenterY
	background.width = display.contentWidth
	background.height = display.contentHeight
    
    borderR = display.newImage("black.png")
    borderR.x = -10
    borderR.y = display.contentCenterY
    borderR.width = 20
    borderR.height = display.contentHeight + 500
    
    borderL = display.newImage("black.png")
    borderL.x = display.contentWidth + 10
    borderL.y = display.contentCenterY
    borderL.width = 20
    borderL.height = display.contentHeight + 500
    
    borderBottom = display.newImage("black.png")
    borderBottom.x = display.contentCenterX
    borderBottom.y = display.contentHeight + 10
    borderBottom.width = display.contentWidth
    borderBottom.height = 20

    scoreText = display.newText(score, display.contentCenterX, 300, "Aspergit", 80)

----------------------------------------------------------------------------------------------------

    physics.addBody( borderR, "static", { density=3.0, friction=1.0})
    physics.addBody( borderL, "static", { density=3.0, friction=1.0})
    physics.addBody( borderBottom, "static", { density=3.0, friction=1.0})
	
----------------------------------------------------------------------------------------------------

	sceneGroup:insert( background )
    sceneGroup:insert( borderR )
    sceneGroup:insert( borderL )
    sceneGroup:insert( borderBottom )
    sceneGroup:insert( menuBtn )
    sceneGroup:insert( upgradeBtn )
    sceneGroup:insert( scoreText )
end

----------------------------------------------------------------------------------------------------

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		physics.start()
		ballTimer = timer.performWithDelay(spawnTimeBlue, blueBalls, 0)
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		physics.stop()
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
	
end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view

	if menuBtn then
		menuBtn:removeSelf()
		menuBtn = nil
	end
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene