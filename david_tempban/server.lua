-------------------------------Made by David cu putin ajutor de la alte scripturi xD-------------------------------

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","david_tempban")

local sql = [[
    UPDATE vrp_users SET timpban = CASE WHEN timpban > 0 THEN timpban - 1 END, banned = CASE WHEN timpban = 0 THEN banned = 0 ELSE banned END WHERE banned = 2
]]

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)
        MySQL.Async.execute(sql,{}, function(data)end)
    end
end)

vRP.registerMenuBuilder({"admin", function(add, data)
    local user_id = vRP.getUserId({data.player})
    if user_id ~= nil then
      local choices = {}

      if vRP.hasPermission({user_id,"player.ban"}) then -- daca ai permisiunea player.ban la gradul tau de pe server, ai acces la tempban, poti pune tu o permisiune separata
        choices["TempBan"] = {function(player,choice)
            vRP.prompt({player, "ID : ", "", function(player, id_target)
                id_target = parseInt(id_target)
                if(tonumber(id_target) and id_target ~= nil) then
                    vRP.prompt({player, "Motiv (Maxim 30 de caractere) :", "", function(player, motiv)
                        if(motiv ~= nil and string.len(motiv) <= 30) then
                            vRP.prompt({player, "Cate zile? (Maxim 31 de zile) : ", "", function(player, zile)
                                zile = parseInt(zile)
                                if(tonumber(zile) and zile ~= nil and zile <= 31) then
                                    MySQL.Async.execute("UPDATE vrp_users SET banned = @banned,motiv = @motiv,timpban = @timpban,banatdecatre = @banatdecatre WHERE id = @user_id",{["user_id"] = id_target,["timpban"] = zile*(60*24),["banned"] = 2,["motiv"] = motiv,["banatdecatre"] = user_id}, function(data)end)
                                    if(vRP.getUserSource({id_target}) ~= nil) then
                                        DropPlayer(vRP.getUserSource({id_target}),"[TempBan] Ai primit ~r~Ban !") -- pui tu aici cum vrei sa ii apara jucatorului cand primeste TempBan
                                        --print ("Un jucator a primit ban temporar.")
                                    end
                                else
                                    vRP.notify(player,{"Maxim 31 de zile!"})
                                end
                            end})
                        else
                            vRP.notify(player,{"Motiv Invalid!"})
                        end
                    end})
                end
            end})
        end,"Ban temporar unui jucator"}
      end

      add(choices)
    end
end})