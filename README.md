``
* signals: 

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


* vanilla operators: -- these works exactly like any other ruleset operator

  & = queue

  + = send the signal in the 3 other directions

* console commands: 

  add object width height

  edit width height

  rm width height

  run filename

  save

  exit
``