display.setStatusBar( display.HiddenStatusBar )
local StickLib   = require("lib_analog_stick")
local physics = require ("physics")
physics.start()

local screenW = display.contentWidth
local screenH = display.contentHeight
local Text        = display.newText( " ", screenW*.6, screenH-20, native.systemFont, 15 )
local posX = display.contentWidth/2
local posY = display.contentHeight/2
-- local hero
local localGroup = display.newGroup() -- remember this for farther down in the code
 motionx = 0; -- Variable used to move character along x axis
 motiony = 0; -- Variable used to move character along y axis
 speed = 2; -- Set Walking Speed 
 
-- CREATE ANALOG STICK
MyStick = StickLib.NewStick( 
        {
        x             = screenW*.15,
        y             = screenH*.85,
        thumbSize     = 16,
        borderSize    = 32, 
        snapBackSpeed = .2, 
        R             = 25,
        G             = 255,
        B             = 255
        } )
 -- MAIN LOOP
----------------------------------------------------------------
local function main( event )
        
        -- MOVE THE SHIP
        MyStick:move(hero, 1.0, false) -- se a opção for true o objeto se move com o joystick
 
        -- -- SHOW STICK INFO
        -- Text.text = "ANGLE = "..MyStick:getAngle().."   DIST = "..math.ceil(MyStick:getDistance()).."   PERCENT = "..math.ceil(MyStick:getPercent()*100).."%"
		
		print("MyStick:getAngle = "..MyStick:getAngle())
		print("MyStick:getDistance = "..MyStick:getDistance())
		-- print("MyStick:getPercent = "..MyStick:getPercent()*100)
		print("POSICAO X / Y  " ..hero.x,hero.y)
		
		angle = MyStick:getAngle() 
		moving = MyStick:getMoving()
	
		--Determine which animation to play based on the direction of the analog stick	
		-- 
		if(angle <= 45 or angle > 315) then
			seq = "forward"
		elseif(angle <= 135 and angle > 45) then
			seq = "right"
		elseif(angle <= 225 and angle > 135) then 
			seq = "back" 
		elseif(angle <= 315 and angle > 225) then 
			seq = "left" 
		end
		
		--Change the sequence only if another sequence isn't still playing 
		if(not (seq == hero.sequence) and moving) then -- and not attacking
			hero:setSequence(seq)
		end
		
		--If the analog stick is moving, animate the sprite
		if(moving) then 
			hero:play() 
		end
	
end
 timer.performWithDelay(2000, function()
 --MyStick:delete()
 end, 1)
Runtime:addEventListener( "enterFrame", main )
 
 --Declare and set up Sprite Image Sheet and sequence data
	spriteOptions = {	
		height = 64, 
		width = 64, 
		numFrames = 273, 
		sheetContentWidth = 832, 
		sheetContentHeight = 1344 
	}
	mySheet = graphics.newImageSheet("rectSmall.png", spriteOptions) 
	sequenceData = {
		{name = "forward", frames={105,106,107,108,109,110,111,112}, time = 500, loopCount = 1},
		{name = "right", frames={144,145,146,147,148,149,150,151,152}, time = 500, loopCount = 1}, 
		{name = "back", frames= {131,132,133,134,135,136,137,138,139}, time = 500, loopCount = 1}, 
		{name = "left", frames={118,119,120,121,122,123,124,125,126}, time = 500, loopCount = 1},
		{name = "attackForward", frames={157,158,159,160,161,162,157}, time = 400, loopCount = 1},
		{name = "attackRight", frames={196,197,198,199,200,201,196}, time = 400, loopCount = 1},
		{name = "attackBack", frames={183,184,185,186,187,188,183}, time = 400, loopCount = 1},
		{name = "attackLeft", frames={170,171,172,173,174,175,170}, time = 400, loopCount = 1},
		{name = "death", frames={261,262,263,264,265,266}, time = 500, loopCount = 1}
	}	
	
local bg = display.newImage("background.png")
bg.x = posX
bg.y = posY


-- Display the new sprite at the coordinates passed
hero = display.newSprite(mySheet, sequenceData)
hero:setSequence("forward")
hero.x = posX
hero.y = posY


localGroup:insert(bg)
localGroup:insert(hero)
