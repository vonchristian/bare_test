# frozen_string_literal: true

require_relative "direction"

class Robot
  attr_reader :grid
  attr_accessor :current_cell, :current_direction

  def initialize(args = {})
    @grid = args.fetch(:grid)
    @current_direction = Direction.new
  end

  def place!(coordinates)
    cell = grid.find_cell(coordinates)
    return if cell.nil?

    self.current_cell = cell
  end

  def placed?
    !current_cell.nil?
  end

  def move!
    cell = grid.next_cell(direction: current_direction, cell: current_cell)

    return if cell.nil?

    self.current_cell = cell
  end

  def face_right!
    current_direction.right!
  end

  def face_left!
    current_direction.left!
  end

  def report
    [current_cell.coordinates, current_direction.direction].flatten
  end
end
