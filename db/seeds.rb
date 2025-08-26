# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

archetype_names = ["A-to-Z", "Albaz", "Abyss Actor", "Adamancipator", "Adventurer Token", "Aesir", "Agent", "Alien", "Ally of Justice", "Altergeist", "Amazemment", "Amazoness", "Amorphage", "Ancient Gear", "Ancient Warriors", "Appliancer", "Aquaactress", "Arcana Force", "Archfiend", "Armed Dragon", "Aroma", "Artifact", "Artmage", "Ashened", "Assault Mode", "Atlantean", "Batteryman", "Battlewasp", "Battlin Boxer", "Beetrooper", "Black Luster", "Blackwing", "Blue-Eyes", "Bounzer", "Bujin", "Burning Abyss", "Buster Blader", "Butterspy", "Bystial", "Centur-Ion", "Charmer", "Chaos", "Chemicritter", "Chronomaly", "Chrysalis", "Cipher", "Cloudian", "Code Talker", "Constellar", "Crusadia", "Crystal Beast", "Crystron", "Cubic", "Cyber", "Cyberdark", "Cyber Dragon", "D.D.", "D/D/", "Danger!", "Darklord", "Dark Magician", "Dark Scorpion", "Dark World", "Deep Sea", "Deskbot", "Despia", "Destiny Hero", "Digital Bug", "Dinomist", "Dinomorphia", "Dinowrestler", "Dododo", "Dogmatika", "Doodle Beast", "Dracoslayer", "Dracotail", "Dragon Ruler", "Dragonmaid", "Dragunity", "Dream Mirror", "Drytron", "Dual Avatar", "Duston", "Earthbound", "Edge Imp", "Edlich", "Elemental Hero", "Elementsaber", "Empowered Warrior", "Endymion", "Evil Eye", "Evil Hero", "Evil Twin / Live Twin", "Evilswarm", "Evoltile", "Exosister ", "Eyes Restrict", "Fabled", "Face Cards", "F.A.", "Fairy Tail", "Familiar-Possessed", "Fiendsmith", "Brotherhood of the Fire Fist", "Fire King", "Fire Warrior", "Flame Swordsman", "Flamvell", "Fleur", "Floowandereeze", "Flower Cardian", "Fluffal", "Forbidden One (Exodia)", "Fortune Fairy", "Fortune Lady", "Fossil Fusion", "Frightfur", "Frog", "Fur Hire", "G Golem", "Gadget", "Gagaga", "Gaia", "Galaxy", "Ganbara", "Gate Guardian", "Gearfried", "Geargia", "Gem-", "Generaider", "Genex", "Ghostrick", "Ghoti", "Gimmick Puppet", "Gishki", "Glacial Beast", "Gladiator Beast", "Goblin", "Goblin Biker", "Gogogo", "Gold Pride", "Gorgonic", "Gouki", "Goyo", "Gravekeeper", "Graydle", "Gunkan", "Gusto", "Harpie", "Hazy Flame", "Heraldic Beast", "Heroic", "Hieratic", "Horus", "Ice Barrier", "Icejade", "Igknight", "Ignister", "Impcantation", "Infernity", "Infernoble", "Infernoid", "Infinitrack", "Invoked", "Inzektor", "Iron Chain", "Junk", "Jurrac", "K9", "Kaiju", "Karakuri", "Kashtira", "Knightmare", "Koa'ki Meiru", "Kozmo", "Krawler", "Kuriboh", "Labrynth", "Laval", "Libromancer", "Lightray", "Lightsworn", "Lswarm", "Lunalight", "Lyrilusc", "Machina", "Madolche", "Magical Musket", "Magician", "Magikey", "Magistus", "Majespecter", "Malefic", "Maliss", "Mannadium", "Marincess", "Masked HERO", "Materiactor", "Mathmech", "Mayakashi", "Mecha Phantom Beast", "Megalith", "Mekk-Knight", "Meklord", "Melffy", "Melodious", "Memento", "Mermail", "Metalfoes", "Metalmorph", "Metaphys", "Mikanko", "Millennium", "Mimighoul", "Mist Valley", "Mitsurugi", "Monarch", "Morphtronic", "Mystical Beast", "Mythical Beast", "Myutant", "Naturia", "Nekroz", "Nemleria", "Neo-Spacian", "Neos", "Nemeses", "Nephthys", "Nimble", "Ninja", "Noble Knight", "Nordic", "Nouvelles", "Number", "Numeron", "Odd-Eyes", "Ogdoadic", "Orcust", "Ojama", "P.U.N.K.", "Paleozoic", "Parshath", "Penguin", "Performage", "Performapal", "Phantasm Spiral", "Phantom Beast", "Photon", "Plunder Patroll", "Prank-Kids", "Predaplant", "Prediction Princess", "Purrely", "PSY-Framegear", "Psychic", "Qli", "R.B.", "Ragnaraika", "Raidraptor", "Red-Eyes", "Regenesis", "Reptilianne", "Rescue-ACE", "Resonator", "Rikka", "Risebell", "Ritual Beast", "Roid", "Rokket", "Rose", "Runick", "Ryu-Ge", "Ryzeal", "Sangen", "S-Force", "Salamangreat", "Scareclaw", "Scrap", "Shaddoll", "Shark", "Shining Sarcophagus", "Shinobird", "Shiranui", "Silent Magician", "Silent Swordsman", "Simorgh", "Sinful Spoils", "Six Samurai", "Skull Servant", "Sky Striker", "Snake-Eye", "Solfachord", "Speedroid", "Spellbook", "Sphinx", "Springan", "Spyral", "Spellcaster", "Spright", "Star Sereph", "Starry Knight", "Steelswarm", "Subterror", "Sunavalon", "Superheavy Samurai", "Supreme King", "Swordsoul", "Sylvan", "Symphonic Warrior", "Synchron", "Tearlaments", "Tellarknight", "Tenyi", "T.G.", "The Agent", "The Phantom Knights", "The Weather", "Therion", "Thunder Dragon", "Time Thief", "Timelord", "Tindangle", "Tistina", "Toon", "Toy", "Traptrix", "Triamid", "Tri-Brigade", "Trickstar", "True King", "Twilightsworn", "U.A.", "Unchained", "Ursarctic", "Utopia", "Vaalmonica", "Vampire", "Vanquish Soul", "Vassal", "Vaylantz", "Vendread", "Venom", "Virtual World", "Visas Starfrost", "Vision HERO", "Voiceless Voice", "Volcanic", "Vylon", "War Rock", "Watt", "White Forest", "Wind-up", "Windwitch", "Witchcrafter", "World Chalice", "World Legacy", "Worm", "Xtra HERO", "Xyz", "X-Saber", "Yang Zing", "Yosenju", "Yubel", "Yummy", "Zefra", "Zombie", "Zoodiac", "Zubaba", "ZW -"]

