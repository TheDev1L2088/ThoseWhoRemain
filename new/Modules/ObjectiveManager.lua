wait()

----------------------------------------------
--// Variables

local Workspace = game:GetService('Workspace')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local RunService = game:GetService('RunService')
local Players = game:GetService('Players')
local Player = Players.LocalPlayer

local YWR = _G.YWR
local ObjectiveFolder, ObjectiveEntities = YWR.ObjectiveFolder, YWR.EntityObjectives

----------------------------------------------
--// Load objectives

local Objectives = {
    --['Tundra'] = 'Car',
    --['Silverado'] = 'Car',

    ['Ammo'] = 'Sit',
    ['Medical'] = 'Sit',
    ['Radio'] = 'Sit',

    ['Bus'] = 'Bus',

    ['EscortChar'] = 'Escort',

    ['Fuel Truck'] = 'Truck',
}

local ObjectiveFunctions = {} -- acts as cache
for i, Name in pairs(Objectives) do -- loads all objective functions
    if not ObjectiveFunctions[Name] then
        ObjectiveFunctions[Name] = _G.Import('Modules/Objectives/' .. Name)
    end
    Objectives[i] = ObjectiveFunctions[Name]
end

----------------------------------------------
--// Main

local GetObjective = function()
    local Objective

    local PossibleObjectives = {}
    for _, Object in pairs(ObjectiveFolder:GetChildren()) do
        table.insert(PossibleObjectives, Object)
    end
    for _, Object in pairs(ObjectiveEntities:GetChildren()) do
        table.insert(PossibleObjectives, Object)
    end

    table.foreach(PossibleObjectives, print)

    for _, Object in pairs(PossibleObjectives) do
        local Data = Objectives[Object.Name]
        if Data and Data.Load() then
            if Data.Check(Object) then
                Objective = {Data, Object}
                break
            else
                warn(Object.Name, 'Failed check')
            end
        end
    end

    return Objective
end

----------------------------------------------

warn('ObjectiveManager loaded.')
return GetObjective