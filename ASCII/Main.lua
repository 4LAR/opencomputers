
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
  text2.text = table.concat({string.byte(text1.text, 1, #text1.text)}, "/")
end

function decode()
	if text2.text:match("^[%d/]+$") then
		text1.text = ""
		local number = ""
		for digits in text2.text:gmatch("[^/]+") do
			number  =tonumber(digits)
			if number then	
				text1.text = text1.text .. string.char(number)
			end
		end
	else
		GUI.alert("Говно ввёл")
	end
end

local contextMenu = menu:addContextMenuItem("File")

contextMenu:addItem("Save").onTouch = function()
	local filesystemDialogSave = GUI.addFilesystemDialog(workspace, false, 50, math.floor(workspace.height * 0.8), "Save", "Cancel", "File name", "/")
	filesystemDialogSave:setMode(GUI.IO_MODE_SAVE, GUI.IO_MODE_FILE)
	filesystemDialogSave:addExtensionFilter(".maf")
	filesystemDialogSave.onSubmit = function(path)
		filesystem.write(path,text2.text)
	end
	filesystemDialogSave:show()
end
contextMenu:addItem("Open").onTouch = function()
	local filesystemDialogOpen = GUI.addFilesystemDialog(workspace, false, 50, math.floor(workspace.height * 0.8), "Open", "Cancel", "File name", "/")
	filesystemDialogOpen:setMode(GUI.IO_MODE_OPEN, GUI.IO_MODE_FILE)
	filesystemDialogOpen:addExtensionFilter(".maf")
	filesystemDialogOpen.onSubmit = function(path)
		text2.text = filesystem.read(path)
	end
	filesystemDialogOpen:show()
end

contextMenu:addSeparator()
contextMenu:addItem("Close").onTouch = function()
  window:remove()
end
