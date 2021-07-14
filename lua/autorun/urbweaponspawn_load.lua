if SERVER then
    local function SpawnWeapon(k, v)
        local ent = ents.Create("urbweaponspawn")
        ent:Spawn()
        ent:SetConfig(k, v.weapon, v.pos, v.respawnTime)
    end

    hook.Add("InitPostEntity","UrbWeaponSpawnInit",function() 
        local initQuery = sql.Query( "CREATE TABLE IF NOT EXISTS urbws_weapons (weapon VARCHAR(255) NOT NULL, map VARCHAR(255) NOT NULL, pos VARCHAR(255) NOT NULL, respawnTime DECIMAL(8,2) NOT NULL)" )  
        local spawnQuery = sql.Query("SELECT * FROM urbws_weapons WHERE map ='" .. game.GetMap() .. "'")
        for k,v in pairs(spawnQuery) do
            SpawnWeapon(k,v)
        end
    end)
end

UrbanWeapon = UrbanWeapon or {}
UrbanWeapon.Dir = "UrbanWeapon"

function UrbanWeapon:IncludeClient(path)
    if (CLIENT) then
        include(path)
    elseif (SERVER) then
        AddCSLuaFile(path)
    end
end

local function IncludeClientDir(dir)
    dir = UrbanWeapon.Dir .. "/" .. dir .. "/"
    local File, Directory = file.Find(dir.."*", "LUA")

    for k, v in ipairs(File) do
        if string.EndsWith(v, ".lua") then
            UrbanWeapon:IncludeClient(dir..v)
        end
    end
end

IncludeClientDir("elements")
