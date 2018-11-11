if not SERVER then return end

-- AddNetworkString

util.AddNetworkString( "Advanced:System:Npc:Respawning:OpenMenu" )
util.AddNetworkString( "Advanced:System:Npc:Respawning:Add" )
util.AddNetworkString( "Advanced:System:Npc:Respawning:Edit" )
util.AddNetworkString( "Advanced:System:Npc:Respawning:Delete" )
util.AddNetworkString( "Advanced:System:Npc:Respawning:Refresh" )

-- Functions

hook.Add( "PlayerSay", "Advanced:System:Npc:Respawning:Say", function( ply, text, public )
	if ( string.lower( text ) == "!"..Advanced.System.Npc.Respawning.Config.CommandSay or string.lower( text ) == "/"..Advanced.System.Npc.Respawning.Config.CommandSay ) then
			if not IsValid(ply) and not ply:IsPlayer() then return end
			if not Advanced.System.Npc.Respawning.Config.GroupAccess[ply:GetUserGroup()] then return end
			net.Start( "Advanced:System:Npc:Respawning:OpenMenu" )
			net.WriteTable(util.JSONToTable(file.Read("advanced_system_npc_respawning/position.txt", "DATA")))
			net.Send( ply )
		return ""
	end
end )

net.Receive( "Advanced:System:Npc:Respawning:Refresh", function(len, caller)
	if not IsValid(caller) and not caller:IsPlayer() then return end
	if not Advanced.System.Npc.Respawning.Config.GroupAccess[caller:GetUserGroup()] then return end
	Advanced_System_Npc_Respawning_Init()
	DarkRP.notify(caller, 0, 6, Advanced.System.Npc.Respawning.Config.RefreshNotify)
	for k, v in pairs( util.JSONToTable(file.Read("advanced_system_npc_respawning/position.txt", "DATA")) ) do
		for w, x in pairs( ents.FindByClass( v.class ) ) do
			x:Remove()
		end
		local ent = ents.Create( v.class )
		if not IsValid(ent) then return end
		local pos = table.Random({ Vector(v.pos1), Vector(v.pos2) })
		ent:SetPos( pos ) 
		if pos == Vector(v.pos1) then
			angleforentity = Angle(v.ang1)
		elseif pos == Vector(v.pos2) then
			angleforentity = Angle(v.ang2)
		end
		ent:SetAngles( angleforentity )
		ent:Spawn()
		ent:Activate()
	end
end)

-- Data

function Advanced_System_Npc_Respawning_Init()
	if not file.Exists("advanced_system_npc_respawning", "DATA") then
		file.CreateDir( "advanced_system_npc_respawning", "DATA" )
	end

	if not file.Exists("advanced_system_npc_respawning/position.txt", "DATA") then
		file.Write( "advanced_system_npc_respawning/position.txt", util.TableToJSON( {} ) )
	end
end
hook.Add( "Initialize", "Advanced:System:Npc:Respawning:Init", Advanced_System_Npc_Respawning_Init )

-- Functions

net.Receive( "Advanced:System:Npc:Respawning:Add", function(len, caller)
	if not IsValid(caller) and not caller:IsPlayer() then return end
	if not Advanced.System.Npc.Respawning.Config.GroupAccess[caller:GetUserGroup()] then return end
	local vclass = net.ReadString()
	local vpos1 = net.ReadString()
	local vpos2 = net.ReadString()
	local vang1 = net.ReadString()
	local vang2 = net.ReadString()
	
	local fileData = file.Read("advanced_system_npc_respawning/position.txt", "DATA")
	
	local tabData = util.JSONToTable(fileData)

	table.insert( tabData, {class = vclass, pos1 = vpos1, pos2 = vpos2, ang1 = vang1, ang2 = vang2} )

	fileData = util.TableToJSON(tabData)

	file.Write("advanced_system_npc_respawning/position.txt", fileData)

	DarkRP.notify(caller, 0, 6, Advanced.System.Npc.Respawning.Config.AddNotify ..vclass)

end)

