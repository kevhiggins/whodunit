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
--    runTestData()
    -- TODO
    -- Create a frame
    -- Make sure the frame is scrollable
    -- Update frame with the result of FailManager display
    local frame, bodyFrame, scrollFrame, content, scrollBar = scrollFrame()
--    frame.text = frame:CreateFontString(nil, "BACKGROUND", "PVPInfoTextFont");

    local function onUpdate(self, elapsed)
        self.text:SetText(WhoDunIt.failManager:display())
        -- TODO it looks like this gives too much space. Figure out why
        scrollBar:SetMinMaxValues(1, self.text:GetHeight())
    end

    local e = 0
    bodyFrame:SetScript("OnUpdate", function(self, elapsed)
        e = e + elapsed
        if e >= 0.5 then
            e = 0
            return onUpdate(self, elapsed)
        end
    end)
    end

    function scrollFrame()
        -- Create the root frame
        local frame = CreateFrame("Frame", "MyFrame", UIParent)
        frame:SetSize(220, 200)
        frame:SetPoint("CENTER")

        -- Create the menu bar
        local menuBar = CreateFrame("Frame", "WhoDunIt_Menu_Bar", frame)
        menuBar:SetSize(220, 25)
        menuBar:SetPoint("TOPLEFT", 0, 0)
        local menuBarTexture = menuBar:CreateTexture()
        menuBarTexture:SetAllPoints()
        menuBarTexture:SetTexture(.25, .41, .88, 1)

        -- Create the scroll frame
        local scrollframe = CreateFrame("ScrollFrame", nil, frame)
        scrollframe:SetPoint("TOPLEFT", 0, -25)
        scrollframe:SetPoint("BOTTOMRIGHT", 0, 0)

        -- Create the content background TODO move this to the content frame
        local texture = scrollframe:CreateTexture()
        texture:SetAllPoints()
        texture:SetTexture(0, 0, 0, 0.6)

        --    local texture = scrollframe:CreateTexture()
        --    texture:SetAllPoints()
        --    texture:SetTexture(0, 0, 0, 0.4)
        --    frame.scrollframe = scrollframe

        -- Scroll bar
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

        -- Content frame
        local content = CreateFrame("Frame", nil, scrollframe)
        content:SetPoint("TOPLEFT", 0, 0)
        content:SetSize(220, 500)

        local body = CreateFrame("Frame", nil, content)
        body:SetPoint("TOPLEFT", 5, -5)
        body:SetPoint("BOTTOMRIGHT", 0, 0)

--        content.background = texture


--            local texture = content:CreateTexture()
--            texture:SetAllPoints()
--            texture:SetTexture("Interface\\GLUES\\MainMenu\\Glues-BlizzardLogo")
--            content.texture = texture

        local text = body:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        text:SetPoint("TOPLEFT", 0, 0)
        text:SetTextColor(1, 1, 1)
        text:SetText("AWOO")
        body.text = text



        scrollframe.content = content
        scrollframe:SetScrollChild(content)

        frame:SetMovable(true)
        frame:EnableMouse(true)
        frame:RegisterForDrag("LeftButton")
        frame:SetScript("OnDragStart", frame.StartMoving)
        frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

        return frame, body, scrollframe, content, scrollbar
    end

    function runTestData()
        WhoDunIt.eventManager:startEncounter(unpack({ 1689, "Flamebender Ka'graz", 15, 15 }))

        for key, value in pairs(testData) do
            WhoDunIt.eventManager:processCombatLog(unpack(value))
        end

        WhoDunIt.eventManager:endEncounter(unpack({ 1689, "Flamebender Ka'graz", 15, 15, 0 }))
    end

    function test()
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