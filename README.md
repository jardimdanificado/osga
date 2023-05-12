## OSGA command-line commands

- `lua osga.lua` : Starts the OSGA REPL on the default path (default is: ./data)
- `lua osga.lua filename` : Starts the repl on specified _filename_ file

## OSGA Signals

- `*` : A power signal, contains just power.
- `$` : A setup signal, contains just data.
- `@` : A transmission signal, contains data and power.

### OSGA Signal Class

- `speed` : Number.
- `direction` : 
  - `x` : Number (-1 to 1).
  - `y` : Number (-1 to 1).
- `data` : Any type or `nil`.
- `power` : Boolean or `nil`.
- `position` :
  - `x` : Number.
  - `y` : Number.

## OSGA Vanilla Operators

- `&` : Queue operator.
- `+` : Send the signal in the 3 other directions.

## OSGA Console Commands

- `add object width height` :  add a _object_ to specified _width_ x _height_ position
- `edit width height` : set the cusor to the specified _width_ x _height_ position
- `rm width height` : remove the worker on the specified _width_ x _height_ position
- `run filename` : run the script on _filename_ path
- `save filename` : save the map on _filename_ path, if no path provided it replaces the current _map.txt_
- `exit` : quits the OSGA REPL