# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
MoveType.create(name: 'ground')
MoveType.create(name: 'water')
MoveType.create(name: 'air')
MoveType.create(name: 'tunneling')

Location.create(name: 'eye')
Location.create(name: 'skull')
Location.create(name: 'face')
Location.create(name: 'right leg')
Location.create(name: 'right arm')
Location.create(name: 'torso')
Location.create(name: 'groin/abdomen')
Location.create(name: 'left arm')
Location.create(name: 'left leg')
Location.create(name: 'right hand')
Location.create(name: 'left hand')
Location.create(name: 'right foot')
Location.create(name: 'left foot')
Location.create(name: 'neck')
Location.create(name: 'vitals')

MonsterClass.create(name: 'Animal')
MonsterClass.create(name: 'Animal, Dire')
MonsterClass.create(name: 'Animal, Giant')
MonsterClass.create(name: 'Construct')
MonsterClass.create(name: 'Demon')
MonsterClass.create(name: 'Elder Thing')
MonsterClass.create(name: 'Elemental')
MonsterClass.create(name: 'Faerie')
MonsterClass.create(name: 'Hybrid')
MonsterClass.create(name: 'Mundane')
MonsterClass.create(name: 'Plant')
MonsterClass.create(name: 'Slime')
MonsterClass.create(name: 'Undead')

