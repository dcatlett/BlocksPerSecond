-- Namespace
BlocksPerSecond = {}
BlocksPerSecond.name = "BlocksPerSecond"
BlocksPerSecond.inCombat = IsUnitInCombat("player") --Bool of whether player is in combat or not
BlocksPerSecond.blockCounter = 0
 
-- Initialization
function BlocksPerSecond:Initialize()
	--Calls OnCombatStart when player's combat state changes
	EVENT_MANAGER:RegisterForEvent(BlocksPerSecond.name, EVENT_PLAYER_COMBAT_STATE, BlocksPerSecond.OnCombatStart)
end
 
 --Main loop
 function BlocksPerSecond:OnCombatStart()
	local timems = GetGameTimeMilliseconds()
	if BlocksPerSecond.inCombat == true
		--Starts the timer when combat starts
		local combatStart = timems
		--Event Manager for when block
		EVENT_MANAGER:RegisterForEvent(BlocksPerSecond.name, EVENT_COMBAT_EVENT, BlocksPerSecond.IncrementBlock)
		--Displays blockCounter/timer
	else
		--Ends timer when combat ends
		local combatEnd = timems
	end
 end
 
 function BlocksPerSecond:IncrementBlock(eventCode,result,isError,abilityName,abilityGraphic,abilityActionSlotType,sourceName,sourceType,targetName,targetType,hitValue,powerType,damageType,combatEventLog,sourceUnitId,targetUnitId,abilityId)
	--Triggers if the result was blocked by player
	if result == ACTION_RESULT_BLOCKED
		if targetName == "player"
			BlocksPerSecond.blockCounter = BlocksPerSecond.blockCounter + 1
		end
	end
 end
 
-- EVENT_ADD_ON_LOADED
function BlocksPerSecond.OnAddOnLoaded(event, addonName)
  -- Limit to this addon
  if addonName == BlocksPerSecond.name then
    BlocksPerSecond:Initialize()
  end
end
 
-- Event Manager for loading addons
EVENT_MANAGER:RegisterForEvent(BlocksPerSecond.name, EVENT_ADD_ON_LOADED, BlocksPerSecond.OnAddOnLoaded)