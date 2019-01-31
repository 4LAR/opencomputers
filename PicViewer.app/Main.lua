local image = require("image")
local GUI = require("GUI")
local system = require("System")
local filesystem = require("Filesystem")
--------------------------------------------------------------------------------
local application = GUI.workspace()
application:addChild(GUI.panel(1, 1, application.width, application.height, 0x2D2D2D))
local menu = application:addChild(GUI.menu(1, 1, application.width, 0xEEEEEE, 0x666666, 0x3366CC, 0xFFFFFF))
menu:addItem("Pic Viewer", 0x0).onTouch = function()
end
menu:addItem("open", 0x0).onTouch = function()
  local filesystemDialogOpen = GUI.addFilesystemDialog(application, false, 50, math.floor(application.height * 0.8), "Open", "Cancel", "File name", "/")
  filesystemDialogOpen:setMode(GUI.IO_MODE_OPEN, GUI.IO_MODE_FILE)
  filesystemDialogOpen:addExtensionFilter(".pic")
  filesystemDialogOpen.onSubmit = function(path)
    application:addChild(GUI.image(1, 2, image.load(path)))
  end
  filesystemDialogOpen:show()
end
menu:addItem("exit", 0x0).onTouch = function()
  application:stop()
end
--------------------------------------------------------------------------------
application:draw(true)
application:start()
