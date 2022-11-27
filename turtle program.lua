local path = {}
local record = false
local doing = false
rednet.open('right')
while true do
    local id, mes, prot = rednet.receive('aboba') 
    if id ~= 0 then
        if mes == 'forward' then
            doing = turtle.forward()
        elseif mes == 'back' then
            doing = turtle.back()
        elseif mes == 'right' then
            doing = turtle.turnRight()
        elseif mes == 'left' then
            doing = turtle.turnLeft()
        elseif mes == 'stop' then
            break
        elseif mes == 'record' then
            record = true
        elseif mes == 'do path' then
            record = false
            for i = 0, #path do
                if path[#path-i] == 'forward' then
                    turtle.back()
                elseif path[#path-i] == 'back' then
                    turtle.forward()
                elseif path[#path-i] == 'right' then
                    turtle.turnLeft()
                elseif path[#path-i] == 'left' then
                    turtle.turnRight()
                end
            end
            path = {}
        elseif mes == 'res record' then
            path = {}
            record = false
        end
        if record and doing then
            table.insert(path, mes)
        end
        doing = false
    end
end
rednet.close('right')