archetype_names.each do |name|
  Archetype.create!(name: name)
end

BoardType::TYPES.each do |type|
  BoardType.create!(name: type)
end

# Creating a full deck for testing 
user = User.create!(username: "testhands.com", email_address: "1@1.1", password: "aaaaaaaa")

deck = Deck.create!(advice: "Mitsurugi Test advice", tier: 1, user: user)
deck.archetypes << Archetype.find_by!(name: "Mitsurugi")

# MITSURUGI START
board = Board.create!(deck_summons: 2, hand_summons: 2, gy_banishment_summons: 3, deck: deck, board_type: BoardType.find_by!(name: "Full Combo 1"))
card = TrapCard.create!(name: "Misturugi Great Purification", description:'Mitsurugi Great Purification Description', card_type: "normal")
board.board_cards.create!(position: "stz2", card: card)
card = MonsterCard.create!(name: "Ame no Murakumo no Mitsurugi", description: "Murakumo Description", card_type: "reptile")
board.board_cards.create!(position: "mmz1", card: card)
card = MonsterCard.create!(name: "Dyna Mondo", description: "Dyna Mondo Description", card_type: "cyberse")
board.board_cards.create!(position: "emz1", card: card)
veiler = MonsterCard.create!(name: "Effect Veiler", description: "Effect Veiler Description", card_type: "spellcaster")
board.board_cards.create!(position: "hand1", card: veiler)

board2 = Board.create!(deck_summons: 1, hand_summons: 4, gy_banishment_summons: 5, deck: deck, board_type: BoardType.find_by!(name: "Through Fuwalos"))
card2 = SpellCard.create!(name: "Mitsurugi Magatama", description: "Mitsurugi Magatama Description", card_type: "quick-play")
board2.board_cards.create!(position: "stz3", card: card2)

# MITSURUGI END

# RYZEAL START
deck = Deck.create!(advice: "Ryzeal Test advice", tier: 2, user: user)
deck.archetypes << Archetype.find_by!(name: "Ryzeal")

board = Board.create!(deck_summons: 1, hand_summons: 5, gy_banishment_summons: 0, deck: deck, board_type: BoardType.find_by!(name: "Full Combo 1"))
card = MonsterCard.create!(name: "Ryzeal Detonator", description:'Detonator Description', card_type: "pyro")
board.board_cards.create!(position: "mmz1", card: card)
card = SpellCard.create!(name: "Ryzeal Cross", description: "Cross Description", card_type: "field")
board.board_cards.create!(position: "field", card: card)
card = MonsterCard.create!(name: "Ryzeal Duo Drive", description: "Duo Drive Description", card_type: "pyro")
board.board_cards.create!(position: "mmz3", card: card)
board.board_cards.create!(position: "hand2", card: veiler)

# RYZEAL END

