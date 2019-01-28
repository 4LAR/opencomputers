
local GUI = require("GUI")
local system = require("System")
local filesystem = require("Filesystem")
local paths = require("Paths")

local text1
local text2
local text11
local text22
local slovo
local g

local applicationPath = paths.user.applicationData .. "ascii/"



function savebuf()
    file = io.open("buf.txt", "wb")
    file:close()
    file = io.open("buf.txt", "a")
    file:write(buf)
    file:close()
end
function saveascii()
    filesystem.writeTable(applicationPath .. "ascii.txt", g)
end
function openascii()
    filesystem.readTable(applicationPath .. "ascii.txt", g)
end
function clearascii()
    filesystem.writeTable(applicationPath .. "", g)
end

function code()
        --clearascii()
        --text1 = text11
        for i = 1,string.len(text1.text) do
            g = string.byte(text1.text,i).. "/"
            --io.write(g)
            saveascii()
        end
        openascii()
        text2.text = buf
end

local s
local ss
local sl
local i

function decode()
        clearascii()
        s = 1
        while true do
            if (s + 1) > string.len(text2.text) then break end
            ss = string.find(text2.text,"/",s)
            sl = string.sub(text2.text,s,ss-1)
            --io.write(string.char(sl))
            -- print(sl)
g = string.char(sl)
saveascii()
            s = ss + 1
        end
openascii()
text1.text = buf
end

--text1 = "suka"



local window = system.addWindow(GUI.filledWindow(1, 1, 60, 23, 0xE1E1E1))

-- Get localization table dependent of current system language
local localization = system.getCurrentScriptLocalization()

-- Add single cell layout to window
local layout = window:addChild(GUI.layout(1, 1, window.width, window.height, 1, 1))
-- Add some stuff to layout
local btncode = GUI.button(1, 1, 36, 3, 0xB4B4B4, 0xFFFFFF, 0x969696, 0xB4B4B4, "code")
btncode.onTouch = function()
  code()
end
local butdecode = GUI.button(1, 1, 36, 3, 0xB4B4B4, 0xFFFFFF, 0x969696, 0xB4B4B4, "decode")
butdecode.onTouch = function()
  decode()
end
text1 = GUI.input(1, 1, 40, 3, 0xFFFFFF, 0x555555, 0x999999, 0xFFFFFF, 0x2D2D2D, "", "code")--.onInputFinished = function()
  

text2 = GUI.input(2, 2, 40, 3, 0xFFFFFF, 0x555555, 0x999999, 0xFFFFFF, 0x2D2D2D, "", "decode")

local butclear = GUI.button(1, 1, 36, 3, 0xB4B4B4, 0xFFFFFF, 0x969696, 0xB4B4B4, "clear")
butclear.onTouch = function()
  text1.text = ""
  text2.text = "" 
end

--btncode.hidden = state
layout.hidden = false
layout:addChild(btncode)
layout:addChild(butdecode)
layout:addChild(text1)
layout:addChild(text2)
layout:addChild(butclear)



window:draw(true)
--window:draw(false)
--window:start()


