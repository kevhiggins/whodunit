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
    for attemptId, attempt in pairs(self.attempts) do
        print("Attempt #" .. attemptId .. " fails:")
        for mechanicId, failGroup in pairs(attempt) do
            local guidFails = {}
            print(failGroup:getMechanic():getName())
            for key, fail in pairs(failGroup:getFails()) do
                for key, guid in pairs(fail.guidList) do
                    if guidFails[guid] == nill then
                        guidFails[guid] = 1
                    else
                        guidFails[guid] = guidFails[guid] + 1
                    end
                end
            end

            -- Print fail summaries for mechanic
            for guid, failCount in pairs(guidFails) do
                print(guid .. " - " .. failCount)
            end
        end
    end
end

WhoDunIt.failManager = FailManager