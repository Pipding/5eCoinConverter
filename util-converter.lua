Amount = require("model-amount")
require("util-maths")

function silverToCopper(silverAmount)
    return (silverAmount * 10)
end


function electrumToCopper(electrumAmount)
    return (electrumAmount * 50)
end


function goldToCopper(goldAmount)
    return (goldAmount * 100)
end


function platinumToCopper(platinumAmount)
    return (platinumAmount * 1000)
end


function amountToCopper(amount)
    return amount.copper + silverToCopper(amount.silver) + electrumToCopper(amount.electrum) + goldToCopper(amount.gold) + platinumToCopper(amount.platinum)
end


function toCopper(platinum, gold, electrum, silver, copper)
    local amount = Amount:new(platinum, gold, electrum, silver, copper)
    return amount.copper + silverToCopper(amount.silver) + electrumToCopper(amount.electrum) + goldToCopper(amount.gold) + platinumToCopper(amount.platinum)
end


-- Converts copper to another coin type. Accepts exchange rate (x copper per other) as argument
function copperToOther(copperAmount, exchangeRate)
    local otherCoinAmount = math.floor(copperAmount/exchangeRate)
    local remainingCopper = otherCoinAmount == 0  and copperAmount or (copperAmount % (otherCoinAmount * exchangeRate)) -- Ternary operator
    return otherCoinAmount, remainingCopper
end


function copperToFewestCoins(copperToConvert, onlyUseGSC)
    local platinum = 0
    local electrum = 0

    if (onlyUseGSC == false) then
         platinum, copperToConvert = copperToOther(copperToConvert, 1000)
    end

    local gold, copperToConvert = copperToOther(copperToConvert, 100)

    if not onlyUseGSC then
        electrum, copperToConvert = copperToOther(copperToConvert, 50)
    end

    local silver, copperToConvert = copperToOther(copperToConvert, 10)
    local copper = math.floor(copperToConvert/1)

    local amount = Amount:new(platinum, gold, electrum, silver, copper)

    return amount
end


function share(plat, gold, elec, silv, copp, party, useRemainder, onlyGSC)
    local remainderCopper = 0
    local result = ''

    local totalCopper = toCopper(plat, gold, elec, silv, copp)

    if(totalCopper == 0) then
        return result
    end

    totalCopper, remainderCopper = makeDivisibleBy(totalCopper, party)

    local evenCopperShare = totalCopper / party

    if(useRemainder and remainderCopper > 0) then
        local groupA = party - remainderCopper
        local groupB = remainderCopper

        local groupAResult = copperToFewestCoins(evenCopperShare, onlyGSC):toString(onlyGSC)
        local groupBResult = copperToFewestCoins(evenCopperShare + 1, onlyGSC):toString(onlyGSC)

        -- If either of the results are long, insert extra newlines (14 chars)

        if((string.len(groupAResult) > 11) or (string.len(groupBResult) > 14)) then
            groupAResult = ":\n".. groupAResult
            groupBResult = ":\n".. groupBResult
        end

        result = groupA .. (groupA == 1 and ' person gets ' or ' people get ')  .. groupAResult .. "\n\n" .. groupB .. (groupB == 1 and ' person gets ' or ' people get ') .. groupBResult
    else
        result = "Each person gets " .. copperToFewestCoins(evenCopperShare, onlyGSC):toString(onlyGSC)
    end

    return result

end