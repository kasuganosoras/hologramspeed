local DuiEntity
local DuiTxd
local DuiObj
local DuiHandle
local DuiLoaded = false
local Enabled = true
local IsDuiDisplayed = false
local carRPM, carSpeed, carGear, carIL, carAcceleration, carHandbrake, carBrakePressure, carBrakeAbs, carLS_r, carLS_o, carLS_h
local Profile
local ProfileInitialized = false

Citizen.CreateThread(function()
	InitProfile()
end)

Citizen.CreateThread(function()
	while ProfileInitialized == false do
		Citizen.Wait(100)
	end
	while true do
		Citizen.Wait(0)
		if Enabled then
			if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
				if IsDuiDisplayed then
					UpdateDui()
				else
					DisplayDui()
					IsDuiDisplayed = true
				end
			else
				if IsDuiDisplayed then
					HideDui()
					IsDuiDisplayed = false
				end
			end
		else
			HideDui()
			IsDuiDisplayed = false
		end
	end
end)

Citizen.CreateThread(function()
	while ProfileInitialized == false do
		Citizen.Wait(100)
	end
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(0, Profile.keyControl) then
			Enabled = not Enabled
			local CurrentStatus = Enabled and "^2On^0" or "^1Off^0"
			SendChatMessage("Your speedometer has been switched to " .. CurrentStatus)
		end
	end
end)

RegisterCommand('hsp', function(source, args)
	local cmd = args[1] or ''
	if cmd == 'mph' then
		Profile.useMph = not Profile.useMph
		SetPlayerProfile(Profile)
		local CurrentUnit = Profile.useMph and "^2MPH^0" or "^2KPH^0"
		SendChatMessage("Your speed unit has been switched to " .. CurrentUnit .. ", please restart your game to take effect")
	elseif cmd == 'nve' then
		Profile.useNve = not Profile.useNve
		SetPlayerProfile(Profile)
		local CurrentNve = Profile.useNve and "^2On^0" or "^1Off^0"
		SendChatMessage("Your NVE graphic mods has been switched to " .. CurrentNve .. ", please restart your game to take effect")
	else
		Enabled = not Enabled
		local CurrentStatus = Enabled and "^2On^0" or "^1Off^0"
		SendChatMessage("Your speedometer has been switched to " .. CurrentStatus)
	end
end, false)

function SendChatMessage(data)
	TriggerEvent('chat:addMessage', {
		args = { data }
	})
end

function InitProfile()
	Profile = GetPlayerProfile()
	if Profile.unit == nil then
		Profile.unit = Config.unit
	end
	if Profile.keyControl == nil then
		Profile.keyControl = Config.keyControl
	end
	if Profile.useNve == nil then
		Profile.useNve = Config.useNve
	end
	SetPlayerProfile(Profile)
	ProfileInitialized = true
end

function CreateHologramDui()
	print("Loading " .. Config.duiUrl)
	local urlHash = "#"
	local jsonTemp = {}
	if Profile.useMph then
		jsonTemp.unit = "MPH"
	else
		jsonTemp.unit = "KPH"
	end
	if Profile.useNve then
		jsonTemp.nve = true
	else
		jsonTemp.nve = false
	end
	urlHash = urlHash .. json.encode(jsonTemp)
	DuiTxd = CreateRuntimeTxd('DuiHologramTxd')
	DuiObj = CreateDui(Config.duiUrl .. urlHash, 512, 512)
	while not IsDuiAvailable(DuiObj) do
		Wait(100)
	end
	print("Successful create Dui")
	_G.DuiObj = DuiObj
	DuiHandle = GetDuiHandle(DuiObj)
	local tx5 = CreateRuntimeTextureFromDuiHandle(DuiTxd, 'DuiTexture', DuiHandle)
	print("Replace textures...")
	AddReplaceTexture('hologram_box_model', 'p_hologram_box', 'DuiHologramTxd', 'DuiTexture')
end

function DestroyHologramDui()
	DestroyDui(DuiObj)
end