net.Receive( "Advanced:System:Npc:Respawning:Edit", function(len, caller)
	if not IsValid(caller) and not caller:IsPlayer() then return end
	if not Advanced.System.Npc.Respawning.Config.GroupAccess[caller:GetUserGroup()] then return end
	local k = net.ReadUInt(2)
	
	local vclass = net.ReadString()
	local vpos1 = net.ReadString()
	local vpos2 = net.ReadString()
	local vang1 = net.ReadString()
	local vang2 = net.ReadString()

	local fileData = file.Read("advanced_system_npc_respawning/position.txt", "DATA")
	
	local tabData = util.JSONToTable(fileData)

	tabData[k]["class"] = vclass
	tabData[k]["pos1"] = vpos1
	tabData[k]["pos2"] = vpos2
	tabData[k]["ang1"] = vang1
	tabData[k]["ang2"] = vang2

	fileData = util.TableToJSON(tabData)

	file.Write("advanced_system_npc_respawning/position.txt", fileData)

	DarkRP.notify(caller, 0, 6, Advanced.System.Npc.Respawning.Config.EditNotify..vclass)

end)

net.Receive( "Advanced:System:Npc:Respawning:Delete", function(len, caller)
	if not IsValid(caller) and not caller:IsPlayer() then return end
	if not Advanced.System.Npc.Respawning.Config.GroupAccess[caller:GetUserGroup()] then return end
	local k = net.ReadUInt(2)
	
	local fileData = file.Read("advanced_system_npc_respawning/position.txt", "DATA")
	
	local tabData = util.JSONToTable(fileData)
	
	table.remove(tabData, k)
	
	fileData = util.TableToJSON(tabData)

	file.Write("advanced_system_npc_respawning/position.txt", fileData)

	DarkRP.notify(caller, 0, 6, Advanced.System.Npc.Respawning.Config.DeleteNotify..tostring(k))

end)

-- Delete and respawning System
local NextPrintNTime = 0
function Advanced_System_Npc_Respawning_Think()
    if (CurTime() >= NextPrintNTime) then
    	Advanced_System_Npc_Respawning_Init()
		for k, v in pairs( util.JSONToTable(file.Read("advanced_system_npc_respawning/position.txt", "DATA")) ) do
			for w, x in pairs( ents.FindByClass( v.class ) ) do
				x:Remove()
			end
			local ent = ents.Create( v.class )
			if not IsValid(ent) then return end
			local pos = table.Random({ Vector(v.pos1), Vector(v.pos2) })
			ent:SetPos( pos ) 
			if pos == Vector(v.pos1) then
				angleforentity = Angle(v.ang1)
			elseif pos == Vector(v.pos2) then
				angleforentity = Angle(v.ang2)
			end
			ent:SetAngles( angleforentity )
			ent:Spawn()
			ent:Activate()
		end
        NextPrintNTime = CurTime() + Advanced.System.Npc.Respawning.Config.TimeRespawning
    end
end
hook.Add("Think", "Advanced:System:Npc:Respawning:Think", Advanced_System_Npc_Respawning_Think)

-- CleanUP
hook.Add( "PostCleanupMap", "Advanced:System:Npc:Respawning:CleanUP", function()
	timer.Simple( 0.1, function()
		Advanced_System_Npc_Respawning_Init()
		for k, v in pairs( util.JSONToTable(file.Read("advanced_system_npc_respawning/position.txt", "DATA")) ) do
			for w, x in pairs( ents.FindByClass( v.class ) ) do
				x:Remove()
			end
			local ent = ents.Create( v.class )
			if not IsValid(ent) then return end
			local pos = table.Random({ Vector(v.pos1), Vector(v.pos2) })
			ent:SetPos( pos ) 
			if pos == Vector(v.pos1) then
				angleforentity = Angle(v.ang1)
			elseif pos == Vector(v.pos2) then
				angleforentity = Angle(v.ang2)
			end
			ent:SetAngles( angleforentity )
			ent:Spawn()
			ent:Activate()
		end
	end)
end)