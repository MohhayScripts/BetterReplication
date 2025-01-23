local bufferWriter = require(script.Parent.Parent.process.bufferWriter)
local types = require(script.Parent.Parent.types)

local f32NoAlloc = bufferWriter.f32NoAlloc
local alloc = bufferWriter.alloc

local cframe = {
	read = function(b: buffer, cursor: number)
		local x = buffer.readf32(b, cursor)
		local y = buffer.readf32(b, cursor + 4)
		local z = buffer.readf32(b, cursor + 8)
		local rx = buffer.readf32(b, cursor + 12)
		local ry = buffer.readf32(b, cursor + 16)
		local rz = buffer.readf32(b, cursor + 20)

		return CFrame.new(x, y, z) * CFrame.Angles(rx, ry, rz), 24
	end,
	write = function(value: CFrame)
		local x, y, z = value.X, value.Y, value.Z
		local rx, ry, rz = value:ToEulerAnglesXYZ()

		-- Math done, write it now
		alloc(24)
		f32NoAlloc(x)
		f32NoAlloc(y)
		f32NoAlloc(z)
		f32NoAlloc(rx)
		f32NoAlloc(ry)
		f32NoAlloc(rz)
	end,
}

return function(): types.dataTypeInterface<CFrame>
	return cframe
end