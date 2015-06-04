################
## THE ESCAPE ##
################
#
# A text-based dungeon crawler game
# Developed by Tom Kelly, 2015
#
# This file contains the Room class/subclasses and the 'key' global variables
# Required by escape.rb
#

$key_0 = false
$key_1 = false
$key_2 = false
$key_3 = false

class Room
  def enter()
    puts "\nThis Room has not been initialized. Make a subclass and implement enter()."
    exit(1)
  end

  def prompt()
    print "\n> "
    return $stdin.gets.chomp
  end
end


class StartRoom < Room
  def initialize()
    @door_open = false
  end

  def enter()
    if @door_open
      puts "\nYou find yourself back in the barren concrete room."
    else
      puts "\nYou wake up on the floor of a cold, damp room.  You slowly rise to your"
      puts "feet as your eyes adjust to the darkness.  Perhaps you should LOOK around?"
    end

    loop do
      response = prompt()

      if @door_open
        if response.include? "look"
          puts "\nThe walls, floor, and ceiling are made of solid concrete.  In front"
          puts "of you, the DOOR to the hallway is wide open, just begging for you to"
          puts "GO through it."
        elsif response.include?("open") && response.include?("door")
          puts "\nIt's already open!"
        elsif response.include?("close") && response.include?("door")
          puts "\nThe hinges seem to have rusted over.  This door isn't going anywhere!"
        elsif response.include? "go"
          puts "\nYou walk through the doorway..."
          return 'HALL'
        else
          puts "\nThat doesn't make any sense..."
        end
      else
        if response.include? "look"
          puts "\nThe walls, floor, and ceiling are made of solid concrete.  The only"
          puts "light in the room is coming from a thin crack at the bottom of a large"
          puts "DOOR in front of you."
        elsif response.include?("open") && response.include?("door")
          puts "\nYou turn the doorknob, and the door slowly opens with an ear-piercing squeak."
          @door_open = true
        elsif response.include?("close") && response.include?("door")
          puts "\nIt's already closed!"
        else
          puts "\nThat doesn't make any sense..."
        end
      end
    end
  end
end


class HallRoom < Room
  def enter()
    puts "\nYou find yourself in a hallway with one door to your LEFT and another to your RIGHT."

    loop do
      response = prompt()

      if response.include? "look"
        puts "\nAll of the doors in the hallway appear to be unlocked.  You could"
        puts "GO LEFT or GO RIGHT, and you can always GO BACK the way you came."
      elsif response.include?("go") && response.include?("left")
        puts "\nYou open the left door and step through..."
        return 'KEY'
      elsif response.include?("go") && response.include?("right")
        puts "\nYou open the right door and step through..."
        return 'LOCK'
      elsif response.include?("go") && response.include?("back")
        puts "\nYou go through the door behind you..."
        return 'START'
      else
        puts "\nThat doesn't make any sense..."
      end
    end
  end
end


class KeyRoom < Room
  def initialize()
    @drawer_open = false
  end

  def enter()
    puts "\nYou enter a dimly-lit room with old, dusty curtains covering the walls."

    loop do
      response = prompt()

      if $key_0
        if response.include? "look"
          puts "\nA single candle sits on a table in the center of the room.  A DRAWER"
          puts "in the table is open, but nothing is inside.  Nothing left to do but"
          puts "GO BACK the way you came..."
        elsif response.include?("open") && response.include?("drawer")
          puts "\nIt's already open!"
        elsif response.include?("close") && response.include?("drawer")
          puts "\nThe drawer appears to be stuck, and won't close again."
        elsif response.include?("go") && response.include?("back")
          puts "\nYou go through the door behind you..."
          return 'HALL'
        else
          puts "\nThat doesn't make any sense..."
        end
      elsif @drawer_open
        if response.include? "look"
          puts "\nA single candle sits on a table in the center of the room.  A DRAWER"
          puts "in the table is open, and a small metal KEY is inside.  Maybe you should"
          puts "try to TAKE it?"
        elsif response.include?("take") && response.include?("key")
          puts "\nYou take the key from the drawer and put it in your pocket."
          $key_0 = true
        elsif response.include?("open") && response.include?("drawer")
          puts "\nIt's already open!"
        elsif response.include?("close") && response.include?("drawer")
          puts "\nThe drawer appears to be stuck, and won't close again."
        elsif response.include?("go") && response.include?("back")
          puts "\nYou go through the door behind you..."
          return 'HALL'
        else
          puts "\nThat doesn't make any sense..."
        end
      else
        if response.include? "look"
          puts "\nA single candle sits on a table in the center of the room.  Stepping"
          puts "closer, you notice that the table has a DRAWER.  Maybe you should try"
          puts "to OPEN it?"
        elsif response.include?("open") && response.include?("drawer")
          puts "\nYou slide open the drawer to reveal a small metal KEY."
          @drawer_open = true
        elsif response.include?("close") && response.include?("drawer")
          puts "\nIt's already closed!"
        elsif response.include?("go") && response.include?("back")
          puts "\nYou go through the door behind you..."
          return 'HALL'
        else
          puts "\nThat doesn't make any sense..."
        end
      end
    end
  end
