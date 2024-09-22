local NDCore = exports['ND_Core']

function NearTaxi(src)
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    for _, v in pairs(Config.NPCLocations.DeliverLocations) do
        local dist = #(coords - vector3(v.x, v.y, v.z))
        if dist < 20 then
            return true
        end
    end
end

RegisterNetEvent('qb-taxi:server:NpcPay', function(payment, hasReceivedBonus)
    local src = source
    local Player = NDCore:getPlayer(src) -- Directly get Player data

    -- Check if Player is nil
    if not Player then
        print(string.format("Player data not found for source: %d", src)) -- Debug log
        return -- Just return if Player is nil
    end

    if Player.job == Config.jobRequired then
        if NearTaxi(src) then
            local randomAmount = math.random(1, 5)
            local r1, r2 = math.random(1, 5), math.random(1, 5)
            if randomAmount == r1 or randomAmount == r2 then payment = payment + math.random(10, 20) end

            if Config.Advanced.Bonus.Enabled then
                local tipAmount = math.floor(payment * Config.Advanced.Bonus.Percentage / 100)

                payment += tipAmount
                if hasReceivedBonus then
                    -- Updated notification to use ox_lib
                    TriggerClientEvent('ox_lib:notify', src, {
                        title = Lang:t('info.tip_received'),
                        description = string.format(Lang:t('info.tip_received'), tipAmount),
                        type = 'success',
                        duration = 5000
                    })
                else
                    -- Updated notification to use ox_lib
                    TriggerClientEvent('ox_lib:notify', src, {
                        title = Lang:t('info.tip_not_received'),
                        type = 'warning',
                        duration = 5000
                    })
                end
            end

            if Config.Management then
                exports['qb-banking']:AddMoney('taxi', payment, 'Customer payment')
            else
                Player.addMoney('cash', payment, 'Taxi payout')
            end

            local chance = math.random(1, 100)
            if chance < 26 then
                exports['ox_inventory']:AddItem(src, Config.Rewards, 1, false, false, 'qb-taxi:server:NpcPay')
            end
        else
            DropPlayer(src, 'Attempting To Exploit')
        end
    else
        DropPlayer(src, 'Attempting To Exploit')
    end
end)
