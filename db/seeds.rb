# # This file should ensure the existence of records required to run the application in every environment (production,
# # development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Example:
# #
# #   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
# #     MovieGenre.find_or_create_by!(name: genre_name)
# #   end
require "net/http"
require "json"
require "uri"

def add_archetypes
  archetype_names = ["A-to-Z", "Albaz", "Abyss Actor", "Adamancipator", "Adventurer Token", "Aesir", "Agent", "Alien", "Ally of Justice", "Altergeist", "Amazemment", "Amazoness", "Amorphage", "Ancient Gear", "Ancient Warriors", "Appliancer", "Aquaactress", "Arcana Force", "Archfiend", "Armed Dragon", "Aroma", "Artifact", "Artmage", "Ashened", "Assault Mode", "Atlantean", "Batteryman", "Battlewasp", "Battlin Boxer", "Beetrooper", "Black Luster", "Blackwing", "Blue-Eyes", "Bounzer", "Bujin", "Burning Abyss", "Buster Blader", "Butterspy", "Bystial", "Centur-Ion", "Charmer", "Chaos", "Chemicritter", "Chronomaly", "Chrysalis", "Cipher", "Cloudian", "Code Talker", "Constellar", "Crusadia", "Crystal Beast", "Crystron", "Cubic", "Cyber", "Cyberdark", "Cyber Dragon", "D.D.", "D/D/", "Danger!", "Darklord", "Dark Magician", "Dark Scorpion", "Dark World", "Deep Sea", "Deskbot", "Despia", "Destiny Hero", "Digital Bug", "Dinomist", "Dinomorphia", "Dinowrestler", "Dododo", "Dogmatika", "Doodle Beast", "Dracoslayer", "Dracotail", "Dragon Ruler", "Dragonmaid", "Dragunity", "Dream Mirror", "Drytron", "Dual Avatar", "Duston", "Earthbound", "Edge Imp", "Edlich", "Elemental Hero", "Elementsaber", "Empowered Warrior", "Endymion", "Evil Eye", "Evil Hero", "Evil Twin / Live Twin", "Evilswarm", "Evoltile", "Exosister ", "Eyes Restrict", "Fabled", "Face Cards", "F.A.", "Fairy Tail", "Familiar-Possessed", "Fiendsmith", "Brotherhood of the Fire Fist", "Fire King", "Fire Warrior", "Flame Swordsman", "Flamvell", "Fleur", "Floowandereeze", "Flower Cardian", "Fluffal", "Forbidden One (Exodia)", "Fortune Fairy", "Fortune Lady", "Fossil Fusion", "Frightfur", "Frog", "Fur Hire", "G Golem", "Gadget", "Gagaga", "Gaia", "Galaxy", "Ganbara", "Gate Guardian", "Gearfried", "Geargia", "Gem-", "Generaider", "Genex", "Ghostrick", "Ghoti", "Gimmick Puppet", "Gishki", "Glacial Beast", "Gladiator Beast", "Goblin", "Goblin Biker", "Gogogo", "Gold Pride", "Gorgonic", "Gouki", "Goyo", "Gravekeeper", "Graydle", "Gunkan", "Gusto", "Harpie", "Hazy Flame", "Heraldic Beast", "Heroic", "Hieratic", "Horus", "Ice Barrier", "Icejade", "Igknight", "Ignister", "Impcantation", "Infernity", "Infernoble", "Infernoid", "Infinitrack", "Invoked", "Inzektor", "Iron Chain", "Junk", "Jurrac", "K9", "Kaiju", "Karakuri", "Kashtira", "Knightmare", "Koa'ki Meiru", "Kozmo", "Krawler", "Kuriboh", "Labrynth", "Laval", "Libromancer", "Lightray", "Lightsworn", "Lswarm", "Lunalight", "Lyrilusc", "Machina", "Madolche", "Magical Musket", "Magician", "Magikey", "Magistus", "Majespecter", "Malefic", "Maliss", "Mannadium", "Marincess", "Masked HERO", "Materiactor", "Mathmech", "Mayakashi", "Mecha Phantom Beast", "Megalith", "Mekk-Knight", "Meklord", "Melffy", "Melodious", "Memento", "Mermail", "Metalfoes", "Metalmorph", "Metaphys", "Mikanko", "Millennium", "Mimighoul", "Mist Valley", "Mitsurugi", "Monarch", "Morphtronic", "Mystical Beast", "Mythical Beast", "Myutant", "Naturia", "Nekroz", "Nemleria", "Neo-Spacian", "Neos", "Nemeses", "Nephthys", "Nimble", "Ninja", "Noble Knight", "Nordic", "Nouvelles", "Number", "Numeron", "Odd-Eyes", "Ogdoadic", "Orcust", "Ojama", "P.U.N.K.", "Paleozoic", "Parshath", "Penguin", "Performage", "Performapal", "Phantasm Spiral", "Phantom Beast", "Photon", "Plunder Patroll", "Prank-Kids", "Predaplant", "Prediction Princess", "Purrely", "PSY-Framegear", "Psychic", "Qli", "R.B.", "Ragnaraika", "Raidraptor", "Red-Eyes", "Regenesis", "Reptilianne", "Rescue-ACE", "Resonator", "Rikka", "Risebell", "Ritual Beast", "Roid", "Rokket", "Rose", "Runick", "Ryu-Ge", "Ryzeal", "Sangen", "S-Force", "Salamangreat", "Scareclaw", "Scrap", "Shaddoll", "Shark", "Shining Sarcophagus", "Shinobird", "Shiranui", "Silent Magician", "Silent Swordsman", "Simorgh", "Sinful Spoils", "Six Samurai", "Skull Servant", "Sky Striker", "Snake-Eye", "Solfachord", "Speedroid", "Spellbook", "Sphinx", "Springan", "Spyral", "Spellcaster", "Spright", "Star Sereph", "Starry Knight", "Steelswarm", "Subterror", "Sunavalon", "Superheavy Samurai", "Supreme King", "Swordsoul", "Sylvan", "Symphonic Warrior", "Synchron", "Tearlaments", "Tellarknight", "Tenyi", "T.G.", "The Agent", "The Phantom Knights", "The Weather", "Therion", "Thunder Dragon", "Time Thief", "Timelord", "Tindangle", "Tistina", "Toon", "Toy", "Traptrix", "Triamid", "Tri-Brigade", "Trickstar", "True King", "Twilightsworn", "U.A.", "Unchained", "Ursarctic", "Utopia", "Vaalmonica", "Vampire", "Vanquish Soul", "Vassal", "Vaylantz", "Vendread", "Venom", "Virtual World", "Visas Starfrost", "Vision HERO", "Voiceless Voice", "Volcanic", "Vylon", "War Rock", "Watt", "White Forest", "Wind-up", "Windwitch", "Witchcrafter", "World Chalice", "World Legacy", "Worm", "Xtra HERO", "Xyz", "X-Saber", "Yang Zing", "Yosenju", "Yubel", "Yummy", "Zefra", "Zombie", "Zoodiac", "Zubaba", "ZW -"]
  archetypes_without_name = ["Chimera"]
  archetype_names = archetype_names.concat(archetypes_without_name).sort
  archetype_names.each { |name| Archetype.create!(name: name) }
