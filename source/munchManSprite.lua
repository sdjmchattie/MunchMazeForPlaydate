import 'CoreLibs/object'
import 'CoreLibs/sprites'

import "animatedSprite"

local gfx <const> = playdate.graphics
local function emptyFunc()end

class("MunchManSprite").extends(AnimatedSprite)

function MunchManSprite.new(animate)
    return MunchManSprite(animate)
end

function MunchManSprite:init(animate)
    local imageTable = gfx.imagetable.new("images/munchMan")
    local states = {
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

            onFrameChangedEvent = emptyFunc,
            onStateChangedEvent = emptyFunc,
            onLoopFinishedEvent = emptyFunc,
            onAnimationEndEvent = emptyFunc
        }
    }

    MunchManSprite.super.init(self, imageTable, states, animate)
end
