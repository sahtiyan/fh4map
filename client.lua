local uiHidden = false
Citizen.CreateThread(function()

	RequestStreamedTextureDict("circlemap", false)
	while not HasStreamedTextureDictLoaded("circlemap") do
		Citizen.Wait(100)
	end

	AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasksm")

	SetMinimapClipType(1)
	SetBlipAlpha(GetNorthRadarBlip(), 0)
	SetMinimapComponentPosition('minimap', 'L', 'B', 0.0, -0.07, 0.140, 0.245)
	SetMinimapComponentPosition('minimap_mask', 'L', 'B', 0.0, 0.07, 0.500, 0.175)
	SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.015, -0.015, 0.190, 0.290)
	
	SetRadarBigmapEnabled(true, false)
    Citizen.Wait(0)
    SetRadarBigmapEnabled(false, false)
	
	while true do
		Citizen.Wait(100)
		if IsBigmapActive() or IsBigmapFull() then
            SetBigmapActive(false, false)
        end
		if IsPauseMenuActive() or IsRadarHidden() then
			if not uiHidden then
				SendNUIMessage({
					action = "hideUI"
				})
				uiHidden = true
			end
		elseif uiHidden then
			SendNUIMessage({
				action = "displayUI"
			})
			uiHidden = false
		end
	end
end)
  
Citizen.CreateThread(function()
	Citizen.Wait(100)

	while true do

		local radarEnabled = IsRadarEnabled()

		if not IsPedInAnyVehicle(PlayerPedId()) and radarEnabled then
			DisplayRadar(false)
		elseif IsPedInAnyVehicle(PlayerPedId()) and not radarEnabled then
			DisplayRadar(true)
		end

		Citizen.Wait(500)
	end
end)
