local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_gps")

locatii = {
  ["Showroom"] = {-67.178565979004,-1107.2642822266,25.980241775512},
  ["Sectia de Politie"] = {399.67001342774,-989.19720458984,29.465553283692},
  ["Spital"] = {274.01965332032,-586.6049194336,43.16217803955},
  ["Centrul pentru Angajari"] = {-234.84730529786,-982.2509765625,29.136503219604}
}

RegisterCommand("gps", function(player, choice)
  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    local menu_gps = {}
    for k, v in pairs(locatii) do
      menu_gps[k] = {function(player, choice)
        vRPclient.setGPS(player, {v[1], v[2]})
        vRP.closeMenu({player})
      end, ""}
    end
    vRP.openMenu({player, menu_gps})
  end
end)