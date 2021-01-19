# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Spree::Core::Engine.load_seed if defined?(Spree::Core)
Spree::Auth::Engine.load_seed if defined?(Spree::Auth)
default_specs = [
  ["clothing-type","top"],["clothing-type","pants"],["clothing-type","shoes"],["clothing-type","accessory"],

  ["fit","loose"],["fit","regular"],["fit","slim"],["fit","skinny"],
  ["color-scheme","monochromatic"],["color-scheme","pattern"],["color-scheme","print"],
  ["cuffs","none"],["cuffs","elastic"],["cuffs","buttoned"],["cuffs","puffed"],
  ["zipper","none"],["zipper","edge-to-edge"],["zipper","invisible"],
  ["fabric","cotton"],["fabric","silk"],["fabric","linen"],["fabric","polyester"],["fabric","jeans"],["fabric","lycra"],["fabric","khaki"],["fabric","athletic"],["fabric","leather"],["fabric","foam"],["fabric","generic"],["fabric","other"],

  ["top-type","formal-shirt"],["top-type","casual-shirt"],["top-type","sweater"],["top-type","hoodie"],["top-type","jacket"],["top-type","dress"],["top-type","vest"],["top-type","coat"],
  ["collar","round"],["collar","v-neck"],["collar","polo"],["collar","henley"],["collar","scoop"],["collar","cowl"],["collar","boat"],["collar","off-shoulder"],["collar","asymmetric"],["collar","turtle-neck"],
  ["top-cut","regular"],["top-cut","crop"],
  ["sleeve","none"],["sleeve","cap"],["sleeve","short"],["sleeve","three-quraters"],["sleeve","long"],

  ["shoe-type","boots"],["shoe-type","athletic"],["shoe-type","casual"],["shoe-type","formal"],
  ["shoe-height","knee"],["shoe-height","high"],["shoe-height","regular"],["shoe-height","low"],
  ["heel","flat"],["heel","low"],["heel","medium"],["heel","high"],
  ["lace","none"],["lace","lace"],["lace","velcro"],["lace","button"],

  ["pants-length","floor"],["pants-length","ankle"],["pants-length","above-ankle"],["pants-length","calf"],["pants-length","knee"],["pants-length","short"],["pants-length","mini"],["pants-length","micro"],
  ["pants-cut","straight"],["pants-cut","boot"],["pants-cut","wide"],["pants-cut","cargo"],["pants-cut","sweat"],["pants-cut","jump-suit"],["pants-cut","carpenter"],
  ["rise","super-high"],["rise","high"],["rise","medium"],["rise","medium-to-low"],["riserise","low"],["rise","super-low"],
  ["band","button"],["band","zipper"],["band","elastic"],["band","tie"],
  ["crotch","regular"],["crotch","sarouel"],
  ["pockets","none"],["pockets","small"],["pockets","regular"],["pockets","cargo"],
  ["gender","male"], ["gender","female"], ["gender","unisex"]
]

default_specs.each do |spec|
  if !Spec.where(value: spec[1]).exists?
    Spec.create(name: spec[0], value: spec[1]).save!
    puts "#{spec[0]}: #{spec[1]} created."
  end
end
