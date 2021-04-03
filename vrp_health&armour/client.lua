-- ARMURA SI VIATA DISPLAY --
Citizen.CreateThread(function()
    while true do Wait(1)
        ped = GetPlayerPed(-1)
        viata = (GetEntityHealth(ped)-100)
    if viata >= 35 then 
        text(0.035, 0.965, 0.29, 4, "~w~VIATA ~g~".. viata .."", 255, 255, 255, true)
    else
        text(0.035, 0.965, 0.29, 4, "~w~VIATA ~r~".. viata .."", 255, 255, 255, true)
        end

    armura = (GetPedArmour(ped))

    if armura > -1 then
        text(0.110, 0.965, 0.29, 4, "~w~ARMURA ~b~".. armura .."", 255, 255, 255, true)
        end
    end
end)

function text(x, y, scale, font, text, r, g, b, outline)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r,g,b, 255)
    SetTextDropShadow(0,0,0,0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x , y)
end