function UpdateDui()
	
	if not DoesEntityExist(DuiEntity) then
		DisplayDui()
	end
	
	playerPed = GetPlayerPed(-1)
		
	if playerPed and IsDuiDisplayed then
		
		playerCar = GetVehiclePedIsIn(playerPed, false)
		
		if playerCar and GetPedInVehicleSeat(playerCar, -1) == playerPed then
			
			local NcarRPM                      = GetVehicleCurrentRpm(playerCar)
			local NcarSpeed                    = GetEntitySpeed(playerCar)
			local NcarGear                     = GetVehicleCurrentGear(playerCar)
			local NcarIL                       = GetVehicleIndicatorLights(playerCar)
			local NcarAcceleration             = IsControlPressed(0, 71)
			local NcarHandbrake                = GetVehicleHandbrake(playerCar)
			local NcarBrakePressure            = GetVehicleWheelBrakePressure(playerCar, 0)
			local NcarBrakeAbs                 = (GetVehicleWheelSpeed(playerCar, 0) == 0.0 and NcarSpeed > 0.0)
			local NcarLS_r, NcarLS_o, NcarLS_h = GetVehicleLightsState(playerCar)
			
			local shouldUpdate = false
			
			if NcarRPM ~= carRPM then
				shouldUpdate = true
			end
			if NcarSpeed ~= carSpeed then
				shouldUpdate = true
			end
			if NcarGear ~= carGear then
				shouldUpdate = true
			end
			if NcarIL ~= carIL then
				shouldUpdate = true
			end
			if NcarAcceleration ~= carAcceleration then
				shouldUpdate = true
			end
			if NcarHandbrake ~= carHandbrake then
				shouldUpdate = true
			end
			if NcarBrakePressure ~= carBrakePressure then
				shouldUpdate = true
			end
			if NcarBrakeAbs ~= carBrakeAbs then
				shouldUpdate = true
			end
			if NcarLS_r ~= carLS_r then
				shouldUpdate = true
			end
			if NcarLS_o ~= carLS_o then
				shouldUpdate = true
			end
			if NcarLS_h ~= carLS_h then
				shouldUpdate = true
			end
			
			if shouldUpdate then
				carRPM           = NcarRPM
				carGear          = NcarGear
				carSpeed         = NcarSpeed
				carIL            = NcarIL
				carAcceleration  = NcarAcceleration
				carHandbrake     = NcarHandbrake
				carBrakePressure = NcarBrakePressure
				carBrakeAbs      = NcarBrakeAbs
				carLS_r          = NcarLS_r
				carLS_o          = NcarLS_o
				carLS_h          = NcarLS_h
				
				if Profile.useMph then
					carCalcSpeed = math.ceil(carSpeed * 2.236936)
				else
					carCalcSpeed = math.ceil(carSpeed * 3.6)
				end
				
				SendDuiMessage(DuiObj, json.encode({
					ShowHud                = true,
					CurrentCarRPM          = carRPM,
					CurrentCarGear         = carGear,
					CurrentCarSpeed        = carCalcSpeed,
					CurrentCarIL           = carIL,
					CurrentCarAcceleration = carAcceleration,
					CurrentCarHandbrake    = carHandbrake,
					CurrentCarBrake        = carBrakePressure,
					CurrentCarAbs          = carBrakeAbs,
					CurrentCarLS_r         = carLS_r,
					CurrentCarLS_o         = carLS_o,
					CurrentCarLS_h         = carLS_h,
					PlayerID               = GetPlayerServerId(GetPlayerIndex())
				}))
			end
		elseif IsDuiDisplayed then
			SendDuiMessage(DuiObj, json.encode({HideHud = true}))
		end
		
		Wait(50)
	end
end

function HideDui()
	SetEntityAsNoLongerNeeded(DuiEntity)
	DeleteVehicle(DuiEntity)
	DeleteEntity(DuiEntity)
end

function DisplayDui()
	if not IsModelInCdimage(Config.modelName) or not IsModelAVehicle(Config.modelName) then
        TriggerEvent('chat:addMessage', {
            args = { 'Cannot find the model "' .. Config.modelName .. '", please make sure you install the plugin correctly' }
        })
        return
    end
	print("Creating model...")
    RequestModel(Config.modelName)
    while not HasModelLoaded(Config.modelName) do
        Citizen.Wait(500)
    end
	local pos       = GetEntityCoords(GetPlayerPed(-1))
	local playerCar = GetVehiclePedIsIn(GetPlayerPed(-1))
    DuiEntity = CreateVehicle(Config.modelName, pos.x, pos.y, pos.z, GetEntityHeading(GetPlayerPed(-1)), false, false)
	print("Setting entity status...")
	SetVehicleEngineOn(DuiEntity, true, true)
	SetVehicleDoorsLockedForAllPlayers(DuiEntity, true)
	print("Attach to entity...")
	local EntityBone = GetEntityBoneIndexByName(playerCar, "chassis")
	local BindPos = {x = 2.5, y = -1.0, z = 0.85}
	AttachEntityToEntity(DuiEntity, playerCar, EntityBone, BindPos.x, BindPos.y, BindPos.z, 0.0, 0.0, -15.0, false, false, false, false, false, true)
	Citizen.Wait(200)
	if not DuiLoaded then
		print("Creating Dui...")
		CreateHologramDui()
		DuiLoaded = true
	end
end

function GetPlayerProfile()
	local kvpData = GetResourceKvpString("HologramProfile")
	if kvpData ~= nil then
		return json.decode(kvpData)
	else
		return {}
	end
end

function SetPlayerProfile(data)
	SetResourceKvp("HologramProfile", json.encode(data))
end
