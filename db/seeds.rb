# db/seeds.rb
question_set = QuestionSet.create(name:"breakfast")
test_game = Game.create(name:"Test Game", question_set:question_set)
test_game.update(uid:"test")

test_420_game = Game.create(name:"Test Game", question_set:question_set)
test_420_game.update(uid:"test420")

f52_game = Game.create(name:"Test Game", question_set:question_set)
f52_game.update(uid:"food52")

#1 mustard, mayo ketchup
Question.create(question_set_id:question_set.id, option_1:"mustard", option_2:"mayo",option_3:"ketchup", 
    option_1_img_url: "https://target.scene7.com/is/image/Target/GUEST_4ab8dddf-ae9b-4176-8157-3cd4e929d9ca?wid=488&hei=488&fmt=pjpeg", 
    option_2_img_url: "https://cdn.shopify.com/s/files/1/0550/9929/3865/products/Dukes32_F_1024x1024_18e207d3-e9dc-4bd6-8cf0-96c0617f24d1_grande.png?v=1621821273", 
    option_3_img_url: "https://m.media-amazon.com/images/I/71b0CQV4SFS._SX425_.jpg")

#2waffle, pancake, french toast/
Question.create(question_set_id:question_set.id, option_1:"waffle", option_2:"pancake",option_3:"french toast", 
    option_1_img_url: "https://storcpdkenticomedia.blob.core.windows.net/media/recipemanagementsystem/media/recipe-media-files/recipes/retail/x17/2020_belgian-style-waffles_16700_760x580.jpg?ext=.jpg", 
    option_2_img_url: "https://flap-jacks71st.com/wp-content/uploads/2020/06/280-2804057_pancake-stack-png-download-restaurant.png", 
    option_3_img_url:"https://transform.octanecdn.com/fit/600x800/https://octanecdn.com/rumchatacom/rumchatacom_233114218.jpg")

#3 pizza, taco, burger
Question.create(question_set_id:question_set.id, option_1:"pizza", option_2:"tacos",option_3:"burger", 
    option_1_img_url: "https://www.cicis.com/wp-content/uploads/2019/02/pizza_cheese_angle_c.png", 
    option_2_img_url: "https://taco.sfo2.digitaloceanspaces.com/2018/10/Crisp-Taco-PINTO-BEAN-343x300.png", 
    option_3_img_url:"https://www.burgerlounge.com/perch/resources/menuphotos/2020-bl-menu-lounge-white-cheddar.png")

#4 french fry, onion ring, potato chips
Question.create(question_set_id:question_set.id, option_1:"french fries", option_2:"onion rings",option_3:"potato chips", 
    option_1_img_url: "https://cdn11.bigcommerce.com/s-ecaphbiulf/images/stencil/1280x1280/products/278/661/French_Fries__80789.1587266450.png?c=1", 
    option_2_img_url: "https://www.buffalowildwings.com/globalassets/menuitems/10120018-beer-battered-onion-rings.png?format=png&width=600&v=2", 
    option_3_img_url:"https://nudefoodsmarket.com/wp-content/uploads/2020/11/potatochips.png")

# #5 sriracha chihuahua franks
# Question.create(question_set_id:question_set.id, option_1:"sriracha", option_2:"cholula",option_3:"franks", 
#     option_1_img_url: "https://d2j6dbq0eux0bg.cloudfront.net/images/14873646/914534375.jpg", 
#     option_2_img_url: "https://cdn.shopify.com/s/files/1/0621/9645/products/cholula-for-sale_480x480.png?v=1606579977", 
#     option_3_img_url:"https://embed.widencdn.net/img/mccormick/dtpsp8bcwc/400x600px/united_states_franks_redhot_wings_buffalo.png?crop=true&u=1o4a15")

#6 basil oregano thyme
Question.create(question_set_id:question_set.id, option_1:"basil", option_2:"oregano",option_3:"thyme", 
    option_1_img_url: "http://cdn.shopify.com/s/files/1/1257/7487/products/edn-seedpod-genovese-basil_640x.png?v=1604943967", 
    option_2_img_url: "https://www.mammarancia.com/wp-content/uploads/2017/06/ory.png", 
    option_3_img_url: "https://cdn.shopify.com/s/files/1/0108/6402/files/thyme_large.png?v=1490148346")

#7 dominos pizza hut papa john’s
Question.create(question_set_id:question_set.id, option_1:"Dominos", option_2:"Pizza Hut",option_3:"Papa John's", 
    option_1_img_url: "https://www.dennisexpress.com/wp-content/uploads/2017/06/dominos-pizza-logo.png", 
    option_2_img_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Pizza_Hut_1967-1999_logo.svg/1200px-Pizza_Hut_1967-1999_logo.svg.png", 
    option_3_img_url: "https://assets.simpleviewinc.com/simpleview/image/upload/crm/nacogdoches/1280px-PapaJohns.svg-1--2f3ffa8f5056b3a_2f3ffbf2-5056-b3a8-4926f6f4e5ea893c.png")

