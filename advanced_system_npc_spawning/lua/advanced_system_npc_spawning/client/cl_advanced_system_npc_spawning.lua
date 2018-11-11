if not CLIENT then return end

surface.CreateFont("advanced_system_npc_spawning_Font", {
  font = "Roboto",
  size =  ScrH()*0.5,
  weight = 1000,
  antialias = true
})

local blur = Material("pp/blurscreen")
local function DrawBlur( p, a, d )
	local x, y = p:LocalToScreen( 0, 0 )
	
	surface.SetDrawColor( 255, 255, 255 )
	surface.SetMaterial( blur )
	
	for i = 1, d do
		blur:SetFloat( "$blur", (i / d ) * ( a ) )
		blur:Recompute()
		
		render.UpdateScreenEffectTexture()
		
		surface.DrawTexturedRect( x * -1, y * -1, ScrW(), ScrH() )
	end
end

net.Receive( "Advanced:System:Npc:Respawning:OpenMenu", function()
	local Advanced_System_Npc_Spawning_Table = net.ReadTable()

	local scrw, scrh = ScrW(), ScrH()

	local DFrame1 = vgui.Create("DFrame")
	DFrame1:SetSize(scrw*.7, scrh*.7)
	DFrame1:SetTitle("Advanced System Npc Spawning")
	DFrame1:SetDraggable(false)
	DFrame1:ShowCloseButton(false)
	DFrame1:Center()
	DFrame1:MakePopup()
	DFrame1.Paint = function(self, w, h)
		DrawBlur( self, 6, 30 )
		draw.RoundedBox( 6, 0, 0, w, h, Color( 30, 30, 30, 120 ) )
		draw.RoundedBox( 3, 0, 0, w, h-510, Color( 0, 0, 0, 80 ) )
	end

	local quit = vgui.Create( "DButton", DFrame1 )
	quit:SetSize( scrw*.03, scrh*.03 )
	quit:SetPos( scrw*.67, scrh*.01-04 )
	quit:SetText( "X" )
	quit:SetTextColor( Color( 255, 255, 255 ) )
	quit.Paint = function( self, w, h )
		draw.RoundedBox( 6, 0, 0, w, h, Color( 30, 30, 30, 120 ) )
	end
	quit.DoClick = function()
	    DFrame1:Close()
	end

	local DButton1 = vgui.Create( "DButton", DFrame1 )
	DButton1:SetSize( scrw*.05, scrh*.03 )
	DButton1:SetPos( scrw*.60, scrh*.01-04 )
	DButton1:SetText(Advanced.System.Npc.Respawning.Config.Add)
	DButton1:SetTextColor( Color( 255, 255, 255 ) )
	DButton1.Paint = function(p, w, h)
		draw.RoundedBox( 6, 0, 0, w, h, Color( 30, 30, 30, 120 ) )
		local flashing = 100 + math.abs( math.sin( CurTime() * 1.1 ) * 255 )
		surface.SetDrawColor( flashing, flashing, flashing, flashing )
		surface.DrawOutlinedRect( 0, 0, p:GetWide(), p:GetTall() ) 
	end
	DButton1.DoClick = function( pnl )
		DFrame1:Close()	
		Advanced_System_Npc_Respawning_Add_OpenMenu()
	end

	local DButton11 = vgui.Create( "DButton", DFrame1 )
	DButton11:SetSize( scrw*.05, scrh*.03 )
	DButton11:SetPos( scrw*.50, scrh*.01-04 )
	DButton11:SetText(Advanced.System.Npc.Respawning.Config.Refresh)
	DButton11:SetTextColor( Color( 255, 255, 255 ) )
	DButton11.Paint = function(p, w, h)
		draw.RoundedBox( 6, 0, 0, w, h, Color( 30, 30, 30, 120 ) )
		local flashing = 100 + math.abs( math.sin( CurTime() * 1.1 ) * 255 )
		surface.SetDrawColor( flashing, flashing, flashing, flashing )
		surface.DrawOutlinedRect( 0, 0, p:GetWide(), p:GetTall() ) 
	end
	DButton11.DoClick = function( pnl )
		net.Start( "Advanced:System:Npc:Respawning:Refresh" )
		net.SendToServer()
		DFrame1:Close()
	end

	local DPanel2 = vgui.Create( "DPanelList", DFrame1 )
	DPanel2:SetSize( scrw*.68, scrh*.64 )
	DPanel2:SetPos( scrw*.01, scrh*.05 )
	DPanel2:SetSpacing( 3 )
	DPanel2:EnableVerticalScrollbar( true )
	DPanel2.Paint = function( self, w, h )
		local flashing = 100 + math.abs( math.sin( CurTime() * 1.1 ) * 255 )
		surface.SetDrawColor( flashing, flashing, flashing, flashing )
		surface.DrawOutlinedRect( 0, 0, self:GetWide(), self:GetTall() ) 
	end

	for k, v in pairs(Advanced_System_Npc_Spawning_Table) do
		local DPanel1 = vgui.Create( "DButton", DPanel2 )
		DPanel1:SetText(k.." - "..v.class)
		DPanel1:SetTextColor( Color( 255, 255, 255 ) )
		DPanel1.Paint = function(p, w, h)
			draw.RoundedBox( 6, 0, 0, w, h, Color( 30, 30, 30, 120 ) )
			local flashing = 100 + math.abs( math.sin( CurTime() * 1.1 ) * 255 )
			surface.SetDrawColor( flashing, flashing, flashing, flashing )
			surface.DrawOutlinedRect( 0, 0, p:GetWide(), p:GetTall() ) 
		end

		local DButton2 = vgui.Create( "DButton", DPanel1 )
		DButton2:SetSize( scrw*.05, DPanel1:GetTall() )
		DButton2:SetText(Advanced.System.Npc.Respawning.Config.Edit)
		DButton2:SetTextColor( Color( 255, 255, 255 ) )
		DButton2.Paint = function(p, w, h)
			draw.RoundedBox( 6, 0, 0, w, h, Color( 30, 30, 30, 120 ) )
			local flashing = 100 + math.abs( math.sin( CurTime() * 1.1 ) * 255 )
			surface.SetDrawColor( flashing, flashing, flashing, flashing )
			surface.DrawOutlinedRect( 0, 0, p:GetWide(), p:GetTall() ) 
		end
		DButton2.DoClick = function( pnl )
			Advanced_System_Npc_Respawning_Edit_OpenMenu(k, v.class, v.pos1, v.pos2, v.ang1, v.ang2)
			DFrame1:Close()
		end

		local DButton3 = vgui.Create( "DButton", DPanel1 )
		DButton3:SetSize( scrw*.05, DPanel1:GetTall() )
		DButton3:SetPos( DPanel1:GetWide(), 0 )
		DButton3:SetText(Advanced.System.Npc.Respawning.Config.Remove)
		DButton3:SetTextColor( Color( 255, 255, 255 ) )
		DButton3.Paint = function(p, w, h)
			draw.RoundedBox( 6, 0, 0, w, h, Color( 30, 30, 30, 120 ) )
			local flashing = 100 + math.abs( math.sin( CurTime() * 1.1 ) * 255 )
			surface.SetDrawColor( flashing, flashing, flashing, flashing )
			surface.DrawOutlinedRect( 0, 0, p:GetWide(), p:GetTall() ) 
		end
		DButton3.DoClick = function( pnl )
			net.Start( "Advanced:System:Npc:Respawning:Delete" )
			net.WriteUInt(k, 2)
			net.SendToServer()
			DFrame1:Close()
		end

		DPanel2:AddItem( DPanel1 )
	end
end)

