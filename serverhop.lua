local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local placeId = game.PlaceId
local serversApi = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"

function getLowestPopulatedServer()
    local servers = game:HttpGet(serversApi)
    local serverData = game:GetService("HttpService"):JSONDecode(servers)

    if serverData and serverData.data then
        for _, server in pairs(serverData.data) do
            if server.playing <= 4 then 
                return server.id
            end
        end
    end
  
    return nil
end

local targetServerId = getLowestPopulatedServer()

if targetServerId then
    StarterGui:SetCore("SendNotification", {
        Title = "Script Executed",
        Text = "by KOBITAh",
        Duration = 2
    })

    TeleportService:TeleportToPlaceInstance(placeId, targetServerId, Players.LocalPlayer)
else
    print("No suitable servers found.")
end