end


class LockRoom < Room
  def initialize()
    @door_open = false
  end

  def enter()
    puts "\nThis room is covered in sheets of thick steel, like a bank vault."

    loop do
      response = prompt()

      if @door_open
        if response.include? "look"
          puts "\nA huge DOOR lies in front of you, opened just enough for"
          puts "you to be able to GO through it."
        elsif response.include?("open") && response.include?("door")
          puts "\nIt's already open!"
        elsif response.include?("close") & response.include?("door")
          puts "\nYeah, that's not gonna happen."
        elsif response.include?("go") && response.include?("back")
          puts "\nYou go through the door behind you..."
          return 'HALL'
        elsif response.include? "go"
          puts "\nYou squeeze through the door into the next room..."
          return 'HATCH'
        else
          puts "\nThat doesn't make any sense..."
        end
      else
        if response.include? "look"
          puts "\nA huge DOOR lies in front of you.  It looks heavy, but you could"
          puts "try to OPEN it..."
        elsif response.include?("open") && response.include?("door")
          if $key_0
            puts "\nYou slide the key into the keyhole, and turn it.  You push on the door"
            puts "with all your strength, and with a loud groan it opens just wide enough"
            puts "for you to squeeze through."
            @door_open = true
          else
            puts "\nYou push on the huge door, but it won't budge!  Looking closer, you"
            puts "notice a small keyhole.  Maybe the door is locked?  You should look"
            puts "around for a key."
          end
        elsif response.include?("close") && response.include?("door")
          puts "\nIt's already closed!"
        elsif response.include?("go") && response.include?("back")
          puts "\nYou go through the door behind you..."
          return 'HALL'
        else
          puts "\nThat doesn't make any sense..."
        end
      end
    end
  end
end


class HatchRoom < Room
  def initialize()
    @hatch_open = false
  end

  def enter()
    puts "\nYou enter a large, brightly-lit room with many doors."

    loop do
      response = prompt()

      if response.include? "look"
        if @hatch_open
          puts "\nThere are three open doorways in front of you: one to the LEFT,"
          puts "one to the RIGHT, and one in the MIDDLE.  Below your feet is a"
          puts "large, open HATCH."
        else
          puts "\nThere are three open doorways in front of you: one to the LEFT,"
          puts "one to the RIGHT, and one in the MIDDLE.  Below your feet is a"
          puts "large, locked HATCH with three keyholes."
        end
      elsif response.include?("open") && response.include?("hatch") 
        if @hatch_open
          puts "\nIt's already open!"
        elsif $key_1 && $key_2 && $key_3
          puts "\nYou insert the three keys into their respective keyholes, and"
          puts "give them all a turn.  The hatch blows open with a gust of"
          puts "fresh air.  You're almost there!"
          @hatch_open = true
        else
          puts "\nYou pull on the hatch, but it won't budge.  Looks like you need"
          puts "to find those three keys!"
        end
      elsif response.include?("go") && response.include?("hatch")
        if @hatch_open
          puts "\nYou climb down through the hatch into a tunnel..."
          return 'END'
        else
          puts "\nYou've got to open it first!"
        end
      elsif response.include?("go") && response.include?("left")
        puts "\nYou go through the left doorway..."
        return 'SPHINX'
      elsif response.include?("go") && response.include?("middle")
        puts "\nYou go through the middle doorway..."
        return 'TROLL'
      elsif response.include?("go") && response.include?("right")
        puts "\nYou go through the right doorway..."
        return 'JUNK'
      elsif response.include?("go") && response.include?("back")
        puts "\nYou go through the door behind you..."
        return 'LOCK'
      else
        puts "\nThat doesn't make any sense..."
      end
    end
  end
end


class SphinxRoom < Room
  def initialize()
    @mouth_open = false
  end

  def enter()
    puts "\nYou enter an ancient-looking room made of dusty old stone."

    loop do
      response = prompt()

      if response.include? "tablet"
        puts "\nThe tablet reads:"
        puts "'I have no arms or legs, but I eat with a fork every day."
        puts "What am I?'"
      elsif response.include? "snake"
        puts "\nYou hear a low rumbling noise as the sphinx's mouth slowly"
        puts "opens, revealing a small KEY!"
        @mouth_open = true
      elsif response.include? "look"
        puts "\nA sphinx statue sits in the center of the room with a"
        puts "mysterious smile on its face.  In front of the statue"
        puts "lies a stone TABLET with some words inscribed onto it."
      elsif @mouth_open && response.include?("take") && response.include?("key")
        puts "\nYou take the key from the sphinx's mouth, and put it in"
        puts "your pocket."
        $key_1 = true
      elsif response.include?("go") && response.include?("back")
        puts "\nYou go through the door behind you..."
        return 'HATCH'
      else
        puts "\nThat doesn't make any sense..."
      end
    end
  end
