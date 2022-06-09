power = 0

function ui_add_power(amount)
    power = power + amount
end

function ui_remv_power(amount)
    power = power - amount
end

function ui_get_power()
    return power
end