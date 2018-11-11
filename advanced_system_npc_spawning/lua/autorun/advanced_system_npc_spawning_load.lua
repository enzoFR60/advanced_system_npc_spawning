if SERVER then

    AddCSLuaFile( 'advanced_system_npc_spawning/config/sh_advanced_system_npc_spawning.lua' )
    AddCSLuaFile( 'advanced_system_npc_spawning/client/cl_advanced_system_npc_spawning.lua' )


    include( 'advanced_system_npc_spawning/config/sh_advanced_system_npc_spawning.lua' )
	include( 'advanced_system_npc_spawning/server/sv_advanced_system_npc_spawning.lua' )
else
    include( 'advanced_system_npc_spawning/config/sh_advanced_system_npc_spawning.lua' )
	
	include( 'advanced_system_npc_spawning/client/cl_advanced_system_npc_spawning.lua' )
end