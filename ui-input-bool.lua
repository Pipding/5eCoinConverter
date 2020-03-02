local widget = require( "widget" )

BoolInput = { label = "", width = 0, height = 0, x = 0, y = 0, value = false, checkbox = {} }
BoolInput.__index = BoolInput

-- Constructor
function BoolInput:new (label, width, height, x, y)
    local blinpt = {}
    setmetatable(blinpt, BoolInput)
    blinpt.label = label
    blinpt.width = width
    blinpt.height = height
    blinpt.x = x
    blinpt.y = y

    blinpt.label = display.newImageRect( label, width, height )
    blinpt.label.x = x
    blinpt.label.y = y

    blinpt.container = display.newRect(
        x,
        y + 30,
        display.actualContentWidth/3,
        display.actualContentHeight/8
    )
    blinpt.container:setFillColor( 0, 0, 0, 0 )
    blinpt.container:setStrokeColor(0)
    blinpt.container.strokeWidth = 0

    -- Checkbox
    local function onSwitchPress( event )
        blinpt.value = event.target.isOn
    end

    local options = {
        width = 256,
        height = 256,
        numFrames = 2
    }
    local checkboxSheet = graphics.newImageSheet( "img-checkbox.png", options )


    blinpt.checkbox = widget.newSwitch(
        {
            x = blinpt.container.x,
            y = blinpt.container.y + 10,
            style = "checkbox",
            id = "Checkbox",
            onPress = onSwitchPress,
            sheet = checkboxSheet,
            frameOff = 1,
            frameOn = 2
        }
    )
    
    return blinpt
end

return BoolInput