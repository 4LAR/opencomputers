
-- Import libraries
local GUI = require("GUI")
local system = require("System")
local filesystem = require("Filesystem")
---------------------------------------------------------------------------------
local workspace, window, menu = system.addWindow(GUI.titledWindow(1, 1, 56, 14, "ASCII", true))

local text1
local text2
local g
local i
local s
local ss
local sl
local i

local btncode = GUI.button(5, 3, 10, 3, 0xB4B4B4, 0xFFFFFF, 0x969696, 0xB4B4B4, "code")
btncode.onTouch = function()
  code()
end
local butdecode = GUI.button(16, 3, 10, 3, 0xB4B4B4, 0xFFFFFF, 0x969696, 0xB4B4B4, "decode")
butdecode.onTouch = function()
  decode()
end
local text1 = GUI.input(4, 7, 50, 3, 0xFFFFFF, 0x555555, 0x999999, 0xFFFFFF, 0x2D2D2D, "", "code")
  

local text2 = GUI.input(4, 11, 50, 3, 0xFFFFFF, 0x555555, 0x999999, 0xFFFFFF, 0x2D2D2D, "", "decode")

local butclear = GUI.button(27, 3, 10, 3, 0xB4B4B4, 0xFFFFFF, 0x969696, 0xB4B4B4, "clear")
butclear.onTouch = function()
  text1.text = ""
  text2.text = "" 
end

window:addChild(btncode)
window:addChild(butdecode)
window:addChild(text1)
window:addChild(text2)
window:addChild(butclear)
function code()
  text2.text = ""
        for i = 1,string.len(text1.text) do
            g =string.byte(text1.text,i) .. "/"
      text2.text = text2.text .. g
        end
end

function decode()
    text1.text = ""
        s = 1
        while true do
            if (s + 1) > string.len(text2.text) then break end
            ss = string.find(text2.text,"/",s)
            sl = string.sub(text2.text,s,ss-1)
g = string.char(sl)
text1.text = text1.text .. g
            s = ss + 1
        end
end

local contextMenu = menu:addContextMenuItem("File")

contextMenu:addItem("Save").onTouch = function()
  filesystem.write("/ascii.maf", text2.text)
  
end
contextMenu:addSeparator()
contextMenu:addItem("Close").onTouch = function()
  window:remove()
end
