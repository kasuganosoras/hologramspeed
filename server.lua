RegisterServerEvent('HologramSpeed:CheckTheme')

local resourceName = GetCurrentResourceName()
local lowerCaseName = string.lower(resourceName)
if lowerCaseName ~= resourceName then
	print(string.format("\n^1Please rename the resource %s to %s or a similar name with ^8no^1 capital letters.^7\nDue to NUI restrictions, the resource will ^1not^7 work until you do this!!!\n", resourceName, lowerCaseName))
else
	SetConvarReplicated("hsp_defaultTheme", "default")
end

AddEventHandler('HologramSpeed:CheckTheme', function(theme)
	local netID = source
	if theme == 'default' then
		TriggerClientEvent('HologramSpeed:SetTheme', netID, theme)
	elseif string.match(theme, '(%w+)') then
		local path = string.format("%s/ui/css/themes/%s.css", GetResourcePath(GetCurrentResourceName()), theme)
		local file = io.open(path,"r")
		if file ~= nil then
			io.close(file)
			TriggerClientEvent('HologramSpeed:SetTheme', netID, theme)
		else
			TriggerClientEvent('chat:addMessage', netID, {args = {"Cannot find the theme ^1" .. theme .. "^r!"}})
		end
	else
		TriggerClientEvent('chat:addMessage', netID, {args = {"Invalid theme name ^1" .. theme .. "^r!"}})
	end
end)
