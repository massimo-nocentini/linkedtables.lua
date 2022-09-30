
local stack = {}

local stack_mt = {__index = stack, __name = 'linkedstack'}

function stack_mt.__tostring (S)
	local l = S.top
	local tbl = {}
	while l do
		table.insert(tbl, l.value)
		l = l.nexttable
	end
	return 'top -> ' .. table.concat(tbl, ', ')
end

function stack_mt.__len (S) return S.size end

function stack.create(pool)
	local t = {pool = pool, size = 0}
	setmetatable(t, stack_mt)
	return t
end

function stack.push(S, v)

	local t = S.pool:ask ()	-- `pool` is set by the `create` function.
	t.value, t.nexttable = v, S.top
	S.top = t
	S.size = S.size + 1
	return S
end

function stack.pop(S)

	if S.top then 
		local t, v = S.top, S.top.value

		S.top = S.top.nexttable
		S.size = S.size - 1
		
		t.value = nil
		S.pool:release (t)

		return v
	else 
		error 'Popping from an empty stack' 
	end

end

function stack.isempty(S) return S.top == nil end

return stack
