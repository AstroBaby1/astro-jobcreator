local QBCore = exports['qb-core']:GetCoreObject()

RegisterCommand('createjob', function(source, args, rawCommand)
    if QBCore.Functions.HasPermission(source, 'admin') then
        local bossId = tonumber(args[1])
        local jobName = args[2]
        local gradesLimit = tonumber(args[3])
        local path = GetResourcePath(GetCurrentResourceName())

        if bossId and jobName and gradesLimit and gradesLimit > 0 and gradesLimit <= 4 then
            -- Create the job file
            local jobFileName = jobName .. '.lua'
            local jobFilePath = path .. '/jobs/' .. jobFileName
            
            local jobFileContent = "local QBCore = exports['qb-core']:GetCoreObject()\n\nexports['qb-core']:AddJob('" .. jobName .. "', {\n"
            jobFileContent = jobFileContent .. "    label = '" .. jobName .. "',\n"
            jobFileContent = jobFileContent .. "    defaultDuty = true,\n"
            jobFileContent = jobFileContent .. "    offDutyPay = false,\n"
            jobFileContent = jobFileContent .. "    grades = {\n"
            for i = 0, gradesLimit do
                local gradeName = i == 4 and "Chief" or jobName .. " " .. i
                local isBoss = i == 4 and "true" or "false"
                jobFileContent = jobFileContent .. "        ['" .. i .. "'] = {\n"
                jobFileContent = jobFileContent .. "            name = '" .. gradeName .. "',\n"
                jobFileContent = jobFileContent .. "            isboss = " .. isBoss .. ",\n"
                jobFileContent = jobFileContent .. "            payment = 10\n"
                jobFileContent = jobFileContent .. "        },\n"
            end
            jobFileContent = jobFileContent .. "    }\n"
            jobFileContent = jobFileContent .. "})\n"
            
            local file = io.open(jobFilePath, 'w')
            file:write(jobFileContent)
            file:close()
            
            -- Add the job to QBcore
            for i = 0, gradesLimit do
                local jobGrade = jobName .. i
                local gradeName = i == 4 and "Chief" or jobName .. " " .. i
                local isBoss = i == 4 and true or false
                exports['qb-core']:AddJob(jobGrade, gradeName, bossId, isBoss)
            end
            
            -- Send a confirmation message
            TriggerClientEvent('chat:addMessage', source, {
                color = {255, 255, 255},
                multiline = true,
                args = {'Job Creator', 'Job ' .. jobName .. ' created successfully.'}
            })
        else
            TriggerClientEvent('chat:addMessage', source, {
                color = {255, 0, 0},
                multiline = true,
                args = {'Job Creator', 'Invalid arguments. Usage: /createjob <bossId> <jobName> <gradesLimit (max 4)>'}
            })
        end
    end
end)

RegisterServerEvent('saveCoords')
AddEventHandler('saveCoords', function(type, coords)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    -- Load current contents of file
    local file = LoadResourceFile(GetCurrentResourceName(), 'coords.json')
    local jobName = Player.PlayerData.job.name
    -- Decode contents to a Lua table
    local data = json.decode(file)

    -- Create sub-object for job if it doesn't exist
    if not data[jobName] then
        data[jobName] = {
            stash = {},
            garage = {}
        }
    end

    -- Update the appropriate coordinate values based on the job name and type
    if type == 'stash' then
        data[jobName].stash = coords
    elseif type == 'garage' then
        data[jobName].garage = coords
    end

    -- Encode the updated table to a JSON string
    local newFile = json.encode(data)

    -- Save the updated JSON string to the file
    SaveResourceFile(GetCurrentResourceName(), 'coords.json', newFile, -1)
end)
-- Define callback to get job's coordinates
QBCore.Functions.CreateCallback('GetCurrentJobStashCoords', function(source, cb, jobName)
    local file = LoadResourceFile(GetCurrentResourceName(), 'coords.json')
    local data = json.decode(file)
    local stashCoords = data[jobName].stash

    cb(stashCoords)
end)
