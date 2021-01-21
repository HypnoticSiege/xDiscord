--Made by HypnoticSiege (Some things from sadboilogan's Rich Presence https://github.com/sadboilogan/FiveM-RichPresence) and Health status thanks to Jeva's RPC
--This Rich Presence will not show the vehicle type in order to not leak any spawncodes you might want private as I see that as a problem on some servers
--This script will also update every 1 SECOND, change the Citizen.Wait times if you would like it more delayed
--If you need any help please contact me on Discord (HypnoticSiege#2909)
Citizen.CreateThread(function()
    while true do
        local player = GetPlayerPed(-1)


        --Discord Configuration (CONFIGURE TO YOUR NEEDS)
        SetDiscordAppId('781164218661339176') --Make an app here https://discord.com/developers/applications
        SetDiscordRichPresenceAsset('main') --This is the big pictutre that will show you your profile
        SetDiscordRichPresenceAssetText('Playing on a FiveM Server') --This is the text that will show when hovering over the image above
        SetDiscordRichPresenceAssetSmall('second') --This is a sacond image that is a bit smaller than the big one a few rows above
        SetDiscordRichPresenceAssetSmallText("Health: "..(GetEntityHealth(player)-100)) --This shows the player's health when hovering over picture above


        --Some information here to get player's location, vehicle, name, ID, and some more
        --Don't suggest touching this if you don't know what you are doing :) (Unless you want to change some text)
        local pId = GetPlayerServerId(PlayerId())
        local pName = GetPlayerName(PlayerId())
        local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
        local StreetHash = GetStreetNameAtCoord(x, y, z)
        Citizen.Wait(1000)
        if StreetHash ~= nil then
            StreetName = GetStreetNameFromHashKey(StreetHash)

            --Player Walking Status
            if IsPedOnFoot(PlayerPedId()) and not IsEntityInWater(PlayerPedId()) then
				if IsPedSprinting(PlayerPedId()) then
					SetRichPresence("ID: " ..pId.. " | " ..pName.. " is sprinting down "..StreetName)
				elseif IsPedRunning(PlayerPedId()) then
					SetRichPresence("ID: " ..pId.. " | " ..pName.. " is running down "..StreetName)
				elseif IsPedWalking(PlayerPedId()) then
					SetRichPresence("ID: " ..pId.. " | " ..pName.. " is walking down "..StreetName)
				elseif IsPedStill(PlayerPedId()) then
					SetRichPresence("ID: " ..pId.. " | " ..pName.. " is standing on "..StreetName)
                end
                
                --Player Vehicle Status
            elseif GetVehiclePedIsUsing(PlayerPedId()) ~= nil and not IsPedInAnyHeli(PlayerPedId()) and not IsPedInAnyPlane(PlayerPedId()) and not IsPedOnFoot(PlayerPedId()) and not IsPedInAnySub(PlayerPedId()) and not IsPedInAnyBoat(PlayerPedId()) then
                local MPH = math.ceil(GetEntitySpeed(GetVehiclePedIsUsing(PlayerPedId())) * 2.236936)
                if MPH > 0 then
                    SetRichPresence("ID: "..pId.." | "..pName.." is on "..StreetName.." going "..MPH.."MPH")
                end

                --Player Flying Status
            elseif IsPedInAnyHeli(PlayerPedId()) or IsPedInAnyPlane(PlayerPedId()) then
                if IsEntityInAir(GetVehiclePedIsUsing(PlayerPedId())) or GetEntityHeightAboveGround(GetVehiclePedIsUsing(PlayerPedId())) > 5.0 then
                    SetRichPresence("ID: "..pId.." | "..pName.." is flying above "..StreetName)
                end
                
                --Player Swimming Status
            elseif IsEntityInWater(PlayerPedId()) then
                SetRichPresence("ID: "..pId.." | "..pName.." is swimming around "..StreetName)
            end
        end
    end
end)