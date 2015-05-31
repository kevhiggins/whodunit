local frame = CreateFrame("FRAME", "FooAddonFrame");
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
local function eventHandler(self, event, ...)
        print(inspect({ ... }))
    --print arg.n
--    print("Hello World! Hello " .. event);
end

frame:SetScript("OnEvent", eventHandler);