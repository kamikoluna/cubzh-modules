local permission = {}
Modules = {
    playerData = "github.com/BucheGithub/modzh/playerData:20105ef",
}

dat = {
    "ban",
    "unban",
    "reason",
}
playerData:init(dat)

local Permission = {}
Permission.__index = Permission

function Permission.new()
    local self = setmetatable({}, Permission)
    return self
end

function Permission:openWorld(WorldID)
    local url = "https://app.cu.bzh/?worldID="..WorldID
    URL:Open(url)
end

function permission:check(player, Permission)
    return true
end
function permission:checkAll(Permission)
    if permission:check(Player, Permission) then
    return true
    end
end
function permission:checkBan(Permission)
    playerData:load(Player) 
    if Player.ban == true then 
        permission:openWorld("5420fdc3-bab1-4db4-b831-652f198c95a5") 
    end
end
function permission:checkAny(Permission)
    if permission:checkAll(Permission) then
    return true
    end
end
function permission:checkNot(Permission)
    if permission:checkAll(Permission) then
    return true
    end
end
function permission:ban( player, Reason)
    alert = require("alert")
    local done = alert:create("Player has been banned! Reason :" .. Reason)
    player.ban = true
    playerData:save()
    done:setPositiveCallback("",nil)
    done:setNegativeCallback("Quit Game", function() permission:openWorld("5420fdc3-bab1-4db4-b831-652f198c95a5") end)
end
function permission:kick( player, reason)
    alert = require("alert")
    local done = alert:create("Player has been kicked! Reason :" .. reason)
    done:setPositiveCallback("",nil)
    done:setNegativeCallback("Quit Game", function() permission:openWorld("5420fdc3-bab1-4db4-b831-652f198c95a5") end)
end
function permission:unban( player)
    playerData:load(Player) 
    playerData:reset(Player) 
end


return Permission
