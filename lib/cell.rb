# frozen_string_literal: true

class Cell
  attr_reader :x_axis, :y_axis

  def initialize(args = {})
    @x_axis = args.fetch(:x_axis)
    @y_axis = args.fetch(:y_axis)
  end

  def coordinates
    [x_axis, y_axis]
  end
end