MasterSkill.create(name: 'Acrobatics', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Acting', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Alchemy/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Animal Handling (Big Cats)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Animal Handling (Dogs)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Animal Handling (Equines)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Animal Handling (Raptors)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Architecture/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Area Knowledge (Tembladera)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Armoury (Body Armor)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Armoury (Melee Weapons)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Armoury (Missile Weapons)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Axe/Mace', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Blowpipe', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Boating (Large Powerboat)', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Boating (Motorboat)', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Boating (Sailboat)', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Boating (Unpowered)', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Body Language', baseStat: MasterSkill.baseStats["Per"] )
MasterSkill.create(name: 'Body Sense', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Bolas', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Bow', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Boxing', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Brawling', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Broadsword', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Camouflage', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Carousing', baseStat: MasterSkill.baseStats["HT"] )
MasterSkill.create(name: 'Cartography', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Climbing', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Cloak', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Counterfeiting/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Crossbow', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Current Affairs (High Culture)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Current Affairs (Popular Culture)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Dancing', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Detect Lies', baseStat: MasterSkill.baseStats["Per"] )
MasterSkill.create(name: 'Diagnosis/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Diplomacy', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Disguise/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Engineer (Body Armor)/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Engineer (Clockwork)/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Engineer (Glider)/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Engineer (Lighter-Than-Air)/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Engineer (Melee Weapons)/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Engineer (Missile Weapons)/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Engineer (Rockets)/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Engineer (Sailboat)/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Engineer (Steam Engine)/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Engineer (Unpowered Boat)/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Engineer (Artillery)/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Engineer (Civil)/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Engineer (Combat)/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Engineer (Mining)/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Erotic Art', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Escape', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Falconry', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Fast-Draw (Knife)', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Fast-Draw (Sword)', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Fast-Draw (Two-Handed Sword)', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Fast-Draw (Arrow)', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Fast-Draw (Shuriken)', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Fast-Draw (Dart)', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Fast-Talk', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Filch', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'First Aid/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Fishing', baseStat: MasterSkill.baseStats["Per"] )
MasterSkill.create(name: 'Flail', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Forced Entry', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Forgery/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Gambling', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Games (Chess)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Games (Go)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Garrote', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Gesture', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Hazardous Materials (Magical)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Heraldry', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Hidden Lore (Demons)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Hidden Lore (Elder Things)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Hidden Lore (Magic Items)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Hidden Lore (Magical Writings)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Hidden Lore (Dragons)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Hidden Lore (Elementals)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Hidden Lore (Faerie Lore)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Hidden Lore (Hidden Styles)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Hidden Lore (Lost Civilizations)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Hidden Lore (Nature Spirits)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Hidden Lore (Undead)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Hiking', baseStat: MasterSkill.baseStats["HT"] )
MasterSkill.create(name: 'Hobby Skill DX/E or', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Holdout', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Innate Attack (Beam)', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Innate Attack (Breath)', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Innate Attack (Gaze)', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Innate Attack (Projectile)', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Interrogation', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Intimidation', baseStat: MasterSkill.baseStats["Will"] )
MasterSkill.create(name: 'Jeweler/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Jitte/Sai', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Judo', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Jumping', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Karate', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Knife', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Knot-Tying', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Kusari', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Lance', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Lasso', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Leadership', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Leatherworking', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Lifting', baseStat: MasterSkill.baseStats["HT"] )
MasterSkill.create(name: 'Lip Reading', baseStat: MasterSkill.baseStats["Per"] )
MasterSkill.create(name: 'Lockpicking/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Main-Gauche', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Meditation', baseStat: MasterSkill.baseStats["Will"] )
MasterSkill.create(name: 'Merchant', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Mimicry (Animal Sounds)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Mimicry (Bird Calls)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Mimicry (Speech)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Musical Composition', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Musical Instrument (Stringed)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Musical Instrument (Harp)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Musical Instrument (Harmonica)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Naturalist', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Navigation (Land)/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Navigation (Sea)/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Navigation (Air)/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Net', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Observation', baseStat: MasterSkill.baseStats["Per"] )
MasterSkill.create(name: 'Occultism', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Packing', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Panhandling', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Performance', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Pharmacy/TL3 (Herbal)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Philosophy', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Physiology (Elder Thing)/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Physiology (Human)/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Pickpocket', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Poetry', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Poisons/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Polearm', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Professional Skill DX/A or', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Propaganda/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Prospecting/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Psychology', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Public Speaking', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Rapier', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Religious Ritual (Good Church)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Religious Ritual (Demon Worship)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Research/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Riding (Equine)', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Running', baseStat: MasterSkill.baseStats["HT"] )
MasterSkill.create(name: 'Saber', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Savoir-Faire (High Society)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Scrounging', baseStat: MasterSkill.baseStats["Per"] )
MasterSkill.create(name: 'Seamanship/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Search', baseStat: MasterSkill.baseStats["Per"] )
MasterSkill.create(name: 'Sex Appeal', baseStat: MasterSkill.baseStats["HT"] )
MasterSkill.create(name: 'Shadowing', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Shield (Buckler)', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Shield (Shield)', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Shortsword', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Singing', baseStat: MasterSkill.baseStats["HT"] )
MasterSkill.create(name: 'Skiing', baseStat: MasterSkill.baseStats["HT"] )
MasterSkill.create(name: 'Sleight of Hand', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Sling', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Smallsword', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Smith (Copper)/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Smith (Iron)/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Smith (Tin and Lead)/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Smuggling', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Spear', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Spear Thrower', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Speed-Reading', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Staff', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Stealth', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Strategy (Land)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Strategy (Naval)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Streetwise', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Sumo Wrestling', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Surgery/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Survival (Arctic)', baseStat: MasterSkill.baseStats["Per"] )
MasterSkill.create(name: 'Survival (Desert)', baseStat: MasterSkill.baseStats["Per"] )
MasterSkill.create(name: 'Survival (Dungeon)', baseStat: MasterSkill.baseStats["Per"] )
MasterSkill.create(name: 'Survival (Island/Beach)', baseStat: MasterSkill.baseStats["Per"] )
MasterSkill.create(name: 'Survival (Jungle)', baseStat: MasterSkill.baseStats["Per"] )
MasterSkill.create(name: 'Survival (Mountain)', baseStat: MasterSkill.baseStats["Per"] )
MasterSkill.create(name: 'Survival (Plains)', baseStat: MasterSkill.baseStats["Per"] )
MasterSkill.create(name: 'Survival (Subterranean)', baseStat: MasterSkill.baseStats["Per"] )
MasterSkill.create(name: 'Survival (Swampland)', baseStat: MasterSkill.baseStats["Per"] )
MasterSkill.create(name: 'Survival (Woodlands)', baseStat: MasterSkill.baseStats["Per"] )
MasterSkill.create(name: 'Swimming', baseStat: MasterSkill.baseStats["HT"] )
MasterSkill.create(name: 'Tactics', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Teaching', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Teamster (Equine)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Teamster (Cave Goat)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Thaumatology', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Theology (Good Church)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Theology (Demon Worship)', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Throwing', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Thrown Weapon (Axe/Mace)', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Thrown Weapon (Dart)', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Thrown Weapon (Disc)', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Thrown Weapon (Harpoon)', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Thrown Weapon (Knife)', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Thrown Weapon (Shuriken)', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Thrown Weapon (Spear)', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Thrown Weapon (Stick)', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Tonfa', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Tracking', baseStat: MasterSkill.baseStats["Per"] )
MasterSkill.create(name: 'Traps/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Two-Handed Axe/Mace', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Two-Handed Flail', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Two-Handed Sword', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Urban Survival', baseStat: MasterSkill.baseStats["Per"] )
MasterSkill.create(name: 'Ventriloquism', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Veterinary/TL3', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Weather Sense', baseStat: MasterSkill.baseStats["IQ"] )
MasterSkill.create(name: 'Whip', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Wrestling', baseStat: MasterSkill.baseStats["DX"] )
MasterSkill.create(name: 'Writing', baseStat: MasterSkill.baseStats["IQ"] )
