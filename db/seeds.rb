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
    tier: 2,
    advice: "- Don't forget about Mirror Swordknight, Cornfield Coatl and the 2 Chimera fusion monsters in the grave, they have effects.\n\n- Imperms/Veilers usually aren't good because the enemy can just chain Chimera Fusion to it, but if you have it always use it on Berfomet. Always use Ash Blossom on Berfomet, not Mirror Swordknight because this deck plays 2 Berfomets and it really likes when it can resolve it, so by Ash-ing one you waste 1 of the 2 Berfomets.\n\n- If you want to play the deck, Chimera Fusion adds itself if you have Chimera the Flying Mythical Beast in your field OR GRAVEYARD!!\n\n- If the you broke the board and you go battle phase, if your opponent uses a Chimera monster in the gy to summon Mirror Swordknight (which can't be destroyed by battle) can you still win?\n\n- Artmage Diactorus only negates when the player has 3 types, but if you think you are safe the player can use a Chimera monster in the grave to get the 3rd type on field. Also if you destroy Diactorus before it uses it's effect it can summon Medius The Pure from deck and he can summon Artmage Power Patron from deck which can fuse into another, keep that in mind and try to get rid of him without destroying him.",
    user: User.find_by!(username: "testhands.com"),
    archetype_names: ["Artmage", "Chimera"],
    boards: [
      {
        deck_summons: 4,
        hand_summons: 1,
        gy_banishment_summons: 2,
        information: "- Discard 1 random card before drawing your sixth card.\n- If you destroy Diactorus before his negate he will summon Medius and Power Patron from deck and Patron will fuse into another.",
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
            name: "Artmage Diactorus",
            position: "extra_deck"
          }
        ]
      },
      {
        deck_summons: 2,
        hand_summons: 1,
        gy_banishment_summons: 1,
        information: "- Discard 1 random card before drawing your sixth card.\n- Used Mirror Swordknight in your draw phase to summon Berfomet and add Gazelle (so if you drew Ash Blossom 6th card ignore Berfomet, Gazelle and Chimera Fusion in hand, if you drew Fuwalos discard it to draw 1 and another when you Super Poly/Chimera Fusion yourself).\n- Will fuse into Guardian Chimera after Mirror Swordnight grave effect, or if you drew Ash Blossom 6th card into Magnum The Reliever or Dragostapelia if you decide to get Super Poly'd first.",
        board_type: "Full Combo 2",
        cards:[
          {
            name: "Chimera the King of Phantom Beasts",
            position: "emz1"
          },
          {
            name: "Big-Winged Berfomet",
            position: "mmz1"
          },
          {
            name: "Chimera Fusion",
            position: "stz3"
          },
          {
            name: "Super Polymerization",
            position: "stz4"
          },
          {
            name: "Emissary from the House of Wax",
            position: "hand1"
          },
          {
            name: "Gazelle the King of Mythical Claws",
            position: "hand2"
          },
          {
            name: "Chimera Fusion",
            position: "hand3"
          },
          {
            name: "Cornfield Coatl",
            position: "graveyard"
          },
          {
            name: "Mirror Swordknight",
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
            name: "Guardian Chimera",
            position: "extra_deck"
          },
          {
            name: "Magnum the Reliever",
            position: "extra_deck"
          },
          {
            name: "Garura, Wings of Resonant Life",
            position: "extra_deck"
          },
          {
            name: "Mudragon of the Swamp",
            position: "extra_deck"
          },
          {
            name: "Predaplant Dragostapelia",
            position: "extra_deck"
          }
        ]
      },
      {
        deck_summons: 1,
        hand_summons: 1,
        gy_banishment_summons: 1,
        information: "- Mirror Swordknight used effect in your Draw Phase to summon Berfomet and add Gazelle & Chimera Fusion, if you drew Ash Blossom as 6th card ignore those 3, if you drew Fuwalos discard it and draw 1 (Also draw when you decide to Guardian Chimera yourself).\n- Guardian Chimera is untargetable because of Polymerization in the grave.",
        board_type: "Interrupted Once",
        cards:[
            {
              name: "Berfomet the Mythical King of Phantom Beasts",
              position: "emz1"
            },
            {
              name: "Big-Winged Berfomet",
              position: "mmz3"
            },
            {
              name: "Chimera Fusion",
              position: "stz4"
            },
            {
              name: "Mirror Swordknight",
              position: "graveyard"
            },
            {
              name: "Cornfield Coatl",
              position: "graveyard"
            },
            {
              name: "Polymerization",
              position: "graveyard"
            },
            {
              name: "Gazelle the King of Mythical Claws",
              position: "hand1"
            },
            {
              name: "Chimera Fusion",
              position: "hand2"
            },
            {
              name: "Guardian Chimera",
              position: "extra_deck"
            }
        ]
      },
      {
        deck_summons: 1,
        hand_summons: 1,
        gy_banishment_summons: 0,
        information: "- Mirror Swordknight and Coatl in grave, as well as Berfomet in grave to summon one back from banish.",
        board_type: "Interrupted Twice",
        cards:[
            {
              name: "Berfomet the Mythical King of Phantom Beasts",
              position: "emz1"
            },
            {
              name: "Mirror Swordknight",
              position: "graveyard"
            },
            {
              name: "Cornfield Coatl",
              position: "graveyard"
            }
        ]
      },
      {
        deck_summons: 0,
        hand_summons: 2,
        gy_banishment_summons: 0,
        information: "- Nightmare Apprentice is in defense position.",
        board_type: "Interrupted 3+ Times",
        cards:[
            {
              name: "Nightmare Apprentice",
              position: "mmz3"
            },
            {
              name: "Emissary from the House of Wax",
              position: "hand1"
            }
        ]
      },
      {
        deck_summons: 3,
        hand_summons: 1,
        gy_banishment_summons: 2,
        information: "- Discard 1 random card before drawing your sixth card.\n- Chain to the first thing in main phase Artmage Power Patron will Fuse Into Diactorus.",
        board_type: "Through Fuwalos",
        cards:[
          {
            name: "Berfomet the Mythical King of Phantom Beasts",
            position: "emz1"
          },
          {
            name: "Mirror Swordknight",
            position: "mmz1"
          },
          {
            name: "Artmage Power Patron",
            position: "mmz3"
          },
          {
            name: "Artmage Vandalism -Assault-",
            position: "stz3"
          },
          {
            name: "Medius the Pure",
            position: "hand1"
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
            name: "Artmage Diactorus",
            position: "extra_deck"
          }
        ]
      },
      {
        deck_summons: 2,
        hand_summons: 1,
        gy_banishment_summons: 1,
        information: "- In the Draw Phase Mirror Swordknight used it's effect to summon Berfomet from deck and add Gazelle, if you drew ash ignore them, and chimera fusion will summon Magnum The Reliever",
        board_type: "Through Droll",
        cards:[
          {
            name: "Berfomet the Mythical King of Phantom Beasts",
            position: "emz1"
          },
          {
            name: "Big-Winged Berfomet",
            position: "mmz3"
          },
          {
            name: "Chimera Fusion",
            position: "stz3"
          },
          {
            name: "Gazelle the King of Mythical Claws",
            position: "hand1"
          },
          {
            name: "Chimera Fusion",
            position: "hand2"
          },
          {
            name: "Mirror Swordknight",
            position: "graveyard"
          },
          {
            name: "Guardian Chimera",
            position: "extra_deck"
          },
          {
            name: "Magnum the Reliever",
            position: "extra_deck"
          }
        ]
      },
      {
        deck_summons: 4,
        hand_summons: 1,
        gy_banishment_summons: 2,
        information: "- Discard 1 random card before drawing your sixth card.\n- In your draw phase Chimera in the gy summoned Big-Winged Berfomet and the Berfomet fusion summoned Chimera from banish. In your main phase Power Patron will fuse into Diactorus. Now interruptions are Diactorus, Mirror Swordknight and Coatl in the graveyard.",
        board_type: "Through Nibiru",
        cards:[
          {
            name: "Medius the Pure",
            position: "mmz1"
          },
          {
            name: "Artmage Power Patron",
            position: "mmz2"
          },
          {
            name: "Big-Winged Berfomet",
            position: "mmz3"
          },
          {
            name: "Chimera the King of Phantom Beasts",
            position: "mmz5"
          },
          {
            name: "Artmage Vandalism -Assault-",
            position: "stz3"
          },
          {
            name: "Mirror Swordknight",
            position: "graveyard"
          },
          {
            name: "Cornfield Coatl",
            position: "graveyard"
          },
          {
            name: "Berfomet the Mythical King of Phantom Beasts",
            position: "banishment"
          }
        ]
      }
    ])
end

#add_archetypes
#add_board_types
#fetch_and_add_all_cards
#add_users
remove_decks
add_decks