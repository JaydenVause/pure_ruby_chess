# game class (holds the objects)
class Game
    attr_reader :player_1, :player_2, :game_board
    attr_accessor :player_turn
    def initialize
        @player_turn = 1
        @game_board = Board.new
        @player_1 = Player.new(['♚','♛','♜','♝','♞','♟︎'], @game_board, 1)
        @player_2 = Player.new(['♔','♕','♖','♗','♘','♙'], @game_board, 2) 
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
# finds the sqr (node) holding a piece
    def object_selector(co_ord)
        co_ord = co_ord[0] + (co_ord[1]*8)
               
        self.game_board.board.each_with_index do |sqr, idx|
            if co_ord == idx
                if sqr.piece_holder == nil
                    return false
                elsif sqr.piece_holder.owner == player_turn
                    return sqr
                else
                    return false
                end
             end
        end
    end
# finds a sqr (node) given the co_ords
    def sqr_selector(co_ord)
        co_ord = co_ord[0] + (co_ord[1]*8)
               
        self.game_board.board.each_with_index do |sqr, idx|
            if co_ord == idx
                    return sqr
            end  
        end
        return false
    end
# for rook, bishop, queen movements
  def determine_move_set(starting_location, ending_location, piece,visited = Array.new, x = false, q = Queue.new)
   piece.edge_list.each do |xy_change|
   q << starting_location
   while !q.empty?
      node = q.pop
      # p node
      
        x = xy_change[0] + node.position[0]
        y = xy_change[1] + node.position[1]
        self.game_board.board.each do |sqr|
          if sqr.position == [x, y]
            if sqr == ending_location
              if sqr.piece_holder != nil
                if sqr.piece_holder.owner != player_turn
                  return true
                else
                  return false
                end
              else
                return true
              end
            end

            q << sqr if sqr.piece_holder == nil
          end
        end
      end
    end
  end
# moving a piece
  def make_move(starting_location, ending_location, piece, q = Queue.new)
    # lambda if it finds the location in its moveset then its valid
      check_result = -> {
                search = determine_move_set(starting_location,ending_location,piece)
                if search == true
                    ending_location.piece_holder = starting_location.piece_holder
                    starting_location.piece_holder = nil
                    return true
                end
      }
    # when its valid changes pieces
change_nodes = -> {
  ending_location.piece_holder = starting_location.piece_holder
  starting_location.piece_holder = nil
      }

if piece.is_a?(Queen)
  return true if check_result.call == true
elsif piece.is_a?(Bishop)
  return true if check_result.call == true
elsif piece.is_a?(Rook)   
  return true if check_result.call == true
end

        # get the avalible moves the pawn has
piece.edge_list.each do |pos|
            # get the xy position of the pawn
  x = starting_location.position[0] + pos[0]
  y = starting_location.position[1] + pos[1]
  xy_pos = [x,y]
    if xy_pos == ending_location.position
      if piece.is_a?(Pawn)
                    # print "pawn"
                    # if its moving diagonally
          if starting_location.position[0] != ending_location.position[0]
                        return false if ending_location.piece_holder == nil
                    # if it is moving forward
          elsif ending_location.piece_holder != nil
                        return false
                    end

          elsif piece.is_a?(King)
            if ending_location.piece_holder != nil && ending_location.piece_holder.owner == self.player_turn
                      return false
            end     
          end

          if ending_location.piece_holder != nil
              return false if ending_location.piece_holder.owner == self.player_turn
          end

          change_nodes.call
          return true
          end
      end
        return false
    end

# still coding this out

    def determine_check
      self.game_board.board.each do |sqr|
        if sqr.piece_holder != nil
          x = sqr.piece_holder.determine_valid_moves(sqr, board = game_board)
          if !x.empty?
            x.each do |move|
              if move.piece_holder != nil
                if move.piece_holder.is_a?(King) && move.piece_holder.owner == player_turn
                  return true
                end
              end
            end
          end
        end
      end
      print "false"
    end

    def determine_check_on_sqr(sqr_to_find)
      
    end

end