# board class holds all the board nodes
class Board
    attr_reader :board
    def initialize
        @board = populate_board
    end

    # makes squares in board
    def populate_board
        board = []

        8.times do |row|
            if row % 2 == 1
                # black start
                8.times do |col|
                    if col % 2 == 1 
                        # black
                        board << Square.new((row*col), holder = nil, '⬜')
                    else
                        # white
                        board << Square.new((row*col), holder = nil, '⬛')
                    end
                end
            elsif row % 2 == 0
                    # white start
                8.times do |col|
                    if col % 2 == 1 
                        # white
                        board << Square.new((row*col), holder = nil, '⬛')
                    else
                        # black
                        board << Square.new((row*col), holder = nil, '⬜')
                    end
                end
            end
                 
        end
        return board
    end        

    def to_s
        puts ""
        print "  a   b   c   d   e   f   g   h"
        x = (0..9).to_a
        @board.each_with_index do |node, idx|
            
            puts "" if idx % 8 == 0
            
            puts "------------------------------" if idx % 8 == 0
            print x.shift if idx % 8 == 0
            print " "
            if node.piece_holder == nil
                print node.display
                print "|"
            else
                print "#{node.piece_holder.place_holder} "
                print "|"
            end
            
        end
        puts 
    end

end

class Node
    def initialize(i)
        @value = i
    end
end 
# square (placement on the board graph)
class Square < Node
    attr_accessor :holder, :piece_holder
    attr_reader :display
    def initialize(i, holder = nil, display)
        @holder = holder
        @piece_holder = nil
        @display = display
    end
end
# chess piece node object
class ChessPiece
    attr_reader :place_holder, :owner
    def initialize(place_holder, player_number)
        @place_holder = place_holder
        @edge_list = []
        @owner = player_number
    end
end

class King < ChessPiece
end

class Queen < ChessPiece
end

class Rook < ChessPiece
end

class Bishop < ChessPiece
end

class Knight < ChessPiece
end

class Pawn < ChessPiece
end

class Player
    attr_reader :pieces, :player_number
    def initialize(array, board_link, player_number)
        
        @board = board_link
        @player_number = player_number
        @pieces = generate_pieces(array)
    end

    def generate_pieces(array)

        set_pieces = []
        king =  King.new(array[0], self.player_number)
        queen = Queen.new(array[1], self.player_number)
        rook =  Rook.new(array[2], self.player_number)
        bishop = Bishop.new(array[3], self.player_number)
        knight = Knight.new(array[4], self.player_number)
        pawn =  Pawn.new(array[5], self.player_number)

        if player_number == 1
            @board.board[0].piece_holder = rook
            @board.board[1].piece_holder = knight
            @board.board[2].piece_holder = bishop
            @board.board[3].piece_holder = queen
            @board.board[4].piece_holder = king
            @board.board[5].piece_holder = bishop
            @board.board[6].piece_holder = knight
            @board.board[7].piece_holder = rook
            8.upto(15) do |i|
                @board.board[i].piece_holder = pawn
            end
        elsif player_number == 2
            @board.board[56].piece_holder = rook
            @board.board[57].piece_holder = knight
            @board.board[58].piece_holder = bishop
            @board.board[59].piece_holder = queen
            @board.board[60].piece_holder = king
            @board.board[61].piece_holder = bishop
            @board.board[62].piece_holder = knight
            @board.board[63].piece_holder = rook
            48.upto(55) do |i|
                @board.board[i].piece_holder = pawn
            end
        end

        return set_pieces
    end
# display our players
    def render
        set_list = @pieces
        set_list.each do |node|
            print "#{node}   #{node.place_holder}"
            puts ""
        end
    end

end
# game class (holds the objects)
class Game
    attr_reader :player_1, :game_board
    attr_accessor :player_turn
    def initialize
        @player_turn = 1
        @game_board = Board.new
        @player_1 = Player.new(['♔','♕','♖','♗','♘','♙'], @game_board, 1)
        @player_2 = Player.new(['♚','♛','♜','♝','♞','♟︎'], @game_board, 2)
        
    end
# convert player input into valid co_ordinates
    def convert_co_ord(co_ord)
       x = co_ord[0]
       y = co_ord[1]

       case x
       when 'a'
        x = 0
       when 'b'
        x = 1
       when 'c'
        x = 2
       when 'd'
        x = 3
       when 'e'
        x = 4
       when 'f'
        x = 5
       when 'g'
        x = 6
       when 'h'
        x = 7
       else
        return false
       end

       case y
       when '0'
        y = 0
       when '1'
        y = 1
       when '2'
        y = 2
       when '3'
        y = 3
       when '4'
        y = 4
       when '5'
        y = 5
       when '6'
        y = 6
       when '7'
        y = 7
       else
        return false
       end

       return [x,y]
    end

    def object_selector(co_ord)
        co_ord = co_ord[0] + (co_ord[1]*8)
               
        self.game_board.board.each_with_index do |sqr, idx|
            if co_ord == idx
                if sqr.piece_holder == nil
                    return false
                elsif sqr.piece_holder.owner == player_turn
                    return sqr.piece_holder
                else
                    return false
                end
             end
        end
    end
end

game = Game.new
running = true
puts "Welcome to RUBY Chess players!"


while running == true
    game.game_board.to_s
    puts "Player one you are (white) and Player two you are (black)"
    puts "where is the piece you would like to move? (type in the form of a-0 or b-4 , column by row"
    print "#{game.player_turn == 1 ? "player 1:" : "player 2:"}"
    player_input = gets.chomp.split(',')
    convert_co_ord = game.convert_co_ord(player_input)
    if convert_co_ord == false
        p"false"
        next
    else
        # find node_to move
        if game.object_selector(convert_co_ord) == false
            p "false"
            next
        else
            p 'true'
            game.player_turn == 1 ? game.player_turn = 2 : game.player_turn = 1
        end
    end

end

# if player turn == 1 board can only move white pieces
# if player turn == 2 board can only move black pieces
