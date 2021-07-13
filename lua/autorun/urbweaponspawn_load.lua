if SERVER then
    local function SpawnWeapon(k, v)
        local ent = ents.Create("urbweaponspawn")
        --local pos = position
        --pos.z = pos.z - ent1:OBBMaxs().z
        ent:Spawn()
        ent:SetConfig(v.weapon, v.pos, v.respawnTime)
    end

    hook.Add("InitPostEntity","UrbWeaponSpawnInit",function() 
        local initQuery = sql.Query( "CREATE TABLE IF NOT EXISTS urbws_weapons (weapon VARCHAR(255) NOT NULL, map VARCHAR(255) NOT NULL, pos VARCHAR(255) NOT NULL, respawnTime INTEGER NOT NULL)" )
        --local testQuery = sql.Query("INSERT INTO urbws_weapons (weapon, map, pos, respawnTime) VALUES ('weapon_extinguisher', 'rp_southside_day', '9870.124023 1218.562134 -39.968750', 30)")
        local spawnQuery = sql.Query("SELECT * FROM urbws_weapons WHERE map ='" .. game.GetMap() .. "'")
        --PrintTable(spawnQuery)
        for k,v in pairs(spawnQuery) do
            SpawnWeapon(k,v)
        end
    end)
end