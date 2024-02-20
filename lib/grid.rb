# frozen_string_literal: true

require_relative "cell"

class Grid
  attr_reader :width, :height, :cells

  def initialize(args = {})
    @width = args.fetch(:width)
    @height = args.fetch(:height)
    @cells = create_cells
  end

  def next_cell(direction:, cell:)
    return next_cell_x_axis(direction: direction, cell: cell) if direction.x_axis?

    next_cell_y_axis(direction: direction, cell: cell)
  end

  def find_cell(coordinates)
    return if outside?(coordinates)

    cells.find { |a| a.x_axis == coordinates.first && a.y_axis == coordinates.last }
  end

  def outside?(coordinates)
    cells.select { |a| a.x_axis == coordinates.first && a.y_axis == coordinates.last }.empty?
  end

  private

  def next_cell_x_axis(cell:, direction:)
    x_axis = next_x_axis(x_axis: cell.x_axis, direction: direction)

    find_cell([x_axis, cell.y_axis])
  end

  def next_cell_y_axis(cell:, direction:)
    y_axis = next_y_axis(y_axis: cell.y_axis, direction: direction)

    find_cell([cell.x_axis, y_axis])
  end

  def next_x_axis(x_axis:, direction:)
    return if x_axis > width # outside of grid
    return x_axis + 1 if direction.east?

    x_axis - 1 if direction.west? && x_axis.positive?
  end

  def next_y_axis(y_axis:, direction:)
    return if y_axis > height # outside of grid
    return y_axis + 1 if direction.north?

    y_axis - 1 if direction.south? && y_axis.positive?
  end

  def create_cells
    (0...width).to_a.product((0...height).to_a).map do |coordinate|
      Cell.new(x_axis: coordinate.first, y_axis: coordinate.last)
    end
  end
end
