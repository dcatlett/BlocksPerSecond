-- Namespace
BlocksPerSecond = {}
BlocksPerSecond.name = "BlocksPerSecond"
 
-- Initialization
function BlocksPerSecond:Initialize()
	--Event Manager for when combat starts
		--Starts a timer
		--Event Manager for when block
			--Increases block counter
		--Displays blockCounter/timer
end
 
-- EVENT_ADD_ON_LOADED
function BlocksPerSecond.OnAddOnLoaded(event, addonName)
  -- Limit to this addon
  if addonName == BlocksPerSecond.name then
    BlocksPerSecond:Initialize()
  end
end
 
-- Finally, we'll register our event handler function to be called when the proper event occurs.
EVENT_MANAGER:RegisterForEvent(BlocksPerSecond.name, EVENT_ADD_ON_LOADED, BlocksPerSecond.OnAddOnLoaded)