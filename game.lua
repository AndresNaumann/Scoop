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

attack = 0
defense = 0

----------------------------------------------------------------------------------------------------

local function onMenuBtnRelease()
	display.remove(blues)
	composer.removeScene("game")
	composer.removeScene("menu")
	composer.gotoScene("menu", "fade", 200)
	timer.cancel(ballTimer)
	return true
end

local function upgradeBtnRelease()
	display.remove(blues)
	composer.removeScene("game")
	composer.removeScene("upgrade")
	composer.gotoScene("upgrade", "fade", 200)
	timer.cancel(ballTimer)
	return true
end

blue = {}
bCounter = 1

local blues = display.newGroup()

local function blueBalls()
	blue[bCounter] = display.newImage("blueball.png")
	blue[bCounter].x = math.random(100, 900)
	blue[bCounter].y = -100
	blue[bCounter].width = 40
	blue[bCounter].height = 40
	physics.addBody(blue[bCounter], "dynamic", { bounce = 0.5, friction = 0.2, radius = 20})

	blue[bCounter].type = "blue"
	blues:insert(blue[bCounter])

	bCounter = bCounter + 1
	numBlue = numBlue + 1

	score = score + 1
	scoreText.text = score

	if bCounter == 11 then
		for i = 1, blues.numChildren do
			display.remove(blue[i])
		end
		bCounter = 1
		greenBalls()
	end
end

green = {}
gCounter = 1

local greens = display.newGroup()

function greenBalls()
	green[gCounter] = display.newImage("greenball.png")
	green[gCounter].x = math.random(100,900)
	green[gCounter].y = -100
	green[gCounter].width = 50
	green[gCounter].height = 50
	physics.addBody(green[gCounter], "dynamic", { bounce = 0.5, friction = 0.2, radius = 25})

	green[gCounter].type = "green"
	greens:insert(green[gCounter])

	gCounter = gCounter + 1
	numGreen = numGreen + 1

	if gCounter == 11 then
		for i = 1, greens.numChildren do
			display.remove(green[i])
		end
		gCounter = 1
		yellowBalls()
	end
end

yellow = {}
yCounter = 1

local yellows = display.newGroup()

function yellowBalls()
	yellow[yCounter] = display.newImage("yellowball.png")
	yellow[yCounter].x = math.random(100, 900)
	yellow[yCounter].y = -100
	yellow[yCounter].width = 60
	yellow[yCounter].height = 60
	physics.addBody(yellow[yCounter], "dynamic", {bounce = 0.5, friction = 0.2, radius = 30})

	yellow[yCounter].type = "yellow"
	yellows:insert(yellow[yCounter])

	yCounter = yCounter + 1
	numYellow = numYellow + 1

	if yCounter == 11 then
		for i = 1, yellows.numChildren do
			display.remove(yellow[i])
		end
		yCounter = 1
		orangeBalls()
	end
end

orange = {}
oCounter = 1

local oranges = display.newGroup()

function orangeBalls()
	orange[oCounter] = display.newImage("orangeball.png")
	orange[oCounter].x = math.random(100, 900)
	orange[oCounter].y = -100
	orange[oCounter].width = 70
	orange[oCounter].height = 70
	physics.addBody(orange[oCounter], "dynamic", {bounce = 0.5, friction = 0.2, radius = 35})

	orange[oCounter].type = "orange"
	oranges:insert(orange[oCounter])

	oCounter = oCounter + 1
	numOrange = numOrange + 1

	if oCounter == 11 then
		for i = 1, oranges.numChildren do
			display.remove(orange[i])
		end
		oCounter = 1
		redBalls()
	end
end

red = {}
rCounter = 1

local reds = display.newGroup()

function redBalls()
	red[rCounter] = display.newImage("redball.png")
	red[rCounter].x = math.random(100, 900)
	red[rCounter].y = -100
	red[rCounter].width = 75
	red[rCounter].height = 75
	physics.addBody(red[rCounter], "dynamic", {bounce = 0.5, friction = 0.2, radius = 35})

	red[rCounter].type = "red"
	reds:insert(red[rCounter])

	rCounter = rCounter + 1
	numRed = numRed + 1

	if rCounter == 11 then
		for i = 1, reds.numChildren do
			display.remove(red[i])
		end
		rCounter = 1
		purpleBalls()
	end
end

purple = {}
pCounter = 1

local purples = display.newGroup()

function purpleBalls()
	purple[pCounter] = display.newImage("purpleball.png")
	purple[pCounter].x = math.random(100, 900)
	purple[pCounter].y = -100
	purple[pCounter].width = 80
	purple[pCounter].height = 80
	physics.addBody(purple[pCounter], "dynamic", {bounce = 0.5, friction = 0.2, radius = 35})

	{bounce = 0.5, friction = 0.2, radius = 35}.type = "purple"
	purples:insert(purple[pCounter])

	pCounter = pCounter + 1
	numPurple = numPurple + 1

	if pCounter == 11 then
		for i = 1, purples.numChildren do
			display.remove(purple[i])
		end
		pCounter = 1
	end
end

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