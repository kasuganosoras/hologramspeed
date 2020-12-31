local resourceName = GetCurrentResourceName()
local lowerCaseName = string.lower(resourceName)
if lowerCaseName ~= resourceName then
	print(string.format("\n^1Please rename the resource %s to %s or a similar name with ^8no^1 capital letters.^7\nDue to NUI restrictions, the resource will ^1not^7 work until you do this!!!\n", resourceName, lowerCaseName))
else
	SetConvarReplicated("hsp_defaultTheme", "default")
end