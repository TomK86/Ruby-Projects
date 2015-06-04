################
## THE ESCAPE ##
################
#
# A text-based dungeon crawler game
# Developed by Tom Kelly, 2015
#
# This master file contains the Game and Map classes
# Requires room.rb
#

require "./room.rb"


class Game
  def initialize(room_map)
    @room_map = room_map
  end

  def play()
    puts "\n" * 60
    puts "\n============================  THE ESCAPE  ============================"
    puts "\nWelcome to The Escape!  The goal of this game is to find a way to"
    puts "escape the strange prison you're in.  You do this by entering commands"
    puts "in response to the text prompt.  KEYWORDS will be capitalized to"
    puts "help you figure out what to do next.  Good luck!"
    puts "\n======================================================================"
    puts "\n" * 2

    current_room = @room_map.start_room
    last_room = @room_map.end_room

    while current_room != last_room
      next_room_name = current_room.enter()
      current_room = @room_map.next_room(next_room_name)
    end

    current_room.enter()
  end
end


class Map
  def initialize()
    @start_room = StartRoom.new()
    @hall_room = HallRoom.new()
    @key_room = KeyRoom.new()
    @lock_room = LockRoom.new()
    @hatch_room = HatchRoom.new()
    @sphinx_room = SphinxRoom.new()
    @troll_room = TrollRoom.new()
    @junk_room = JunkRoom.new()
    @end_room = EndRoom.new()
  end

  attr_reader :start_room, :end_room

  def next_room(room_name)
    case room_name
    when 'START'
      next_room(@start_room.enter())
    when 'HALL'
      next_room(@hall_room.enter())
    when 'KEY'
      next_room(@key_room.enter())
    when 'LOCK'
      next_room(@lock_room.enter())
    when 'HATCH'
      next_room(@hatch_room.enter())
    when 'SPHINX'
      next_room(@sphinx_room.enter())
    when 'TROLL'
      next_room(@troll_room.enter())
    when 'JUNK'
      next_room(@junk_room.enter())
    when 'END'
      @end_room.enter()
    else
      puts "Invalid room name: #{room_name}"
      exit(1)
    end
  end
end


my_map = Map.new()
my_game = Game.new(my_map)
my_game.play()

