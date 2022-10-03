
local linkedpool = require 'linkedpool'
local linkedqueue = require 'linkedqueue'

assert (linkedqueue ~= nil)

local pool = linkedpool.create ()

local queue = linkedqueue.create (pool)

assert (queue ~= nil)
assert (#queue == 0)

queue:push(1)

assert (not queue:isempty())

queue:push(2):push(3):push(4)	-- push something more on `queue`.

assert (tostring(queue) == 'top -> 1, 2, 3, 4 <- rear')
assert (#queue == 4)

local four = queue:pop()
local three = queue:pop()
local two = queue:pop()
local one = queue:pop()

assert (four == 1)
assert (three == 2)
assert (two == 3)
assert (one == 4)
assert (queue:isempty())
assert (#queue == 0)
