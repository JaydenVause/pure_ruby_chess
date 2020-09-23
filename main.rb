require "./lib/board.rb"
require "./lib/game.rb"
require "./lib/pieces.rb"
require "./lib/players.rb"

game = Game.new
running = true
puts "Welcome to RUBY Chess players!"
puts "Player one you are (white) and Player two you are (black)"


while running == true
  # system "clear"
  puts "where is the piece you would like to move? (type in the form of a-0 or b-4 , column by row"
  # before player can move player should be out of check
  # p "check status: #{player.check}"
  # render the board out at start of turn
  game.game_board.to_s
  print "check Status: "
  game.determine_check 
  puts ""
  # print out user turn as input msg
  print "#{game.player_turn == 1 ? "player 1: " : "player 2: "}"
  # get where player piece to move is
  player_input = gets.chomp.split(",")
  # convert that into a value we can use
  piece_to_move = game.convert_co_ord(player_input)
  # if its invalid input re do
  next if piece_to_move == false
 
    original_square = game.object_selector(piece_to_move)

    if original_square == false
      p "false"
      next
    else
      piece = original_square.piece_holder
      piece.determine_valid_moves(original_square, game.game_board)

      puts "where would you like to move your piece?"
      print "#{game.player_turn == 1 ? "player 1:" : "player 2:"}"
      player_input = gets.chomp.split(",")
      move_sqr = game.convert_co_ord(player_input)
      next if move_sqr == false

      move_sqr = game.sqr_selector(move_sqr)
      rewrite = move_sqr.piece_holder

      x = original_square.piece_holder
      y = move_sqr.piece_holder
       
      
      player_move = game.make_move(original_square, move_sqr, piece)
      
       if game.determine_check == true && player_move == true
        p x
        p y 
        original_square.piece_holder = x
        move_sqr.piece_holder = y
        p "PLAYER YOU ARE IN CHECK FIX IT !"
        next
       end

      next if player_move == false
      game.player_turn == 1 ? game.player_turn = 2 : game.player_turn = 1
  end
end
