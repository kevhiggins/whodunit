-- ENCOUNTER_START hook
local startEncounterFrame = CreateFrame("FRAME", "StartEncounterFrame");
startEncounterFrame:RegisterEvent("ENCOUNTER_START")

local function startEncounterHandler(self, eventName, ...)
    WhoDunIt.eventManager:startEncounter(...)
end

startEncounterFrame:SetScript("OnEvent", startEncounterHandler);


-- ENCOUNTER_END hook
local endEncounterFrame = CreateFrame("FRAME", "EndEncounterFrame");
endEncounterFrame:RegisterEvent("ENCOUNTER_END")

local function endEncounterHandler(self, eventName, ...)
    WhoDunIt.eventManager:endEncounter(...)
end

endEncounterFrame:SetScript("OnEvent", endEncounterHandler);

-- COMBAT_LOG_EVENT_UNFILTERED hook
local combagLogFrame = CreateFrame("FRAME", "CombatLogFrame");
combagLogFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

local function combagLogHandler(self, eventName, ...)
    WhoDunIt.eventManager:processCombatLog(...)
end

combagLogFrame:SetScript("OnEvent", combagLogHandler);