# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'factory_bot_rails'

include FactoryBot::Syntax::Methods

OrderItem.destroy_all
Order.destroy_all
Item.destroy_all
User.destroy_all

admin = create(:user, role: 2)
admin_1 = create(:user, role: 2, name: "admin", email: "admin@admin.com", password: "admin")
merchant_5 = create(:user, role: 1, name: "merchant", email: "merchant@merchant.com", password: "merchant")
user_1 = create(:user, name: "user", email: "user@user.com", password: "user")
user = create(:user)
merchant_1 = create(:user, role: 1, name: "Bill Murray")
merchant_2 = create(:user, role: 1, name: "Steve Martin")
merchant_3 = create(:user, role: 1, name: "Rick Moranis")
merchant_4 = create(:user, role: 1, name: "Jack Nicholson")

item_1 = create(:item, user: merchant_1, name: "Nightmares", description: "Nightmares is a delightful plant for any home.  The leering eyes don’t just appear to follow you around the room, they actually do.", enabled: true)
item_2 = create(:item, user: merchant_2, name: "Children's Fingers", description: "Don’t let the name fool you, Children’s Fingers is not a plant for a children.  This plant will draw blood at the slightest graze of a hand; however, the good news is blood is the perfect fertilizer to help this plant grow full and strong.", enabled: true)
item_3 = create(:item, user: merchant_3, name: "Bavarian Venus Flytrap", description: "The Bavarian Venus Flytrap is our take on the traditional.  Instead of flies, this plant has a taste for small household pets.  Cats, rodents, and annoyingly small dogs, beware.", enabled: true)
item_4 = create(:item, user: merchant_4, name: "Spider Leaf", description: "If shiny objects regularly go missing in your home, blame the Spider Leaf.  Warning, the Spider Leaf has been known to take rings off fingers and the fingers sometimes come off the hand as well.", enabled: true)
item_5 = create(:item, user: merchant_4, name: "Werewolf Rose", description: "Werewolf Rose has a dreamy look to it in the daytime and transforms to its demonic self once the sun goes down.  Post-transformation, this plant emits a nightmarish howling.  Enjoy!", enabled: true)
item_6 = create(:item, user: merchant_4, name: "Albino Rat", description: "The Albino Rat is not an animal; it’s a plant!  For sale!", enabled: true)
item_7 = create(:item, user: merchant_5, name: "Medusa's Monkeys", description: "Medusa’s Monkeys are a poisonous trio and make a great replacement for office ferns.", enabled: true)
item_8 = create(:item, user: merchant_5, name: "Cavities", description: "Cavities are so-called as they’re able to locate the remotest of open spaces, fill them, and rip them to shreds, causing immense pain for all parties involved.", enabled: true)
item_9 = create(:item, user: merchant_5, name: "Giraffe's Neck", description: "The Giraffe’s Neck will wrap around nearby objects and strangle.  Purchase of this plant comes with a knife, just in case.", enabled: true)
item_10 = create(:item, user: merchant_1, name: "Librarian's Tongues", description: "Librarian’s Tongues always come in pairs.  Silent, but deadly.  Keeping them in their cage is entirely appropriate.", enabled: true)
item_11 = create(:item, user: merchant_1, name: "Purple Squealer", description: "The Purple Squealer is one of our more popular options with young people.  It makes a high-pitched cry that only teenagers can hear.  Works as a great a prank against your teacher.", enabled: true)
item_12 = create(:item, user: merchant_1, name: "Pacifier", description: "If a child locks eyes with the Pacifier, it will be hypnotized into a heavy night-terror-filled slumber. Use sparingly.", enabled: true)
item_13 = create(:item, user: merchant_1, name: "Grandmother Longlegs", description: "Grandmother Longlegs is continually sweeping her legs.  Sometimes she’ll graze you as you walk by, and other times, she’ll aggressively throw things across the room. ", enabled: true)
item_14 = create(:item, user: merchant_1, name: "Red Grouch", description: "The Red Grouch regularly spews pollen over the home.  Nothing can be done", enabled: true)
item_15 = create(:item, user: merchant_1, name: "Sunnyflowers", description: "Sunnyflowers appear to be happy, but upon closer inspection, they’re actually quite angry, often screaming in rage for no apparent reason.  A delight for all who come to see!", enabled: true)
item_16 = create(:item, user: merchant_2, name: "Spider Pods", description: "Spider Pods are a perfect additive for the chef in the house.  A few squeezes from the pods will cause upset stomachs all night.  Tasteless and totally undetected!", enabled: true)
item_17 = create(:item, user: merchant_2, name: "Bird Bath", description: "Do you have a problem with too many beautiful birds in your backyard?  The Bird Bath will take care of that!  Visually appealing to our friends in flight, the Bird Bath will lure them in and promptly devour.", enabled: true)
item_18 = create(:item, user: merchant_2, name: "Webbed Cage", description: "The Webbed Cage is a beautifully mysterious plant.  Somehow items lost in the couch years ago will return encased in this gorgeous plant.  Think you can get back your lost item?  Think again.  The webbing will burn any skin it touches.  Exciting!", enabled: true)
item_19 = create(:item, user: merchant_2, name: "Princess's Serpents", description: "The Princess’s Serpents are what we lovingly refer to as a guard-plant.  It knows its owner’s scent and will shoot prickling needles at any intruders to come within 5 feet of the plant.", enabled: true)
item_20 = create(:item, user: merchant_5, name: "Red Skunk Lashes", description: "Red Skunk Lashes are quite beautiful from a distance and can only be viewed in total darkness.  In the daytime, their scent is almost unbearable, but oh what a show for the evening.", enabled: true)
item_21 = create(:item, user: merchant_3, name: "Ghost Pods", description: "Ghost Pods grow best over the graves of household pets. Neat!", enabled: true)
item_22 = create(:item, user: merchant_3, name: "Separated Optical Nerves", description: "Separated Optical Nerves aren’t just fun for your ophthalmology friends; when these pods burst, they’ll cause a burning sensation in your eyes and be so much fun for you as well!", enabled: true)
item_23 = create(:item, user: merchant_3, name: "Tarantula Cactus", description: "Tarantula Cactus needs sunlight and TLC — Toes, Lips, & Carcass.  Don’t worry, those can come from any mammal.", enabled: true)
item_24 = create(:item, user: merchant_3, name: "Cyclops Vine", description: "Too much time spent around the Cyclops Vine may result in your becoming a cyclops too, and really, isn’t that what we all want?", enabled: true)
item_25 = create(:item, user: merchant_3, name: "Fluke", description: "Fluke is our most beautiful, yet boring, creature.  It lazily lounges in the sun and occasionally swats at passersby with its limbs.", enabled: true)
item_26 = create(:item, user: merchant_3, name: "Purple Ducks", description: "Purple Ducks actually quack!  All the time!  No one can make it stop!", enabled: true)
item_27 = create(:item, user: merchant_4, name: "Beetle Pods", description: "Beetle Pods ooze most of the time, and the ooze can be difficult to clean.  If you can catch them on a non-oozey day, count your lucky stars.", enabled: true)
item_28 = create(:item, user: merchant_4, name: "Bursting Succulents", description: "Bursting Succulents make great party favors.  You never know what odor they’ll emit when the pods finally go boom!", enabled: true)
item_29 = create(:item, user: merchant_4, name: "New Jersey Pipecleaner", description: "The New Jersey Pipecleaner is lovely; however, its leaves gather bacteria and save it for an unspecified time, when it chooses to spew its ickiness all around.  15-foot radius in most cases.", enabled: true)
item_30 = create(:item, user: merchant_4, name: "Yellow Eel Tree", description: "The Yellow Eel Tree works best in warmer climates.  A scientific anomaly, it creates an electric shock felt by anyone within 20 yards of the tree, just because.", enabled: true)
# create_list(:item, 10, user: merchant_1, enabled: true)

