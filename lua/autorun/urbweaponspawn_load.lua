if SERVER then
    local function SpawnWeapon(k, v)
        local ent = ents.Create("urbweaponspawn")
        ent:Spawn()
        ent:SetConfig(k, v.weapon, v.pos, v.respawnTime)
    end

    hook.Add("InitPostEntity","UrbWeaponSpawnInit",function() 
        local initQuery = sql.Query( "CREATE TABLE IF NOT EXISTS urbws_weapons (weapon VARCHAR(255) NOT NULL, map VARCHAR(255) NOT NULL, pos VARCHAR(255) NOT NULL, respawnTime DECIMAL(8,2) NOT NULL)" )
        --local testQuery = sql.Query("INSERT INTO urbws_weapons (weapon, map, pos, respawnTime) VALUES ('weapon_extinguisher', 'rp_southside_day', '9870.124023 1218.562134 -100', 30)")     
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
        print("Including Client: " .. path)
        AddCSLuaFile(path)
    end
end

function UrbanWeapon:IncludeServer(path)
    if (SERVER) then
        print("Including Server: " .. path)
        include(path)
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
    
    for k, v in ipairs(Directory) do
        print("[AUTOLOAD] Directory: " .. dir .. v)
        IncludeDir(dir..v)
    end
end

local function IncludeServerDir(dir)
    dir = UrbanWeapon.Dir .. "/" .. dir .. "/"
    local File, Directory = file.Find(dir.."*", "LUA")

    for k, v in ipairs(File) do
        if string.EndsWith(v, ".lua") then
            UrbanWeapon:IncludeServer(dir..v)
        end
    end
    
    for k, v in ipairs(Directory) do
        print("[AUTOLOAD] Directory: " .. dir .. v)
        IncludeDir(dir..v)
    end
end
IncludeClientDir("elements")