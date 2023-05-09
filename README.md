--[[
speed = 10 --iterations, bigger the speed slower it will be
. = empty space
a-Z = workers
all workers must have their defaults

signals:
  * = power, always true, when it touch a worker run it with the defaults 
  $ = setup, only data, this override the worker defaults
  @ = transmission, this do not override the worker defaults, but run a single time the data in the worker

special operators: -- these operators are hardcoded
  ! = outputer
  # = blocker
  < = left spawner
  > = right spawner
  
vanilla operators: -- these works exactly like any other ruleset operator
  ? = redirects a signal
  & = queue
  + = send the signal in the 3 other directions

console commands: 
  add/new object width height
  edit width height
  rm width height
  exit
--]]

