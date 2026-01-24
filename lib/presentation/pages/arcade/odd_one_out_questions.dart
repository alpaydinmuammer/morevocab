class OddOneOutQuestion {
  final List<String> words;
  final int oddIndex;
  final String explanation;

  const OddOneOutQuestion(this.words, this.oddIndex, this.explanation);
}

class OddOneOutQuestions {
  static const List<OddOneOutQuestion> questions = [
    // Existing levels (1-18)
    OddOneOutQuestion(
      ['Apple', 'Banana', 'Car', 'Orange'],
      2,
      'Car is not a fruit',
    ),
    OddOneOutQuestion(
      ['Happy', 'Joyful', 'Sad', 'Cheerful'],
      2,
      'Sad is opposite emotion',
    ),
    OddOneOutQuestion(
      ['Dog', 'Cat', 'Bird', 'Table'],
      3,
      'Table is not an animal',
    ),
    OddOneOutQuestion(
      ['Red', 'Blue', 'Green', 'Chair'],
      3,
      'Chair is not a color',
    ),
    OddOneOutQuestion(
      ['Run', 'Walk', 'Jump', 'Book'],
      3,
      'Book is not an action',
    ),
    OddOneOutQuestion(
      ['Monday', 'Tuesday', 'March', 'Friday'],
      2,
      'March is a month, not a day',
    ),
    OddOneOutQuestion(
      ['Piano', 'Guitar', 'Violin', 'Hammer'],
      3,
      'Hammer is not an instrument',
    ),
    OddOneOutQuestion(
      ['Doctor', 'Teacher', 'Engineer', 'Apple'],
      3,
      'Apple is not a profession',
    ),
    OddOneOutQuestion(
      ['Whale', 'Shark', 'Dolphin', 'Lion'],
      3,
      'Lion lives on land, others in water',
    ),
    OddOneOutQuestion(
      ['Cloud', 'Rain', 'Snow', 'Sand'],
      3,
      'Sand is part of the ground, others are weather',
    ),
    OddOneOutQuestion(
      ['Square', 'Circle', 'Triangle', 'Blue'],
      3,
      'Blue is a color, others are shapes',
    ),
    OddOneOutQuestion(
      ['Mars', 'Venus', 'Jupiter', 'Moon'],
      3,
      'Moon is a satellite, others are planets',
    ),
    OddOneOutQuestion(
      ['Milk', 'Juice', 'Water', 'Bread'],
      3,
      'Bread is solid food, others are liquids',
    ),
    OddOneOutQuestion(
      ['Pencil', 'Pen', 'Crayon', 'Paper'],
      3,
      'Paper is for writing on, others are for writing',
    ),
    OddOneOutQuestion(
      ['Socks', 'Shoes', 'Boots', 'Hat'],
      3,
      'Hat is for the head, others are for feet',
    ),
    OddOneOutQuestion(
      ['Ear', 'Eye', 'Nose', 'Hand'],
      3,
      'Hand is a limb, others are facial sense organs',
    ),
    OddOneOutQuestion(
      ['Sun', 'Star', 'Lantern', 'Rock'],
      3,
      'Rock does not produce light',
    ),
    OddOneOutQuestion(
      ['Bed', 'Sofa', 'Chair', 'Car'],
      3,
      'Car is a vehicle, others are furniture',
    ),

    // New Levels (19-50)
    OddOneOutQuestion(
      ['Fork', 'Spoon', 'Knife', 'Plate'],
      3,
      'Plate is what you eat off, others are utensils',
    ),
    OddOneOutQuestion(
      ['Bus', 'Train', 'Airplane', 'Ticket'],
      3,
      'Ticket is what you buy, others are transport',
    ),
    OddOneOutQuestion(
      ['Summer', 'Winter', 'Spring', 'Sunday'],
      3,
      'Sunday is a day, others are seasons',
    ),
    OddOneOutQuestion(
      ['Soccer', 'Basketball', 'Tennis', 'Ball'],
      3,
      'Ball is equipment, others are sports',
    ),
    OddOneOutQuestion(
      ['Rose', 'Tulip', 'Daisy', 'Tree'],
      3,
      'Tree is a plant type, others are flowers',
    ),
    OddOneOutQuestion(
      ['Shirt', 'Pants', 'Dress', 'Closet'],
      3,
      'Closet is storage, others are clothes',
    ),
    OddOneOutQuestion(
      ['Monitor', 'Keyboard', 'Mouse', 'Desk'],
      3,
      'Desk is furniture, others are computer parts',
    ),
    OddOneOutQuestion(
      ['Coffee', 'Tea', 'Soda', 'Cup'],
      3,
      'Cup is a container, others are drinks',
    ),
    OddOneOutQuestion(
      ['Shark', 'Whale', 'Dolphin', 'Eagle'],
      3,
      'Eagle flies, others swim',
    ),
    OddOneOutQuestion(
      ['Carrot', 'Potato', 'Onion', 'Apple'],
      3,
      'Apple is a fruit, others are vegetables',
    ),
    OddOneOutQuestion(
      ['Hammer', 'Screwdriver', 'Wrench', 'Nail'],
      3,
      'Nail is a fastener, others are tools',
    ),
    OddOneOutQuestion(
      ['Guitar', 'Violin', 'Cello', 'Flute'],
      3,
      'Flute is a wind instrument, others are string',
    ),
    OddOneOutQuestion(
      ['Rome', 'Paris', 'London', 'Europe'],
      3,
      'Europe is a continent, others are cities',
    ),
    OddOneOutQuestion(
      ['Math', 'Science', 'History', 'School'],
      3,
      'School is the place, others are subjects',
    ),
    OddOneOutQuestion(
      ['Lake', 'River', 'Ocean', 'Boat'],
      3,
      'Boat is a vehicle, others are water bodies',
    ),
    OddOneOutQuestion(
      ['Second', 'Minute', 'Hour', 'Watch'],
      3,
      'Watch measures time, others are units of time',
    ),
    OddOneOutQuestion(
      ['A', 'B', 'C', '1'],
      3,
      '1 is a number, others are letters',
    ),
    OddOneOutQuestion(
      ['Circle', 'Square', 'Triangle', 'Cube'],
      3,
      'Cube is 3D, others are 2D',
    ),
    OddOneOutQuestion(
      ['Harry Potter', 'Ron', 'Hermione', 'Hogwarts'],
      3,
      'Hogwarts is a place, others are people',
    ),
    OddOneOutQuestion(
      ['Batman', 'Superman', 'Spiderman', 'Joker'],
      3,
      'Joker is a villain, others are heroes',
    ),
    OddOneOutQuestion(
      ['Gold', 'Silver', 'Bronze', 'Ring'],
      3,
      'Ring is jewelry, others are metals',
    ),
    OddOneOutQuestion(
      ['Roof', 'Wall', 'Floor', 'House'],
      3,
      'House is the whole, others are parts',
    ),
    OddOneOutQuestion(
      ['Toe', 'Foot', 'Ankle', 'Hand'],
      3,
      'Hand is on arm, others are on leg',
    ),
    OddOneOutQuestion(
      ['Lion', 'Tiger', 'Leopard', 'Wolf'],
      3,
      'Wolf is canine, others are feline',
    ),
    OddOneOutQuestion(
      ['Beef', 'Chicken', 'Pork', 'Egg'],
      3,
      'Egg comes from animal, others are meat',
    ),
    OddOneOutQuestion(
      ['Rain', 'Snow', 'Hail', 'Wind'],
      3,
      'Wind is checking air, others are precipitation',
    ),
    OddOneOutQuestion(
      ['North', 'South', 'East', 'Map'],
      3,
      'Map is a tool, others are directions',
    ),
    OddOneOutQuestion(
      ['One', 'Two', 'Three', 'First'],
      3,
      'First is ordinal, others are cardinal numbers',
    ),
    OddOneOutQuestion(
      ['Morning', 'Afternoon', 'Evening', 'Clock'],
      3,
      'Clock measures time, others are times of day',
    ),
    OddOneOutQuestion(
      ['January', 'February', 'March', 'Monday'],
      3,
      'Monday is a day, others are months',
    ),
    OddOneOutQuestion(
      ['Dollar', 'Euro', 'Yen', 'Bank'],
      3,
      'Bank is a place, others are currencies',
    ),
    OddOneOutQuestion(
      ['King', 'Queen', 'Prince', 'Castle'],
      3,
      'Castle is a building, others are royalty',
    ),

    // New Levels (51-100)
    OddOneOutQuestion(
      ['Apple', 'Potato', 'Onion', 'Carrot'],
      0,
      'Apple is a fruit, others are vegetables',
    ),
    OddOneOutQuestion(
      ['Desk', 'Chair', 'Table', 'Computer'],
      3,
      'Computer is electronic device, others are furniture',
    ),
    OddOneOutQuestion(
      ['Shirt', 'Pants', 'Hat', 'Shoes'],
      3,
      'Shoes are for feet, others are clothing/accessories',
    ),
    OddOneOutQuestion(
      ['Car', 'Bicycle', 'Motorcycle', 'Bus'],
      1,
      'Bicycle is human-powered, others are motorized',
    ),
    OddOneOutQuestion(
      ['Cat', 'Dog', 'Rabbit', 'Eagle'],
      3,
      'Eagle is a bird, others are mammals',
    ),
    OddOneOutQuestion(
      ['Summer', 'Rain', 'Winter', 'Spring'],
      1,
      'Rain is weather, others are seasons',
    ),
    OddOneOutQuestion(
      ['Pen', 'Notebook', 'Pencil', 'Marker'],
      1,
      'Notebook is paper, others are writing instruments',
    ),
    OddOneOutQuestion(
      ['Guitar', 'Piano', 'Drum', 'Flute'],
      2,
      'Drum is percussion, others are melodic instruments',
    ),
    OddOneOutQuestion(
      ['Red', 'Blue', 'Light', 'Green'],
      2,
      'Light is not a color',
    ),
    OddOneOutQuestion(
      ['Happy', 'Sad', 'Angry', 'Face'],
      3,
      'Face is body part, others are emotions',
    ),
    OddOneOutQuestion(
      ['Book', 'Magazine', 'Newspaper', 'Library'],
      3,
      'Library is a place, others are reading materials',
    ),
    OddOneOutQuestion(
      ['Cup', 'Glass', 'Mug', 'Water'],
      3,
      'Water is liquid, others are containers',
    ),
    OddOneOutQuestion(
      ['Soccer', 'Tennis', 'Ball', 'Basketball'],
      2,
      'Ball is object, others are sports',
    ),
    OddOneOutQuestion(
      ['River', 'Lake', 'Ocean', 'Water'],
      3,
      'Water is substance, others are bodies of water',
    ),
    OddOneOutQuestion(
      ['Sun', 'Moon', 'Star', 'Sky'],
      3,
      'Sky is background, others are celestial bodies',
    ),
    OddOneOutQuestion(
      ['Hand', 'Foot', 'Leg', 'Arm'],
      1,
      'Foot is part of leg, others are upper/main limbs',
    ),
    OddOneOutQuestion(
      ['Beef', 'Pork', 'Chicken', 'Meat'],
      3,
      'Meat is general category, others are specific types',
    ),
    OddOneOutQuestion(
      ['Gold', 'Silver', 'Iron', 'Metal'],
      3,
      'Metal is category, others are specific elements',
    ),
    OddOneOutQuestion(
      ['Rose', 'Tulip', 'Flower', 'Lily'],
      2,
      'Flower is category, others are specific types',
    ),
    OddOneOutQuestion(
      ['Oak', 'Pine', 'Tree', 'Maple'],
      2,
      'Tree is category, others are specific types',
    ),
    OddOneOutQuestion(
      ['Walk', 'Run', 'Jump', 'Move'],
      3,
      'Move is general action, others are specific actions',
    ),
    OddOneOutQuestion(
      ['See', 'Hear', 'Taste', 'Sense'],
      3,
      'Sense is category, others are specific senses',
    ),
    OddOneOutQuestion(
      ['Circle', 'Square', 'Triangle', 'Shape'],
      3,
      'Shape is category, others are specific shapes',
    ),
    OddOneOutQuestion(
      ['Ant', 'Bee', 'Fly', 'Spider'],
      3,
      'Spider is arachnid, others are insects',
    ),
    OddOneOutQuestion(
      ['Shark', 'Whale', 'Dolphin', 'Fish'],
      3,
      'Fish is category, others are specific (Whale/Dolphin are mammals)',
    ),
    OddOneOutQuestion(
      ['Monitor', 'Keyboard', 'Mouse', 'Screen'],
      3,
      'Screen is component, others are peripherals',
    ),
    OddOneOutQuestion(
      ['Doctor', 'Nurse', 'Hospital', 'Patient'],
      2,
      'Hospital is place, others are people',
    ),
    OddOneOutQuestion(
      ['Teacher', 'Student', 'School', 'Principal'],
      2,
      'School is place, others are people',
    ),
    OddOneOutQuestion(
      ['Chef', 'Waiter', 'Restaurant', 'Customer'],
      2,
      'Restaurant is place, others are people',
    ),
    OddOneOutQuestion(
      ['Pilot', 'Flight Attendant', 'Passenger', 'Airport'],
      3,
      'Airport is place, others are people',
    ),
    OddOneOutQuestion(
      ['Police', 'Firefighter', 'Doctor', 'Uniform'],
      3,
      'Uniform is clothing, others are professions',
    ),
    OddOneOutQuestion(
      ['Belt', 'Watch', 'Tie', 'Suit'],
      3,
      'Suit is clothing outfit, others are accessories',
    ),
    OddOneOutQuestion(
      ['Ring', 'Necklace', 'Bracelet', 'Jewelry'],
      3,
      'Jewelry is category, others are specific items',
    ),
    OddOneOutQuestion(
      ['Boots', 'Slippers', 'Sandals', 'Shoes'],
      3,
      'Shoes is general category, others are specific types',
    ),
    OddOneOutQuestion(
      ['Physics', 'Chemistry', 'Biology', 'Science'],
      3,
      'Science is category, others are specific fields',
    ),
    OddOneOutQuestion(
      ['Novel', 'Poetry', 'Drama', 'Literature'],
      3,
      'Literature is category, others are specific types',
    ),
    OddOneOutQuestion(
      ['Jazz', 'Rock', 'Pop', 'Music'],
      3,
      'Music is category, others are specific genres',
    ),
    OddOneOutQuestion(
      ['Apple', 'Samsung', 'Nokia', 'Phone'],
      3,
      'Phone is device, others are brands',
    ),
    OddOneOutQuestion(
      ['Ford', 'Toyota', 'Honda', 'Car'],
      3,
      'Car is vehicle, others are brands',
    ),
    OddOneOutQuestion(
      ['Google', 'Bing', 'Yahoo', 'Search'],
      3,
      'Search is action/category, others are engines',
    ),
    OddOneOutQuestion(
      ['London', 'Paris', 'Berlin', 'City'],
      3,
      'City is category, others are specific capitals',
    ),
    OddOneOutQuestion(
      ['USA', 'Canada', 'Mexico', 'Country'],
      3,
      'Country is category, others are specific nations',
    ),
    OddOneOutQuestion(
      ['Asia', 'Europe', 'Africa', 'Continent'],
      3,
      'Continent is category, others are specific ones',
    ),
    OddOneOutQuestion(
      ['Atlantic', 'Pacific', 'Indian', 'Ocean'],
      3,
      'Ocean is category, others are specific ones',
    ),
    OddOneOutQuestion(
      ['Everest', 'K2', 'Fuji', 'Mountain'],
      3,
      'Mountain is category, others are specific peaks',
    ),
    OddOneOutQuestion(
      ['Nile', 'Amazon', 'Yangtze', 'River'],
      3,
      'River is category, others are specific ones',
    ),
    OddOneOutQuestion(
      ['Sahara', 'Gobi', 'Kalahari', 'Desert'],
      3,
      'Desert is category, others are specific ones',
    ),
    OddOneOutQuestion(
      ['Earth', 'Mars', 'Venus', 'Planet'],
      3,
      'Planet is category, others are specific ones',
    ),
    OddOneOutQuestion(
      ['Monday', 'Tuesday', 'Wednesday', 'Week'],
      3,
      'Week is period, others are days',
    ),
    OddOneOutQuestion(
      ['January', 'February', 'March', 'Month'],
      3,
      'Month is period, others are specific months',
    ),
    // New Levels (101-150)
    OddOneOutQuestion(
      ['Banana', 'Strawberry', 'Tomato', 'Lettuce'],
      3,
      'Lettuce is leafy veg, others are fruits/botanical fruits',
    ),
    OddOneOutQuestion(
      ['Car', 'Truck', 'Van', 'Skateboard'],
      3,
      'Skateboard is non-motorized/small, others are motor vehicles',
    ),
    OddOneOutQuestion(
      ['Raincoat', 'Umbrella', 'Boots', 'Sunscreen'],
      3,
      'Sunscreen is for sun, others are for rain',
    ),
    OddOneOutQuestion(
      ['Winter', 'Snow', 'Ice', 'Heat'],
      3,
      'Heat is associated with summer, others with cold',
    ),
    OddOneOutQuestion(
      ['Breakfast', 'Lunch', 'Dinner', 'Snack'],
      3,
      'Snack is small meal, others are main meals',
    ),
    OddOneOutQuestion(
      ['Square', 'Box', 'Cube', 'Pyramid'],
      0,
      'Square is 2D, others are 3D',
    ),
    OddOneOutQuestion(
      ['Penny', 'Nickel', 'Dime', 'Paper'],
      3,
      'Paper is material, others are coins',
    ),
    OddOneOutQuestion(
      ['Visa', 'Mastercard', 'Amex', 'Money'],
      3,
      'Money is concept, others are credit card brands',
    ),
    OddOneOutQuestion(
      ['Email', 'Letter', 'Text', 'Phone'],
      3,
      'Phone is device, others are messages',
    ),
    OddOneOutQuestion(
      ['Screen', 'Battery', 'Keyboard', 'Laptop'],
      3,
      'Laptop is device, others are parts',
    ),
    OddOneOutQuestion(
      ['Spotify', 'Netflix', 'Hulu', 'Disney+'],
      0,
      'Spotify is audio, others are video',
    ),
    OddOneOutQuestion(
      ['Instagram', 'TikTok', 'Snapchat', 'Excel'],
      3,
      'Excel is productivity, others are social media',
    ),
    OddOneOutQuestion(
      ['Cow', 'Sheep', 'Goat', 'Lion'],
      3,
      'Lion is wild/predator, others are farm/prey',
    ),
    OddOneOutQuestion(
      ['Bee', 'Wasp', 'Hornet', 'Butterfly'],
      3,
      'Butterfly does not sting usually, others do',
    ),
    OddOneOutQuestion(
      ['Pineapple', 'Mango', 'Papaya', 'Broccoli'],
      3,
      'Broccoli is vegetable, others are tropical fruits',
    ),
    OddOneOutQuestion(
      ['Onion', 'Garlic', 'Ginger', 'Apple'],
      3,
      'Apple is fruit, others are aromatics/veg',
    ),
    OddOneOutQuestion(
      ['Salt', 'Pepper', 'Sugar', 'Spoon'],
      3,
      'Spoon is utensil, others are seasonings',
    ),
    OddOneOutQuestion(
      ['Fork', 'Knife', 'Spoon', 'Napkin'],
      3,
      'Napkin is paper/cloth, others are cutlery',
    ),
    OddOneOutQuestion(
      ['Plate', 'Bowl', 'Cup', 'Table'],
      3,
      'Table is furniture, others are dishware',
    ),
    OddOneOutQuestion(
      ['Bed', 'Pillow', 'Blanket', 'Lamp'],
      3,
      'Lamp produces light, others are bedding',
    ),
    OddOneOutQuestion(
      ['Shampoo', 'Soap', 'Conditioner', 'Towel'],
      3,
      'Towel is cloth, others are liquids/bars',
    ),
    OddOneOutQuestion(
      ['Toothbrush', 'Toothpaste', 'Floss', 'Comb'],
      3,
      'Comb is for hair, others for teeth',
    ),
    OddOneOutQuestion(
      ['Hammer', 'Drill', 'Saw', 'Wood'],
      3,
      'Wood is material, others are tools',
    ),
    OddOneOutQuestion(
      ['Painter', 'Brush', 'Canvas', 'Paint'],
      0,
      'Painter is person, others are tools',
    ),
    OddOneOutQuestion(
      ['Actor', 'Movie', 'Director', 'Script'],
      1,
      'Movie is product, others are makers/parts',
    ),
    OddOneOutQuestion(
      ['Menu', 'Chef', 'Waiter', 'Food'],
      0,
      'Menu is list, others are people/product',
    ),
    OddOneOutQuestion(
      ['Ticket', 'Passport', 'Visa', 'Suitcase'],
      3,
      'Suitcase is luggage, others are documents',
    ),
    OddOneOutQuestion(
      ['Hotel', 'Motel', 'Inn', 'House'],
      3,
      'House is private residence, others are lodging',
    ),
    OddOneOutQuestion(
      ['Train', 'Subway', 'Tram', 'Taxi'],
      3,
      'Taxi is private hire, others are mass transit',
    ),
    OddOneOutQuestion(
      ['Helicopter', 'Airplane', 'Jet', 'Boat'],
      3,
      'Boat is water, others are air',
    ),
    OddOneOutQuestion(
      ['Circle', 'Oval', 'Sphere', 'Line'],
      3,
      'Line is 1D, others are shapes',
    ),
    OddOneOutQuestion(
      ['Red', 'Yellow', 'Blue', 'Purple'],
      3,
      'Purple is secondary, others are primary colors (RYB model)',
    ),
    OddOneOutQuestion(
      ['North', 'West', 'South', 'Up'],
      3,
      'Up is relative direction, others are cardinal',
    ),
    OddOneOutQuestion(
      ['Second', 'Minute', 'Degree', 'Hour'],
      2,
      'Degree measures angle/temp, others time',
    ),
    OddOneOutQuestion(
      ['Gram', 'Meter', 'Liter', 'Color'],
      3,
      'Color is a property, others are units',
    ),
    OddOneOutQuestion(
      ['Solid', 'Liquid', 'Gas', 'Wood'],
      3,
      'Wood is material, others are states of matter',
    ),
    OddOneOutQuestion(
      ['Proton', 'Neutron', 'Electron', 'Atom'],
      3,
      'Atom is whole, others are particles',
    ),
    OddOneOutQuestion(
      ['Root', 'Stem', 'Leaf', 'Water'],
      3,
      'Water is resource, others are plant parts',
    ),
    OddOneOutQuestion(
      ['Head', 'Torso', 'Legs', 'Clothing'],
      3,
      'Clothing is external, others are body parts',
    ),
    OddOneOutQuestion(
      ['Brain', 'Heart', 'Lungs', 'Blood'],
      3,
      'Blood is fluid, others are organs',
    ),
    OddOneOutQuestion(
      ['Sight', 'Hearing', 'Smell', 'Brain'],
      3,
      'Brain is organ, others are senses',
    ),
    OddOneOutQuestion(
      ['Noun', 'Verb', 'Adjective', 'Word'],
      3,
      'Word is general, others are types of words',
    ),
    OddOneOutQuestion(
      ['Period', 'Comma', 'Colon', 'Letter'],
      3,
      'Letter is character, others are punctuation',
    ),
    OddOneOutQuestion(
      ['A', 'E', 'I', 'B'],
      3,
      'B is consonant, others are vowels',
    ),
    OddOneOutQuestion(
      ['One', 'Two', 'Three', 'Zero'],
      3,
      'Zero represents nothing, others count something',
    ),
    OddOneOutQuestion(
      ['Plus', 'Minus', 'Divide', 'Math'],
      3,
      'Math is subject, others are operations',
    ),
    OddOneOutQuestion(
      ['Circle', 'Triangle', 'Square', 'Red'],
      3,
      'Red is color, others are shapes',
    ),
    OddOneOutQuestion(
      ['Piano', 'Violin', 'Guitar', 'Music'],
      3,
      'Music is art form, others are instruments',
    ),
    OddOneOutQuestion(
      ['Painting', 'Sculpture', 'Drawing', 'Museum'],
      3,
      'Museum is place, others are artworks',
    ),

    // New Levels (151-200)
    OddOneOutQuestion(
      ['Mars', 'Snickers', 'Twix', 'Apple'],
      3,
      'Apple is fruit, others are chocolates',
    ),
    OddOneOutQuestion(
      ['Coke', 'Pepsi', 'Sprite', 'Water'],
      3,
      'Water is natural, others are sodas',
    ),
    OddOneOutQuestion(
      ['Nike', 'Adidas', 'Puma', 'Shirt'],
      3,
      'Shirt is generic garment, others are brands',
    ),
    OddOneOutQuestion(
      ['iPhone', 'iPad', 'MacBook', 'Windows'],
      3,
      'Windows is OS/Microsoft, others are Apple products',
    ),
    OddOneOutQuestion(
      ['Python', 'Java', 'C++', 'HTML'],
      3,
      'HTML is markup language, others are programming languages',
    ),
    OddOneOutQuestion(
      ['Mouse', 'Rat', 'Hamster', 'Snake'],
      3,
      'Snake is reptile, others are rodents/mammals',
    ),
    OddOneOutQuestion(
      ['Gold', 'Diamond', 'Ruby', 'Emerald'],
      0,
      'Gold is metal, others are gemstones',
    ),
    OddOneOutQuestion(
      ['T-shirt', 'Sweater', 'Jacket', 'Fabric'],
      3,
      'Fabric is material, others are garments',
    ),
    OddOneOutQuestion(
      ['Wallet', 'Purse', 'Backpack', 'Money'],
      3,
      'Money is content, others are containers',
    ),
    OddOneOutQuestion(
      ['Key', 'Lock', 'Door', 'House'],
      0,
      'Key opens, others are structural/security',
    ),
    OddOneOutQuestion(
      ['Candle', 'Lamp', 'Flashlight', 'Sun'],
      3,
      'Sun is natural light source, others are artificial',
    ),
    OddOneOutQuestion(
      ['Battery', 'Charger', 'Power', 'Socket'],
      2,
      'Power is concept/energy, others are objects',
    ),
    OddOneOutQuestion(
      ['Wifi', 'Bluetooth', 'NFC', 'Cable'],
      3,
      'Cable is physical connection, others are wireless',
    ),
    OddOneOutQuestion(
      ['Spotify', 'Apple Music', 'YouTube', 'CD'],
      3,
      'CD is physical media, others are streaming',
    ),
    OddOneOutQuestion(
      ['Netflix', 'Hulu', 'Prime', 'TV'],
      3,
      'TV is device, others are services',
    ),
    OddOneOutQuestion(
      ['Uber', 'Lyft', 'Taxi', 'Car'],
      3,
      'Car is vehicle, others are services',
    ),
    OddOneOutQuestion(
      ['Facebook', 'Twitter', 'Social', 'Instagram'],
      2,
      'Social is category/concept, others are platforms',
    ),
    OddOneOutQuestion(
      ['Google', 'Amazon', 'Microsoft', 'Tech'],
      3,
      'Tech is industry, others are companies',
    ),

    // New Levels (201-250)
    OddOneOutQuestion(
      ['Headphones', 'Earbuds', 'Speaker', 'Music'],
      3,
      'Music is content, others are devices',
    ),
    OddOneOutQuestion(
      ['Rain', 'Cloud', 'Thunder', 'Sky'],
      3,
      'Sky is background, others are weather events',
    ),
    OddOneOutQuestion(
      ['Wallet', 'Pocket', 'Bag', 'Keys'],
      3,
      'Keys are objects, others are storage',
    ),
    OddOneOutQuestion(
      ['Clock', 'Watch', 'Timer', 'Time'],
      3,
      'Time is concept, others measure it',
    ),
    OddOneOutQuestion(
      ['Pen', 'Pencil', 'Brush', 'Paper'],
      3,
      'Paper is surface, others are tools',
    ),
    OddOneOutQuestion(
      ['Car', 'Truck', 'Bus', 'Road'],
      3,
      'Road is infrastructure, others are vehicles',
    ),
    OddOneOutQuestion(
      ['Chair', 'Sofa', 'Stool', 'Sit'],
      3,
      'Sit is action, others are furniture',
    ),
    OddOneOutQuestion(
      ['Bed', 'Cot', 'Hammock', 'Sleep'],
      3,
      'Sleep is action, others are furniture',
    ),
    OddOneOutQuestion(
      ['Knife', 'Fork', 'Spoon', 'Cut'],
      3,
      'Cut is action, others are utensils',
    ),
    OddOneOutQuestion(
      ['Cup', 'Mug', 'Glass', 'Drink'],
      3,
      'Drink is action/substance, others are containers',
    ),
    OddOneOutQuestion(
      ['Apple', 'Banana', 'Grape', 'Eat'],
      3,
      'Eat is action, others are food',
    ),
    OddOneOutQuestion(
      ['Shirt', 'Pants', 'Hat', 'Wear'],
      3,
      'Wear is action, others are clothing',
    ),
    OddOneOutQuestion(
      ['Book', 'Magazine', 'Novel', 'Read'],
      3,
      'Read is action, others are materials',
    ),
    OddOneOutQuestion(
      ['Ball', 'Bat', 'Glove', 'Play'],
      3,
      'Play is action, others are equipment',
    ),
    OddOneOutQuestion(
      ['Sun', 'Moon', 'Star', 'Shine'],
      3,
      'Shine is action, others are celestial bodies',
    ),
    OddOneOutQuestion(
      ['Fire', 'Flame', 'Spark', 'Burn'],
      3,
      'Burn is action, others are physical',
    ),
    OddOneOutQuestion(
      ['Water', 'Ice', 'Steam', 'Flow'],
      3,
      'Flow is action, others are states of water',
    ),
    OddOneOutQuestion(
      ['Wind', 'Breeze', 'Gale', 'Blow'],
      3,
      'Blow is action, others are wind types',
    ),
    OddOneOutQuestion(
      ['Walk', 'Run', 'Jog', 'Legs'],
      3,
      'Legs are body parts, others are actions',
    ),
    OddOneOutQuestion(
      ['See', 'Look', 'Watch', 'Eyes'],
      3,
      'Eyes are organs, others are actions',
    ),
    OddOneOutQuestion(
      ['Hear', 'Listen', 'Sound', 'Ears'],
      3,
      'Ears are organs, others areactions/phenomena',
    ),
    OddOneOutQuestion(
      ['Smell', 'Sniff', 'Scent', 'Nose'],
      3,
      'Nose is organ, others are actions/phenomena',
    ),
    OddOneOutQuestion(
      ['Taste', 'Eat', 'Flavor', 'Tongue'],
      3,
      'Tongue is organ, others are actions/phenomena',
    ),
    OddOneOutQuestion(
      ['Touch', 'Feel', 'Texture', 'Hand'],
      3,
      'Hand is body part, others are senses/properties',
    ),
    OddOneOutQuestion(
      ['Thought', 'Idea', 'Concept', 'Brain'],
      3,
      'Brain is organ, others are mental products',
    ),
    OddOneOutQuestion(
      ['Love', 'Hate', 'Fear', 'Heart'],
      3,
      'Heart is organ, others are emotions',
    ),
    OddOneOutQuestion(
      ['Lung', 'Breath', 'Air', 'Breathe'],
      3,
      'Breathe is action, others are physical/substance',
    ),
    OddOneOutQuestion(
      ['Stomach', 'Digest', 'Food', 'Eat'],
      3,
      'Eat is action, others are internal/process',
    ),
    OddOneOutQuestion(
      ['Muscle', 'Bone', 'Skin', 'Strong'],
      3,
      'Strong is adjective, others are body parts',
    ),
    OddOneOutQuestion(
      ['Doctor', 'Nurse', 'Surgeon', 'Heal'],
      3,
      'Heal is action, others are professions',
    ),
    OddOneOutQuestion(
      ['Teacher', 'Professor', 'Tutor', 'Teach'],
      3,
      'Teach is action, others are professions',
    ),
    OddOneOutQuestion(
      ['Chef', 'Cook', 'Baker', 'Kitchen'],
      3,
      'Kitchen is place, others are professions',
    ),
    OddOneOutQuestion(
      ['Farmer', 'Gardener', 'Grower', 'Farm'],
      3,
      'Farm is place, others are people',
    ),
    OddOneOutQuestion(
      ['Driver', 'Pilot', 'Captain', 'Vehicle'],
      3,
      'Vehicle is object, others are operators',
    ),
    OddOneOutQuestion(
      ['Artist', 'Painter', 'Sculptor', 'Studio'],
      3,
      'Studio is place, others are people',
    ),
    OddOneOutQuestion(
      ['Writer', 'Author', 'Poet', 'Book'],
      3,
      'Book is product, others are creators',
    ),
    OddOneOutQuestion(
      ['Musician', 'Singer', 'Band', 'Song'],
      3,
      'Song is product, others are creators',
    ),
    OddOneOutQuestion(
      ['Actor', 'Actress', 'Star', 'Stage'],
      3,
      'Stage is place, others are people',
    ),
    OddOneOutQuestion(
      ['Judge', 'Lawyer', 'Court', 'Trial'],
      2,
      'Court is place, others are people/event',
    ),
    OddOneOutQuestion(
      ['Soldier', 'General', 'Army', 'War'],
      2,
      'Army is group, others are people/event',
    ),
    OddOneOutQuestion(
      ['King', 'Queen', 'Prince', 'Throne'],
      3,
      'Throne is object, others are people',
    ),
    OddOneOutQuestion(
      ['President', 'Prime Minister', 'Governor', 'Vote'],
      3,
      'Vote is action, others are titles',
    ),
    OddOneOutQuestion(
      ['Mother', 'Father', 'Sister', 'Family'],
      3,
      'Family is group, others are members',
    ),
    OddOneOutQuestion(
      ['Friend', 'Partner', 'Colleague', 'Relationship'],
      3,
      'Relationship is concept, others are people',
    ),
    OddOneOutQuestion(
      ['Enemy', 'Rival', 'Opponent', 'Fight'],
      3,
      'Fight is action, others are people',
    ),
    OddOneOutQuestion(
      ['Cat', 'Kitten', 'Feline', 'Meow'],
      3,
      'Meow is sound, others are animals',
    ),
    OddOneOutQuestion(
      ['Dog', 'Puppy', 'Canine', 'Bark'],
      3,
      'Bark is sound, others are animals',
    ),
    OddOneOutQuestion(
      ['Bird', 'Chick', 'Avian', 'Chirp'],
      3,
      'Chirp is sound, others are animals',
    ),
    OddOneOutQuestion(
      ['Cow', 'Calf', 'Bovine', 'Moo'],
      3,
      'Moo is sound, others are animals',
    ),
    OddOneOutQuestion(
      ['Lion', 'Cub', 'Predator', 'Roar'],
      3,
      'Roar is sound, others are animals',
    ),

    // New Levels (251-300)
    OddOneOutQuestion(
      ['Sheep', 'Lamb', 'Wool', 'Baa'],
      2,
      'Wool is product, others are animal/sound',
    ),
    OddOneOutQuestion(
      ['Pig', 'Piglet', 'Pork', 'Oink'],
      2,
      'Pork is meat, others are animal/sound',
    ),
    OddOneOutQuestion(
      ['Chicken', 'Hen', 'Rooster', 'Egg'],
      3,
      'Egg is product, others are animals',
    ),
    OddOneOutQuestion(
      ['Duck', 'Goose', 'Swan', 'Swim'],
      3,
      'Swim is action, others are birds',
    ),
    OddOneOutQuestion(
      ['Fish', 'Shark', 'Salmon', 'Water'],
      3,
      'Water is environment, others are animals',
    ),
    OddOneOutQuestion(
      ['Bee', 'Ant', 'Wasp', 'Hive'],
      3,
      'Hive is home, others are insects',
    ),
    OddOneOutQuestion(
      ['Spider', 'Web', 'Silk', 'Catch'],
      3,
      'Catch is action, others are spider/product',
    ),
    OddOneOutQuestion(
      ['Snake', 'Lizard', 'Turtle', 'Crawl'],
      3,
      'Crawl is action, others are reptiles',
    ),
    OddOneOutQuestion(
      ['Frog', 'Toad', 'Newt', 'Jump'],
      3,
      'Jump is action, others are amphibians',
    ),
    OddOneOutQuestion(
      ['Oak', 'Pine', 'Maple', 'Leaf'],
      3,
      'Leaf is part, others are trees',
    ),
    OddOneOutQuestion(
      ['Rose', 'Tulip', 'Lily', 'Petal'],
      3,
      'Petal is part, others are flowers',
    ),
    OddOneOutQuestion(
      ['Grass', 'Weed', 'Moss', 'Green'],
      3,
      'Green is color, others are plants',
    ),
    OddOneOutQuestion(
      ['Apple', 'Orange', 'Banana', 'Fruit'],
      3,
      'Fruit is category, others are examples',
    ),
    OddOneOutQuestion(
      ['Carrot', 'Potato', 'Pea', 'Vegetable'],
      3,
      'Vegetable is category, others are examples',
    ),
    OddOneOutQuestion(
      ['Beef', 'Pork', 'Lamb', 'Meat'],
      3,
      'Meat is category, others are examples',
    ),
    OddOneOutQuestion(
      ['Milk', 'Cheese', 'Yogurt', 'Dairy'],
      3,
      'Dairy is category, others are examples',
    ),
    OddOneOutQuestion(
      ['Bread', 'Pasta', 'Rice', 'Grain'],
      3,
      'Grain is category, others are examples',
    ),
    OddOneOutQuestion(
      ['Water', 'Juice', 'Soda', 'Liquid'],
      3,
      'Liquid is state, others are drinks',
    ),
    OddOneOutQuestion(
      ['Cake', 'Cookie', 'Pie', 'Dessert'],
      3,
      'Dessert is category, others are examples',
    ),
    OddOneOutQuestion(
      ['Salt', 'Pepper', 'Spice', 'Taste'],
      3,
      'Taste is sense, others are flavorings',
    ),
    OddOneOutQuestion(
      ['Breakfast', 'Lunch', 'Dinner', 'Meal'],
      3,
      'Meal is category, others are times',
    ),
    OddOneOutQuestion(
      ['Fork', 'Spoon', 'Knife', 'Cutlery'],
      3,
      'Cutlery is category, others are examples',
    ),
    OddOneOutQuestion(
      ['Cup', 'Plate', 'Bowl', 'Dish'],
      3,
      'Dish is category, others are examples',
    ),
    OddOneOutQuestion(
      ['Kitchen', 'Bathroom', 'Bedroom', 'Room'],
      3,
      'Room is category, others are examples',
    ),
    OddOneOutQuestion(
      ['Bed', 'Sofa', 'Table', 'Furniture'],
      3,
      'Furniture is category, others are examples',
    ),
    OddOneOutQuestion(
      ['Shirt', 'Pants', 'Shoes', 'Clothes'],
      3,
      'Clothes is category, others are examples',
    ),
    OddOneOutQuestion(
      ['Car', 'Bus', 'Train', 'Transport'],
      3,
      'Transport is category, others are examples',
    ),
    OddOneOutQuestion(
      ['Phone', 'Computer', 'TV', 'Electronics'],
      3,
      'Electronics is category, others are examples',
    ),
    OddOneOutQuestion(
      ['Hammer', 'Saw', 'Drill', 'Tool'],
      3,
      'Tool is category, others are examples',
    ),
    OddOneOutQuestion(
      ['Pen', 'Pencil', 'Marker', 'Stationery'],
      3,
      'Stationery is category, others are examples',
    ),
    OddOneOutQuestion(
      ['Red', 'Blue', 'Yellow', 'Color'],
      3,
      'Color is category, others are examples',
    ),
    OddOneOutQuestion(
      ['Circle', 'Square', 'Triangle', 'Shape'],
      3,
      'Shape is category, others are examples',
    ),
    OddOneOutQuestion(
      ['One', 'Two', 'Three', 'Number'],
      3,
      'Number is category, others are examples',
    ),
    OddOneOutQuestion(
      ['A', 'B', 'C', 'Letter'],
      3,
      'Letter is category, others are examples',
    ),
    OddOneOutQuestion(
      ['Mon', 'Tue', 'Wed', 'Day'],
      3,
      'Day is category, others are examples',
    ),
    OddOneOutQuestion(
      ['Jan', 'Feb', 'Mar', 'Month'],
      3,
      'Month is category, others are examples',
    ),
    OddOneOutQuestion(
      ['Spring', 'Summer', 'Autumn', 'Season'],
      3,
      'Season is category, others are examples',
    ),
    OddOneOutQuestion(
      ['Earth', 'Mars', 'Jupiter', 'Planet'],
      3,
      'Planet is category, others are examples',
    ),
    OddOneOutQuestion(
      ['USA', 'UK', 'China', 'Country'],
      3,
      'Country is category, others are examples',
    ),
    OddOneOutQuestion(
      ['London', 'Paris', 'Tokyo', 'City'],
      3,
      'City is category, others are examples',
    ),
    OddOneOutQuestion(
      ['River', 'Lake', 'Ocean', 'Water'],
      3,
      'Water is substance, others are bodies',
    ),
    OddOneOutQuestion(
      ['Mountain', 'Hill', 'Valley', 'Land'],
      3,
      'Land is substance, others are formations',
    ),
    OddOneOutQuestion(
      ['Cloud', 'Rain', 'Snow', 'Weather'],
      3,
      'Weather is category, others are phenomena',
    ),
    OddOneOutQuestion(
      ['Gold', 'Silver', 'Bronze', 'Metal'],
      3,
      'Metal is category, others are examples',
    ),
    OddOneOutQuestion(
      ['Rock', 'Pop', 'Jazz', 'Music'],
      3,
      'Music is category, others are examples',
    ),
    OddOneOutQuestion(
      ['Action', 'Comedy', 'Drama', 'Genre'],
      3,
      'Genre is category, others are examples',
    ),
    OddOneOutQuestion(
      ['Football', 'Tennis', 'Golf', 'Sport'],
      3,
      'Sport is category, others are examples',
    ),
    OddOneOutQuestion(
      ['Math', 'Science', 'History', 'Subject'],
      3,
      'Subject is category, others are examples',
    ),
    OddOneOutQuestion(
      ['Lion', 'Tiger', 'Bear', 'Animal'],
      3,
      'Animal is category, others are examples',
    ),
    OddOneOutQuestion(
      ['Oak', 'Rose', 'Grass', 'Plant'],
      3,
      'Plant is category, others are examples',
    ),

    // New Levels (301-350)
    OddOneOutQuestion(
      ['Physics', 'Chemistry', 'Biology', 'History'],
      3,
      'History is humanities, others are hard sciences',
    ),
    OddOneOutQuestion(
      ['Novel', 'Short Story', 'Poem', 'Textbook'],
      3,
      'Textbook is educational, others are creative/literature',
    ),
    OddOneOutQuestion(
      ['Jazz', 'Blues', 'Rock', 'Opera'],
      3,
      'Opera is classical vocal, others are modern music genres',
    ),
    OddOneOutQuestion(
      ['Action', 'Adventure', 'Comedy', 'Documentary'],
      3,
      'Documentary is factual, others are fictional genres',
    ),
    OddOneOutQuestion(
      ['Soccer', 'Basketball', 'Volleyball', 'Swimming'],
      3,
      'Swimming is water/individual, others are team ball sports',
    ),
    OddOneOutQuestion(
      ['Lion', 'Leopard', 'Cheetah', 'Elephant'],
      3,
      'Elephant is herbivore, others are big cats/carnivores',
    ),
    OddOneOutQuestion(
      ['Eagle', 'Hawk', 'Falcon', 'Parrot'],
      3,
      'Parrot is pet/tropical, others are birds of prey',
    ),
    OddOneOutQuestion(
      ['Gold', 'Silver', 'Platinum', 'Steel'],
      3,
      'Steel is alloy, others are precious metals',
    ),
    OddOneOutQuestion(
      ['Rose', 'Lily', 'Tulip', 'Cactus'],
      3,
      'Cactus is succulent/desert, others are garden flowers',
    ),
    OddOneOutQuestion(
      ['Oak', 'Maple', 'Pine', 'Palm'],
      3,
      'Palm is monocot/tropical, others are temperate trees',
    ),
    OddOneOutQuestion(
      ['Apple', 'Pear', 'Orange', 'Carrot'],
      3,
      'Carrot is vegetable, others are fruits',
    ),
    OddOneOutQuestion(
      ['Potato', 'Onion', 'Garlic', 'Tomato'],
      3,
      'Tomato is fruit (botanically), others are root/bulb veg',
    ),
    OddOneOutQuestion(
      ['Beef', 'Pork', 'Lamb', 'Fish'],
      3,
      'Fish is seafood, others are red meat typically',
    ),
    OddOneOutQuestion(
      ['Milk', 'Yogurt', 'Butter', 'Egg'],
      3,
      'Egg is poultry product, others are dairy',
    ),
    OddOneOutQuestion(
      ['Bread', 'Bagel', 'Croissant', 'Cake'],
      3,
      'Cake is dessert, others are breakfast/savory breads',
    ),
    OddOneOutQuestion(
      ['Water', 'Coffee', 'Tea', 'Sandwich'],
      3,
      'Sandwich is food, others are drinks',
    ),
    OddOneOutQuestion(
      ['Cake', 'Pie', 'Brownie', 'Salad'],
      3,
      'Salad is savory/meal, others are desserts',
    ),
    OddOneOutQuestion(
      ['Salt', 'Pepper', 'Sugar', 'Flour'],
      3,
      'Flour is base ingredient, others are seasonings',
    ),
    OddOneOutQuestion(
      ['Breakfast', 'Lunch', 'Dinner', 'Midnight'],
      3,
      'Midnight is time, others are meals',
    ),
    OddOneOutQuestion(
      ['Fork', 'Spoon', 'Knife', 'Chopsticks'],
      3,
      'Chopsticks are wood/plastic pair, others are metal set',
    ),
    OddOneOutQuestion(
      ['Plate', 'Bowl', 'Tupperware', 'Saucer'],
      2,
      'Tupperware is storage, others are dining wear',
    ),
    OddOneOutQuestion(
      ['Kitchen', 'Bedroom', 'Bathroom', 'Garden'],
      3,
      'Garden is outdoors, others are indoor rooms',
    ),
    OddOneOutQuestion(
      ['Bed', 'Sofa', 'Chair', 'Desk'],
      3,
      'Desk is for working, others for resting/sitting',
    ),
    OddOneOutQuestion(
      ['Shirt', 'Pants', 'Shorts', 'Socks'],
      3,
      'Socks are undergarment/footwear accessory, others are main clothes',
    ),
    OddOneOutQuestion(
      ['Car', 'Motorcycle', 'Bicycle', 'Plane'],
      3,
      'Plane is air, others are land transport',
    ),
    OddOneOutQuestion(
      ['Computer', 'Tablet', 'Phone', 'Calculator'],
      3,
      'Calculator is single-purpose, others are general computing',
    ),
    OddOneOutQuestion(
      ['Hammer', 'Screwdriver', 'Wrench', 'Nail'],
      3,
      'Nail is consumable fastener, others are tools',
    ),
    OddOneOutQuestion(
      ['Pen', 'Pencil', 'Marker', 'Eraser'],
      3,
      'Eraser removes, others mark',
    ),
    OddOneOutQuestion(
      ['Red', 'Blue', 'Yellow', 'White'],
      3,
      'White is achromatic/shade, others are hues',
    ),
    OddOneOutQuestion(
      ['Circle', 'Square', 'Triangle', 'Sphere'],
      3,
      'Sphere is 3D, others are 2D shapes',
    ),
    OddOneOutQuestion(
      ['One', 'Ten', 'Hundred', 'First'],
      3,
      'First is ordinal, others are cardinals/amounts',
    ),
    OddOneOutQuestion(
      ['A', 'B', 'C', 'Alpha'],
      3,
      'Alpha is word/Greek, others are Latin letters',
    ),
    OddOneOutQuestion(
      ['Monday', 'Friday', 'Sunday', 'Holiday'],
      3,
      'Holiday is concept, others are days',
    ),
    OddOneOutQuestion(
      ['January', 'June', 'December', 'Winter'],
      3,
      'Winter is season, others are months',
    ),
    OddOneOutQuestion(
      ['Spring', 'Summer', 'Fall', 'Rain'],
      3,
      'Rain is weather, others are seasons',
    ),
    OddOneOutQuestion(
      ['Earth', 'Mars', 'Venus', 'Sun'],
      3,
      'Sun is star, others are planets',
    ),
    OddOneOutQuestion(
      ['USA', 'France', 'Japan', 'New York'],
      3,
      'New York is city, others are countries',
    ),
    OddOneOutQuestion(
      ['London', 'Paris', 'Rome', 'Italy'],
      3,
      'Italy is country, others are cities',
    ),
    OddOneOutQuestion(
      ['River', 'Stream', 'Creek', 'Pond'],
      3,
      'Pond is still water, others are flowing',
    ),
    OddOneOutQuestion(
      ['Mountain', 'Hill', 'Peak', 'Valley'],
      3,
      'Valley is low, others are high',
    ),
    OddOneOutQuestion(
      ['Rain', 'Snow', 'Hail', 'Fog'],
      3,
      'Fog is ground cloud, others are falling precipitation',
    ),
    OddOneOutQuestion(
      ['Gold', 'Silver', 'Bronze', 'Diamond'],
      3,
      'Diamond is crystal/carbon, others are metals',
    ),
    OddOneOutQuestion(
      ['Rock', 'Pop', 'Country', 'Song'],
      3,
      'Song is unit, others are genres',
    ),
    OddOneOutQuestion(
      ['Comedy', 'Horror', 'Sci-Fi', 'Book'],
      3,
      'Book is medium, others are genres',
    ),
    OddOneOutQuestion(
      ['Football', 'Baseball', 'Basketball', 'Team'],
      3,
      'Team is group, others are sports',
    ),
    OddOneOutQuestion(
      ['Math', 'History', 'Art', 'Class'],
      3,
      'Class is event/group, others are subjects',
    ),
    OddOneOutQuestion(
      ['Cat', 'Dog', 'Hamster', 'Whale'],
      3,
      'Whale is aquatic wildlife, others are pets',
    ),
    OddOneOutQuestion(
      ['Rose', 'Daisy', 'Lily', 'Garden'],
      3,
      'Garden is place, others are flowers',
    ),
    OddOneOutQuestion(
      ['Oak', 'Pine', 'Birch', 'Forest'],
      3,
      'Forest is place, others are trees',
    ),
    OddOneOutQuestion(
      ['Apple', 'Orange', 'Banana', 'Juice'],
      3,
      'Juice is processed liquid, others are raw fruit',
    ),

    // New Levels (351-400)
    OddOneOutQuestion(
      ['Monday', 'Tuesday', 'Wednesday', 'Yesterday'],
      3,
      'Yesterday is relative time, others are specific days',
    ),
    OddOneOutQuestion(
      ['January', 'February', 'March', 'Calendar'],
      3,
      'Calendar is object, others are months',
    ),
    OddOneOutQuestion(
      ['Spring', 'Summer', 'Autumn', 'Weather'],
      3,
      'Weather is condition, others are seasons',
    ),
    OddOneOutQuestion(
      ['Mars', 'Venus', 'Jupiter', 'Galaxy'],
      3,
      'Galaxy is system, others are planets',
    ),
    OddOneOutQuestion(
      ['France', 'Germany', 'Spain', 'Europe'],
      3,
      'Europe is continent, others are countries',
    ),
    OddOneOutQuestion(
      ['London', 'Paris', 'Madrid', 'England'],
      3,
      'England is country, others are cities',
    ),
    OddOneOutQuestion(
      ['Nile', 'Amazon', 'Yangtze', 'Water'],
      3,
      'Water is substance, others are specific rivers',
    ),
    OddOneOutQuestion(
      ['Sahara', 'Gobi', 'Kalahari', 'Sand'],
      3,
      'Sand is substance, others are specific deserts',
    ),
    OddOneOutQuestion(
      ['Everest', 'K2', 'Kilimanjaro', 'Height'],
      3,
      'Height is dimension, others are specific mountains',
    ),
    OddOneOutQuestion(
      ['Atlantic', 'Pacific', 'Indian', 'Sea'],
      3,
      'Sea is generic, others are specific oceans',
    ),
    OddOneOutQuestion(
      ['Gold', 'Silver', 'Copper', 'Money'],
      3,
      'Money is value medium, others are elements',
    ),
    OddOneOutQuestion(
      ['Diamond', 'Ruby', 'Sapphire', 'Jewel'],
      3,
      'Jewel is category, others are specific stones',
    ),
    OddOneOutQuestion(
      ['Granite', 'Marble', 'Slate', 'Stone'],
      3,
      'Stone is category, others are specific rocks',
    ),
    OddOneOutQuestion(
      ['Gas', 'Diesel', 'Petrol', 'Fuel'],
      3,
      'Fuel is category, others are specific types',
    ),
    OddOneOutQuestion(
      ['Oak', 'Pine', 'Maple', 'Wood'],
      3,
      'Wood is material, others are trees',
    ),
    OddOneOutQuestion(
      ['Rose', 'Tulip', 'Daisy', 'Bouquet'],
      3,
      'Bouquet is arrangement, others are flowers',
    ),
    OddOneOutQuestion(
      ['Apple', 'Banana', 'Orange', 'Smoothie'],
      3,
      'Smoothie is drink/mix, others are basic fruits',
    ),
    OddOneOutQuestion(
      ['Carrot', 'Potato', 'Onion', 'Soup'],
      3,
      'Soup is dish, others are ingredients',
    ),
    OddOneOutQuestion(
      ['Beef', 'Chicken', 'Pork', 'Burger'],
      3,
      'Burger is dish, others are meats',
    ),
    OddOneOutQuestion(
      ['Milk', 'Cheese', 'Yogurt', 'Cow'],
      3,
      'Cow is animal, others are products',
    ),
    OddOneOutQuestion(
      ['Bread', 'Rice', 'Pasta', 'Flour'],
      3,
      'Flour is ingredient, others are cooked staples',
    ),
    OddOneOutQuestion(
      ['Water', 'Juice', 'Soda', 'Bottle'],
      3,
      'Bottle is container, others are liquids',
    ),
    OddOneOutQuestion(
      ['Cake', 'Cookie', 'Pie', 'Sugar'],
      3,
      'Sugar is ingredient, others are baked goods',
    ),
    OddOneOutQuestion(
      ['Salt', 'Pepper', 'Herbs', 'Cook'],
      3,
      'Cook is action, others are seasonings',
    ),
    OddOneOutQuestion(
      ['Breakfast', 'Lunch', 'Dinner', 'Menu'],
      3,
      'Menu is list, others are meals',
    ),
    OddOneOutQuestion(
      ['Fork', 'Spoon', 'Knife', 'Kitchen'],
      3,
      'Kitchen is place, others are utensils',
    ),
    OddOneOutQuestion(
      ['Cup', 'Glass', 'Mug', 'Drink'],
      3,
      'Drink is action/substance, others are containers',
    ),
    OddOneOutQuestion(
      ['Table', 'Chair', 'Desk', 'Room'],
      3,
      'Room is place, others are furniture',
    ),
    OddOneOutQuestion(
      ['Bed', 'Pillow', 'Blanket', 'Sleep'],
      3,
      'Sleep is action, others are bedding',
    ),
    OddOneOutQuestion(
      ['Shirt', 'Pants', 'Shoes', 'Fashion'],
      3,
      'Fashion is concept, others are items',
    ),
    OddOneOutQuestion(
      ['Car', 'Bus', 'Train', 'Traffic'],
      3,
      'Traffic is condition, others are vehicles',
    ),
    OddOneOutQuestion(
      ['Computer', 'Phone', 'Tablet', 'Internet'],
      3,
      'Internet is network, others are devices',
    ),
    OddOneOutQuestion(
      ['Hammer', 'Saw', 'Drill', 'Build'],
      3,
      'Build is action, others are tools',
    ),
    OddOneOutQuestion(
      ['Pen', 'Pencil', 'Paper', 'Write'],
      3,
      'Write is action, others are tools',
    ),
    OddOneOutQuestion(
      ['Red', 'Green', 'Blue', 'Paint'],
      3,
      'Paint is substance, others are colors',
    ),
    OddOneOutQuestion(
      ['Circle', 'Square', 'Triangle', 'Draw'],
      3,
      'Draw is action, others are shapes',
    ),
    OddOneOutQuestion(
      ['One', 'Two', 'Three', 'Count'],
      3,
      'Count is action, others are numbers',
    ),
    OddOneOutQuestion(
      ['A', 'B', 'C', 'Alphabet'],
      3,
      'Alphabet is set, others are letters',
    ),
    OddOneOutQuestion(
      ['Mon', 'Tue', 'Wed', 'Week'],
      3,
      'Week is period, others are days',
    ),
    OddOneOutQuestion(
      ['Jan', 'Feb', 'Mar', 'Year'],
      3,
      'Year is period, others are months',
    ),
    OddOneOutQuestion(
      ['Spring', 'Summer', 'Autumn', 'Cycle'],
      3,
      'Cycle is concept, others are seasons',
    ),
    OddOneOutQuestion(
      ['Earth', 'Mars', 'Venus', 'Space'],
      3,
      'Space is place, others are planets',
    ),
    OddOneOutQuestion(
      ['USA', 'Canada', 'Mexico', 'North America'],
      3,
      'North America is continent, others are countries',
    ),
    OddOneOutQuestion(
      ['London', 'Paris', 'Berlin', 'Europe'],
      3,
      'Europe is continent, others are cities',
    ),
    OddOneOutQuestion(
      ['Nile', 'Amazon', 'Yangtze', 'Geography'],
      3,
      'Geography is subject, others are rivers',
    ),
    OddOneOutQuestion(
      ['Sahara', 'Gobi', 'Arctic', 'Place'],
      3,
      'Place is general, others are specific regions',
    ),
    OddOneOutQuestion(
      ['Everest', 'Fuji', 'Olympus', 'Climb'],
      3,
      'Climb is action, others are mountains',
    ),
    OddOneOutQuestion(
      ['Pacific', 'Atlantic', 'Arctic', 'Swim'],
      3,
      'Swim is action, others are oceans',
    ),
    OddOneOutQuestion(
      ['Gold', 'Silver', 'Bronze', 'Medal'],
      3,
      'Medal is object, others are materials',
    ),
    OddOneOutQuestion(
      ['Jazz', 'Rock', 'Pop', 'Listen'],
      3,
      'Listen is action, others are genres',
    ),
    OddOneOutQuestion(
      ['Visa', 'Passport', 'ID', 'Travel'],
      3,
      'Travel is activity, others are documents',
    ),
    OddOneOutQuestion(
      ['Summer', 'Holiday', 'Vacation', 'Trip'],
      0,
      'Summer is season, others are breaks/travel',
    ),
    OddOneOutQuestion(
      ['Monday', 'Work', 'Job', 'Office'],
      0,
      'Monday is day, others related to employment',
    ),
    OddOneOutQuestion(
      ['Study', 'Read', 'Learn', 'School'],
      3,
      'School is place, others are actions',
    ),
    OddOneOutQuestion(
      ['Run', 'Jog', 'Sprint', 'Walk'],
      3,
      'Walk is slow, others are fast movement',
    ),
    OddOneOutQuestion(
      ['Smile', 'Laugh', 'Grin', 'Cry'],
      3,
      'Cry is sad expression, others are happy',
    ),
    OddOneOutQuestion(
      ['Sing', 'Hum', 'Whistle', 'Talk'],
      3,
      'Talk is speaking, others are musical',
    ),
    OddOneOutQuestion(
      ['Draw', 'Paint', 'Sketch', 'Art'],
      3,
      'Art is subject, others are actions',
    ),
    OddOneOutQuestion(
      ['Write', 'Type', 'Print', 'Read'],
      3,
      'Read is consuming, others are producing text',
    ),
    OddOneOutQuestion(
      ['Cook', 'Bake', 'Fry', 'Eat'],
      3,
      'Eat is consuming, others are preparation',
    ),
    OddOneOutQuestion(
      ['Wash', 'Clean', 'Scrub', 'Dirty'],
      3,
      'Dirty is state, others are cleaning actions',
    ),
    OddOneOutQuestion(
      ['Sleep', 'Nap', 'Rest', 'Awake'],
      3,
      'Awake is state, others are rest states',
    ),
    OddOneOutQuestion(
      ['Up', 'Down', 'Left', 'Direction'],
      3,
      'Direction is category, others are specific',
    ),
    OddOneOutQuestion(
      ['Big', 'Small', 'Huge', 'Size'],
      3,
      'Size is category, others are descriptions',
    ),
    OddOneOutQuestion(
      ['Hot', 'Cold', 'Warm', 'Temperature'],
      3,
      'Temperature is category, others are states',
    ),
    OddOneOutQuestion(
      ['Fast', 'Slow', 'Quick', 'Speed'],
      3,
      'Speed is category, others are descriptions',
    ),
    OddOneOutQuestion(
      ['Heavy', 'Light', 'Weight', 'Scale'],
      3,
      'Scale is tool, others are properties (mostly)',
    ),
    OddOneOutQuestion(
      ['Old', 'New', 'Young', 'Age'],
      3,
      'Age is category, others are descriptions',
    ),
    OddOneOutQuestion(
      ['Rich', 'Poor', 'Wealthy', 'Money'],
      3,
      'Money is object, others are statuses',
    ),
    OddOneOutQuestion(
      ['Happy', 'Sad', 'Angry', 'Emotion'],
      3,
      'Emotion is category, others are specific',
    ),
    OddOneOutQuestion(
      ['Red', 'Green', 'Blue', 'Color'],
      3,
      'Color is category, others are specific',
    ),
    OddOneOutQuestion(
      ['Circle', 'Square', 'Shape', 'Oval'],
      2,
      'Shape is category, others are specific',
    ),
    OddOneOutQuestion(
      ['One', 'Number', 'Two', 'Three'],
      1,
      'Number is category, others are specific',
    ),
    OddOneOutQuestion(
      ['A', 'Letter', 'B', 'C'],
      1,
      'Letter is category, others are specific',
    ),
    OddOneOutQuestion(
      ['Cat', 'Animal', 'Dog', 'Bird'],
      1,
      'Animal is category, others are specific',
    ),
    OddOneOutQuestion(
      ['Rose', 'Flower', 'Lily', 'Daisy'],
      1,
      'Flower is category, others are specific',
    ),
    OddOneOutQuestion(
      ['Oak', 'Tree', 'Pine', 'Maple'],
      1,
      'Tree is category, others are specific',
    ),
    OddOneOutQuestion(
      ['Apple', 'Fruit', 'Banana', 'Orange'],
      1,
      'Fruit is category, others are specific',
    ),
    OddOneOutQuestion(
      ['Carrot', 'Vegetable', 'Potato', 'Onion'],
      1,
      'Vegetable is category, others are specific',
    ),
    OddOneOutQuestion(
      ['Shirt', 'Clothes', 'Pants', 'Dress'],
      1,
      'Clothes is category, others are specific',
    ),
    OddOneOutQuestion(
      ['Chair', 'Furniture', 'Table', 'Sofa'],
      1,
      'Furniture is category, others are specific',
    ),
    OddOneOutQuestion(
      ['Hammer', 'Tool', 'Saw', 'Drill'],
      1,
      'Tool is category, others are specific',
    ),

    // New Levels (Remaining 401-500+)
    OddOneOutQuestion(
      ['Shark', 'Whale', 'Octopus', 'Camel'],
      3,
      'Camel is land animal, others are marine',
    ),
    OddOneOutQuestion(
      ['Apple', 'Orange', 'Banana', 'Onion'],
      3,
      'Onion is vegetable, others are fruits',
    ),
    OddOneOutQuestion(
      ['Car', 'Bicycle', 'Train', 'Horse'],
      3,
      'Horse is animal, others are machines',
    ),
    OddOneOutQuestion(
      ['Pen', 'Pencil', 'Marker', 'Hammer'],
      3,
      'Hammer is tool, others are writing',
    ),
    OddOneOutQuestion(
      ['Shirt', 'Pants', 'Dress', 'Bag'],
      3,
      'Bag is accessory, others are clothes',
    ),
    OddOneOutQuestion(
      ['Guitar', 'Piano', 'Drum', 'Song'],
      3,
      'Song is music, others are instruments',
    ),
    OddOneOutQuestion(
      ['Red', 'Blue', 'Green', 'Dark'],
      3,
      'Dark is shade, others are colors',
    ),
    OddOneOutQuestion(
      ['Circle', 'Square', 'Triangle', 'Corner'],
      3,
      'Corner is part, others are shapes',
    ),
    OddOneOutQuestion(
      ['One', 'Two', 'Three', 'A'],
      3,
      'A is letter, others are numbers',
    ),
    OddOneOutQuestion(
      ['Monday', 'Tuesday', 'Friday', 'January'],
      3,
      'January is month, others are days',
    ),
    OddOneOutQuestion(
      ['Spring', 'Summer', 'Winter', 'Cold'],
      3,
      'Cold is temp, others are seasons',
    ),
    OddOneOutQuestion(
      ['Mars', 'Venus', 'Saturn', 'Moon'],
      3,
      'Moon is satellite, others are planets',
    ),
    OddOneOutQuestion(
      ['USA', 'Canada', 'Brazil', 'London'],
      3,
      'London is city, others are countries',
    ),
    OddOneOutQuestion(
      ['London', 'Paris', 'Tokyo', 'France'],
      3,
      'France is country, others are cities',
    ),
    OddOneOutQuestion(
      ['Nile', 'Amazon', 'Yangtze', 'Everest'],
      3,
      'Everest is mountain, others are rivers',
    ),
    OddOneOutQuestion(
      ['Sahara', 'Gobi', 'Arabian', 'Pacific'],
      3,
      'Pacific is ocean, others are deserts',
    ),
    OddOneOutQuestion(
      ['Everest', 'K2', 'Fuji', 'Atlantic'],
      3,
      'Atlantic is ocean, others are mountains',
    ),
    OddOneOutQuestion(
      ['Pacific', 'Indian', 'Atlantic', 'Sahara'],
      3,
      'Sahara is desert, others are oceans',
    ),
    OddOneOutQuestion(
      ['Gold', 'Silver', 'Copper', 'Glass'],
      3,
      'Glass is material/ceramic, others are metals',
    ),
    OddOneOutQuestion(
      ['Rock', 'Pop', 'Jazz', 'Movie'],
      3,
      'Movie is visual, others are music types',
    ),
    OddOneOutQuestion(
      ['Physics', 'Chemistry', 'Biology', 'English'],
      3,
      'English is language, others are sciences',
    ),
    OddOneOutQuestion(
      ['Novel', 'Poem', 'Drama', 'Paint'],
      3,
      'Paint is visual art material, others are literature',
    ),
    OddOneOutQuestion(
      ['Football', 'Tennis', 'Golf', 'Play'],
      3,
      'Play is action, others are sports',
    ),
    OddOneOutQuestion(
      ['Lion', 'Tiger', 'Leopard', 'Dog'],
      3,
      'Dog is domestic, others are wild cats',
    ),
    OddOneOutQuestion(
      ['Rose', 'Daisy', 'Lily', 'Tree'],
      3,
      'Tree is large plant, others are flowers',
    ),
    OddOneOutQuestion(
      ['Oak', 'Pine', 'Maple', 'Flower'],
      3,
      'Flower is reproductive part/type, others are trees',
    ),
    OddOneOutQuestion(
      ['Apple', 'Pear', 'Grape', 'Potato'],
      3,
      'Potato is tuber/veg, others are fruits',
    ),
    OddOneOutQuestion(
      ['Carrot', 'Onion', 'Pepper', 'Apple'],
      3,
      'Apple is fruit, others are veg',
    ),
    OddOneOutQuestion(
      ['Beef', 'Chicken', 'Pork', 'Bread'],
      3,
      'Bread is grain, others are meats',
    ),
    OddOneOutQuestion(
      ['Milk', 'Cheese', 'Butter', 'Juice'],
      3,
      'Juice is fruit drink, others are dairy',
    ),
    OddOneOutQuestion(
      ['Bread', 'Pasta', 'Rice', 'Meat'],
      3,
      'Meat is protein, others are carbs/grains',
    ),
    OddOneOutQuestion(
      ['Water', 'Soda', 'Tea', 'Cake'],
      3,
      'Cake is food, others are drinks',
    ),
    OddOneOutQuestion(
      ['Cake', 'Pie', 'Cookie', 'Soup'],
      3,
      'Soup is savory/liquid, others are sweet/solid',
    ),
    OddOneOutQuestion(
      ['Salt', 'Pepper', 'Sugar', 'Fork'],
      3,
      'Fork is utensil, others are condiments',
    ),
    OddOneOutQuestion(
      ['Breakfast', 'Lunch', 'Dinner', 'Food'],
      3,
      'Food is substance, others are meals',
    ),
    OddOneOutQuestion(
      ['Fork', 'Spoon', 'Knife', 'Plate'],
      3,
      'Plate is dish, others are utensils',
    ),
    OddOneOutQuestion(
      ['Cup', 'Mug', 'Glass', 'Spoon'],
      3,
      'Spoon is utensil, others are drinkware',
    ),
    OddOneOutQuestion(
      ['Table', 'Chair', 'Desk', 'Lamp'],
      3,
      'Lamp is light, others are furniture support',
    ),
    OddOneOutQuestion(
      ['Bed', 'Sofa', 'Cot', 'Door'],
      3,
      'Door is fixture, others are for resting',
    ),
    OddOneOutQuestion(
      ['Shirt', 'Pants', 'Coat', 'Button'],
      3,
      'Button is part, others are garments',
    ),
    OddOneOutQuestion(
      ['Car', 'Bus', 'Truck', 'Wheel'],
      3,
      'Wheel is part, others are vehicles',
    ),
    OddOneOutQuestion(
      ['Computer', 'Phone', 'Tablet', 'Screen'],
      3,
      'Screen is component, others are devices',
    ),
    OddOneOutQuestion(
      ['Hammer', 'Saw', 'Drill', 'Wood'],
      3,
      'Wood is material, others are tools',
    ),
    OddOneOutQuestion(
      ['Pen', 'Pencil', 'Marker', 'Paper'],
      3,
      'Paper is surface, others are writers',
    ),
    OddOneOutQuestion(
      ['Red', 'Blue', 'Yellow', 'Paint'],
      3,
      'Paint is material, others are colors',
    ),
    OddOneOutQuestion(
      ['Circle', 'Square', 'Triangle', 'Line'],
      3,
      'Line is 1D, others are 2D shapes',
    ),
    OddOneOutQuestion(
      ['One', 'Two', 'Three', 'Plus'],
      3,
      'Plus is operator, others are numbers',
    ),
    OddOneOutQuestion(
      ['A', 'B', 'C', 'Word'],
      3,
      'Word is combination, others are letters',
    ),
    OddOneOutQuestion(
      ['Mon', 'Tue', 'Wed', 'Jan'],
      3,
      'Jan is month, others are days',
    ),
    OddOneOutQuestion(
      ['Jan', 'Feb', 'Mar', 'Mon'],
      3,
      'Mon is day, others are months',
    ),
    OddOneOutQuestion(
      ['Spring', 'Summer', 'Fall', 'Sun'],
      3,
      'Sun is star, others are seasons',
    ),
    OddOneOutQuestion(
      ['Earth', 'Mars', 'Jupiter', 'Star'],
      3,
      'Star is type, others are planets',
    ),
    OddOneOutQuestion(
      ['USA', 'UK', 'China', 'World'],
      3,
      'World is planet/all, others are countries',
    ),
    OddOneOutQuestion(
      ['London', 'Paris', 'Rome', 'Europe'],
      3,
      'Europe is continent, others are cities',
    ),
    OddOneOutQuestion(
      ['Nile', 'Amazon', 'Mississippi', 'Water'],
      3,
      'Water is substance, others are rivers',
    ),
    OddOneOutQuestion(
      ['Sahara', 'Gobi', 'Kalahari', 'Sand'],
      3,
      'Sand is substance, others are deserts',
    ),
    OddOneOutQuestion(
      ['Everest', 'K2', 'Fuji', 'Rock'],
      3,
      'Rock is material, others are mountains',
    ),
    OddOneOutQuestion(
      ['Pacific', 'Atlantic', 'Indian', 'Salt'],
      3,
      'Salt is substance, others are oceans',
    ),
    OddOneOutQuestion(
      ['Gold', 'Silver', 'Bronze', 'Mine'],
      3,
      'Mine is place, others are metals',
    ),
    OddOneOutQuestion(
      ['Rock', 'Pop', 'Jazz', 'Radio'],
      3,
      'Radio is device, others are music',
    ),
    OddOneOutQuestion(
      ['Physics', 'Bio', 'Chem', 'Lab'],
      3,
      'Lab is place, others are sciences',
    ),
    OddOneOutQuestion(
      ['Novel', 'Play', 'Poem', 'Read'],
      3,
      'Read is action, others are texts',
    ),
    OddOneOutQuestion(
      ['Soccer', 'Tennis', 'Golf', 'Ball'],
      3,
      'Ball is equipment, others are sports',
    ),
    OddOneOutQuestion(
      ['Lion', 'Tiger', 'Bear', 'Zoo'],
      3,
      'Zoo is place, others are animals',
    ),
    OddOneOutQuestion(
      ['Rose', 'Lily', 'Tulip', 'Vase'],
      3,
      'Vase is container, others are flowers',
    ),
    OddOneOutQuestion(
      ['Oak', 'Pine', 'Elm', 'Wood'],
      3,
      'Wood is material, others are trees',
    ),
    OddOneOutQuestion(
      ['Apple', 'Pear', 'Plum', 'Tree'],
      3,
      'Tree is source, others are fruits',
    ),
    OddOneOutQuestion(
      ['Potato', 'Carrot', 'Onion', 'Root'],
      3,
      'Root is part/type, others are vegetables',
    ),
    OddOneOutQuestion(
      ['Beef', 'Pork', 'Lamb', 'Cook'],
      3,
      'Cook is action, others are meats',
    ),
    OddOneOutQuestion(
      ['Milk', 'Cream', 'Yogurt', 'Drink'],
      3,
      'Drink is action, others are dairy',
    ),
    OddOneOutQuestion(
      ['Bread', 'Bun', 'Roll', 'Eat'],
      3,
      'Eat is action, others are breads',
    ),
    OddOneOutQuestion(
      ['Water', 'Tea', 'Coffee', 'Cup'],
      3,
      'Cup is container, others are liquids',
    ),
    OddOneOutQuestion(
      ['Pie', 'Cake', 'Tart', 'Bake'],
      3,
      'Bake is action, others are desserts',
    ),
    OddOneOutQuestion(
      ['Salt', 'Pepper', 'Spice', 'Taste'],
      3,
      'Taste is sense, others are spices',
    ),
    OddOneOutQuestion(
      ['Breakfast', 'Lunch', 'Dinner', 'Cook'],
      3,
      'Cook is action, others are meals',
    ),
    OddOneOutQuestion(
      ['Fork', 'Knife', 'Spoon', 'Steel'],
      3,
      'Steel is material, others are cutlery',
    ),
    OddOneOutQuestion(
      ['Plate', 'Bowl', 'Cup', 'Table'],
      3,
      'Table is furniture, others are dishes',
    ),
    OddOneOutQuestion(
      ['Chair', 'Table', 'Sofa', 'Sit'],
      3,
      'Sit is action, others are furniture',
    ),
    OddOneOutQuestion(
      ['Bed', 'Cot', 'Bunk', 'Sleep'],
      3,
      'Sleep is action, others are beds',
    ),
    OddOneOutQuestion(
      ['Shirt', 'Vest', 'Coat', 'Wear'],
      3,
      'Wear is action, others are tops',
    ),
    OddOneOutQuestion(
      ['Car', 'Taxi', 'Uber', 'Drive'],
      3,
      'Drive is action, others are vehicles/services',
    ),
    OddOneOutQuestion(
      ['Computer', 'Laptop', 'PC', 'Type'],
      3,
      'Type is action, others are computers',
    ),
    OddOneOutQuestion(
      ['Hammer', 'Mallet', 'Sledge', 'Hit'],
      3,
      'Hit is action, others are tools',
    ),
    OddOneOutQuestion(
      ['Pen', 'Pencil', 'Biro', 'Draw'],
      3,
      'Draw is action, others are pens',
    ),
    OddOneOutQuestion(
      ['Red', 'Blue', 'Green', 'See'],
      3,
      'See is action, others are colors',
    ),
    OddOneOutQuestion(
      ['Circle', 'Oval', 'Round', 'Shape'],
      3,
      'Shape is category, others are round shapes',
    ),
    OddOneOutQuestion(
      ['One', 'Two', 'Ten', 'Math'],
      3,
      'Math is subject, others are numbers',
    ),
    OddOneOutQuestion(
      ['A', 'B', 'Z', 'Write'],
      3,
      'Write is action, others are letters',
    ),
    OddOneOutQuestion(
      ['Mon', 'Fri', 'Sun', 'Day'],
      3,
      'Day is category, others are specific days',
    ),
    OddOneOutQuestion(
      ['Jan', 'Dec', 'July', 'Month'],
      3,
      'Month is category, others are specific months',
    ),
    OddOneOutQuestion(
      ['Spring', 'Fall', 'Winter', 'Season'],
      3,
      'Season is category, others are specific seasons',
    ),
    OddOneOutQuestion(
      ['Earth', 'Mars', 'Pluto', 'Planet'],
      3,
      'Planet is category, others are specific planets',
    ),
    OddOneOutQuestion(
      ['USA', 'China', 'India', 'Country'],
      3,
      'Country is category, others are specific countries',
    ),
    OddOneOutQuestion(
      ['London', 'Rome', 'Oslo', 'City'],
      3,
      'City is category, others are specific cities',
    ),
    OddOneOutQuestion(
      ['Nile', 'Seine', 'Rhine', 'River'],
      3,
      'River is category, others are specific rivers',
    ),
    OddOneOutQuestion(
      ['Sahara', 'Gobi', 'Mojave', 'Desert'],
      3,
      'Desert is category, others are specific deserts',
    ),
    OddOneOutQuestion(
      ['Everest', 'Blanc', 'Denali', 'Mountain'],
      3,
      'Mountain is category, others are specific mountains',
    ),
    OddOneOutQuestion(
      ['Pacific', 'Indian', 'Arctic', 'Ocean'],
      3,
      'Ocean is category, others are specific oceans',
    ),
    OddOneOutQuestion(
      ['Apple', 'Microsoft', 'Google', 'Monitor'],
      3,
      'Monitor is hardware, others are tech giants',
    ),
    OddOneOutQuestion(
      ['Table', 'Chair', 'Stool', 'Wood'],
      3,
      'Wood is material, others are furniture',
    ),
    OddOneOutQuestion(
      ['Shirt', 'Pants', 'Socks', 'Cotton'],
      3,
      'Cotton is material, others are clothes',
    ),
    OddOneOutQuestion(
      ['Car', 'Truck', 'Van', 'Steel'],
      3,
      'Steel is material, others are vehicles',
    ),
    OddOneOutQuestion(
      ['Pen', 'Pencil', 'Marker', 'Ink'],
      3,
      'Ink is substance, others are tools',
    ),
  ];
}
