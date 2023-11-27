local module = {}

function module.capture(cmd)
	local f = assert(io.popen(cmd, 'r'))
	local s = assert(f:read('*a'))
	f:close()

	return s
end

function module.lerp(a,b,t) return a * (1-t) + b * t end

function module.circumference_points(radius, count)
	local radians_between_each_point = 2 * math.pi/count
	local points = {}

	for i = 1, count do
		points[i] = { x = radius * math.cos(i * radians_between_each_point), y = radius * math.sin(i * radians_between_each_point) }
	end

	return points
end

return module