local get = setmetatable({}, {__index = function(a, b) return game:GetService(b) or game[b] end})

local Data = {}
local DataFunctions = {}
local Http = game:GetService("HttpService")

function Data.new(data)
	if not isfolder("kazhub/"..game.PlaceId) then
		makefolder("kazhub/"..game.PlaceId)
	end

    local savedData = isfile("kazhub/"..game.PlaceId.."/Settings.json") and Http:JSONDecode(readfile("kazhub/"..game.PlaceId.."/Settings.json"))
    
    if savedData then
        for i,v in pairs(data) do
            if not savedData[i] then
                savedData[i] = v
            end
        end
    end

	return setmetatable({
		Data = savedData or data,
		FolderName = "kazhub/"..game.PlaceId
	}, {
		__index = DataFunctions
	})
end

function DataFunctions:Set(name, value)
	self.Data[name] = value
	writefile(self.FolderName.."/Settings.json", Http:JSONEncode(self.Data))
end

function DataFunctions:Get(name)
	return self.Data[name]
end

return Data
