Advanced = Advanced or {}
Advanced.System = Advanced.System or {}
Advanced.System.Npc = Advanced.System.Npc or {}
Advanced.System.Npc.Respawning = Advanced.System.Npc.Respawning or {}
Advanced.System.Npc.Respawning.Config = Advanced.System.Npc.Respawning.Config or {}

-- Language
Advanced.System.Npc.Respawning.Config.SelectedLanguage = "en" -- en = english , fr = french

-- commands in chat ( ! and / )
Advanced.System.Npc.Respawning.Config.CommandSay = "adnpcrp"

-- Group have acces a command
Advanced.System.Npc.Respawning.Config.GroupAccess = { ["superadmin"] = true, ["admin"] = false }

-- Time for delete/respawn
Advanced.System.Npc.Respawning.Config.TimeRespawning = 3600 -- 3600 = 1h

-- Language Config :

if (Advanced.System.Npc.Respawning.Config.SelectedLanguage == "en") then

	Advanced.System.Npc.Respawning.Config.Close = "X"

	Advanced.System.Npc.Respawning.Config.Add = "Add ?"

	Advanced.System.Npc.Respawning.Config.Edit = "Edit ?"

	Advanced.System.Npc.Respawning.Config.Refresh = "Refresh ?"

	Advanced.System.Npc.Respawning.Config.Remove = "Remove ?"

	Advanced.System.Npc.Respawning.Config.Back = "Back ?"

	Advanced.System.Npc.Respawning.Config.RefreshNotify = "The entities have been respawn! [Advanced Npc Respawning System]"

	Advanced.System.Npc.Respawning.Config.AddNotify = "[Advanced Npc Respawning System] You just added : "

	Advanced.System.Npc.Respawning.Config.EditNotify = "[Advanced Npc Respawning System] You just edit : "

	Advanced.System.Npc.Respawning.Config.DeleteNotify = "[Advanced Npc Respawning System] You have just deleted : "

elseif (Advanced.System.Npc.Respawning.Config.SelectedLanguage == "fr") then

	Advanced.System.Npc.Respawning.Config.Close = "X"

	Advanced.System.Npc.Respawning.Config.Add = "Ajouter ?"

	Advanced.System.Npc.Respawning.Config.Edit = "Modifier ?"

	Advanced.System.Npc.Respawning.Config.Refresh = "Actualiser ?"

	Advanced.System.Npc.Respawning.Config.Remove = "Supprimer ?"

	Advanced.System.Npc.Respawning.Config.Back = "Retour ?"

	Advanced.System.Npc.Respawning.Config.RefreshNotify = "Les entités ont été respawn! [Advanced Npc Respawning System]"

	Advanced.System.Npc.Respawning.Config.AddNotify = "[Advanced Npc Respawning System] Tu viens d'ajouter : "

	Advanced.System.Npc.Respawning.Config.EditNotify = "[Advanced Npc Respawning System] Vous venez d'éditer : "

	Advanced.System.Npc.Respawning.Config.DeleteNotify = "[Advanced Npc Respawning System] Tu viens de supprimer : "

end