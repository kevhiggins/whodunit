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

-- TODO Might want to have a configuration for when to start ignoring events.
function FailManager:display()
    local output = WhoDunIt.eol
    for attemptId, attempt in pairs(self.attempts) do
        output = output .. "Attempt #" .. attemptId .. " fails:" .. WhoDunIt.eol
        for mechanicId, failGroup in pairs(attempt) do
            output = output .. failGroup:getMechanic():getName() .. WhoDunIt.eol
            output = output .. failGroup:getMechanic():render(failGroup)
            output = output .. WhoDunIt.eol
        end
    end
    return output
end

WhoDunIt.failManager = FailManager