order = create(:completed_order, user: user)
create(:fulfilled_order_item, order: order, item: item_1, price: 1, quantity: 1)
create(:fulfilled_order_item, order: order, item: item_2, price: 2, quantity: 1)
create(:fulfilled_order_item, order: order, item: item_3, price: 3, quantity: 1)
create(:fulfilled_order_item, order: order, item: item_4, price: 4, quantity: 1)
create(:fulfilled_order_item, order: order, item: item_5, price: 4, quantity: 9)
create(:fulfilled_order_item, order: order, item: item_6, price: 4, quantity: 15)
create(:fulfilled_order_item, order: order, item: item_7, price: 7, quantity: 13)
create(:fulfilled_order_item, order: order, item: item_8, price: 4, quantity: 1)
create(:fulfilled_order_item, order: order, item: item_9, price: 7, quantity: 2)

order = create(:completed_order, user: user)
create(:fulfilled_order_item, order: order, item: item_10, price: 1, quantity: 11)
create(:fulfilled_order_item, order: order, item: item_12, price: 2, quantity: 12)
create(:fulfilled_order_item, order: order, item: item_13, price: 3, quantity: 1)
create(:fulfilled_order_item, order: order, item: item_14, price: 4, quantity: 2)
create(:fulfilled_order_item, order: order, item: item_15, price: 4, quantity: 9)
create(:fulfilled_order_item, order: order, item: item_16, price: 4, quantity: 5)
create(:fulfilled_order_item, order: order, item: item_17, price: 7, quantity: 13)
create(:fulfilled_order_item, order: order, item: item_18, price: 4, quantity: 1)
create(:fulfilled_order_item, order: order, item: item_19, price: 7, quantity: 2)

order = create(:order, user: user)
create(:order_item, order: order, item: item_1, price: 1, quantity: 1)
create(:fulfilled_order_item, order: order, item: item_2, price: 2, quantity: 1)

order = create(:order, user: user)
create(:order_item, order: order, item: item_20, price: 1, quantity: 1)
create(:fulfilled_order_item, order: order, item: item_21, price: 2, quantity: 1)

order = create(:order, user: user)
create(:order_item, order: order, item: item_22, price: 1, quantity: 1)
create(:fulfilled_order_item, order: order, item: item_23, price: 2, quantity: 1)
create(:fulfilled_order_item, order: order, item: item_24, price: 2, quantity: 1)

order = create(:cancelled_order, user: user)
create(:order_item, order: order, item: item_11, price: 2, quantity: 1)
create(:order_item, order: order, item: item_3, price: 3, quantity: 1)

order = create(:cancelled_order, user: user)
create(:order_item, order: order, item: item_25, price: 2, quantity: 1)
create(:order_item, order: order, item: item_26, price: 3, quantity: 1)

order = create(:completed_order, user: user)
create(:fulfilled_order_item, order: order, item: item_27, price: 1, quantity: 1)
create(:fulfilled_order_item, order: order, item: item_28, price: 2, quantity: 1)
create(:fulfilled_order_item, order: order, item: item_29, price: 2, quantity: 1)

order = create(:completed_order, user: user)
create(:fulfilled_order_item, order: order, item: item_1, price: 1, quantity: 1)
create(:fulfilled_order_item, order: order, item: item_30, price: 2, quantity: 1)

order = create(:completed_order, user: user)
create(:fulfilled_order_item, order: order, item: item_1, price: 1, quantity: 1)
create(:fulfilled_order_item, order: order, item: item_28, price: 2, quantity: 1)
