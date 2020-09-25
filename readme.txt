Created a game of chess in ruby

approached the problem by doing the following 

Thinking about what makes a game of chess work
    * 2 players
    * a game board
    * the game itself
Following that i started building out my classes
    * a board has pieces
Started thinking about how I would represent a board effectively
  - for me this was simple to think about as I recently was working with graph data structures
      * a board is simply a graph consisting of 8 * 8 nodes
  - need to have pieces on the board 
      -each piece can also be a node within a node
      -each piece can have an edge list connecting to the other nodes as valid moves
      -each piece should have a player (owner)
      -each piece should have a icon
From this point I started bringing it all together and working out my functions as i moved along 
    determining each players moves being valid on the conditions of what each square held at that point
    wether a player was in check determined on the ability to be able to move a piece
    
                                                      -jamjam
