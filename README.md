## OSGA - Open Scripting Grid Abstracter

The reference _Open Scripting Grid Abstracter_ implemented in lua.

## OSGA - Building

  `Note: that OSGA runs perfectly from the intepreter, building is completely optional`
  
- `(optional)`: put custom libs on the lib folder to preload them
- `1` : Create a zip with the following: main.lua, src and lib
- `2` : Drag and drop the zip into raylua_e or raylua_r(get them here https://github.com/TSnake41/raylib-lua)
- `3` : Done.

## OSGA - Command-line Commands

- `lua osga.lua` : Starts the OSGA REPL
- `lua osga.lua (file)` : Starts the repl with the specified (_file_), which can be a map(.osgm) or a script(.osgs)
- `lua osga.lua -lstd` : Starts the repl with the specified preloaded lib(require), in this case _lib.std_
- `lua osga.lua -l lib/std.lua` : Starts the repl with the specified not-preloaded lib(import), in this case _./lib/std.lua_

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

## OSGA - BuiltIn Commands

- `collect (x)` : collect garbage, if x provided then it set the collecting rate to (_x_), anything else will show current rate
- `require (modname)` : require a preloaded lib named (_modname_)
- `import (filepath)` : load _dofile_ pointed by (_filepath_)
- `-c (x)` : collect shortcut
- `-r (modname)` : require shortcut
- `-i (filepath)` : import shortcut

## OSGA - Standard Library Commands(lib.std)

- `help` : list all loaded commands
- `run (scriptname)` : run the (_filename_) script
- `skip (number)` : plays the simulation for (_number_) frames
- `new (x) (y)` : creates a new map of size (_x_) (_y_)
- `load (mapname)` : load a map named (_mapname_)
- `save (mapname)` : save the map on (_filename_) path, if no path provided it replaces the current _map.txt_
- `add (object) (width) (height)` :  add a (_object_) to specified (_width_) x (_height_) position
- `edit (width) (height)` : set the cusor to the specified (_width_) x (_height_) position
- `rm (width) (height)` : remove the worker on the specified (_width_) x (_height_) position
- `turn (varname)` : turn true/false any world.session variable, if _varname_ unavalaible prints avaliable varaibles
- `write (filename)` : write map to script file, if _varname_ unavalaible prints avaliable varaibles
- `pause` : send the user to api.run()
- `count (worker or signal)` : show active workers or signals, or both.
- `echo (string)` : print text
- `print (string)` : print text and send the user to a api.run(), waiting for another command
- `> (cmd)` : access master(world and api)
- `>> (cmd)` : access lua layer
- `>>> (cmd)` : direcly access OS layer( os.execute((_cmd_)) )
- `exit` : quit, but complete the current loop
- `end` : force quit, terminate the process

## OSGA - Standard Library Operators(lib.std)

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

## OSGA - Standard Library Sginals(lib.std)

- `destroyer` : A pulse which destroy the worker and itself when find a worker.
- `puller` : A pulse which pull the worker and destroy itself when find a worker.
- `pusher` : A pulse which push the worker and destroy itself when find a worker.