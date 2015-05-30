local FailManager = {
    attempts = {}
}

-- Data stored as AttemptId -> mechanicId -> fail data array
function FailManager:logFail(fail)
    local attemptId = WhoDunIt.eventManager:getAttemptId()

    -- Consider moving these structures into classes
    local attempt = self.attempts[attemptId]
    if attempt == nil then
        attempt = {}
        self.attempts[attemptId] = attempt
    end

    local mechanicId = fail.mechanic:getId()
    local failGroup = attempt[mechanicId]
    if failGroup == nil then
        failGroup = WhoDunIt.FailGroup:new(fail.mechanic)
        attempt[mechanicId] = failGroup
    end

    failGroup:addFail(fail)
end

function FailManager:display()
    print("")

    for attemptId, attempt in pairs(self.attempts) do
        print("Attempt #" .. attemptId .. " fails:\n")
        for mechanicId, failGroup in pairs(attempt) do
            local unitFails = {}
            print(failGroup:getMechanic():getName())
            for key, fail in pairs(failGroup:getFails()) do
                for key, unit in pairs(fail.unitList) do
                    if unitFails[unit.guid] == nill then
                        unitFails[unit.guid] = 1
                    else
                        unitFails[unit.guid] = unitFails[unit.guid] + 1
                    end
                end
            end

            -- Print fail summaries for mechanic
            for guid, failCount in pairs(unitFails) do
                local unit = WhoDunIt.Unit:find(guid)
                print(unit.name .. " - " .. failCount)
            end
            print("")
        end
    end
end

WhoDunIt.failManager = FailManager