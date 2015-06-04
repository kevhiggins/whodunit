-- ENCOUNTER_START hook
local startEncounterFrame = CreateFrame("FRAME");
startEncounterFrame:RegisterEvent("ENCOUNTER_START")

local function startEncounterHandler(self, eventName, ...)
    WhoDunIt.eventManager:startEncounter(...)
end

startEncounterFrame:SetScript("OnEvent", startEncounterHandler);


-- ENCOUNTER_END hook
local endEncounterFrame = CreateFrame("FRAME");
endEncounterFrame:RegisterEvent("ENCOUNTER_END")

local function endEncounterHandler(self, eventName, ...)
    WhoDunIt.eventManager:endEncounter(...)
end

endEncounterFrame:SetScript("OnEvent", endEncounterHandler);

-- COMBAT_LOG_EVENT_UNFILTERED hook
local combagLogFrame = CreateFrame("FRAME");
combagLogFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

local function combagLogHandler(self, eventName, ...)
    WhoDunIt.eventManager:processCombatLog(...)
end

combagLogFrame:SetScript("OnEvent", combagLogHandler);

local AceGUI = LibStub("AceGUI-3.0")

-- SLASH command hook
SLASH_WHODUNIT1 = '/whodunit'; -- 3.
function SlashCmdList.WHODUNIT(msg, editbox)
    -- TODO
    -- Create a frame
    -- Make sure the frame is scrollable
    -- Update frame with the result of FailManager display
    local frame = scrollFrame()
    frame.text = frame:CreateFontString(nil, "BACKGROUND", "PVPInfoTextFont");

    local function onUpdate(self, elapsed)

    end

    local e = 0
    frame:SetScript("OnUpdate", function(self, elapsed)
        e = e + elapsed
        if e >= 0.5 then
            e = 0
            return onUpdate(self, elapsed)
        end
    end)
    end

    function sillyFrame()
        --parent frame
        local MOD_TextFrame = CreateFrame("Frame");
        --    MOD_TextFrame:ClearAllPoints();
        MOD_TextFrame:SetHeight(300);
        MOD_TextFrame:SetWidth(300);
        --    MOD_TextFrame:Hide();
        MOD_TextFrame.text = MOD_TextFrame:CreateFontString(nil, "BACKGROUND", "PVPInfoTextFont");
        MOD_TextFrame.text:SetAllPoints();
        MOD_TextFrame:SetPoint("CENTER", 0, 200);
        --    MOD_TextFrameTime = 0;


        local function MOD_TextMessage(message)
            MOD_TextFrame.text:SetText(message);
            --        MOD_TextFrame:SetAlpha(1);
            --        MOD_TextFrame:Show();
            --        MOD_TextFrameTime = GetTime();
        end

        MOD_TextMessage("RAWR")
    end

    function scrollFrame()
        --parent frame
        local frame = CreateFrame("Frame", "MyFrame", UIParent)
        frame:SetSize(220, 200)
        frame:SetPoint("CENTER")
        local texture = frame:CreateTexture()
        texture:SetAllPoints()
        texture:SetTexture(0, 0, 0, 0.6)
        frame.background = texture

        --scrollframe
        local scrollframe = CreateFrame("ScrollFrame", nil, frame)
        scrollframe:SetPoint("TOPLEFT", 10, -10)
        scrollframe:SetPoint("BOTTOMRIGHT", -10, 10)
        --    local texture = scrollframe:CreateTexture()
        --    texture:SetAllPoints()
        --    texture:SetTexture(0, 0, 0, 0.4)
        --    frame.scrollframe = scrollframe

        --scrollbar
        local scrollbar = CreateFrame("Slider", nil, scrollframe, "UIPanelScrollBarTemplate")
        scrollbar:SetPoint("TOPLEFT", frame, "TOPRIGHT", 4, -16)
        scrollbar:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 4, 16)
        scrollbar:SetMinMaxValues(1, 200)
        scrollbar:SetValueStep(1)
        scrollbar.scrollStep = 1
        scrollbar:SetValue(0)
        scrollbar:SetWidth(16)
        scrollbar:SetScript("OnValueChanged",
            function(self, value)
                self:GetParent():SetVerticalScroll(value)
            end)
        local scrollbg = scrollbar:CreateTexture(nil, "BACKGROUND")
        scrollbg:SetAllPoints(scrollbar)
        scrollbg:SetTexture(0, 0, 0, 0.4)
        frame.scrollbar = scrollbar

        --content frame
        local content = CreateFrame("Frame", nil, scrollframe)
        content:SetSize(128, 128)
        --    local texture = content:CreateTexture()
        --    texture:SetAllPoints()
        --    texture:SetTexture("Interface\\GLUES\\MainMenu\\Glues-BlizzardLogo")
        --    content.texture = texture
        scrollframe.content = content

        scrollframe:SetScrollChild(content)

        frame:SetMovable(true)
        frame:EnableMouse(true)
        frame:RegisterForDrag("LeftButton")
        frame:SetScript("OnDragStart", frame.StartMoving)
        frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

        return frame
    end

    function runTestData()
        WhoDunIt.eventManager:startEncounter(unpack({ 1689, "Flamebender Ka'graz", 15, 15 }))

        for key, value in pairs(testData) do
            WhoDunIt.eventManager:processCombatLog(unpack(value))
        end

        WhoDunIt.eventManager:endEncounter(unpack({ 1689, "Flamebender Ka'graz", 15, 15, 0 }))

        WhoDunIt.failManager:display()
    end

    function test()
    end

