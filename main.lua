local Background = require("ui-background")
local Title = require("ui-title")
local IntInput = require("ui-input-int")
local BoolInput = require("ui-input-bool")

require("util-converter")

local inputTextColour = { r = 0.79, g = 0.79, b = 0.79, a = 1 }
local outputFont = native.newFont( "font-sherwood.ttf" )

-- UI elements
local background = Background:new(1, 1, 1, 1)
local title = Title:new(300, 65, 160, 5)
local inputFrame = display.newImageRect( "img-inputBevel.png", 260, 255 )
inputFrame.x = 160
inputFrame.y = 188

-- Number inputs
local platInput = IntInput:new("img-platinum.png", 93, 17, 96, 86, inputTextColour, 9)
local goldInput = IntInput:new("img-gold.png", 55, 17, 116, 123, inputTextColour, 9)
local elecInput = IntInput:new("img-electrum.png", 95, 17, 95, 158, inputTextColour, 9)
local silvInput = IntInput:new("img-silver.png", 64, 17, 112, 194, inputTextColour, 9)
local coppInput = IntInput:new("img-copper.png", 73, 17, 106, 230, inputTextColour, 9)
local prtyInput = IntInput:new("img-partysize.png", 105, 17, 92, 289, inputTextColour, 5)

-- Boolean inputs
local forceEq = BoolInput:new("img-equalShares.png", 108, 34, 70, 351)
local onlyGSC = BoolInput:new("img-onlyGSC.png", 122, 34, 244, 351)

-- Output parchment
local outputParchment = display.newImageRect( "img-outputParchment.png", 298, 95 )
outputParchment.x = 160
outputParchment.y = 471

-- Output text
local outputText = display.newText( '', display.contentCenterX, 468, 225, 0, outputFont, 20 )
outputText:setFillColor(0)

-- Functions
local function updateOutputText(event)
    outputText.size = 20
    
    outputText.text = share( platInput.value, goldInput.value, elecInput.value, silvInput.value, coppInput.value, prtyInput.value == 0 and 1 or prtyInput.value, not forceEq.value, onlyGSC.value)

    -- Shrink text to fit viewable area
    while(outputText.height > 68) do
      outputText.size = outputText.size - 1
    end
end

local function hideKeyboard(event)
    native.setKeyboardFocus(nil)
  end

-- Event listeners
background.rectangle:addEventListener("tap", hideKeyboard)
platInput.input:addEventListener("userInput", updateOutputText)
goldInput.input:addEventListener("userInput", updateOutputText)
elecInput.input:addEventListener("userInput", updateOutputText)
silvInput.input:addEventListener("userInput", updateOutputText)
coppInput.input:addEventListener("userInput", updateOutputText)
prtyInput.input:addEventListener("userInput", updateOutputText)
forceEq.checkbox:addEventListener("tap", updateOutputText)
onlyGSC.checkbox:addEventListener("tap", updateOutputText)