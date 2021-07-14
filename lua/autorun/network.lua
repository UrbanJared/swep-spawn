if SERVER then
	util.AddNetworkString("UrbanWeaponSpawnsSetConfig")
	util.AddNetworkString("UrbanWeaponSpawnsDelete")
	
	net.Receive("UrbanWeaponSpawnsSetConfig",function()
		local ent = net.ReadEntity()
		local id = ent:GetNWInt("id")
		local weapon = net.ReadString()
		local pos = net.ReadString()
		local respawnTime = net.ReadFloat()
		ent:SetConfig(id, weapon, pos, respawnTime)
		if id == 0 then
			local insertQuery = sql.Query("INSERT INTO urbws_weapons (weapon, map, pos, respawnTime) VALUES ('"..weapon.."','"..game.GetMap().."','"..pos.."','"..respawnTime.."')")
			local findQuery = sql.Query("SELECT rowid FROM urbws_weapons WHERE weapon = '"..weapon.."' AND pos = '" ..pos.. "'")
			ent:SetNWInt("id", tonumber(findQuery[1].rowid))
		else
			local updateQuery = sql.Query("UPDATE urbws_weapons SET weapon = '" ..weapon.."', pos = '" ..pos.."', respawnTime = " ..respawnTime.." WHERE rowid = " .. id)
		end
	end)
	net.Receive("UrbanWeaponSpawnsDelete",function()
		local ent = net.ReadEntity()
		local id = ent:GetNWInt("id")
		if id > 0 then
			local deleteQuery = sql.Query("DELETE FROM urbws_weapons WHERE rowid = "..id)
		end
		ent:Remove()
	end)

end