module Processor
  class Players
    include UsesState
    PLAYER_WIDTH = 10
    PLAYER_HEIGHT = 10
    PLAYER_SPEED = 2

    def self.tick
      process_inputs
      ::Processor::Players.this.active_players.each do |player|
        move_player(player)
      end
    end

    def self.move_player(player)
      return if player.move_to_x == player.x && player.move_to_y == player.y

      if player.x < player.move_to_x
        player.x += player.speed
      elsif player.x > player.move_to_x
        player.x -= player.speed
      end
      if player.y < player.move_to_y
        player.y += player.speed
      elsif player.y > player.move_to_y
        player.y -= player.speed
      end

      player.x = player.move_to_x if (player.x - player.move_to_x).abs < player.speed
      player.y = player.move_to_y if (player.y - player.move_to_y).abs < player.speed

      player.x = 0 if player.x < 0
      player.y = 0 if player.y < 0
      player.x = (world.dimensions.w - player.w) if player.x > (world.dimensions.w - player.w)
      player.y = (world.dimensions.h - player.h) if player.y > (world.dimensions.h - player.h)
    end

    def self.process_inputs
      ::Processor::Players.this.active_players.each do |player|
        player.move_to_y += player.speed if args.inputs.keyboard.key_held.up || args.inputs.keyboard.key_held.w
        player.move_to_y -= player.speed if args.inputs.keyboard.key_held.down || args.inputs.keyboard.key_held.a
        player.move_to_x -= player.speed if args.inputs.keyboard.key_held.left || args.inputs.keyboard.key_held.s
        player.move_to_x += player.speed if args.inputs.keyboard.key_held.right || args.inputs.keyboard.key_held.d
      end
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

    def self.active_players
      this.active_players
    end

    def self.active_players=(val)
      this.active_players = val
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
          speed: PLAYER_SPEED,
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