end


class TrollRoom < Room
  def initialize()
    @asleep = true
  end

  def enter()
    if @asleep
      puts "\nYou walk into a cold, damp cave.  The sounds of snoring echo off the walls."
    else
      puts "\nYou walk into a cold, damp cave.  Nigel waves happily at you."
    end

    loop do
      response = prompt()

      if @asleep
        if response.include? "look"
          puts "\nA huge, ugly troll is sleeping against the wall in front of you."
          puts "You notice a small KEY hanging from a string around its neck."
          puts "You shudder as you think about what an angry troll might do to you"
          puts "if you were to wake it up from its nap."
        elsif response.include?("troll") || response.include?("key")
          puts "\nUh oh!  You must have agitated the troll, because it woke up!"
          puts "The troll rises to its feet, towering above you.  It opens its"
          puts "huge mouth, and you have to hold your breath to survive the"
          puts "horrible stench!  You brace yourself for the worst..."
          puts "\n'Oh jeez, look at the time!  Thanks for wakin' me up, mate."
          puts "The name's Nigel.  Nice to meet you!'"
          @asleep = false
        elsif response.include?("go") && response.include?("back")
          puts "\nYou go through the door behind you..."
          return 'HATCH'
        else
          puts "\nThat doesn't make any sense..."
        end
      else
        if response.include? "look"
          puts "\nNigel looks at you curiously."
          puts "'Say, if you're looking for more of those keys, I think I left one"
          puts "underneath some CLOTHES in my bedroom.  See you around, mate!'"
        elsif response.include? "key"
          puts "\nThe troll -- er, Nigel -- points at the key on his neck."
          puts "'What, this thing?  Sure, you can have it.  The string was starting"
          puts "to chafe, anyway.'"
          puts "\nNigel yanks the key from his neck and hands it to you.  You thank"
          puts "him, and put it in your pocket.  Who knew trolls could be so nice?"
          $key_2 = true
        elsif response.include?("go") && response.include?("back")
          puts "\nNigel waves goodbye as you go through the door behind you..."
          return 'HATCH'
        else
          puts "\nNigel raises an eyebrow at you."
          puts "'You alright, mate?'"
        end
      end
    end
  end
end


class JunkRoom < Room
  def enter()
    puts "\nYou stumble into a room full of boxes of what appears to be junk."

    loop do
      response = prompt()

      if ( response.include?("silverware") ||
           response.include?("dishes") ||
           response.include?("records") ||
           response.include?("magazines") ||
           response.include?("books") ||
           response.include?("games") ||
           response.include?("jewelry") ||
           response.include?("other") )
        puts "\nYou dig around in the box for a while, but you can't find anything useful."
      elsif response.include? "bed"
        puts "\nWith some effort, you manage to lift up the heavy matress.  Unfortunately,"
        puts "you find nothing but a stinky green stain underneath."
      elsif response.include? "clothes"
        puts "\nAfter digging through the clothes for a while, you finally find a small KEY"
        puts "inside the pocket of some very large trousers.  You take it and put it into"
        puts "your own pocket."
        $key_3 = true
      elsif response.include? "look"
        puts "\nYou're surrounded by numerous labeled boxes of junk.  There's all kinds of stuff:"
        puts "SILVERWARE, DISHES, RECORDS, MAGAZINES, BOOKS, GAMES, CLOTHES, JEWELRY, and  OTHER."
        puts "There's also a rather large BED stuffed into the corner at the back of the room."
      elsif response.include?("go") && response.include?("back")
        puts "\nYou go through the door behind you..."
        return 'HATCH'
      else
        puts "\nThat doesn't make any sense..."
      end
    end
  end
end


class EndRoom < Room
  def enter()
    puts "\nYou shield your eyes as you emerge into the daylight.  You look back just"
    puts "in time to see the prison start to crumble to the ground!  Time seems to"
    puts "slow down as you turn to run away, action-hero style, from the fiery"
    puts "explosion.  You throw yourself to the ground as the inferno is about to"
    puts "sweep over you."
    puts "\nAfter getting up and dusting yourself off, you look back at the destruction,"
    puts "grateful to be alive and free from that dark prison.  Time to go home..."
    puts "\n" * 2
    puts "\n==========================================================================="
    puts "\n                         CONGRATULATIONS, YOU WON!                         "
    puts "\n==========================================================================="
    puts "\n" * 2
    puts "Poor Nigel..."

    exit(1)
  end
end

