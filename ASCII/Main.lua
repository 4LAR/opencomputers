
-- Import libraries
local GUI = require("GUI")
local system = require("System")
local filesystem = require("Filesystem")
---------------------------------------------------------------------------------

-- Add a new window to MineOS workspace
local workspace, window, menu = system.addWindow(GUI.filledWindow(1, 1, 50, 25, 0xE1E1E1))

-- Get localization table dependent of current system language
local localization = system.getCurrentScriptLocalization()

-- Add single cell layout to window
local layout = window:addChild(GUI.layout(1, 1, window.width, window.height, 1, 1))

local text1
local text2
local g
local i

local btncode = GUI.button(1, 1, 36, 3, 0xB4B4B4, 0xFFFFFF, 0x969696, 0xB4B4B4, "code")
btncode.onTouch = function()
  code()
end
local butdecode = GUI.button(1, 1, 36, 3, 0xB4B4B4, 0xFFFFFF, 0x969696, 0xB4B4B4, "decode")
butdecode.onTouch = function()
  decode()
end
local text1 = GUI.input(1, 1, 40, 3, 0xFFFFFF, 0x555555, 0x999999, 0xFFFFFF, 0x2D2D2D, "", "code")--.onInputFinished = function()
  

local text2 = GUI.input(2, 2, 40, 3, 0xFFFFFF, 0x555555, 0x999999, 0xFFFFFF, 0x2D2D2D, "", "decode")

local butclear = GUI.button(1, 1, 36, 3, 0xB4B4B4, 0xFFFFFF, 0x969696, 0xB4B4B4, "clear")
butclear.onTouch = function()
  text1.text = ""
  text2.text = "" 
end

layout:addChild(btncode)
layout:addChild(butdecode)
layout:addChild(text1)
layout:addChild(text2)
layout:addChild(butclear)
function code()
  text2.text = ""
        for i = 1,string.len(text1.text) do
            g =string.byte(text1.text,i) .. "/"
      text2.text = text2.text .. g
        end
end

local s
local ss
local sl
local i

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
--contextMenu:addSeparator()

contextMenu:addItem("Save").onTouch = function()
  filesystem.write("/ascii.maf", text2.text)
  
end
--contextMenu:addItem("Save as")
contextMenu:addSeparator()
contextMenu:addItem("Close").onTouch = function()
  window:remove()
end

workspace:draw()
