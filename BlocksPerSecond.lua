-- Namespace
BlocksPerSecond = {}
BlocksPerSecond.name = "BlocksPerSecond"
BlocksPerSecond.blockCounter = 0
BlocksPerSecond.combatStart = 0
 
-- Initialization
function BlocksPerSecond:Initialize()
	--Bool of whether player is in combat or not
	BlocksPerSecond.inCombat = IsUnitInCombat("player")
	--Event manager for combat state changing
	EVENT_MANAGER:RegisterForEvent(self.name, EVENT_PLAYER_COMBAT_STATE, self.OnPlayerCombatState)
end
 
 --[[
 function BlocksPerSecond.OnPlayerCombatState(event, inCombat)
  -- The ~= operator is "not equal to" in Lua.
  if inCombat ~= BlocksPerSecond.inCombat then
    -- The player's state has changed. Update the stored state...
    BlocksPerSecond.inCombat = inCombat
 
    -- ...and then announce the change.
    if inCombat then
      d("Entering combat.")
    else
      d("Exiting combat.")
    end
 
  end
end
 ]]
 
 --Called when combat state changes
 ---[[
 function BlocksPerSecond.OnPlayerCombatState(event, inCombat)
	--Check if players combat state has changed
	if inCombat ~= BlocksPerSecond.inCombat then
		BlocksPerSecond.inCombat = inCombat
	end
	
	if inCombat then
		--Starts the timer when combat starts
		BlocksPerSecond.combatStart = GetGameTimeMilliseconds()
		--Event Manager for when block
		EVENT_MANAGER:RegisterForEvent(BlocksPerSecond.name, EVENT_COMBAT_EVENT, BlocksPerSecond.IncrementBlock)
	else
		--Ends timer when combat ends
		BlocksPerSecond.combatEnd = GetGameTimeMilliseconds()
		d("Blocks: " .. BlocksPerSecond.blockCounter)
		BlocksPerSecond.totalTime = BlocksPerSecond.combatEnd - BlocksPerSecond.combatStart
		BlocksPerSecond.totalTime = BlocksPerSecond.totalTime/1000
		d("Time:  " .. BlocksPerSecond.totalTime)
		d("BPS: " .. BlocksPerSecond.blockCounter/BlocksPerSecond.totalTime)
		--Reset counter
		BlocksPerSecond.blockCounter = 0
	end
 end
 --]]
 
 function BlocksPerSecond.IncrementBlock(eventCode,result,isError,abilityName,abilityGraphic,abilityActionSlotType,sourceName,sourceType,targetName,targetType,hitValue,powerType,damageType,combatEventLog,sourceUnitId,targetUnitId,abilityId)
	--Triggers if the result was blocked by player
	if result == ACTION_RESULT_BLOCKED_DAMAGE then
		--d("Block")
		BlocksPerSecond.blockCounter = BlocksPerSecond.blockCounter + 1
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