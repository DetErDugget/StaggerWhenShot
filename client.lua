local weaponsList = {
	453432689,
	2017895192,
	-1074790547,
	-2084633992,
	-619010992,
 	1593441988
}
local playerPed = nil
local effekt = 'SwitchSceneTrevor'
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		playerPed = GetPlayerPed(-1)
    end
end)
Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1)
			if playerPed ~= nil then
				if HasEntityBeenDamagedByWeapon(playerPed, 0, 2) then -- 0 is any weaponhash according to natives docs
					for i, weaponHash in ipairs(weaponsList) do
						if HasEntityBeenDamagedByWeapon(playerPed, 1593441988, 0) then
							local RNG = math.random(1,100)
							if RNG >= 70 then
								WoopsTripped(playerPed)
							end
							ClearEntityLastDamageEntity(playerPed)
						end
					end
				end
			else
				Citizen.Wait(5000)
			end
		end
end)
function WoopsTripped()
	if IsEntityDead(playerPed) or IsPedInAnyVehicle(playerPed , false) then return false end
	StartScreenEffect(effekt, 0, true)
	SetPedToRagdoll(playerPed, 2000, 2000, 3, 0, 0, 0)
	Citizen.Wait(2000)
	StopScreenEffect(effekt)
	StopGameplayCamShaking(false)
end
