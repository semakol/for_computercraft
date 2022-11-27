gui = {}
 
gui.doCanvas = function(w, h)
    canvas = {}
    for i=1, w do
        table.insert(canvas, {})
        for t=1, h do
            table.insert(canvas[i], {' ',colors.white, colors.white})
        end    
    end
    return canvas
end
 
gui.drawCanvas = function(canvas, w, h)
    for i=1, w do
        for t=1, h do
            term.setBackgroundColor(canvas[i][t][3])
            term.setTextColor(canvas[i][t][2])
            term.setCursorPos(i,t)
            term.write(canvas[i][t][1])
        end
    end
end
 
gui.setPixel = function(canvas, x, y, ch, cch, cb)
    ch = ch or canvas[x][y][1]
    cch = cch or canvas[x][y][2]
    cb = cb or canvas[x][y][3]
    canvas[x][y] = {ch, cch, cb}      
end
 
gui.drawRect = function(canvas, x1, y1, x2, y2, color, fill, replace)
    fill = fill or false
    replace = replace or false
    if fill then
        for i = x1, x2 do
            for t = y1, y2 do
                if replace then
                    gui.setPixel(canvas, i, t, ' ', colors.black, color)
                else
                    gui.setPixel(canvas, i, t, nil, nil, color)
                end
            end
        end
    else
        if replace then
            for i=x1,x2 do
                gui.setPixel(canvas, i, y1, ' ', colors.black, color)
                gui.setPixel(canvas, i, y2, ' ', colors.black, color)
            end
            for i = (y1+1),(y2-1) do
                gui.setPixel(canvas, x1, i, ' ', colors.black, color)
                gui.setPixel(canvas, x2, i, ' ', colors.black, color)
            end
        else
            for i=x1,x2 do
                gui.setPixel(canvas, i, y1, nil, nil, color)
                gui.setPixel(canvas, i, y2, nil, nil, color)
            end
            for i = (y1+1),(y2-1) do
                gui.setPixel(canvas, x1, i, nil, nil, color)
                gui.setPixel(canvas, x2, i, nil, nil, color)
            end
        end
    end
end
 
gui.writeText = function(canvas, text, x, y, color)
    color = color or colors.black
    for i=x, string.len(text)+x-1 do
        gui.setPixel(canvas, i, y, string.char(string.byte(text, i-x+1)), color, canvas[i][y][3])
    end
end
 
gui.buttonAdd = function(buttons, x1, y1, com, str, col, actcol, x2, y2, but, comda, coltxt)
    x2 = x2 or x1
    y2 = y2 or y1
    str = str or ' '
    col = col or colors.green
    actcol = actcol or col
    but = but or '1'
    coltxt = coltxt or colors.black
    table.insert(buttons, {x1, y1, com, str, col, actcol, x2, y2, but, false, comda, coltxt})
end
 
gui.buttonClickCheck = function(button, xm, ym)
    if button[1] <= xm and button[7] >= xm and button[2] <= ym and button[8] >= ym then
        if button[10] then
            button[10] = false
            return button[3]
        else
            button[10] = true
            if button[9] then
            	button[10] = false
            	return button[3]
    		end
            return button[11]
        end
    end
    return nil
end
 
gui.buttonsDraw = function(canvas, buttons)
    for i=1, #buttons do
        if buttons[i][9] then
            gui.drawRect(canvas, buttons[i][1], buttons[i][2], buttons[i][7], buttons[i][8], buttons[i][5], true, true)
            gui.writeText(canvas, buttons[i][4], buttons[i][1], buttons[i][2], buttons[i][12])
        else
            if buttons[i][10] then
                gui.drawRect(canvas, buttons[i][1], buttons[i][2], buttons[i][7], buttons[i][8], buttons[i][6], true, true)
                gui.writeText(canvas, buttons[i][4], buttons[i][1], buttons[i][2], buttons[i][12])
            else
                gui.drawRect(canvas, buttons[i][1], buttons[i][2], buttons[i][7], buttons[i][8], buttons[i][5], true, true)
                gui.writeText(canvas, buttons[i][4], buttons[i][1], buttons[i][2], buttons[i][12])
            end
        end
    end
end
return gui

