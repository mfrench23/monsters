# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
TerrainType.create(name: 'ground')
TerrainType.create(name: 'water')
TerrainType.create(name: 'air')
TerrainType.create(name: 'tunneling')

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

