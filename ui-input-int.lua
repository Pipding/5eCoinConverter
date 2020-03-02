IntInput = { label = "", width = 0, height = 0, x = 0, y = 0, value = 0, input = {} }
IntInput.__index = IntInput

-- Constructor
function IntInput:new (label, width, height, x, y, textColour, maxCharCount)
    local intinpt = {}
    setmetatable(intinpt, IntInput)
    intinpt.label = label
    intinpt.width = width
    intinpt.height = height
    intinpt.x = x
    intinpt.y = y

    intinpt.label = display.newImageRect( label, width, height )
    intinpt.label.x = x
    intinpt.label.y = y

    intinpt.background = display.newImageRect( "img-inputBox.png", 102, 25 )
    intinpt.background.x = 215
    intinpt.background.y = y

    -- Text box
    intinpt.input = native.newTextField(
        215,
        y - 1,
        98,
        20
    )
    intinpt.input.hasBackground = false
    intinpt.input.font = native.newFont( "font-ds-gabriele.ttf" )
    intinpt.input.inputType = "number"
    intinpt.input.align = "center"
    intinpt.input:setTextColor(textColour.r, textColour.g, textColour.b, textColour.a)

    intinpt.input:setReturnKey( "next" )
    intinpt.input:resizeFontToFitHeight()

    local function textListener( event )
        if(string.len(event.target.text) <= maxCharCount) then
            intinpt.value = tonumber(event.target.text)
        else
            intinpt.input.text = tostring(intinpt.value)
        end
    end

    intinpt.input:addEventListener( "userInput", textListener )
    
    return intinpt
end

return IntInput