## OSGA command-line commands

- `lua osga.lua` : Starts the OSGA REPL on the default path (default is: ./data)
- `lua osga.lua filename` : Starts the repl on specified _filename_ file

## OSGA Signals

- `*` : A pulse, contains nothing beside position and direction.
- `@` : A transmission, same as pulse, but contains data.

### OSGA Signal Class

- `direction` : 
  - `x` : Number (-1 to 1).
  - `y` : Number (-1 to 1).
- `data` : Any type or `nil`.
- `position` :
  - `x` : Number.
  - `y` : Number.

## OSGA Vanilla Operators

- `&` : Queue operator.
- `+` : Square spammer, sends the signal in vertical and horizontal directions.
- `X` : Diagonal spammer, sends the signal in vertical and horizontal directions.
- `*` : Spammer, sends the signal in all directions.
- `-` : Deleter, delete the signal.
- `?` : Randomizer.
- `!` : Printer.
- `|` : Mirror.

## OSGA Console Commands

- `add object width height` :  add a _object_ to specified _width_ x _height_ position
- `edit width height` : set the cusor to the specified _width_ x _height_ position
- `rm width height` : remove the worker on the specified _width_ x _height_ position
- `run filename` : run the script on _filename_ path
- `save filename` : save the map on _filename_ path, if no path provided it replaces the current _map.txt_
- `exit` : quits the OSGA REPL
- `clear` : free memory