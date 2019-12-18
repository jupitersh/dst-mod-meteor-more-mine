AddPrefabPostInit("shadowmeteor", function(inst)

	local function myexplode(inst)
		if inst:IsOnValidGround() then
			local extraloot = {
				rocks = GetModConfigData("rocks"),
				flint = GetModConfigData("flint"),
				goldnugget = GetModConfigData("goldnugget"),
				nitre = GetModConfigData("nitre"),
				marble = GetModConfigData("marble"),
				moonrocknugget = GetModConfigData("moonrocknugget"),
				redgem = GetModConfigData("redgem"),
				bluegem = GetModConfigData("bluegem"),
				purplegem = GetModConfigData("purplegem"),
				orangegem = GetModConfigData("orangegem"),
				yellowgem = GetModConfigData("yellowgem"),
				greengem = GetModConfigData("greengem"),
			}
			for k, v in pairs(extraloot) do
				if math.random() <= v then
					local drop = GLOBAL.SpawnPrefab(k)
					if drop ~= nil then
						local x, y, z = inst.Transform:GetWorldPosition()
						drop.Transform:SetPosition(x, y, z)
						if drop.components.inventoryitem ~= nil then
							drop.components.inventoryitem:OnDropped(true)
						end
					end
				end
			end
		end
	end

	local function mystrike(inst)
		inst.mystriketask = nil
		inst:DoTaskInTime(0.33, myexplode)
	end

	local _SetSize = inst.SetSize
	inst.SetSize = function(inst, sz, mod)
		_SetSize(inst, sz, mod)
		inst.mystriketask = inst:DoTaskInTime(1.1, mystrike)
	end

end)