function Advanced_System_Npc_Respawning_Add_OpenMenu()

	local scrw, scrh = ScrW(), ScrH()

	local createdTime = CurTime()

	local DFrame1 = vgui.Create("DFrame")
	DFrame1:SetSize(scrw*.7, scrh*.35)
	DFrame1:SetTitle("Advanced System Npc Spawning - Add")
	DFrame1:SetDraggable(true)
	DFrame1:ShowCloseButton(false)
	DFrame1:Center()
	DFrame1:MakePopup()
	DFrame1.Paint = function(self, w, h)
		DrawBlur( self, 6, 30 )
		draw.RoundedBox( 6, 0, 0, w, h, Color( 30, 30, 30, 120 ) )
	end

	local quit = vgui.Create( "DButton", DFrame1 )
	quit:SetSize( scrw*.03, scrh*.03 )
	quit:SetPos( scrw*.67, scrh*.01-04 )
	quit:SetText( "X" )
	quit:SetTextColor( Color( 255, 255, 255 ) )
	quit.Paint = function( self, w, h )
		draw.RoundedBox( 6, 0, 0, w, h, Color( 30, 30, 30, 120 ) )
	end
	quit.DoClick = function()
	    DFrame1:Close()
	end

	local DButton1 = vgui.Create( "DButton", DFrame1 )
	DButton1:SetSize( scrw*.05, scrh*.03 )
	DButton1:SetPos( scrw*.60, scrh*.01-04 )
	DButton1:SetText(Advanced.System.Npc.Respawning.Config.Back)
	DButton1:SetTextColor( Color( 255, 255, 255 ) )
	DButton1.Paint = function(p, w, h)
		draw.RoundedBox( 6, 0, 0, w, h, Color( 30, 30, 30, 120 ) )
		local flashing = 100 + math.abs( math.sin( CurTime() * 1.1 ) * 255 )
		surface.SetDrawColor( flashing, flashing, flashing, flashing )
		surface.DrawOutlinedRect( 0, 0, p:GetWide(), p:GetTall() ) 
	end
	DButton1.DoClick = function( pnl )
		LocalPlayer():ConCommand( "say /"..Advanced.System.Npc.Respawning.Config.CommandSay )
		DFrame1:Close()	
	end

	local Class = vgui.Create( "DTextEntry", DFrame1 )
	Class:SetPos( scrw*.02, scrh*.05 )
	Class:SetSize( scrw*.67, scrh*.04 )
	Class:SetText( "Class" )

	local Position1 = vgui.Create( "DTextEntry", DFrame1 )
	Position1:SetPos( scrw*.02, scrh*.1 )
	Position1:SetSize( scrw*.67, scrh*.04 )
	Position1:SetText( "Position 1" )

	local Position2 = vgui.Create( "DTextEntry", DFrame1 )
	Position2:SetPos( scrw*.02, scrh*.15 )
	Position2:SetSize( scrw*.67, scrh*.04 )
	Position2:SetText( "Position 2" )

	local Angles1 = vgui.Create( "DTextEntry", DFrame1 )
	Angles1:SetPos( scrw*.02, scrh*.2 )
	Angles1:SetSize( scrw*.67, scrh*.04 )
	Angles1:SetText( "Angles 1" )

	local Angles2 = vgui.Create( "DTextEntry", DFrame1 )
	Angles2:SetPos( scrw*.02, scrh*.25 )
	Angles2:SetSize( scrw*.67, scrh*.04 )
	Angles2:SetText( "Angles 2" )

	local DButton1 = vgui.Create( "DButton", DFrame1 )
	DButton1:SetPos( scrw*.02, scrh*.3 )
	DButton1:SetSize( scrw*.67, scrh*.04 )
	DButton1:SetText(Advanced.System.Npc.Respawning.Config.Add)
	DButton1:SetTextColor( Color( 255, 255, 255 ) )
	DButton1.Paint = function(p, w, h)
		draw.RoundedBox( 6, 0, 0, w, h, Color( 30, 30, 30, 120 ) )
		local flashing = 100 + math.abs( math.sin( CurTime() * 1.1 ) * 255 )
		surface.SetDrawColor( flashing, flashing, flashing, flashing )
		surface.DrawOutlinedRect( 0, 0, p:GetWide(), p:GetTall() ) 
	end
	DButton1.DoClick = function( pnl )
		if Class:GetText() == "" or Class:GetText() == "Class" then return end
		if Position1:GetText() == "" or Position1:GetText() == "Position 1" then return end
		if Position2:GetText() == "" or Position2:GetText() == "Position 2" then return end
		if Angles1:GetText() == "" or Angles1:GetText() == "Angles 1" then return end
		if Angles2:GetText() == "" or Angles2:GetText() == "Angles 2" then return end
		net.Start( "Advanced:System:Npc:Respawning:Add" )
		net.WriteString(Class:GetText())
		net.WriteString(Position1:GetText())
		net.WriteString(Position2:GetText())
		net.WriteString(Angles1:GetText())
		net.WriteString(Angles2:GetText())
		net.SendToServer()
		DFrame1:Close()	
	end
