--local frame = CreateFrame("FRAME", "FooAddonFrame");
--frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
--local function eventHandler(self, event, ...)
--    local eventData = { ... };
--    local eventName = eventData[2]
--
--    if event == "ENCOUNTER_START" then
--        print(inspect(eventData))
--    end
--
--    if eventName == 'ENCOUNTER_START' then
--        print(inspect(eventData))
--    end
--    --print arg.n
--    --    print("Hello World! Hello " .. event);
--end
--
--frame:SetScript("OnEvent", eventHandler);

local startEncounterFrame = CreateFrame("FRAME", "StartEncounterFrame");
startEncounterFrame:RegisterEvent("ENCOUNTER_START")
startEncounterFrame:SetScript("OnEvent", WhoDunIt.eventManager.startEncounter);