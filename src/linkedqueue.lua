
local queue = {}

local queue_mt = {__index = queue, __name = 'linkedqueue'}

function queue_mt.__tostring (S)
	local l = S.top
	local tbl = {}
	while l do
		table.insert(tbl, l.value)
		l = l.nexttable
	end
	return 'top -> ' .. table.concat(tbl, ', ') .. ' <- rear'
end

function queue_mt.__len (S) return S.size end

function queue_mt.__close (S) 

	if not S:isempty() then

		S.rear.nexttable = S.pool.avail
		S.pool.avail = S.top

		S.top = nil
		S.rear = nil
	end
end

function queue.create(pool)
	local t = {pool = pool, size = 0}
	setmetatable(t, queue_mt)
	return t
end

function queue.push(S, v)

	local t = S.pool:ask ()	-- `pool` is set by the `create` function.
	t.value, t.nexttable = v, nil
	
	if S:isempty() then
		S.rear = t 
		S.top = S.rear
	else
		S.rear.nexttable = t
		S.rear = t
	end
	
	S.size = S.size + 1
	
	return S
end

function queue.pop(S)

	if not S:isempty() then 
		local p = S.top
		S.top = p.nexttable
		
		if S:isempty() then S.rear = S.top end
		
		local v = p.value
		p.value = nil	-- cleaning `p` up to be released.
		S.pool:release (p)
		
		S.size = S.size - 1
		
		return v
	else 
		error 'Popping from an empty queue' 
	end

end

function queue.isempty(S) return S.top == nil end

return queue
