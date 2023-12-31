game = require 'game'
utils = require 'utils'

math.randomseed(os.time())

USERNAME = os.getenv('USERNAME')
HOSTNAME = 'phoenixNAP'

os.execute 'powershell (New-Object -ComObject Shell.Application).MinimizeAll()'

local f = io.popen("hostname")
if f ~= nil then
	HOSTNAME = f:read("*a") or HOSTNAME
	f:close()
	HOSTNAME = string.gsub(HOSTNAME, "\n$", "")
end

game.load_scene('launcher')