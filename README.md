--[[



speed = 10 --iterations, bigger the speed slower it will be
. = empty space
a-Z = workers
all workers must have their defaults

signals:
  * = power, always true, when it touch a worker run it with the defaults 
  $ = setup, only data, this override the worker defaults
  @ = transmission, this do not override the worker defaults, but run a single time the data in the worker

signal operators: -- operators are pre-built logic controlers 
  ! = outputer
  # = blocker
  
special(need outputs): -- special are made with api functions
  ? = redirects a signal
  & = queue
  + = send the signal in the 3 other directions
  < = slow down by 1
  > = speed up by 1
--]]

