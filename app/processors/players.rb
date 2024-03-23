module Processor
  class Players
    include UsesState
    PLAYER_WIDTH = 10
    PLAYER_HEIGHT = 10
    PLAYER_SPEED = 2

    def self.tick
      process_inputs
      this.active_players.each do |player|
        move_player(player)
      end
    end

    def self.move_player(player)
      return if player.move_to_x == player.x && player.move_to_y == player.y && player.queued_moves.empty?

      # Project the next move
      # Check collisions against buddies/nearby landscape

      angle = args.geometry.angle_to(player, [player.move_to_x, player.move_to_y])
      horizontal_component = Math.cos(angle * DEGREES_TO_RADIANS)
      vertical_component = Math.sin(angle * DEGREES_TO_RADIANS)

      player.x = player.move_to_x if (player.x - player.move_to_x).abs < PLAYER_SPEED
      player.y = player.move_to_y if (player.y - player.move_to_y).abs < PLAYER_SPEED

      player.x = (player.x + (horizontal_component * PLAYER_SPEED)).clamp(0, world.dimensions.w - player.w) if player.x != player.move_to_x
      player.y = (player.y + (vertical_component * PLAYER_SPEED)).clamp(0, world.dimensions.h - player.h) if player.y != player.move_to_y

      if player.x == player.move_to_x && player.y == player.move_to_y
        if player.queued_moves.any?
          next_move = player.queued_moves.shift
          player.move_to_x = next_move.x
          player.move_to_y = next_move.y
        end
      end
    end

    DEGREES_TO_RADIANS = Math::PI / 180

    def self.process_inputs
      process_mouse_inputs
      process_keyboard_inputs
    end

    def self.process_mouse_inputs
      return unless args.inputs.mouse.click

      next_move = [
        camera.viewport.x + args.inputs.mouse.click.point.x,
        camera.viewport.y + args.inputs.mouse.click.point.y
      ]
      all_moves = this.active_players.map do |player|
        [player.x, player.y]
      end
      all_moves.unshift(next_move)
      all_moves.reverse!
      puts "all moves: #{all_moves}"
      this.active_players.each_with_index do |player, index|
        player.queued_moves = all_moves[-(index + 1)..]
        player.move_to_x = player.x
        player.move_to_y = player.y
      end
    end

    def self.process_keyboard_inputs
      movement = [0, 0]
      movement.y += (PLAYER_SPEED * 2) if args.inputs.keyboard.key_held.up || args.inputs.keyboard.key_held.w
      movement.y -= (PLAYER_SPEED * 2) if args.inputs.keyboard.key_held.down || args.inputs.keyboard.key_held.s
      movement.x += (PLAYER_SPEED * 2) if args.inputs.keyboard.key_held.right || args.inputs.keyboard.key_held.d
      movement.x -= (PLAYER_SPEED * 2) if args.inputs.keyboard.key_held.left || args.inputs.keyboard.key_held.a

      return if movement.x.zero? && movement.y.zero?

      next_move = [leader.x + movement.x, leader.y + movement.y]
      next_move.x = (next_move.x).clamp(0, world.dimensions.w - leader.w)
      next_move.y = (next_move.y).clamp(0, world.dimensions.h - leader.h)
      leader.queued_moves = [next_move]
    end

    def self.active_player_count
      this.active_player_count
    end

    def self.active_player_count=(val)
      this.active_player_count = val
    end

    def self.active_players
      this.active_players
    end

    def self.active_players=(val)
      this.active_players = val
    end

    def self.roster
      this.roster
    end

    def self.roster=(val)
      this.roster = val
    end

    def self.leader
      this.active_players.first
    end

    def self.leader_moving?
      leader.x != leader.move_to_x || leader.y != leader.move_to_y
    end

    def self.other_players
      this.active_players[1..]
    end

    def self.setup(level:)
      if level == :one
        this.active_player_count = 5
      end
      load_active_players
      position_players(level: level)
    end

    def self.load_active_players
      this.active_players ||= []

      return if this.active_players.length == this.active_player_count

      init_count = this.active_player_count - this.active_players.length

      init_count.times do
        player_name = this.roster.delete_at(0)
        this.active_players << state.new_entity_strict(
          :player,
          x: 300,
          y: 300,
          move_to_x: 300,
          move_to_y: 300,
          queued_moves: [],
          w: PLAYER_WIDTH,
          h: PLAYER_HEIGHT,
          text: player_name,
          path: "sprites/player.png"
        )
      end
    end

    def self.position_players(level:)
      central_x = 100
      central_y = 100

      if level == :one
        central_x = 100
        central_y = 100
      end

      this.active_players.each_with_index do |player, index|
        player.x = central_x
        player.y = central_y
        player.x -= 20 if index == 1 || index == 3
        player.x += 20 if index == 2 || index == 4
        player.y += 20 if index == 1 || index == 2
        player.y -= 20 if index == 3 || index == 4

        player.move_to_x = player.x
        player.move_to_y = player.y
      end
    end

    def self.setup_roster
      this.roster = ROSTER_NAMES.dup
    end

    def self.this
      state.game.players
    end

    def self.world
      state.game.world
    end

    def self.camera
      state.game.camera
    end

    ROSTER_NAMES = %w[
      Jools Jops Stoo Rj Ubik Cj Chris Pete Tadger Hector Elroy Softy Mac Bomber Stan
      Tosh Brains Norm Buster Spike Browny Murphy Killer Abdul Spotty Goofy Donald Windy
      Nifta Denzil Cedric Alf Marty Cecil Wally Pervy Jason Roy Peewee Arnie Lofty Tubby
      Porky Norris Bugsy Greg Gus Ginger Eddy Steve Hugo Zippy Sonny Willy Mario Luigi Bo
      Johan Colin Queeny Morgan Reg Peter Brett Matt Vic Hut Bud Brad Ashley Les Rex Louis
      Pedro Marco Leon Ali Tyson Tiger Frank Reuben Leyton Josh Judas Aj Lex Butch Bison
      Gary Luther Kermit Brian Ray Freak Leroy Lee Banjo Beaker Basil Bonzo Kelvin Ronnie]
      # Rupert Roo Dan Jimmy Ronnie Bob Don Tommy Eddie Ozzy Mark Paddy Arnold Tony Teddy Dom
      # Theo Martin Chunky Jon Ben Girly Julian Gary Pizza Mark Ciaran Jock Gravy Trendy Neil
      # Derek Ed Steve Biff Steve Paul Stuart Randy Loreta Suzie Pumpy Urmer Roger Pussy Meat
      # Beefy Harry Tiny Howard Morris Thor Rev Duke Willy Micky Chas Melony Craig Sidney
      # Parson Rowan Smelly Dok Stew Donald Adrian Pat Iceman Goose Dippy Viv Fags Bunty Noel
      # Bono Edge Robbie Sean Miles Jimi Gordon Val Hobo Fungus Toilet Lampy Marcus Pele
      # Hubert James Tim Saul Andy Alf Silky Simon Handy Sid George Joff Barry Dick Gil Nick
      # Ted Phil Woody Wynn Alan Pip Mickey Justin Karl Maddog Horace Harold Gazza Spiv Foxy
      # Ned Bazil Oliver Rett Scot Darren Edwin Moses Noah Seth Buddah Mary Pilot Mcbeth Mcduff
      # Belly Mathew Mark Luke John Aslam Ham Shem Joshua Jacob Esaw Omar Saul Enoch Obadia
      # Daniel Samuel Ben Robbo Joebed Ismael Isreal Isabel Isarat Monk Blip Bacon Danube
      # Friend Darryl Izzy Crosby Stills Nash Young Cheese Salami Prawn Radish Egbert Edwy
      # Edgar Edwin Edred Eggpie Bros Sonic Ziggy Alfred Siggy Hilda Snell Sparks Spook Topcat
      # Benny Dibble Benker Dosey Beaky Joist Pivot Tree Bush Grass Seedy Tin Rollo Zippo Nancy
      # Larry Iggy Nigel Jamie Jesse Leo Virgo Garth Fidel Idi Che Kirk Spock Maccoy Chekov Uhura
      # Bones Vulcan Fester Jethro Jimbob Declan Dalek Hickey Chocco Goch Pablo Renoir Rolf Dali
      # Monet Manet Gaugin Chagal Kid Hully Robert Piers Raith Jeeves Paster Adolf Deiter Deni
      # Zark Wizkid Wizard Iain Kitten Gonner Waster Loser Fodder]
  end
end
