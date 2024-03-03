module Processor
  class Players
    include UsesState
    PLAYER_WIDTH = 10
    PLAYER_HEIGHT = 10

    def self.tick(args)
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
      end
    end

    def self.setup_roster
      this.roster = ROSTER_NAMES.dup
    end

    def self.this
      state.game.players
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
