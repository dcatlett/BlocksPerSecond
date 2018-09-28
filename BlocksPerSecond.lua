-- Namespace
BlocksPerSecond = {}
BlocksPerSecond.name = "BlocksPerSecond"
BlocksPerSecond.blockCounter = 0
 
-- Initialization
function BlocksPerSecond:Initialize()
	--Bool of whether player is in combat or not
	BlocksPerSecond.inCombat = IsUnitInCombat("player")
	--Event manager for combat state changing
	EVENT_MANAGER:RegisterForEvent(self.name, EVENT_PLAYER_COMBAT_STATE, self.OnPlayerCombatState)
end
 
 --Called when combat state changes
 function BlocksPerSecond:OnPlayerCombatState(event, inCombat)
	local BlocksPerSecond.CurrentFight = {} --Initializes a new object to hold current fights data
	CurrentFight.timems = GetGameTimeMilliseconds()
	--Check if players combat state has changed
	if inCombat ~= BlocksPerSecond.inCombat then
		BlocksPerSecond.inCombat = inCombat
	end
	
	if inCombat then
		--Starts the timer when combat starts
		CurrentFight.combatStart = CurrentFight.timems
		--Event Manager for when block
		EVENT_MANAGER:RegisterForEvent(BlocksPerSecond.name, EVENT_COMBAT_EVENT, BlocksPerSecond.IncrementBlock)
	else
		--Ends timer when combat ends
		CurrentFight.combatEnd = CurrentFight.timems
	end
 end
 
 function BlocksPerSecond:IncrementBlock(eventCode,result,isError,abilityName,abilityGraphic,abilityActionSlotType,sourceName,sourceType,targetName,targetType,hitValue,powerType,damageType,combatEventLog,sourceUnitId,targetUnitId,abilityId)
	--Triggers if the result was blocked by player
	if result == ACTION_RESULT_BLOCKED_DAMAGE then
		if targetName == "player" then
			BlocksPerSecond.blockCounter = BlocksPerSecond.blockCounter + 1
			d("Block")
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