end

function Advanced_System_Npc_Respawning_Edit_OpenMenu(k, class, pos1, pos2, ang1, ang2)

	local scrw, scrh = ScrW(), ScrH()

	local DFrame1 = vgui.Create("DFrame")
	DFrame1:SetSize(scrw*.7, scrh*.35)
	DFrame1:SetTitle("Advanced System Npc Spawning - Edit")
	DFrame1:SetDraggable(true)
	DFrame1:ShowCloseButton(false)
	DFrame1:Center()
	DFrame1:MakePopup()
	DFrame1.Paint = function(self, w, h)
		DrawBlur( self, 6, 30 )
		draw.RoundedBox( 6, 0, 0, w, h, Color( 30, 30, 30, 120 ) )
	end

	local quit = vgui.Create( "DButton", DFrame1 )
	quit:SetSize( scrw*.03, scrh*.03 )
	quit:SetPos( scrw*.67, scrh*.01-04 )
	quit:SetText( "X" )
	quit:SetTextColor( Color( 255, 255, 255 ) )
	quit.Paint = function( self, w, h )
		draw.RoundedBox( 6, 0, 0, w, h, Color( 30, 30, 30, 120 ) )
	end
	quit.DoClick = function()
	    DFrame1:Close()
	end

	local DButton1 = vgui.Create( "DButton", DFrame1 )
	DButton1:SetSize( scrw*.05, scrh*.03 )
	DButton1:SetPos( scrw*.60, scrh*.01-04 )
	DButton1:SetText(Advanced.System.Npc.Respawning.Config.Back)
	DButton1:SetTextColor( Color( 255, 255, 255 ) )
	DButton1.Paint = function(p, w, h)
		draw.RoundedBox( 6, 0, 0, w, h, Color( 30, 30, 30, 120 ) )
		local flashing = 100 + math.abs( math.sin( CurTime() * 1.1 ) * 255 )
		surface.SetDrawColor( flashing, flashing, flashing, flashing )
		surface.DrawOutlinedRect( 0, 0, p:GetWide(), p:GetTall() ) 
	end
	DButton1.DoClick = function( pnl )
		LocalPlayer():ConCommand( "say /"..Advanced.System.Npc.Respawning.Config.CommandSay )
		DFrame1:Close()	
	end

	local Class = vgui.Create( "DTextEntry", DFrame1 )
	Class:SetPos( scrw*.02, scrh*.05 )
	Class:SetSize( scrw*.67, scrh*.04 )
	Class:SetText( "Class : "..class )

	local Position1 = vgui.Create( "DTextEntry", DFrame1 )
	Position1:SetPos( scrw*.02, scrh*.1 )
	Position1:SetSize( scrw*.67, scrh*.04 )
	Position1:SetText( "Position 1 : "..pos1 )

	local Position2 = vgui.Create( "DTextEntry", DFrame1 )
	Position2:SetPos( scrw*.02, scrh*.15 )
	Position2:SetSize( scrw*.67, scrh*.04 )
	Position2:SetText( "Position 2 : "..pos2 )

	local Angles1 = vgui.Create( "DTextEntry", DFrame1 )
	Angles1:SetPos( scrw*.02, scrh*.2 )
	Angles1:SetSize( scrw*.67, scrh*.04 )
	Angles1:SetText( "Angles 1 : "..ang1 )

	local Angles2 = vgui.Create( "DTextEntry", DFrame1 )
	Angles2:SetPos( scrw*.02, scrh*.25 )
	Angles2:SetSize( scrw*.67, scrh*.04 )
	Angles2:SetText( "Angles 2 : "..ang2 )

	local DButton1 = vgui.Create( "DButton", DFrame1 )
	DButton1:SetPos( scrw*.02, scrh*.3 )
	DButton1:SetSize( scrw*.67, scrh*.04 )
	DButton1:SetText(Advanced.System.Npc.Respawning.Config.Edit)
	DButton1:SetTextColor( Color( 255, 255, 255 ) )
	DButton1.Paint = function(p, w, h)
		draw.RoundedBox( 6, 0, 0, w, h, Color( 30, 30, 30, 120 ) )
		local flashing = 100 + math.abs( math.sin( CurTime() * 1.1 ) * 255 )
		surface.SetDrawColor( flashing, flashing, flashing, flashing )
		surface.DrawOutlinedRect( 0, 0, p:GetWide(), p:GetTall() ) 
	end
	DButton1.DoClick = function( pnl )
		if Class:GetText() == "" or Class:GetText() == "Class : "..class then return end
		if Position1:GetText() == "" or Position1:GetText() == "Position 1 : "..pos1 then return end
		if Position2:GetText() == "" or Position2:GetText() == "Position 2 : "..pos2 then return end
		if Angles1:GetText() == "" or Angles1:GetText() == "Angles 1 : "..ang1 then return end
		if Angles2:GetText() == "" or Angles2:GetText() == "Angles 2 : "..ang2 then return end
		net.Start( "Advanced:System:Npc:Respawning:Edit" )
		net.WriteUInt(k,2)
		net.WriteString(Class:GetText())
		net.WriteString(Position1:GetText())
		net.WriteString(Position2:GetText())
		net.WriteString(Angles1:GetText())
		net.WriteString(Angles2:GetText())
		net.SendToServer()
		DFrame1:Close()	
	end
end