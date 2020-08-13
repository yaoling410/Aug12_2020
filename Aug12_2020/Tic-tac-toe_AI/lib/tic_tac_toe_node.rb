require_relative 'tic_tac_toe'
require 'byebug'
class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if self.board.over? 
      self.board.won? && self.board.winner != evaluator 

    else 
      if @next_mover_mark==evaluator
        self.children.all? do |child|
          child.losing_node?(evaluator)
        end 
      else
        self.children.any? do |child|
          child.losing_node?(evaluator)
        end 
      end

    end
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children=[]
    items=(0..2).to_a
    items.each do |row|
      items.each do |col|
        pos_next=[row,col]
        next unless self.board.empty?(pos_next)
        next_move = self.board.dup
        next_move[pos_next] = @next_mover_mark
        #debugger
        #pre_pos=  (@prev_move_pos.empty? pos_next: (@prev_move_pos+pos_next))
        children << TicTacToeNode.new(next_move,self.turn_mark, pos_next)
      end 
    end 
    children
  end

  def turn_mark
    ((@next_mover_mark==:x)? :o: :x)
  end 

end
