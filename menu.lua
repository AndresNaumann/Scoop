
local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "widget" library
local widget = require "widget"
physics.start()
physics.setGravity(0, 50)

local playBtn
local spawnTime = 500
local ballTable = {}

local function onPlayBtnRelease()
	composer.removeScene("menu")
	composer.removeScene("game")
	composer.gotoScene( "game", "fade", 200 )
	timer.cancel(ballTimer)

	for i = #ballTable, 1, -1 do 
    	local thisBall = ballTable[i]

    	if (thisBall.y < display.contentHeight + 1000) then
    		display.remove(thisBall)
    		table.remove( ballTable, i)
    	end
    end
	return true
end

local function balls()
	local startX = math.random(100, display.contentWidth - 100)

	local ball = display.newImage("blueball.png")
	ball.width = 80
	ball.height = 80
	ball.x = startX
	ball.y = -100
	ball.type = "ball"
	physics.addBody(ball, "dynamic", {bounce=1})
	table.insert(ballTable, ball)

	ball.collision = function(self, event)
        if (event.phase == "began" and event.other.type == "bottom") then
            display.remove(self)
            ballTable[self] = nil
            table.remove(ballTable, 1)
        end
    end
    ball:addEventListener( "collision", ball)
end

function scene:create( event )
	local sceneGroup = self.view

	physics.start()

	local background = display.newImageRect( "menubackground.png", display.actualContentWidth, display.actualContentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX 
	background.y = 0 + display.screenOriginY

	playBtn = widget.newButton{
		defaultFile = "playbtn.png",
		width=250, height=150,
		onRelease = onPlayBtnRelease
	}

	playBtn.x = display.contentCenterX
	playBtn.y = display.contentCenterY
     
    --[[ local borderR = display.newImage("black.png")
    borderR.x = -10
    borderR.y = display.contentCenterY
    borderR.width = 20
    borderR.height = display.contentHeight + 500
    
    physics.addBody( borderR, "static", { density=3.0, friction=1.0, bounce=0.5 })
    
    local borderL = display.newImage("black.png")
    borderL.x = display.contentWidth + 10
    borderL.y = display.contentCenterY
    borderL.width = 20
    borderL.height = display.contentHeight + 500
    
    physics.addBody( borderL, "static", { density=3.0, friction=1.0, bounce=0.5 })
    --]]
    local borderBottom = display.newImage("black.png")
    borderBottom.x = display.contentCenterX
    borderBottom.y = display.contentHeight + 400
    borderBottom.width = display.contentWidth
    borderBottom.height = 20
    borderBottom.type = "bottom"
    
    physics.addBody( borderBottom, "static", { density=3.0, friction=1.0, bounce=0.5 })	

	sceneGroup:insert( background )
    --sceneGroup:insert( borderR )
    --sceneGroup:insert( borderL )
    sceneGroup:insert( borderBottom )
	sceneGroup:insert( playBtn )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		physics.start()
		ballTimer = timer.performWithDelay(spawnTime, balls, 0)
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
		ball:removeEventListener("collision",ball)
		timer.cancel(ballTimer)
		physics.pause()


	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	
	if playBtn then
		playBtn:removeSelf()	-- widgets must be manually removed
		playBtn = nil
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