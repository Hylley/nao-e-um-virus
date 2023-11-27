function love.conf(t)
	t.console = false
	t.window.icon = 'assets/images/icons/defender.png'
	
	t.window.title = 'não-é-um-virus.exe'
	t.window.width = 654; t.window.minwidth = 654
    t.window.height = 450; t.window.minheight = 450
	t.window.resizable = false
	t.window.borderless = true

	t.modules.physics = false
	t.modules.joystick = false
	t.modules.touch = false
end