#8 everything cinnamon raisin plain
Question.create(question_set_id:question_set.id, option_1:"Everything", option_2:"cinnamon Raisin",option_3:"Plain", 
    option_1_img_url: "http://cdn.shopify.com/s/files/1/1749/6693/products/whole-wheat-everything-bagel_3937b74e-e06c-4c37-8f06-863d64feba5e_1024x1024.png?v=1531755389", 
    option_2_img_url: "https://turano.com/wp-content/uploads/2019/03/90093_Bagels_Cinnamon_Raisin_Bagels_TD_EDITED_v2_forceUpdate.png", 
    option_3_img_url:"https://turano.com/wp-content/uploads/2019/03/90094_Bagels_Plain_Bagels_TD_EDITED_V2_forceUpdate.png")

#9 mozzarella sticks, nachos, wings
Question.create(question_set_id:question_set.id, option_1:"mozzarella sticks", option_2:"nachos",option_3:"wings", 
    option_1_img_url: "https://images.ctfassets.net/o19mhvm9a2cm/EQCjA5qVColXO98cRAgKo/d656b34de0ad080f0769dc871bde7854/Website_Side_Mozz_6PC.png", 
    option_2_img_url: "https://olo-images-live.imgix.net/fc/fccbe9c1cff8465e815705590fa1cc0e.png?auto=format%2Ccompress&q=60&cs=tinysrgb&w=528&h=352&fit=fill&fm=png32&bg=transparent&s=46fe477d11700afba190d196fd49a92c", 
    option_3_img_url: "https://vinceandjoes.com/wp-content/uploads/2020/01/BUFFALO_WINGS_shutterstock_1176069616_clipped_rev_1.png")

# #10 soft serve, frozen custard, gelato
# Question.create(question_set_id:question_set.id, option_1:"Soft Serve", option_2:"Frozen Custard",option_3:"Ice Cream Sandwich", 
#     option_1_img_url: "https://www.carvel.com/-/media/carvel/menu/ice-cream/soft-serve/2-chocolate-new.png?v=1&d=20180430T193908Z&h=600&w=600&la=en&hash=78EF4BE6817E692ACEDC66FE8FDF5140", 
#     option_2_img_url: "https://static.wixstatic.com/media/59ab9a_20ba852ad9e84bf7837e17e4588764ac~mv2_d_5058_3372_s_4_2.png/v1/crop/x_738,y_472,w_3581,h_2880/fill/w_560,h_450,al_c,q_85,usm_0.66_1.00_0.01/IMG_6295-Edit.webp", 
    # option_3_img_url:"https://creamerynovelties.com/wp-content/uploads/2021/02/Ice-Cream-Sandwich-600x600-1.png")

    #11 hummus, guac and salsa
Question.create(question_set_id:question_set.id, option_1:"Hummus", option_2:"Guac",option_3:"Salsa", 
    option_1_img_url: "https://today-company.com/wp-content/uploads/2021/04/hummus_PNG53.png", 
    option_2_img_url: "https://www.yummymath.com/wp-content/uploads/2021/04/guacamole@3x.png", 
    option_3_img_url: "https://www.osoriotacosysalsas.com/wp-content/uploads/2014/04/roja-medium.png")

#12 tagalongs, samoas, thin mints
Question.create(question_set_id:question_set.id, option_1:"tagalongs", option_2:"Caramel deLites",option_3:"Thin Mints", 
    option_1_img_url: "https://www.sheknows.com/wp-content/uploads/2018/08/eurgqortnfcvif9rjv8g.png?w=800", 
    option_2_img_url: "https://www.abcbakers.com/media/1029/caramel-delites.png", 
    option_3_img_url: "https://www.littlebrowniebakers.com/media/images/cookie-info/NutrCookie_ThinMints.png")

# #13 Cobb, Caesar, or Greek
# Question.create(question_set_id:question_set.id, option_1:"Cobb", option_2:"Caesar",option_3:"Greek", 
#     option_1_img_url: "https://www.cfacdn.com/img/order/menu/Online/Salads%26wraps/cobbSalad_grill_pdp.png", 
#     option_2_img_url: "https://www.noodles.com/wp-content/uploads/2018/03/Grilled-Chicken-Caesar-OH-1050x700.png", 
#     option_3_img_url: "https://fastfoodnutrition.org/item-photos/full/162369614170139.png")

#14 waffle fries, crinkle cut, curly fries
Question.create(question_set_id:question_set.id, option_1:"Waffle", option_2:"Crinkle Cut",option_3:"Curly", 
    option_1_img_url: "https://cdn.shopify.com/s/files/1/0554/8713/5912/products/wafflefries_grande.png?v=1622023981", 
    option_2_img_url: "https://www.lutosa.com/wp-content/uploads/2021/05/17858_-_crinkle_cut_fries_9-12-1.png", 
    option_3_img_url: "https://burgerking.com.mt/wp-content/uploads/2020/03/CURLY-FRIES.png")