wait()

----------------------------------------------
--// Variables

local Workspace = game:GetService('Workspace')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local RunService = game:GetService('RunService')
local Players = game:GetService('Players')
local Player = Players.LocalPlayer

local YWR = _G.YWR

----------------------------------------------

local Objectives = {
    ['Tundra'] = 'Car',
    ['Silverado'] = 'Car',

    ['Ammo'] = 'Sit',
    ['Medical'] = 'Sit',
    ['Radio'] = 'Sit',

    ['Bus'] = 'Bus',

    ['EscortChar'] = 'Escort',

    ['Fuel Truck'] = 'Truck',
}

local ObjectiveFunctions = {} -- acts as cache
for i, Name in pairs(Objectives) do
    if not ObjectiveFunctions[Name] then
        ObjectiveFunctions[Name] = _G.Import('Modules/Objectives/' .. Name)
    end
    Objectives[i] = ObjectiveFunctions[Name]
end

----------------------------------------------

warn('ObjectiveManager loaded.')
return Objectives