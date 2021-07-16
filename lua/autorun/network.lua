if SERVER then
	util.AddNetworkString("UrbanWeaponSpawnsSetConfig")
	util.AddNetworkString("UrbanWeaponSpawnsDelete")
	
	net.Receive("UrbanWeaponSpawnsSetConfig",function(len, ply)
		local ent = net.ReadEntity()
		local id = ent:GetNWInt("id")
		local weapon = net.ReadString()
		local pos = tostring(ent:GetPos())
		local respawnTime = net.ReadFloat()
		if respawnTime < 0.7 then -- Less than this gets players stuck. Less than 0 causes crashes.
			respawnTime = 0.7
		end
		ent:SetConfig(id, weapon, pos, respawnTime)
		if id == 0 then
			local insertQuery = sql.Query("INSERT INTO urbws_weapons (weapon, map, pos, respawnTime) VALUES ('"..weapon.."','"..game.GetMap().."','"..pos.."','"..respawnTime.."')")
			local findQuery = sql.Query("SELECT rowid FROM urbws_weapons WHERE weapon = '"..weapon.."' AND pos = '" ..pos.. "'")
			ent:SetNWInt("id", tonumber(findQuery[1].rowid))
			ply:PrintMessage( HUD_PRINTTALK, "Spawn added" )
		else
			local updateQuery = sql.Query("UPDATE urbws_weapons SET weapon = '" ..weapon.."', pos = '" ..pos.."', respawnTime = " ..respawnTime.." WHERE rowid = " .. id)
			ply:PrintMessage( HUD_PRINTTALK, "Spawn updated" )
		end
	end)
	net.Receive("UrbanWeaponSpawnsDelete",function(len, ply)
		local ent = net.ReadEntity()
		local id = ent:GetNWInt("id")
		if id > 0 then
			local deleteQuery = sql.Query("DELETE FROM urbws_weapons WHERE rowid = "..id)
			ply:PrintMessage( HUD_PRINTTALK, "Spawn deleted" )
		end
		ent:Remove()
	end)

end
