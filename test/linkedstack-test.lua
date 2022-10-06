
local linkedpool = require 'linkedpool'
local linkedstack = require 'linkedstack'

assert (linkedstack ~= nil)

local pool = linkedpool.create ()

local stack = linkedstack.create (pool)

assert (stack ~= nil)
assert (#stack == 0)

stack:push(1)

assert (not stack:isempty())

stack:push(2):push(3):push(4)	-- push something more on `stack`.

assert (tostring(stack) == 'top -> 4, 3, 2, 1')
assert (#stack == 4)

local four = stack:pop()
local three = stack:pop()
local two = stack:pop()
local one = stack:pop()

assert (four == 4)
assert (three == 3)
assert (two == 2)
assert (one == 1)
assert (stack:isempty())
assert (#stack == 0)

stack:push(1):push(2):push(3):push(4)	-- push something again.

stack:reverse ()	-- in place.
assert (tostring(stack) == 'top -> 1, 2, 3, 4')
assert (#stack == 4)

stack:reverse ()	-- restore the original order.
assert (tostring(stack) == 'top -> 4, 3, 2, 1')
assert (#stack == 4)
