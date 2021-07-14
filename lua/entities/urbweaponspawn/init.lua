AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

util.AddNetworkString("UrbanWeaponSpawnsOpenMenu")

function ENT:Initialize()
	self:SetNWInt("id", 0)
	self:SetNWFloat("respawnTime", 30)
	self:SetNWString("weapon","weapon_medkit")
	self:SetModel( weapons.Get(self:GetNWString("weapon")).WorldModel )
	self.Entity:SetUseType( SIMPLE_USE )
	self:SetSolid( SOLID_VPHYSICS )
end

function ENT:Use(a, ply)
	if ply:IsAdmin() then
		net.Start("UrbanWeaponSpawnsOpenMenu")
			net.WriteEntity(self)
		net.Send(ply)
	end
end

function ENT:SetConfig(id, weapon, pos, respawnTime)
	self:SetNWInt("id", id)
	self:SetNWFloat("respawnTime", respawnTime)
	self:SetNWString("weapon", weapon)
	self:SetPos(Vector(pos))
	self:SetModel( weapons.Get(weapon).WorldModel )
end

function ENT:StartTouch(ply)
	local weapon = weapons.Get(self:GetNWString("weapon"))
	if ply:IsPlayer() then
		if ply:Give(weapon.ClassName) == NULL then
			if weapon.Primary.ClipSize > 0 then
				ply:GiveAmmo(weapon.Primary.ClipSize, weapon.Primary.Ammo)
			else
				ply:GiveAmmo(weapon.Primary.DefaultClip, weapon.Primary.Ammo)
			end
		end
		self:SetNoDraw(true)
		self:SetSolid( SOLID_NONE )
		timer.Simple(self:GetNWFloat("respawnTime"), function()
			self:SetSolid( SOLID_VPHYSICS )
			self:SetNoDraw(false)
		end)
	end
end