end

def add_board_types
  BoardType::TYPES.each { |type| BoardType.create!(name: type) }
end

def fetch_and_add_all_cards
  url = URI("https://db.ygoprodeck.com/api/v7/cardinfo.php")
  response = Net::HTTP.get(url)
  cards = JSON.parse(response)["data"]

  cards.each do |card|
    new_card = Card.new(name: card["name"], description: card["desc"], card_type: card["race"])

    case card["frameType"]
    when "skill", "token" # nothing
    when "spell"
      new_card.type = "SpellCard"
      new_card.save!
    when "trap"
      new_card.type = "TrapCard"
      new_card.save!
    else
      new_card.type = "MonsterCard"
      new_card.card_type = card["frameType"]
      new_card.save!
      details = MonsterCardDetail.create!(monster_type: card["race"].downcase, monster_attribute: card["attribute"].downcase, is_effect: card["typeline"].include?("Effect"), atk: card["atk"], def: card["def"], level: card["level"], card: new_card)
    end
  end
end

def add_users
  user = User.create!(username: "testhands.com", email_address: "1@1.1", password: "aaaaaaaa")
end

def create_deck(tier:, advice:, user:, archetype_names:, boards:)
  ActiveRecord::Base.transaction do
    deck = Deck.create!(tier: tier, advice: advice, user: user)
    archetype_names.each { |name| deck.archetypes << Archetype.find_by!(name: name) }

    boards.each do |board|
      new_board = Board.create!(information: board[:information], deck_summons: board[:deck_summons], hand_summons: board[:hand_summons], gy_banishment_summons: board[:gy_banishment_summons], board_type: BoardType.find_by!(name: board[:board_type]), deck: deck)
      board[:cards].each do |card|
        new_board.board_cards.create!(position: card[:position], card: Card.find_by!(name: card[:name]))
      end
    end
  end
