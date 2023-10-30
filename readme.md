# Untitled Halloween Game

This is a game I attempted to develop in about one month, hoping to be done before Halloween 2023. I didn't get very far, mostly due to a lack of motivation, but also due to spending too much time editing video for my devlog. The game was developed entirely using open source tools including Godot, LMMS, and GIMP. Development started on a Debian Linux virtual machine running Xfce before eventually moving to Linux Mint + Cinnamon.

The devlog starts here, if you're interested in watching it: https://www.youtube.com/watch?v=3AeshuhwX5Y

One challenge with Godot is that, as a generalist game engine, it's not very streamlined for making any particular type of game. In this case, something like RPG Maker would have worked fine and I wouldn't have had to fight against the engine so much. You really have to write your own tools on top of Godot if you want to work efficiently.

I probably will not be continuing this game in the near future; maybe I'll come back to it in a few months if inspiration strikes. But hopefully someone finds it useful as learning material. The code and assets are available under an MIT license (see `00_game.txt` in the `license` directory).

Things you might find useful:

- `editable_shape` is a tool for giving a packed scene a unique editable CollisionShape2D automatically in the editor.
- `cutscene` demonstrates a pattern for managing asynchronous cutscene behaviors, like waiting for animations to finish, waiting for the player to finish reading a message window, etc., without having to write "await" at the start of each line. See `crate_controls.gd` for an example of a complex cutscene that uses these behaviors.
- The `local_set` and `local_get` functions in `global_vars.gd` are useful for saving node-specific variables that can be recalled when a room is unloaded and reloaded. Rooms have to have unique names for it to work.
- The (currently unused) enemy is built using a simple inner-class-based state machine.
