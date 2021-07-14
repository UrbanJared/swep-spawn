if SERVER then
	util.AddNetworkString("UrbanWeaponSpawnsSetConfig")
	
	net.Receive("UrbanWeaponSpawnsSetConfig",function()
		local ent = net.ReadEntity()
		print("Id: " .. tostring(ent:GetNWInt("id")))
		local weapon = net.ReadString()
		local pos = net.ReadString()
		local respawnTime = net.ReadFloat()
		ent:SetConfig(id, weapon, pos, respawnTime)
	end)	
end