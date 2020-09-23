 # chess piece node object
class ChessPiece
    attr_reader :owner, :moves
    attr_accessor :place_holder, :edge_list
    def initialize(place_holder, player_number)
        @place_holder = place_holder
        @edge_list = []
        @owner = player_number
        @moves = []
    end
# maybe can use this to determine check from each pieces avalible moves  :/ 
    


end

class King < ChessPiece
    
    def initialize(place_holder, player_number)
      super  
      @edge_list = [
            [0,1],
            [0,-1],
            [1,0],
            [-1,0],
            [1,1],
            [-1,1],
            [-1,-1],
            [1,-1]
        ]
        
    end

    def determine_valid_moves(sqr, board)
      array_of_valid_moves = []
      self.edge_list.each do |xy_change|
        new_x = xy_change[0] + sqr.position[0]
        new_y = xy_change[1] + sqr.position[1]

          board.board.each do |node|
            if node.position == [new_x, new_y]             
              # if pawn is moving forward
              if node.piece_holder != nil &&  node.piece_holder.owner != sqr.piece_holder.owner
                    array_of_valid_moves << node
              # conditional of it its moving side_ways
              elsif node.piece_holder == nil
                array_of_valid_moves << node
              end

            end 
          end
        end
        return array_of_valid_moves
    end
end

class Queen < ChessPiece
      def initialize(place_holder, player_number)
      super  
      @edge_list = [
            [0,1],
            [0,-1],
            [1,0],
            [-1,0],
            [1,1],
            [-1,1],
            [-1,-1],
            [1,-1]
        ]
        
    end

    def determine_valid_moves(piece_sqr, board)
      # make a new queue
      position = []  
      # go through each edge
      piece_sqr.piece_holder.edge_list.each do |edge|
          q = Queue.new
          # p edge
      # add node to the que
          q << piece_sqr
  
      # until it runs out of squares to check
          while !q.empty?
              node = q.pop
              # p node
              # give new x and new y depending on current xy
                  x = node.position[0] + edge[0]
                  y = node.position[1] + edge[1]
                  # p "#{x}, #{y}"
              board.board.each do |sqr|
                  # if we find a sqr given that position
                  if sqr.position == [x,y]
                  
                      # if its an empty square
                      if sqr.piece_holder == nil
                          q << sqr
                          position << sqr
                          # add it to the positions then add it to the que
                      elsif node.piece_holder != nil && node.piece_holder.owner != piece_sqr.piece_holder.owner
                          # add it to the positions but not to the que
                          position << sqr
                      end
                  end
              end
          end
      end
      return position
  end
end

class Rook < ChessPiece
  def initialize(place_holder, player_number)
  super
        @edge_list = [
            [0,1],
            [0,-1],
            [1,0],
            [-1,0]
          ]
  end

  def determine_valid_moves(piece_sqr, board)
      # make a new queue
      position = []  
      # go through each edge
      piece_sqr.piece_holder.edge_list.each do |edge|
          q = Queue.new
          # p edge
      # add node to the que
          q << piece_sqr
  
      # until it runs out of squares to check
          while !q.empty?
              node = q.pop
              # p node
              # give new x and new y depending on current xy
                  x = node.position[0] + edge[0]
                  y = node.position[1] + edge[1]
                  # p "#{x}, #{y}"
              board.board.each do |sqr|
                  # if we find a sqr given that position
                  if sqr.position == [x,y]
                  
                      # if its an empty square
                      if sqr.piece_holder == nil
                        
                          position << sqr
                          q << sqr
                          
                          # add it to the positions then add it to the que
                      elsif node.piece_holder != nil && node.piece_holder.owner != piece_sqr.piece_holder.owner
                          # add it to the positions but not to the que
                          position << sqr
                      end
                  end
              end
          end
      end
      
      return position
  end

end

class Bishop < ChessPiece
  def initialize(place_holder, player_number)
  super
        @edge_list = [
            [1,1],
            [1,-1],
            [-1,-1],
            [-1,1]
          ]
  end


    def determine_valid_moves(piece_sqr, board)
      # make a new queue
      position = []  
      # go through each edge
      piece_sqr.piece_holder.edge_list.each do |edge|
          q = Queue.new
          # p edge
      # add node to the que
          q << piece_sqr
  
      # until it runs out of squares to check
          while !q.empty?
              node = q.pop
              # p node
              # give new x and new y depending on current xy
                  x = node.position[0] + edge[0]
                  y = node.position[1] + edge[1]
                  # p "#{x}, #{y}"
              board.board.each do |sqr|
                  # if we find a sqr given that position
                  if sqr.position == [x,y]
                  
                      # if its an empty square
                      if sqr.piece_holder == nil
                          q << sqr
                          position << sqr
                          # add it to the positions then add it to the que
                      elsif node.piece_holder != nil && node.piece_holder.owner != piece_sqr.piece_holder.owner
                          # add it to the positions but not to the que
                          position << sqr
                      end
                  end
              end
          end
      end
      return position
  end
end

class Knight < ChessPiece

    def initialize(place_holder, player_number)
        super
        @edge_list = [
            [-2, -1],
            [-1, -2],
            [-2, 1],
            [-1, 2],
            [1, 2],
            [2, 1],
            [2, -1],
            [1, -2]
          ]
        end

      def determine_valid_moves(sqr, board)
      array_of_valid_moves = []
      self.edge_list.each do |xy_change|
        new_x = xy_change[0] + sqr.position[0]
        new_y = xy_change[1] + sqr.position[1]

          board.board.each do |node|
            if node.position == [new_x, new_y]             
              # if pawn is moving forward
              if node.piece_holder != nil &&  node.piece_holder.owner != sqr.piece_holder.owner
                    array_of_valid_moves << node
              # conditional of it its moving side_ways
              elsif node.piece_holder == nil
                array_of_valid_moves << node
              end

            end 
          end
        end
        return array_of_valid_moves
      end
        
end

class Pawn < ChessPiece
    def initialize(place_holder, player_number)
        super
        @edge_list = generate_edges(player_number)
        
    end

    def generate_edges(player_number)
        
        return [
            [0,1],
            [-1,1],
            [1,1]
            ] if player_number == 1

        return [
            [0,-1],
            [1,-1],
            [-1,-1]
            ] if player_number == 2
    end

    def determine_valid_moves(sqr, board)
      array_of_valid_moves = []
      self.edge_list.each do |xy_change|
        new_x = xy_change[0] + sqr.position[0]
        new_y = xy_change[1] + sqr.position[1]

          board.board.each do |node|
            if node.position == [new_x, new_y]             
              # if pawn is moving forward
              if node.position[0] == sqr.position[0]
                    array_of_valid_moves << node
              # conditional of it its moving side_ways
              elsif node.position[0] != sqr.position[0]
                  if node.piece_holder != nil && node.piece_holder.owner != sqr.piece_holder.owner
                    array_of_valid_moves << node
                end
              end
            end 
          end
        end
        return array_of_valid_moves
      end
      

        
end