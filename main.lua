-----------------------------------------------------------------------------------------
--
-- 7-10
--
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
--
-- main.lua
--
-- Created By Faiyaz Hossain
-- Created On    May 2018
--
-----------------------------------------------------------------------------------------



display.setStatusBar(display.HiddenStatusBar)
 
centerX = display.contentWidth * .5
centerY = display.contentHeight * .5

local physics = require( "physics" )
physics.start()
physics.setGravity( 0, 25 ) 
--physics.setDrawMode( "hybrid" )

local playerBullets = {} -- Table that holds the players Bullets

local theGround1 = display.newImage( "./assets/sprites/land.png" )
theGround1.x = 520
theGround1.y = display.contentHeight
theGround1.id = "the ground"
physics.addBody( theGround1, "static", { 
    friction = 0.5, 
    bounce = 0.3 
    } )


local theGround2 = display.newImage( "./assets/sprites/land.png" )
theGround2.x = 1520
theGround2.y = display.contentHeight
theGround2.id = "the ground" -- notice I called this the same thing
physics.addBody( theGround2, "static", { 
    friction = 0.5, 
    bounce = 0.3 
    } )



local dPad = display.newImage( "./assets/sprites/d-pad.png" )
dPad.x = 150
dPad.y = display.contentHeight - 200
dPad.alpha = 0.50
dPad.id = "d-pad"


local rightArrow = display.newImage( "./assets/sprites/rightArrow.png" )
rightArrow.x = 260
rightArrow.y = display.contentHeight - 200
rightArrow.id = "right arrow"

local leftArrow = display.newImage( "./assets/sprites/leftArrow.png" )
leftArrow.x = 40
leftArrow.y = display.contentHeight - 200
leftArrow.id = "left arrow"


local sheetOptionsIdle =
{
    width = 232,
    height = 439,
    numFrames = 10 
}
local sheetIdleKnight = graphics.newImageSheet( "./assets/spritesheets/knightIdle.png", sheetOptionsIdle )

local sheetOptionsWalk =
{
    width = 363,
    height = 458,
    numFrames = 10
}

local sheetWalkingKnight = graphics.newImageSheet( "./assets/spritesheets/knightWalking.png", sheetOptionsWalk )


-- sequences table
local sequence_data = {
    -- consecutive frames sequence
    {
        name = "idle",
        start = 1,
        count = 10,
        time = 800,
        loopCount = 0,
        sheet = sheetIdleKnight
    },
    {
        name = "walk",
        start = 1,
        count = 10,
        time = 1000,
        loopCount = 1,
        sheet = sheetWalkingKnight
    }
}

local knight = display.newSprite( sheetIdleKnight, sequence_data )
knight.x = centerX
knight.y = centerY
knight:setSequence( "idle" )
knight:play()
physics.addBody( knight, "dynamic", { 
    density = 3.0, 
    friction = 0.5, 
    bounce = 0.3 
    } )


knight.isFixedRotation = true

function rightArrow:touch( event )
    if ( event.phase == "ended" ) then
        -- move the character right
        knight:setLinearVelocity( 400, 0 )
    knight:setSequence( "walk" )
        knight:play()
        knight.xScale = 1
    end

    return true
end

 function leftArrow:touch( event )
    if ( event.phase == "ended" ) then
        -- move the character left
        knight:setLinearVelocity( -400, 0 )
    knight:setSequence( "walk" )
        knight:play()
        knight.xScale = -1
    end

    return true
end




local function resetToIdle (event)
    if event.phase == "ended" then
        knight:setSequence("idle")
        knight:play()
    end
end


rightArrow:addEventListener( "touch", rightArrow )
knight:addEventListener("sprite", resetToIdle)
leftArrow:addEventListener( "touch", leftArrow )