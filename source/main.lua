-- Name this file `main.lua`. Your game can use multiple source files if you wish
-- (use the `import "myFilename"` command), but the simplest games can be written
-- with just `main.lua`.

import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "animatedSprite"

local pd <const> = playdate
local gfx <const> = pd.graphics

local playerSprite = nil

-- A function to set up our game environment.
function MyGameSetUp()
    local playerImageTable = gfx.imagetable.new("images/munchMan")
    local playerStates = {
        {
            name = "eatingLeft",
            firstFrameIndex = 1,
            framesCount = 5,
            animationStartingFrame = 1,
            tickStep = 2,
            frameStep = 1,
            reverse = false,
            loop = true,
            yoyo = true,
            flip = gfx.kImageUnflipped,
            xScale = 1,
            yScale = 1,
            nextAnimation = nil,

            onFrameChangedEvent = function()end,
            onStateChangedEvent = function()end,
            onLoopFinishedEvent = function()end,
            onAnimationEndEvent = function()end
        }
    }

    playerSprite = AnimatedSprite.new(playerImageTable, playerStates, true)
    playerSprite:moveTo( 200, 120 )

    -- We want an environment displayed behind our sprite.
    -- There are generally two ways to do this:
    -- 1) Use setBackgroundDrawingCallback() to draw a background image. (This is what we're doing below.)
    -- 2) Use a tilemap, assign it to a sprite with sprite:setTilemap(tilemap),
    --       and call :setZIndex() with some low number so the background stays behind
    --       your other sprites.

    -- local backgroundImage = gfx.image.new( "images/background" )
    -- assert( backgroundImage )

    -- gfx.sprite.setBackgroundDrawingCallback(
    --     function( x, y, width, height )
    --         -- x,y,width,height is the updated area in sprite-local coordinates
    --         -- The clip rect is already set to this area, so we don't need to set it ourselves
    --         backgroundImage:draw( 0, 0 )
    --     end
    -- )

end

-- Now we'll call the function above to configure our game.
-- After this runs (it just runs once), nearly everything will be
-- controlled by the OS calling `playdate.update()` 30 times a second.

MyGameSetUp()

-- `playdate.update()` is the heart of every Playdate game.
-- This function is called right before every frame is drawn onscreen.
-- Use this function to poll input, run game logic, and move sprites.

function pd.update()

    -- Poll the d-pad and move our player accordingly.
    -- (There are multiple ways to read the d-pad; this is the simplest.)
    -- Note that it is possible for more than one of these directions
    -- to be pressed at once, if the user is pressing diagonally.

    if pd.buttonIsPressed( pd.kButtonUp ) then
        playerSprite:moveBy( 0, -2 )
    end
    if pd.buttonIsPressed( pd.kButtonRight ) then
        playerSprite:moveBy( 2, 0 )
    end
    if pd.buttonIsPressed( pd.kButtonDown ) then
        playerSprite:moveBy( 0, 2 )
    end
    if pd.buttonIsPressed( pd.kButtonLeft ) then
        playerSprite:moveBy( -2, 0 )
    end

    -- Call the functions below in playdate.update() to draw sprites and keep
    -- timers updated. (We aren't using timers in this example, but in most
    -- average-complexity games, you will.)

    gfx.sprite.update()
    pd.timer.updateTimers()

end
