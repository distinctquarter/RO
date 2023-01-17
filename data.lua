
local Data = {}
local DataFunctions = {}
local Http = game:GetService("HttpService")

function Data.new(data)
	if not isfolder("kazhub/"..game.PlaceId.."-"..get.MarketplaceService:GetProductInfo(game.PlaceId).Name) then
		makefolder("kazhub/"..game.PlaceId.."-"..get.MarketplaceService:GetProductInfo(game.PlaceId).Name)
	end

    local savedData = isfile("kazhub/"..game.PlaceId.."-"..get.MarketplaceService:GetProductInfo(game.PlaceId).Name.."/settings.json") and Http:JSONDecode(readfile("kazhub/"..game.PlaceId.."-"..get.MarketplaceService:GetProductInfo(game.PlaceId).Name.."/Settings.json"))
    
    if savedData then
        for i,v in pairs(data) do
            if not savedData[i] then
                savedData[i] = v
            end
        end
    end

	return setmetatable({
		Data = savedData or data,
		FolderName = "kazhub/"..game.PlaceId.."-"..get.MarketplaceService:GetProductInfo(game.PlaceId).Name
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
