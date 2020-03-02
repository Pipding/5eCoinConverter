-- An amount of money measured in platinum, gold, electrum, silver and copper
Amount = {platinum = 0, gold = 0, electrum = 0, silver = 0, copper = 0}
Amount.__index = Amount


-- Constructor
function Amount:new (p, g, e, s, c)
    local amt = {}
    setmetatable(amt, Amount)
    amt.platinum = p
    amt.gold = g
    amt.electrum = e
    amt.silver = s
    amt.copper = c

    return amt
end


function Amount:toString(onlyUseGSC)

    local stringValue = ""
   
    if(onlyUseGSC) then
        stringValue = string.format(" %.fgp, %.fsp, %.fcp", self.gold, self.silver, self.copper)
    else
        stringValue = string.format(" %.fpp, %.fgp, %.fep, %.fsp, %.fcp", self.platinum, self.gold, self.electrum, self.silver, self.copper)
    end

    stringValue = stringValue:gsub("%s0.p,?","")
    stringValue = stringValue:gsub(",$", "")
    stringValue = (stringValue:gsub("^%s*(.-)%s*$", "%1"))
    
    return stringValue
end

return Amount