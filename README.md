``
speed = 10 --iterations, bigger the speed slower it will be
. = empty space
a-Z = workers
all workers must have their defaults

signal: 
\* = a power signal, contains just power

$ = a setup signal, contains just data

@ = a transmission signal, contains data and power

{

  speed = number,

  direction = {x=number(-1 to 1),y=number(-1 to 1)},

  data = any or nil,

  power = boolean or nil,

  position = {x=number,y=number}

}

vanilla operators: -- these works exactly like any other ruleset operator

  & = queue

  + = send the signal in the 3 other directions

console commands: 

  add object width height

  edit width height

  rm width height

  run filename

  save
  
  exit
``