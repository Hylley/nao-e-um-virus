game = require 'game'

USERNAME = os.getenv('USERNAME')
HOSTNAME = 'phoenixNAP'

local f = io.popen("hostname")
if f ~= nil then
	HOSTNAME = f:read("*a") or HOSTNAME
	f:close()
	HOSTNAME = string.gsub(HOSTNAME, "\n$", "")
end

game.load_scene('fake_admin')