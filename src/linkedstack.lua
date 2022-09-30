
local stack = {}

local stack_mt = {__index = stack}

function stack.create(pool)
	local t = {pool = pool}
	setmetatable(t, stack_mt)
	return t
end

function stack.push(S, v)

	local t = S.pool:ask ()
	t.value, t.nexttable = v, S.top
	S.top = t

end

function stack.pop(S)

	if S.top then 
		local t, v = S.top, S.top.value

		S.top = S.top.nexttable

		t.value = nil
		S.pool:release (t)

		return v
	else 
		error 'Popping from an empty stack' 
	end

end

function stack.isempty(S)
	return S.top == nil
end

return stack
