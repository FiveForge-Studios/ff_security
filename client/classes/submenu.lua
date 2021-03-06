xSubMenu = {}
xSubMenu.__index = xMenu

function xSubMenu.New(name, handle)
  local newMenu = {}
  setmetatable(newMenu, xMenu)

  newMenu.Name = name
  newMenu.Handle = handle
  newMenu.Resource = GetCurrentResourceName()

  return newMenu
end

function xSubMenu:BindSubMenu(name)
  local newHandle = exports["xmenu"]:AddSubMenu(name, self.Handle, self.Resource)
  return xSubMenu.New(name, newHandle)
end

function xMenu:BindButton(name, callback)
  exports["xmenu"]:AddButton(name, self.Handle, callback, self.Resource)
end

function xMenu:BindCheckbox(name, callback)
  exports["xmenu"]:AddCheckbox(name, self.Handle, callback, self.Resource)
end

function xMenu:BindList(name, list, callback)
  exports["xmenu"]:AddList(name, self.Handle, list, callback, self.Resource)
end