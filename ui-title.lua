Title = { width = 0, height = 0, x = 0, y = 0 }
Title.__index = Title

-- Constructor
function Title:new (width, height, x, y)
    local ttl = {}
    setmetatable(ttl, Title)
    ttl.width = width
    ttl.height = height
    ttl.x = x
    ttl.y = y

    local banner = display.newImageRect( "img-bannerBox.png", width, height )
    banner.x = x
    banner.y = y

    local titleBox = display.newImageRect( "img-titleBox.png", width - 40, height/2 )
    titleBox.x = x - 2
    titleBox.y = y - 8

    return ttl
end

return Title