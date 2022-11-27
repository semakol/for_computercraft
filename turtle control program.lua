require('f')
 
term.setBackgroundColor(colors.black)
term.setCursorPos(1,1)
local w, h = term.getSize()
local canvas = gui.doCanvas(w, h)
 
local buttons = {}
 
gui.buttonAdd(buttons, 4, 5, 'forward', '^', colors.green)
gui.buttonAdd(buttons, 4, 7, 'back', ' ', colors.green)
gui.buttonAdd(buttons, 3, 6, 'left', '<', colors.green)
gui.buttonAdd(buttons, 5, 6, 'right', '>', colors.green)

local running = true
 
rednet.open('back')
while running do
    gui.buttonsDraw(canvas, buttons)
    gui.drawCanvas(canvas, w, h)
    local event, button, x, y = os.pullEvent()
    if (button == 1 or button == 2) and event == 'mouse_click' then
        for i=1,#buttons do
            local butEvent = gui.buttonClickCheck(buttons[i], x, y)
            if butEvent == 'exit' then
                running = false
            elseif butEvent ~= nil then
                rednet.broadcast(butEvent, 'aboba')
            end
        end
    end
end
term.setBackgroundColor(colors.black)
term.clear()
rednet.close('back') 