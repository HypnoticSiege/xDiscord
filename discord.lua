--Made by HypnoticSiege (Some things from sadboilogan's Rich Presence https://github.com/sadboilogan/FiveM-RichPresence) and Health status thanks to Jeva's RPC
--This Rich Presence will not show the vehicle type in order to not leak any spawncodes you might want private as I see that as a problem on some servers
--This script will also update every 1 SECOND, change the Citizen.Wait times if you would like it more delayed
--If you need any help please contact me on Discord (HypnoticSiege#2909)

--Install Istructions
--Configure the **Discord Configuration** part of this code which you can find at line *#*
--Go to Rich Presence and drag all files from the /Assets Folder into the image assets. This may take up to 10 minutes to cache to Discord
--Done!

Citizen.CreateThread(function()
    while true do
        local Online = GetActivePlayers()
        local player = GetPlayerPed(-1)

        --Discord Configuration (CONFIGURE TO YOUR NEEDS)
        SetDiscordAppId('781164218661339176') --Make an app here https://discord.com/developers/applications
        SetDiscordRichPresenceAsset('main') --This is the big pictutre that will show you your profile

        SetDiscordRichPresenceAssetText(..Online.. "Players Online")

        SetDiscordRichPresenceAssetSmall('second') --This is a sacond image that is a bit smaller than the big one a few rows above
        SetDiscordRichPresenceAssetSmallText("Health: "..(GetEntityHealth(player)-100)) --This shows the player's health when hovering over picture above
        
        SetDiscordRichPresenceAction(0, "Connect", "fivem://connect/80.195.75.45:30120") --First Button on RPC, shows on side. Modify text and URL to your liking
        SetDiscordRichPresenceAction(1, "Discord Bot", "https://hypnoticsiege.codes/hypertonic") --Second Button RPC, shows under one above


        --Some information here to get player's location, vehicle, name, ID, and some more
        --Don't suggest touching this if you don't know what you are doing :) (Unless you want to change some text)
        local pId = GetPlayerServerId(PlayerId())
        local pName = GetPlayerName(PlayerId())
        local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
        local StreetHash = GetStreetNameAtCoord(x, y, z)
        local VehClass = GetVehicleClass()
        Citizen.Wait(1000)
        if StreetHash ~= nil then
            StreetName = GetStreetNameFromHashKey(StreetHash)

            if IsPedOnFoot(PlayerPedId()) and not IsEntityInWater(PlayerPedId()) then

                --Player Sprint Status
				if IsPedSprinting(PlayerPedId()) then
					SetRichPresence("ID: " ..pId.. " | " ..pName.. " is sprinting down "..StreetName)
                    SetDiscordRichPresenceAssetSmall('run')
                    SetDiscordRichPresenceAssetSmallText("Sprining on "..StreetName)

                --PLayer Running Status
				elseif IsPedRunning(PlayerPedId()) then
					SetRichPresence("ID: " ..pId.. " | " ..pName.. " is running down "..StreetName)
                    SetDiscordRichPresenceAssetSmall('run')
                    SetDiscordRichPresenceAssetSmallText("Running down "..StreetName)

                --Player Walking Status
				elseif IsPedWalking(PlayerPedId()) then
					SetRichPresence("ID: " ..pId.. " | " ..pName.. " is walking down "..StreetName)
                    SetDiscordRichPresenceAssetSmall('walk')
                    SetDiscordRichPresenceAssetSmallText("Walking down "..StreetName)
                
                --Player Standing Status
				elseif IsPedStill(PlayerPedId()) then
					SetRichPresence("ID: " ..pId.. " | " ..pName.. " is standing on "..StreetName)
                    SetDiscordRichPresenceAssetSmall('stand')
                    SetDiscordRichPresenceAssetSmallText("Standing on "..StreetName)


                --Player Dead Status
				elseif IsPedDead(PlayerPedId()) then
					SetRichPresence("ID: " ..pId.. " | " ..pName.. " is Dead near "..StreetName)
                    SetDiscordRichPresenceAssetSmall('dead')
                    SetDiscordRichPresenceAssetSmallText("Dead Near "..StreetName)

                end
                
                
                --Player Vehicle Status
				if GetVehiclePedIsUsing(PlayerPedId()) ~= nil and not IsPedInAnyHeli(PlayerPedId()) and not IsPedInAnyPlane(PlayerPedId()) and not IsPedOnFoot(PlayerPedId()) and not IsPedInAnySub(PlayerPedId()) and not IsPedInAnyBoat(PlayerPedId()) then
                    local MPH = math.ceil(GetEntitySpeed(GetVehiclePedIsUsing(PlayerPedId())) * 2.236936)
                    if MPH > 0 then
                    SetRichPresence("ID: "..pId.." | "..pName.." is on "..StreetName.." going "..MPH.."MPH")
                    SetDiscordRichPresenceAssetSmall('vehicle')
                    SetDiscordRichPresenceAssetSmallText("Driving a "..VehClass.. "Vehicle")

                --PLayer Boat Staus
				elseif IsPedInAnyBoat(PlayerPedId()) then
					SetRichPresence("ID: " ..pId.. " | " ..pName.. " is on a Boat near "..StreetName)
                    SetDiscordRichPresenceAssetSmall('boat')
                    SetDiscordRichPresenceAssetSmallText("Sailing Near "..StreetName)

                --Player Sub Status
				elseif IsPedInAnySub(PlayerPedId()) then
					SetRichPresence("ID: " ..pId.. " | " ..pName.. " is in a Submarine near "..StreetName)
                    SetDiscordRichPresenceAssetSmall('sub')
                    SetDiscordRichPresenceAssetSmallText("In a Sub near "..StreetName)
                
                --Player Standing Status
				elseif IsPedStill(PlayerPedId()) then
					SetRichPresence("ID: " ..pId.. " | " ..pName.. " is standing on "..StreetName)
                    SetDiscordRichPresenceAssetSmall('stand')
                    SetDiscordRichPresenceAssetSmallText("Standing on "..StreetName)


                --Player Dead Status
				elseif IsPedDead(PlayerPedId()) then
					SetRichPresence("ID: " ..pId.. " | " ..pName.. " is Dead near "..StreetName)
                    SetDiscordRichPresenceAssetSmall('dead')
                    SetDiscordRichPresenceAssetSmallText("Dead Near "..StreetName)

                 --Player Heli Status
				elseif IsPedinAnyHeli(PlayerPedId()) then
					SetRichPresence("ID: " ..pId.. " | " ..pName.. " is flying a Helicopter Near "..StreetName)
                    SetDiscordRichPresenceAssetSmall('heli')
                    SetDiscordRichPresenceAssetSmallText("In a Heli near "..StreetName)
                
                --Player Plane Status
                elseif IsPedinAnyPlane(PlayerPedId()) then
					SetRichPresence("ID: " ..pId.. " | " ..pName.. " is flying a Plane Near "..StreetName)
                    SetDiscordRichPresenceAssetSmall('heli')
                    SetDiscordRichPresenceAssetSmallText("In a Plane near "..StreetName)
                end

                --Player Vehicle Status
            elseif GetVehiclePedIsUsing(PlayerPedId()) ~= nil and not IsPedInAnyHeli(PlayerPedId()) and not IsPedInAnyPlane(PlayerPedId()) and not IsPedOnFoot(PlayerPedId()) and not IsPedInAnySub(PlayerPedId()) and not IsPedInAnyBoat(PlayerPedId()) then
                local MPH = math.ceil(GetEntitySpeed(GetVehiclePedIsUsing(PlayerPedId())) * 2.236936)
                if MPH > 0 then
                    SetRichPresence("ID: "..pId.." | "..pName.." is on "..StreetName.." going "..MPH.."MPH")
                    SetDiscordRichPresenceAssetSmall('vehicle')
                    SetDiscordRichPresenceAssetSmallText("Driving a "..VehClass.. "Vehicle")
                end

                --Player Flying Status
            elseif IsPedInAnyHeli(PlayerPedId()) or IsPedInAnyPlane(PlayerPedId()) then
                if IsEntityInAir(GetVehiclePedIsUsing(PlayerPedId())) or GetEntityHeightAboveGround(GetVehiclePedIsUsing(PlayerPedId())) > 5.0 then
                    SetRichPresence("ID: "..pId.." | "..pName.." is flying above "..StreetName)
                    SetDiscordRichPresenceAssetSmall('plane')
                    SetDiscordRichPresenceAssetSmallText("Flying near "..StreetName)
                end
                
                --Player Swimming Status
            elseif IsEntityInWater(PlayerPedId()) then
                SetRichPresence("ID: "..pId.." | "..pName.." is swimming around "..StreetName)
                SetDiscordRichPresenceAssetSmall('swim')
                SetDiscordRichPresenceAssetSmallText("Swimming near "..StreetName)
            end
        end
    end
end)