end

def remove_decks
  BoardCard.delete_all
  Board.delete_all
  DeckArchetype.delete_all
  Deck.delete_all
end

def add_decks
  create_deck(
    tier: 3,
    advice: "Imperms/Veilers usually aren't good because the enemy can just chain Chimera Fusion to it, but if you have it always use it on Berfomet. Always use Ash Blossom on Berfomet, not Mirror Swordknight because this deck plays 2 Berfomets and it really likes when it can resolve it, so by Ash-ing one you waste 1 of the 2 Berfomets.\n\nDon't forget about Mirror Swordknight, Cornfield Coatl and the 2 Chimera fusions in the grave, they have effects. Also, if the you broke the board and you go battle phase, if your opponent uses Chimera in the gy to summon Mirror Swordknight (which can't be destroyed by battle) can you still win?\n\nArtmage Diactorus only negates when the player has 3 types, but if you think you are safe the player can use a Chimera fusion monster in the grave to get the 3rd type on field. Also if you destroy Diactorus before it uses it's effect it can summon Medius The Pure from deck and he can summon Artmage Power Patron from deck which can fuse into another, keep that in mind and try to get rid of him without destroying him.",
    user: User.find_by!(username: "testhands.com"),
    archetype_names: ["Artmage", "Chimera"],
    boards: [
      {
        deck_summons: 4,
        hand_summons: 1,
        gy_banishment_summons: 2,
        information: "Discard 1 before drawing your sixth card.",
        board_type: "Full Combo 1",
        cards: [
          {
            name: "Berfomet the Mythical King of Phantom Beasts",
            position: "emz1"
          },
          {
            name: "Mirror Swordknight",
            position: "mmz1"
          },
          {
            name: "Artmage Diactorus",
            position: "mmz3"
          },
          {
            name: "Artmage Vandalism -Assault-",
            position: "stz3"
          },
          {
            name: "Cornfield Coatl",
            position: "graveyard"
          },
          {
            name: "Chimera the King of Phantom Beasts",
            position: "graveyard"
          },
          {
            name: "Chimera Fusion",
            position: "graveyard"
          },
          {
            name: "Medius the Pure",
            position: "graveyard"
          },
          {
            name: "Artmage Power Patron",
            position: "graveyard"
          },
          {
            name: "Chimera the King of Phantom Beasts",
            position: "graveyard"
          },
          {
            name: "Big-Winged Berfomet",
            position: "graveyard"
          },
          {
            name: "Gazelle the King of Mythical Claws",
            position: "graveyard"
          },
          {
            name: "Master Tao the Chanter",
            position: "graveyard"
          },
          {
            name: "Master Tao the Chanter",
            position: "banishment"
          },
          {
            name: "Master Tao the Chanter",
            position: "banishment"
          },
          {
            name: "Master Tao the Chanter",
            position: "banishment"
          },
          {
            name: "Master Tao the Chanter",
            position: "banishment"
          },
          {
            name: "Master Tao the Chanter",
            position: "deck"
          },
          {
            name: "Master Tao the Chanter",
            position: "deck"
          },
          {
            name: "Master Tao the Chanter",
            position: "deck"
          },
          {
            name: "Master Tao the Chanter",
            position: "deck"
          },
          {
            name: "Master Tao the Chanter",
            position: "extra_deck"
          },
          {
            name: "Master Tao the Chanter",
            position: "extra_deck"
          },
          {
            name: "Master Tao the Chanter",
            position: "extra_deck"
          }
          
        ]
      }
    ])
end

# add_archetypes
# add_board_types
# fetch_and_add_all_cards
remove_decks
add_decks