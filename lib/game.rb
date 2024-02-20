# frozen_string_literal: true

require_relative "grid"
require_relative "robot"

class Game
  VALID_COMMANDS = %w[PLACE MOVE RIGHT LEFT REPORT].freeze

  attr_accessor :commands, :robot, :current_direction
  attr_reader :grid

  def self.run!
    obj = new
    obj.run
  end

  def initialize
    @grid = Grid.new(height: 6, width: 6)
    @robot = Robot.new(grid: @grid)
    @current_direction = @robot.current_direction
    @commands = []
  end

  def run
    puts "Available Commands: #{VALID_COMMANDS}"

    loop do
      inputs = gets.chomp
      next if inputs.empty?

      command, *params = inputs.split(/\s/)

      next unless VALID_COMMANDS.include?(command)

      commands << command
      next unless commands.include?("PLACE")

      send("#{command.downcase}_robot".to_sym, *params)
    end
  end

  private

  def place_robot(args)
    x_axis, y_axis, direction = args.split(",")
    return unless Direction.new(direction: direction).valid?

    coordinates = [Integer(x_axis), Integer(y_axis)]
    return if grid.outside?(coordinates)

    robot.place!(coordinates)
    update_direction(direction)
  end

  def report_robot
    return unless robot.placed?

    puts robot.report.to_s # rubocop:disable Lint/RedundantStringCoercion
  end

  def move_robot
    robot.move!
  end

  def right_robot
    robot.face_right!
  end

  def left_robot
    robot.face_left!
  end

  def update_direction(direction)
    current_direction.direction = direction
  end
end

Game.run!
