Background = {red = 0, green = 0, blue = 0, alpha = 0}
Background.__index = Background

-- Constructor
function Background:new (red, green, blue, alpha)
    local bg = {}
    setmetatable(bg, Background)
    bg.red = red
    bg.green = green
    bg.blue = blue
    bg.alpha = alpha

    local options =
    {
        width = display.pixelWidth >= 2780 and 2780 or display.pixelWidth,
        height = display.pixelHeight >= 2085 and 2085 or display.pixelHeight,
        numFrames = 1
    }
    local imageSheet = graphics.newImageSheet( "img-background.jpg", options )
 
    bg.rectangle = display.newImageRect( imageSheet, 1, display.actualContentWidth, display.actualContentHeight )

    -- LAYOUT TEMPLATE
    -- bg.rectangle = display.newImageRect(
    --     "img-layout.png",
    --     display.actualContentWidth,
    --     display.actualContentHeight
    -- )

    bg.rectangle.x = display.contentCenterX
    bg.rectangle.y = display.contentCenterY

    return bg
end

return Background