class MonsterCard < Card
  validates :card_type, inclusion: { in: [ "aqua", "beast", "beast-warrior", "cyberse", "creator god", "dinosaur", "divine-beast", "dragon", "fairy", "fiend", "fish", "insect", "illusion", "machine", "plant", "psychic", "pyro", "reptile", "rock", "sea serpent", "spellcaster", "thunder", "warrior", "winged beast", "wyrm", "zombie" ] }
end
