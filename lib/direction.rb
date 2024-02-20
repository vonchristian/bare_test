# frozen_string_literal: true

class Direction
  attr_accessor :direction

  VALID = %w[E W N S].freeze
  TRANSLATIONS = [
    { direction: "N", right: "E", left: "W" },
    { direction: "E", right: "S", left: "N" },
    { direction: "S", right: "W", left: "E" },
    { direction: "W", right: "N", left: "S" }
  ].freeze

  def initialize(args = {})
    @direction = args[:direction] || "E"
  end

  def x_axis?
    east? || west?
  end

  def y_axis?
    north? || south?
  end

  def east?
    direction == "E"
  end

  def west?
    direction == "W"
  end

  def north?
    direction == "N"
  end

  def south?
    direction == "S"
  end

  def right!
    self.direction = TRANSLATIONS.find { |a| a[:direction] == direction }[:right]
  end

  def left!
    self.direction = TRANSLATIONS.find { |a| a[:direction] == direction }[:left]
  end

  def valid?
    VALID.include?(direction)
  end
end
