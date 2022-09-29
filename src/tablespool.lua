
local tablespool = {}
local tablespool_mt = {__index = tablespool}

function tablespool.create ()
	local p = {}
	setmetatable(p, tablespool_mt)
	return p
end

--[[
--This is the implementation of AVAIL ⇒ X
--]]
function tablespool.ask(pool)
	pool.avail = pool.avail or {pool = pool,
				    nexttable = nil} -- allocation of a new link object on demand
	local l = pool.avail
	pool.avail = l.nexttable
	l.nexttable = nil -- just clean the reference to other available tables if any.
	return l
end

-- the duty of cleaning up data in `l` is up to the caller.
function tablespool.release(pool, l)
	l.nexttable = pool.avail
	pool.avail = l
end

return tablespool

