## OSGA - Open Scripting Grid Abstracter

The reference _Open Scripting Grid Abstracter_ implemented in lua.

This is part of the _Open Scripting Grid Architecture_ project.

## OSGA - Command-line Commands

- `lua osga.lua` : Starts the OSGA REPL
- `lua osga.lua (script)` : Starts the repl with the specified (_script_)

## OSGA - Signals

- `*` : A pulse, contains nothing beside position and direction.
- `@` : A transmission, same as pulse, but contains data.

### OSGA - Signal Class

- `direction` : 
  - `x` : Number (-1 to 1).
  - `y` : Number (-1 to 1).
- `data` : Any type or `nil`.
- `position` :
  - `x` : Number.
  - `y` : Number.

## OSGA - Vanilla Operators

- `> < ^ V` : Redirectiors.
- `&` : Queue operator.
- `+` : Square spammer, sends the signal in vertical and horizontal directions.
- `X` : Diagonal spammer, sends the signal in vertical and horizontal directions.
- `$` : Spammer, sends the signal in all directions.
- `-` : Deleter, delete the signal.
- `?` : Randomizer.
- `!` : Printer.
- `|` : Mirror.
- `¬` : Packer.
- `%` : Unpacker.

## OSGA - Console Commands

- `skip (number)` : plays the simulation for (_number_) frames
- `require (modname)` : load a lib named (_modname_)
- `run (scriptname)` : run the (_filename_) script
- `load (mapname)` : load a map named (_mapname_)
- `save (mapname)` : save the map on (_filename_) path, if no path provided it replaces the current _map.txt_
- `add (object) (width) (height)` :  add a (_object_) to specified (_width_) x (_height_) position
- `edit (width) (height)` : set the cusor to the specified (_width_) x (_height_) position
- `rm (width) (height)` : remove the worker on the specified (_width_) x (_height_) position
- `turn (varname)` : turn true/false any world.session variable, if _varname_ unavalaible prints avaliable varaibles
- `clear` : free memory
- `exit` : quits the OSGA REPL
