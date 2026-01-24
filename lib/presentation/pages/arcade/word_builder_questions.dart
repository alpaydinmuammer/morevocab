class WordBuilderQuestion {
  final String definition;
  final List<String> syllables;
  final String answer;

  const WordBuilderQuestion({
    required this.definition,
    required this.syllables,
    required this.answer,
  });
}

class WordBuilderQuestions {
  static final List<WordBuilderQuestion> questions = [
    // Level 1-10
    const WordBuilderQuestion(
      definition: 'A tropical fruit with yellow skin.',
      syllables: ['NA', 'BA', 'NA'],
      answer: 'BANANA',
    ),
    const WordBuilderQuestion(
      definition: 'A machine that performs calculations.',
      syllables: ['TER', 'COM', 'PU'],
      answer: 'COMPUTER',
    ),
    const WordBuilderQuestion(
      definition: 'A large animal with a long trunk.',
      syllables: ['PHANT', 'ELE'],
      answer: 'ELEPHANT',
    ),
    const WordBuilderQuestion(
      definition: 'A device used to talk to people far away.',
      syllables: ['PHONE', 'TELE'],
      answer: 'TELEPHONE',
    ),
    const WordBuilderQuestion(
      definition: 'A building where movies are shown.',
      syllables: ['NE', 'CI', 'MA'],
      answer: 'CINEMA',
    ),
    const WordBuilderQuestion(
      definition: 'A person who travels into space.',
      syllables: ['AS', 'TRO', 'NAUT'],
      answer: 'ASTRONAUT',
    ),
    const WordBuilderQuestion(
      definition: 'A sweet food made from cacao beans.',
      syllables: ['CHO', 'CO', 'LATE'],
      answer: 'CHOCOLATE',
    ),
    const WordBuilderQuestion(
      definition: 'A printed collection of words and meanings.',
      syllables: ['DIC', 'TION', 'A', 'RY'],
      answer: 'DICTIONARY',
    ),
    const WordBuilderQuestion(
      definition: 'An instrument used to measure temperature.',
      syllables: ['THER', 'MOM', 'E', 'TER'],
      answer: 'THERMOMETER',
    ),
    const WordBuilderQuestion(
      definition: 'A large fruit with a hard green rind and red pulp.',
      syllables: ['WA', 'TER', 'MEL', 'ON'],
      answer: 'WATERMELON',
    ),

    // Level 11-20
    const WordBuilderQuestion(
      definition: 'A vehicle with two wheels and an engine.',
      syllables: ['CY', 'MO', 'TOR', 'CLE'],
      answer: 'MOTORCYCLE',
    ),
    const WordBuilderQuestion(
      definition: 'A person who takes pictures.',
      syllables: ['PHO', 'TOG', 'RA', 'PHER'],
      answer: 'PHOTOGRAPHER',
    ),
    const WordBuilderQuestion(
      definition: 'A small red fruit commonly used in salads.',
      syllables: ['TO', 'MA', 'TO'],
      answer: 'TOMATO',
    ),
    const WordBuilderQuestion(
      definition: 'A vegetable with a strong smell and flavor.',
      syllables: ['ON', 'I', 'ON'],
      answer: 'ONION',
    ),
    const WordBuilderQuestion(
      definition: 'A place where books are kept.',
      syllables: ['LI', 'BRA', 'RY'],
      answer: 'LIBRARY',
    ),
    const WordBuilderQuestion(
      definition: 'A detailed plan of an area.',
      syllables: ['NAV', 'I', 'GA', 'TION'],
      answer: 'NAVIGATION',
    ),
    const WordBuilderQuestion(
      definition: 'A place where food is served.',
      syllables: ['RES', 'TAU', 'RANT'],
      answer: 'RESTAURANT',
    ),
    const WordBuilderQuestion(
      definition: 'A musical instrument with black and white keys.',
      syllables: ['PI', 'AN', 'O'],
      answer: 'PIANO',
    ),
    const WordBuilderQuestion(
      definition: 'The continent at the bottom of the world.',
      syllables: ['ANT', 'ARC', 'TI', 'CA'],
      answer: 'ANTARCTICA',
    ),
    const WordBuilderQuestion(
      definition: 'A season with very warm weather.',
      syllables: ['SUM', 'MER', 'TIME'],
      answer: 'SUMMERTIME',
    ),

    // Level 21-30
    const WordBuilderQuestion(
      definition: 'A flying insect with colorful wings.',
      syllables: ['BUT', 'TER', 'FLY'],
      answer: 'BUTTERFLY',
    ),
    const WordBuilderQuestion(
      definition: 'The day before today.',
      syllables: ['YES', 'TER', 'DAY'],
      answer: 'YESTERDAY',
    ),
    const WordBuilderQuestion(
      definition: 'The day after today.',
      syllables: ['TO', 'MOR', 'ROW'],
      answer: 'TOMORROW',
    ),
    const WordBuilderQuestion(
      definition: 'Violent circular wind storm.',
      syllables: ['HUR', 'RI', 'CANE'],
      answer: 'HURRICANE',
    ),
    const WordBuilderQuestion(
      definition: 'Study of the earth\'s physical features.',
      syllables: ['GE', 'OG', 'RA', 'PHY'],
      answer: 'GEOGRAPHY',
    ),
    const WordBuilderQuestion(
      definition: 'A group of people related by blood.',
      syllables: ['FAM', 'I', 'LY'],
      answer: 'FAMILY',
    ),
    const WordBuilderQuestion(
      definition: 'A large open area for growing crops.',
      syllables: ['PLAN', 'TA', 'TION'],
      answer: 'PLANTATION',
    ),
    const WordBuilderQuestion(
      definition: 'A sweet baked treat, often for birthdays.',
      syllables: ['CEL', 'E', 'BRA', 'TION'],
      answer: 'CELEBRATION',
    ),
    const WordBuilderQuestion(
      definition: 'Something that is mysterious or hard to explain.',
      syllables: ['MYS', 'TER', 'Y'],
      answer: 'MYSTERY',
    ),
    const WordBuilderQuestion(
      definition: 'A person who investigates crimes.',
      syllables: ['DE', 'TEC', 'TIVE'],
      answer: 'DETECTIVE',
    ),

    // Level 31-40
    const WordBuilderQuestion(
      definition: 'The planet we live on.',
      syllables: ['U', 'NI', 'VERSE'],
      answer: 'UNIVERSE',
    ),
    const WordBuilderQuestion(
      definition: 'A person skilled in science.',
      syllables: ['SCI', 'EN', 'TIST'],
      answer: 'SCIENTIST',
    ),
    const WordBuilderQuestion(
      definition: 'An event of buying and selling.',
      syllables: ['TRANS', 'AC', 'TION'],
      answer: 'TRANSACTION',
    ),
    const WordBuilderQuestion(
      definition: 'Something dangerous.',
      syllables: ['DAN', 'GER', 'OUS'],
      answer: 'DANGEROUS',
    ),
    const WordBuilderQuestion(
      definition: 'Something exceptionally good.',
      syllables: ['FAN', 'TAS', 'TIC'],
      answer: 'FANTASTIC',
    ),
    const WordBuilderQuestion(
      definition: 'Very beautiful.',
      syllables: ['BEAU', 'TI', 'FUL'],
      answer: 'BEAUTIFUL',
    ),
    const WordBuilderQuestion(
      definition: 'Something important to remember.',
      syllables: ['MEM', 'O', 'RY'],
      answer: 'MEMORY',
    ),
    const WordBuilderQuestion(
      definition: 'A message sent by post.',
      syllables: ['EN', 'VE', 'LOPE'],
      answer: 'ENVELOPE',
    ),
    const WordBuilderQuestion(
      definition: 'The head of a school or organization.',
      syllables: ['PRIN', 'CI', 'PAL'],
      answer: 'PRINCIPAL',
    ),
    const WordBuilderQuestion(
      definition: 'A trip or journey.',
      syllables: ['AD', 'VEN', 'TURE'],
      answer: 'ADVENTURE',
    ),

    // Level 41-50
    const WordBuilderQuestion(
      definition: 'A display of works of art.',
      syllables: ['EX', 'HI', 'BI', 'TION'],
      answer: 'EXHIBITION',
    ),
    const WordBuilderQuestion(
      definition: 'A large musical group with many instruments.',
      syllables: ['OR', 'CHES', 'TRA'],
      answer: 'ORCHESTRA',
    ),
    const WordBuilderQuestion(
      definition: 'Something that is not real.',
      syllables: ['IM', 'AG', 'I', 'NAR', 'Y'],
      answer: 'IMAGINARY',
    ),
    const WordBuilderQuestion(
      definition: 'To communicate ideas or feelings.',
      syllables: ['EX', 'PRES', 'SION'],
      answer: 'EXPRESSION',
    ),
    const WordBuilderQuestion(
      definition: 'The quality of being important.',
      syllables: ['IM', 'POR', 'TANCE'],
      answer: 'IMPORTANCE',
    ),
    const WordBuilderQuestion(
      definition: 'To complete a task successfully.',
      syllables: ['AC', 'COM', 'PLISH'],
      answer: 'ACCOMPLISH',
    ),
    const WordBuilderQuestion(
      definition: 'A formal agreement.',
      syllables: ['SET', 'TLE', 'MENT'],
      answer: 'SETTLEMENT',
    ),
    const WordBuilderQuestion(
      definition: 'The government of a country.',
      syllables: ['GOV', 'ERN', 'MENT'],
      answer: 'GOVERNMENT',
    ),
    const WordBuilderQuestion(
      definition: 'A person filled with energy.',
      syllables: ['EN', 'ER', 'GET', 'IC'],
      answer: 'ENERGETIC',
    ),
    const WordBuilderQuestion(
      definition: 'The rigorous testing of something.',
      syllables: ['EX', 'PER', 'I', 'MENT'],
      answer: 'EXPERIMENT',
    ),

    // Level 51-60
    const WordBuilderQuestion(
      definition: 'An appliance to keep food cold.',
      syllables: ['RE', 'FRIG', 'ER', 'A', 'TOR'],
      answer: 'REFRIGERATOR',
    ),
    const WordBuilderQuestion(
      definition: 'A mountain that erupts lava.',
      syllables: ['VOL', 'CA', 'NO'],
      answer: 'VOLCANO',
    ),
    const WordBuilderQuestion(
      definition: 'A huge wave caused by an earthquake.',
      syllables: ['TSU', 'NA', 'MI'],
      answer: 'TSUNAMI',
    ),
    const WordBuilderQuestion(
      definition: 'The condition of the atmosphere.',
      syllables: ['TEM', 'PER', 'A', 'TURE'], // Close enough
      answer: 'TEMPERATURE',
    ),
    const WordBuilderQuestion(
      definition: 'A device for taking photographs.',
      syllables: ['CAM', 'ER', 'A'],
      answer: 'CAMERA',
    ),
    const WordBuilderQuestion(
      definition: 'A moving image on a screen.',
      syllables: ['VID', 'E', 'O'],
      answer: 'VIDEO',
    ),
    const WordBuilderQuestion(
      definition: 'Electronic communication.',
      syllables: ['IN', 'TER', 'NET'],
      answer: 'INTERNET',
    ),
    const WordBuilderQuestion(
      definition: 'A message sent electronically.',
      syllables: ['E', 'MAIL', 'ING'],
      answer: 'EMAILING',
    ),
    const WordBuilderQuestion(
      definition: 'A list of items to choose from.',
      syllables: ['CAT', 'A', 'LOGUE'],
      answer: 'CATALOGUE',
    ),
    const WordBuilderQuestion(
      definition: 'Something that causes laughter.',
      syllables: ['HI', 'LAR', 'I', 'OUS'],
      answer: 'HILARIOUS',
    ),

    // Level 61-70
    const WordBuilderQuestion(
      definition: 'To calculate roughly.',
      syllables: ['ES', 'TI', 'MATE'],
      answer: 'ESTIMATE',
    ),
    const WordBuilderQuestion(
      definition: 'A discussion between people.',
      syllables: ['CON', 'VER', 'SA', 'TION'],
      answer: 'CONVERSATION',
    ),
    const WordBuilderQuestion(
      definition: 'Information about recent events.',
      syllables: ['NEWS', 'PA', 'PER'],
      answer: 'NEWSPAPER',
    ),
    const WordBuilderQuestion(
      definition: 'A printed publication with articles.',
      syllables: ['MAG', 'A', 'ZINE'],
      answer: 'MAGAZINE',
    ),
    const WordBuilderQuestion(
      definition: 'An exciting experience.',
      syllables: ['EX', 'CITE', 'MENT'],
      answer: 'EXCITEMENT',
    ),
    const WordBuilderQuestion(
      definition: 'Ability to learn and understand.',
      syllables: ['IN', 'TEL', 'LI', 'GENCE'],
      answer: 'INTELLIGENCE',
    ),
    const WordBuilderQuestion(
      definition: 'A machine for washing dishes.',
      syllables: ['DISH', 'WASH', 'ER'],
      answer: 'DISHWASHER',
    ),
    const WordBuilderQuestion(
      definition: 'A distinct part of a city.',
      syllables: ['NEIGH', 'BOR', 'HOOD'],
      answer: 'NEIGHBORHOOD',
    ),
    const WordBuilderQuestion(
      definition: 'A place where medicine is sold.',
      syllables: ['PHAR', 'MA', 'CY'],
      answer: 'PHARMACY',
    ),
    const WordBuilderQuestion(
      definition: 'A facility for medical care.',
      syllables: ['HOS', 'PI', 'TAL'],
      answer: 'HOSPITAL',
    ),

    // Level 71-80
    const WordBuilderQuestion(
      definition: 'A vehicle providing emergency transport.',
      syllables: ['AM', 'BU', 'LANCE'],
      answer: 'AMBULANCE',
    ),
    const WordBuilderQuestion(
      definition: 'Protection against loss.',
      syllables: ['IN', 'SUR', 'ANCE'],
      answer: 'INSURANCE',
    ),
    const WordBuilderQuestion(
      definition: 'A journey by air.',
      syllables: ['FLIGHT', 'AT', 'TEN', 'DANT'],
      answer: 'FLIGHT ATTENDANT',
    ),
    const WordBuilderQuestion(
      definition: 'A planned vacation.',
      syllables: ['HOL', 'I', 'DAY'],
      answer: 'HOLIDAY',
    ),
    const WordBuilderQuestion(
      definition: 'An occasion of public celebration.',
      syllables: ['FES', 'TI', 'VAL'],
      answer: 'FESTIVAL',
    ),
    const WordBuilderQuestion(
      definition: 'Something handed down from ancestors.',
      syllables: ['TRA', 'DI', 'TION'],
      answer: 'TRADITION',
    ),
    const WordBuilderQuestion(
      definition: 'The customs and arts of a nation.',
      syllables: ['CUL', 'TUR', 'AL'],
      answer: 'CULTURAL',
    ),
    const WordBuilderQuestion(
      definition: 'A formal evening meal.',
      syllables: ['DIN', 'NER', 'TIME'],
      answer: 'DINNERTIME',
    ),
    const WordBuilderQuestion(
      definition: 'Something essential for survival.',
      syllables: ['NEC', 'ES', 'SAR', 'Y'],
      answer: 'NECESSARY',
    ),
    const WordBuilderQuestion(
      definition: 'The capability to do something.',
      syllables: ['A', 'BIL', 'I', 'TY'],
      answer: 'ABILITY',
    ),
    const WordBuilderQuestion(
      definition: 'A feeling of happiness.',
      syllables: ['HAP', 'PI', 'NESS'],
      answer: 'HAPPINESS',
    ),

    // Level 81-90
    const WordBuilderQuestion(
      definition: 'A source of light.',
      syllables: ['E', 'LEC', 'TRIC', 'I', 'TY'],
      answer: 'ELECTRICITY',
    ),
    const WordBuilderQuestion(
      definition: 'The community of people living freely.',
      syllables: ['SO', 'CI', 'E', 'TY'],
      answer: 'SOCIETY',
    ),
    const WordBuilderQuestion(
      definition: 'A group of people working together.',
      syllables: ['COM', 'MU', 'NI', 'TY'],
      answer: 'COMMUNITY',
    ),
    const WordBuilderQuestion(
      definition: 'A feeling of thankfulness.',
      syllables: ['GRAT', 'I', 'TUDE'],
      answer: 'GRATITUDE',
    ),
    const WordBuilderQuestion(
      definition: 'To acknowledge with praise.',
      syllables: ['AP', 'PRE', 'CI', 'ATE'],
      answer: 'APPRECIATE',
    ),
    const WordBuilderQuestion(
      definition: 'Being dependable.',
      syllables: ['RE', 'LI', 'A', 'BLE'],
      answer: 'RELIABLE',
    ),
    const WordBuilderQuestion(
      definition: 'Working with others.',
      syllables: ['CO', 'OP', 'ER', 'A', 'TION'],
      answer: 'COOPERATION',
    ),
    const WordBuilderQuestion(
      definition: 'Exchange of information.',
      syllables: ['COM', 'MU', 'NI', 'CA', 'TION'],
      answer: 'COMMUNICATION',
    ),
    const WordBuilderQuestion(
      definition: 'Process of teaching or learning.',
      syllables: ['ED', 'U', 'CA', 'TION'],
      answer: 'EDUCATION',
    ),
    const WordBuilderQuestion(
      definition: 'A university decree.',
      syllables: ['GRAD', 'U', 'A', 'TION'],
      answer: 'GRADUATION',
    ),

    // Level 91-100
    const WordBuilderQuestion(
      definition: 'To obtain something.',
      syllables: ['AC', 'QUI', 'SI', 'TION'],
      answer: 'ACQUISITION',
    ),
    const WordBuilderQuestion(
      definition: 'State of being satisfied.',
      syllables: ['SAT', 'IS', 'FAC', 'TION'],
      answer: 'SATISFACTION',
    ),
    const WordBuilderQuestion(
      definition: 'Something that motivates.',
      syllables: ['IN', 'SPI', 'RA', 'TION'],
      answer: 'INSPIRATION',
    ),
    const WordBuilderQuestion(
      definition: 'A creative idea.',
      syllables: ['I', 'MAG', 'I', 'NA', 'TION'],
      answer: 'IMAGINATION',
    ),
    const WordBuilderQuestion(
      definition: 'The surrounding environment.',
      syllables: ['AT', 'MOS', 'PHERE'],
      answer: 'ATMOSPHERE',
    ),
    const WordBuilderQuestion(
      definition: 'A large meeting for discussion.',
      syllables: ['CON', 'FER', 'ENCE'],
      answer: 'CONFERENCE',
    ),
    const WordBuilderQuestion(
      definition: 'A dramatic performance.',
      syllables: ['THE', 'AT', 'RI', 'CAL'],
      answer: 'THEATRICAL',
    ),
    const WordBuilderQuestion(
      definition: 'A person dealing with customers.',
      syllables: ['REP', 'RE', 'SEN', 'TA', 'TIVE'],
      answer: 'REPRESENTATIVE',
    ),
    const WordBuilderQuestion(
      definition: 'A sweet food made by bees.',
      syllables: ['HON', 'EY', 'COMB'],
      answer: 'HONEYCOMB',
    ),
    const WordBuilderQuestion(
      definition: 'To make something better.',
      syllables: ['IM', 'PROVE', 'MENT'],
      answer: 'IMPROVEMENT',
    ),

    // Level 101-110
    const WordBuilderQuestion(
      definition: 'A large animal that hops.',
      syllables: ['KAN', 'GA', 'ROO'],
      answer: 'KANGAROO',
    ),
    const WordBuilderQuestion(
      definition: 'A large reptile with sharp teeth.',
      syllables: ['CROC', 'O', 'DILE'],
      answer: 'CROCODILE',
    ),
    const WordBuilderQuestion(
      definition: 'A very large river animal.',
      syllables: ['HIP', 'PO', 'POT', 'A', 'MUS'],
      answer: 'HIPPOPOTAMUS',
    ),
    const WordBuilderQuestion(
      definition: 'A large animal with a horn on its nose.',
      syllables: ['RHI', 'NOC', 'ER', 'OS'],
      answer: 'RHINOCEROS',
    ),
    const WordBuilderQuestion(
      definition: 'A large ape.',
      syllables: ['GO', 'RIL', 'LA'],
      answer: 'GORILLA',
    ),
    const WordBuilderQuestion(
      definition: 'A smart primate causing trouble.',
      syllables: ['CHIM', 'PAN', 'ZEE'],
      answer: 'CHIMPANZEE',
    ),
    const WordBuilderQuestion(
      definition: 'A pink bird with long legs.',
      syllables: ['FLA', 'MIN', 'GO'],
      answer: 'FLAMINGO',
    ),
    const WordBuilderQuestion(
      definition: 'A bird that taps on trees.',
      syllables: ['WOOD', 'PECK', 'ER'],
      answer: 'WOODPECKER',
    ),
    const WordBuilderQuestion(
      definition: 'A sea creature with eight arms.',
      syllables: ['OC', 'TO', 'PUS'],
      answer: 'OCTOPUS',
    ),
    const WordBuilderQuestion(
      definition: 'A transparent sea creature.',
      syllables: ['JEL', 'LY', 'FISH'],
      answer: 'JELLYFISH',
    ),

    // Level 111-120
    const WordBuilderQuestion(
      definition: 'A long green vegetable.',
      syllables: ['CU', 'CUM', 'BER'],
      answer: 'CUCUMBER',
    ),
    const WordBuilderQuestion(
      definition: 'A tropical fruit with spiky skin.',
      syllables: ['PINE', 'AP', 'PLE'],
      answer: 'PINEAPPLE',
    ),
    const WordBuilderQuestion(
      definition: 'A red berry with seeds.',
      syllables: ['STRAW', 'BER', 'RY'],
      answer: 'STRAWBERRY',
    ),
    const WordBuilderQuestion(
      definition: 'A small blue fruit.',
      syllables: ['BLUE', 'BER', 'RY'],
      answer: 'BLUEBERRY',
    ),
    const WordBuilderQuestion(
      definition: 'Detailed analysis or assessment.',
      syllables: ['EX', 'AM', 'I', 'NA', 'TION'],
      answer: 'EXAMINATION',
    ),
    const WordBuilderQuestion(
      definition: 'A citrus fruit similar to an orange.',
      syllables: ['TAN', 'GER', 'INE'],
      answer: 'TANGERINE',
    ),
    const WordBuilderQuestion(
      definition: 'A green vegetable that looks like a tree.',
      syllables: ['BROC', 'CO', 'LI'],
      answer: 'BROCCOLI',
    ),
    const WordBuilderQuestion(
      definition: 'A white vegetable with a large head.',
      syllables: ['CAU', 'LI', 'FLOW', 'ER'],
      answer: 'CAULIFLOWER',
    ),
    const WordBuilderQuestion(
      definition: 'A long green summer squash.',
      syllables: ['ZUC', 'CHI', 'NI'],
      answer: 'ZUCCHINI',
    ),
    const WordBuilderQuestion(
      definition: 'A stalk vegetable often eaten raw.',
      syllables: ['CEL', 'ER', 'Y'],
      answer: 'CELERY',
    ),

    // Level 121-130
    const WordBuilderQuestion(
      definition: 'A starchy tuber vegetable.',
      syllables: ['PO', 'TA', 'TO'],
      answer: 'POTATO',
    ),
    const WordBuilderQuestion(
      definition: 'An aircraft with rotating blades.',
      syllables: ['HEL', 'I', 'COP', 'TER'],
      answer: 'HELICOPTER',
    ),
    const WordBuilderQuestion(
      definition: 'A boat that goes underwater.',
      syllables: ['SUB', 'MA', 'RINE'],
      answer: 'SUBMARINE',
    ),
    const WordBuilderQuestion(
      definition: 'A vehicle with two wheels.',
      syllables: ['BI', 'CY', 'CLE'],
      answer: 'BICYCLE',
    ),
    const WordBuilderQuestion(
      definition: 'A vehicle for digging.',
      syllables: ['EX', 'CA', 'VA', 'TOR'],
      answer: 'EXCAVATOR',
    ),
    const WordBuilderQuestion(
      definition: 'A monumental structure with a square base.',
      syllables: ['PYR', 'A', 'MID'],
      answer: 'PYRAMID',
    ),
    const WordBuilderQuestion(
      definition: 'A statue or building to remember someone.',
      syllables: ['MON', 'U', 'MENT'],
      answer: 'MONUMENT',
    ),
    const WordBuilderQuestion(
      definition: 'A large and important church.',
      syllables: ['CA', 'THE', 'DRAL'],
      answer: 'CATHEDRAL',
    ),
    const WordBuilderQuestion(
      definition: 'A very tall building.',
      syllables: ['SKY', 'SCRAP', 'ER'],
      answer: 'SKYSCRAPER',
    ),
    const WordBuilderQuestion(
      definition: 'A set of rooms for living.',
      syllables: ['A', 'PART', 'MENT'],
      answer: 'APARTMENT',
    ),

    // Level 131-140
    const WordBuilderQuestion(
      definition: 'A small house with one story.',
      syllables: ['BUN', 'GA', 'LOW'],
      answer: 'BUNGALOW',
    ),
    const WordBuilderQuestion(
      definition: 'A large sports arena.',
      syllables: ['STA', 'DI', 'UM'],
      answer: 'STADIUM',
    ),
    const WordBuilderQuestion(
      definition: 'A place to see water animals.',
      syllables: ['A', 'QUAR', 'I', 'UM'],
      answer: 'AQUARIUM',
    ),
    const WordBuilderQuestion(
      definition: 'A building for interesting objects.',
      syllables: ['MU', 'SE', 'UM'],
      answer: 'MUSEUM',
    ),
    const WordBuilderQuestion(
      definition: 'A hall for sports and exercise.',
      syllables: ['GYM', 'NA', 'SI', 'UM'],
      answer: 'GYMNASIUM',
    ),
    const WordBuilderQuestion(
      definition: 'A high-level educational institution.',
      syllables: ['U', 'NI', 'VER', 'SI', 'TY'],
      answer: 'UNIVERSITY',
    ),
    const WordBuilderQuestion(
      definition: 'A university teacher of high rank.',
      syllables: ['PRO', 'FES', 'SOR'],
      answer: 'PROFESSOR',
    ),
    const WordBuilderQuestion(
      definition: 'A task given to students.',
      syllables: ['AS', 'SIGN', 'MENT'],
      answer: 'ASSIGNMENT',
    ),
    const WordBuilderQuestion(
      definition: 'A person who designs buildings.',
      syllables: ['AR', 'CHI', 'TECT'],
      answer: 'ARCHITECT',
    ),
    const WordBuilderQuestion(
      definition: 'An official document of achievement.',
      syllables: ['CER', 'TIF', 'I', 'CATE'],
      answer: 'CERTIFICATE',
    ),

    // Level 141-150
    const WordBuilderQuestion(
      definition: 'A certificate awarded by a college.',
      syllables: ['DI', 'PLO', 'MA'],
      answer: 'DIPLOMA',
    ),
    const WordBuilderQuestion(
      definition: 'A device for mathematical calculations.',
      syllables: ['CAL', 'CU', 'LA', 'TOR'],
      answer: 'CALCULATOR',
    ),
    const WordBuilderQuestion(
      definition: 'A screen for a computer.',
      syllables: ['MON', 'I', 'TOR'],
      answer: 'MONITOR',
    ),
    const WordBuilderQuestion(
      definition: 'A device to record sound.',
      syllables: ['MI', 'CRO', 'PHONE'],
      answer: 'MICROPHONE',
    ),
    const WordBuilderQuestion(
      definition: 'A device to make sound louder.',
      syllables: ['LOUD', 'SPEAK', 'ER'],
      answer: 'LOUDSPEAKER',
    ),
    const WordBuilderQuestion(
      definition: 'A system for broadcasting images.',
      syllables: ['TEL', 'E', 'VI', 'SION'],
      answer: 'TELEVISION',
    ),
    const WordBuilderQuestion(
      definition: 'An object orbiting the earth.',
      syllables: ['SAT', 'EL', 'LITE'],
      answer: 'SATELLITE',
    ),
    const WordBuilderQuestion(
      definition: 'An instrument to see far objects.',
      syllables: ['TEL', 'E', 'SCOPE'],
      answer: 'TELESCOPE',
    ),
    const WordBuilderQuestion(
      definition: 'An instrument to see tiny objects.',
      syllables: ['MI', 'CRO', 'SCOPE'],
      answer: 'MICROSCOPE',
    ),
    const WordBuilderQuestion(
      definition: 'A device for seeing distant objects with two eyes.',
      syllables: ['BI', 'NOC', 'U', 'LARS'],
      answer: 'BINOCULARS',
    ),

    // Level 151-160
    const WordBuilderQuestion(
      definition: 'An instrument to measure atmospheric pressure.',
      syllables: ['BA', 'ROM', 'E', 'TER'],
      answer: 'BAROMETER',
    ),
    const WordBuilderQuestion(
      definition: 'A medical instrument for listening.',
      syllables: ['STETH', 'O', 'SCOPE'],
      answer: 'STETHOSCOPE',
    ),
    const WordBuilderQuestion(
      definition: 'A substance used for treatment.',
      syllables: ['MED', 'I', 'CINE'],
      answer: 'MEDICINE',
    ),
    const WordBuilderQuestion(
      definition: 'A nutrient essential for health.',
      syllables: ['VI', 'TA', 'MIN'],
      answer: 'VITAMIN',
    ),
    const WordBuilderQuestion(
      definition: 'A powerful medicine to kill bacteria.',
      syllables: ['AN', 'TI', 'BI', 'OT', 'IC'],
      answer: 'ANTIBIOTIC',
    ),
    const WordBuilderQuestion(
      definition: 'An invasion of germs in the body.',
      syllables: ['IN', 'FEC', 'TION'],
      answer: 'INFECTION',
    ),
    const WordBuilderQuestion(
      definition: 'A medical procedure.',
      syllables: ['OP', 'ER', 'A', 'TION'],
      answer: 'OPERATION',
    ),
    const WordBuilderQuestion(
      definition: 'Medical treatment by cutting.',
      syllables: ['SUR', 'GER', 'Y'],
      answer: 'SURGERY',
    ),
    const WordBuilderQuestion(
      definition: 'A person who designs engines.',
      syllables: ['EN', 'GI', 'NEER'],
      answer: 'ENGINEER',
    ),
    const WordBuilderQuestion(
      definition: 'Person employed to report news.',
      syllables: ['JOUR', 'NAL', 'IST'],
      answer: 'JOURNALIST',
    ),

    // Level 161-170
    const WordBuilderQuestion(
      definition: 'Someone who plays an instrument.',
      syllables: ['MU', 'SI', 'CIAN'],
      answer: 'MUSICIAN',
    ),
    const WordBuilderQuestion(
      definition: 'A person who directs a film.',
      syllables: ['DI', 'REC', 'TOR'],
      answer: 'DIRECTOR',
    ),
    const WordBuilderQuestion(
      definition: 'A person who greets visitors.',
      syllables: ['RE', 'CEP', 'TION', 'IST'],
      answer: 'RECEPTIONIST',
    ),
    const WordBuilderQuestion(
      definition: 'An assistant in an office.',
      syllables: ['SEC', 'RE', 'TAR', 'Y'],
      answer: 'SECRETARY',
    ),
    const WordBuilderQuestion(
      definition: 'A person in charge of a business.',
      syllables: ['MAN', 'A', 'GER'],
      answer: 'MANAGER',
    ),
    const WordBuilderQuestion(
      definition: 'The head of a republic.',
      syllables: ['PRES', 'I', 'DENT'],
      answer: 'PRESIDENT',
    ),
    const WordBuilderQuestion(
      definition: 'A head of a government department.',
      syllables: ['MIN', 'IS', 'TER'],
      answer: 'MINISTER',
    ),
    const WordBuilderQuestion(
      definition: 'A person involved in politics.',
      syllables: ['POL', 'I', 'TI', 'CIAN'],
      answer: 'POLITICIAN',
    ),
    const WordBuilderQuestion(
      definition: 'A person in a position of authority.',
      syllables: ['OF', 'FI', 'CER'],
      answer: 'OFFICER',
    ),
    const WordBuilderQuestion(
      definition: 'A male police officer.',
      syllables: ['PO', 'LICE', 'MAN'],
      answer: 'POLICEMAN',
    ),

    // Level 171-180
    const WordBuilderQuestion(
      definition: 'A person who puts out fires.',
      syllables: ['FIRE', 'FIGHT', 'ER'],
      answer: 'FIREFIGHTER',
    ),
    const WordBuilderQuestion(
      definition: 'A person who makes wooden objects.',
      syllables: ['CAR', 'PEN', 'TER'],
      answer: 'CARPENTER',
    ),
    const WordBuilderQuestion(
      definition: 'A person who installs electrical equipment.',
      syllables: ['E', 'LEC', 'TRI', 'CIAN'],
      answer: 'ELECTRICIAN',
    ),
    const WordBuilderQuestion(
      definition: 'A person who repairs machines.',
      syllables: ['ME', 'CHAN', 'IC'],
      answer: 'MECHANIC',
    ),
    const WordBuilderQuestion(
      definition: 'A person who tends a garden.',
      syllables: ['GAR', 'DEN', 'ER'],
      answer: 'GARDENER',
    ),
    const WordBuilderQuestion(
      definition: 'A person who catches fish.',
      syllables: ['FISH', 'ER', 'MAN'],
      answer: 'FISHERMAN',
    ),
    const WordBuilderQuestion(
      definition: 'A person who cuts hair.',
      syllables: ['HAIR', 'DRESS', 'ER'],
      answer: 'HAIRDRESSER',
    ),
    const WordBuilderQuestion(
      definition: 'A person who buys goods.',
      syllables: ['CUS', 'TOM', 'ER'],
      answer: 'CUSTOMER',
    ),
    const WordBuilderQuestion(
      definition: 'A traveler on a public vehicle.',
      syllables: ['PAS', 'SEN', 'GER'],
      answer: 'PASSENGER',
    ),
    const WordBuilderQuestion(
      definition: 'A legal subject of a state.',
      syllables: ['CIT', 'I', 'ZEN'],
      answer: 'CITIZEN',
    ),

    // Level 181-190
    const WordBuilderQuestion(
      definition: 'The way people are connected.',
      syllables: ['RE', 'LA', 'TION', 'SHIP'],
      answer: 'RELATIONSHIP',
    ),
    const WordBuilderQuestion(
      definition: 'A ceremony for a dead person.',
      syllables: ['FU', 'NER', 'AL'],
      answer: 'FUNERAL',
    ),
    const WordBuilderQuestion(
      definition: 'A belief in a god or gods.',
      syllables: ['RE', 'LI', 'GION'],
      answer: 'RELIGION',
    ),
    const WordBuilderQuestion(
      definition: 'A Jewish house of worship.',
      syllables: ['SYN', 'A', 'GOGUE'],
      answer: 'SYNAGOGUE',
    ),
    const WordBuilderQuestion(
      definition: 'A building for monks.',
      syllables: ['MON', 'AS', 'TER', 'Y'],
      answer: 'MONASTERY',
    ),
    const WordBuilderQuestion(
      definition: 'An ideal or idyllic place.',
      syllables: ['PAR', 'A', 'DISE'],
      answer: 'PARADISE',
    ),
    const WordBuilderQuestion(
      definition: 'An extinct prehistoric reptile.',
      syllables: ['DI', 'NO', 'SAUR'],
      answer: 'DINOSAUR',
    ),
    const WordBuilderQuestion(
      definition: 'Structure of bones in the body.',
      syllables: ['SKEL', 'E', 'TON'],
      answer: 'SKELETON',
    ),
    const WordBuilderQuestion(
      definition: 'The lower part of the alimentary canal.',
      syllables: ['IN', 'TES', 'TINE'],
      answer: 'INTESTINE',
    ),
    const WordBuilderQuestion(
      definition: 'A fruit with a hard shell and red seeds.',
      syllables: ['POM', 'E', 'GRAN', 'ATE'],
      answer: 'POMEGRANATE',
    ),

    // Level 191-200
    const WordBuilderQuestion(
      definition: 'A person who organizes.',
      syllables: ['OR', 'GAN', 'I', 'ZER'],
      answer: 'ORGANIZER',
    ),
    const WordBuilderQuestion(
      definition: 'A person taking part in a sport.',
      syllables: ['COM', 'PET', 'I', 'TOR'],
      answer: 'COMPETITOR',
    ),
    const WordBuilderQuestion(
      definition: 'A deep appreciation.',
      syllables: ['AD', 'MI', 'RA', 'TION'],
      answer: 'ADMIRATION',
    ),
    const WordBuilderQuestion(
      definition: 'A prediction of the future.',
      syllables: ['EX', 'PEC', 'TA', 'TION'],
      answer: 'EXPECTATION',
    ),
    const WordBuilderQuestion(
      definition: 'The action of celebrating.',
      syllables: ['COM', 'MEM', 'O', 'RA', 'TION'],
      answer: 'COMMEMORATION',
    ),
    const WordBuilderQuestion(
      definition: 'The quality of being honest.',
      syllables: ['SIN', 'CER', 'I', 'TY'],
      answer: 'SINCERITY',
    ),
    const WordBuilderQuestion(
      definition: 'A feeling of deep distress.',
      syllables: ['SUF', 'FER', 'ING'],
      answer: 'SUFFERING',
    ),
    const WordBuilderQuestion(
      definition: 'The state of being free.',
      syllables: ['LIB', 'ER', 'TY'],
      answer: 'LIBERTY',
    ),
    const WordBuilderQuestion(
      definition: 'A person who explores.',
      syllables: ['EX', 'PLOR', 'ER'],
      answer: 'EXPLORER',
    ),
    const WordBuilderQuestion(
      definition: 'Something remarkable.',
      syllables: ['PHE', 'NOM', 'E', 'NON'],
      answer: 'PHENOMENON',
    ),

    // Level 201-210
    const WordBuilderQuestion(
      definition: 'A large waterfall.',
      syllables: ['CAT', 'A', 'RACT'],
      answer: 'CATARACT',
    ),
    const WordBuilderQuestion(
      definition: 'A steep descent of water.',
      syllables: ['WAT', 'ER', 'FALL'],
      answer: 'WATERFALL',
    ),
    const WordBuilderQuestion(
      definition: 'A large body of saltwater.',
      syllables: ['O', 'CEAN', 'IC'],
      answer: 'OCEANIC',
    ),
    const WordBuilderQuestion(
      definition: 'Land surrounded by water.',
      syllables: ['PEN', 'IN', 'SU', 'LA'],
      answer: 'PENINSULA',
    ),
    const WordBuilderQuestion(
      definition: 'A group of islands.',
      syllables: ['AR', 'CHI', 'PEL', 'A', 'GO'],
      answer: 'ARCHIPELAGO',
    ),
    const WordBuilderQuestion(
      definition: 'The side of a mountain.',
      syllables: ['MOUN', 'TAIN', 'SIDE'],
      answer: 'MOUNTAINSIDE',
    ),
    const WordBuilderQuestion(
      definition: 'An expanse of sand.',
      syllables: ['DES', 'ER', 'TI', 'FY'],
      answer: 'DESERTIFY',
    ),
    const WordBuilderQuestion(
      definition: 'Violent windy storm.',
      syllables: ['HUR', 'RI', 'CANE'],
      answer: 'HURRICANE',
    ),
    const WordBuilderQuestion(
      definition: 'A funnel-shaped storm.',
      syllables: ['TOR', 'NA', 'DO'],
      answer: 'TORNADO',
    ),
    const WordBuilderQuestion(
      definition: 'A mountain that erupts.',
      syllables: ['VOL', 'CA', 'NO'],
      answer: 'VOLCANO',
    ),

    // Level 211-220
    const WordBuilderQuestion(
      definition: 'A sudden violent shaking of the ground.',
      syllables: ['TREM', 'U', 'LOUS'],
      answer: 'TREMULOUS',
    ),
    const WordBuilderQuestion(
      definition: 'The gaseous envelope of earth.',
      syllables: ['AT', 'MOS', 'PHER', 'IC'],
      answer: 'ATMOSPHERIC',
    ),
    const WordBuilderQuestion(
      definition: 'Relating to the environment.',
      syllables: ['EN', 'VI', 'RON', 'MEN', 'TAL'],
      answer: 'ENVIRONMENTAL',
    ),
    const WordBuilderQuestion(
      definition: 'Study of the earth.',
      syllables: ['GE', 'OL', 'O', 'GY'],
      answer: 'GEOLOGY',
    ),
    const WordBuilderQuestion(
      definition: 'Study of living organisms.',
      syllables: ['BI', 'OL', 'O', 'GY'],
      answer: 'BIOLOGY',
    ),
    const WordBuilderQuestion(
      definition: 'Study of matter.',
      syllables: ['CHEM', 'IS', 'TRY'],
      answer: 'CHEMISTRY',
    ),
    const WordBuilderQuestion(
      definition: 'Study of society.',
      syllables: ['SO', 'CI', 'OL', 'O', 'GY'],
      answer: 'SOCIOLOGY',
    ),
    const WordBuilderQuestion(
      definition: 'Study of the mind.',
      syllables: ['PSY', 'CHOL', 'O', 'GY'],
      answer: 'PSYCHOLOGY',
    ),
    const WordBuilderQuestion(
      definition: 'Study of stars.',
      syllables: ['AS', 'TRON', 'O', 'MY'],
      answer: 'ASTRONOMY',
    ),
    const WordBuilderQuestion(
      definition: 'Science of numbers.',
      syllables: ['MATH', 'E', 'MAT', 'ICS'],
      answer: 'MATHEMATICS',
    ),

    // Level 221-230
    const WordBuilderQuestion(
      definition: 'A public display of works.',
      syllables: ['EX', 'HI', 'BI', 'TION'],
      answer: 'EXHIBITION',
    ),
    const WordBuilderQuestion(
      definition: 'A theatrical entertainment.',
      syllables: ['PER', 'FOR', 'MANCE'],
      answer: 'PERFORMANCE',
    ),
    const WordBuilderQuestion(
      definition: 'A presentation for an audience.',
      syllables: ['PRES', 'EN', 'TA', 'TION'],
      answer: 'PRESENTATION',
    ),
    const WordBuilderQuestion(
      definition: 'A discussion designed to produce an agreement.',
      syllables: ['NE', 'GO', 'TI', 'A', 'TION'],
      answer: 'NEGOTIATION',
    ),
    const WordBuilderQuestion(
      definition: 'The action of communicating.',
      syllables: ['COM', 'MU', 'NI', 'CA', 'TION'],
      answer: 'COMMUNICATION',
    ),
    const WordBuilderQuestion(
      definition: 'The imparting of information.',
      syllables: ['IN', 'FOR', 'MA', 'TION'],
      answer: 'INFORMATION',
    ),
    const WordBuilderQuestion(
      definition: 'The process of receiving instruction.',
      syllables: ['ED', 'U', 'CA', 'TION'],
      answer: 'EDUCATION',
    ),
    const WordBuilderQuestion(
      definition: 'The capacity for learning.',
      syllables: ['IN', 'TEL', 'LI', 'GENCE'],
      answer: 'INTELLIGENCE',
    ),
    const WordBuilderQuestion(
      definition: 'The power of recall.',
      syllables: ['MEM', 'O', 'RY'],
      answer: 'MEMORY',
    ),
    const WordBuilderQuestion(
      definition: 'The faculty of reasoning.',
      syllables: ['UN', 'DER', 'STAND', 'ING'],
      answer: 'UNDERSTANDING',
    ),

    // Level 231-240
    const WordBuilderQuestion(
      definition: 'A state of happiness.',
      syllables: ['SAT', 'IS', 'FAC', 'TION'],
      answer: 'SATISFACTION',
    ),
    const WordBuilderQuestion(
      definition: 'A feeling of pleasure.',
      syllables: ['EN', 'JOY', 'MENT'],
      answer: 'ENJOYMENT',
    ),
    const WordBuilderQuestion(
      definition: 'The state of being amused.',
      syllables: ['A', 'MUSE', 'MENT'],
      answer: 'AMUSEMENT',
    ),
    const WordBuilderQuestion(
      definition: 'The action of entertaining.',
      syllables: ['EN', 'TER', 'TAIN', 'MENT'],
      answer: 'ENTERTAINMENT',
    ),
    const WordBuilderQuestion(
      definition: 'The feeling of being excited.',
      syllables: ['EX', 'CITE', 'MENT'],
      answer: 'EXCITEMENT',
    ),
    const WordBuilderQuestion(
      definition: 'Something that discourages.',
      syllables: ['DIS', 'AP', 'POINT', 'MENT'],
      answer: 'DISAPPOINTMENT',
    ),
    const WordBuilderQuestion(
      definition: 'The condition of being embarrassed.',
      syllables: ['EM', 'BAR', 'RASS', 'MENT'],
      answer: 'EMBARRASSMENT',
    ),
    const WordBuilderQuestion(
      definition: 'The process of developing.',
      syllables: ['DE', 'VEL', 'OP', 'MENT'],
      answer: 'DEVELOPMENT',
    ),
    const WordBuilderQuestion(
      definition: 'The authority to rule.',
      syllables: ['GOV', 'ERN', 'MENT'],
      answer: 'GOVERNMENT',
    ),
    const WordBuilderQuestion(
      definition: 'A group of people.',
      syllables: ['POP', 'U', 'LA', 'TION'],
      answer: 'POPULATION',
    ),

    // Level 241-250
    const WordBuilderQuestion(
      definition: 'A large aggregate of people.',
      syllables: ['COM', 'MU', 'NI', 'TY'],
      answer: 'COMMUNITY',
    ),
    const WordBuilderQuestion(
      definition: 'A particular area or place.',
      syllables: ['LO', 'CA', 'TION'],
      answer: 'LOCATION',
    ),
    const WordBuilderQuestion(
      definition: 'The place where one leads to.',
      syllables: ['DES', 'TI', 'NA', 'TION'],
      answer: 'DESTINATION',
    ),
    const WordBuilderQuestion(
      definition: 'The management of moving goods.',
      syllables: ['TRANS', 'POR', 'TA', 'TION'],
      answer: 'TRANSPORTATION',
    ),
    const WordBuilderQuestion(
      definition: 'A place for treatment.',
      syllables: ['HOS', 'PI', 'TAL'],
      answer: 'HOSPITAL',
    ),
    const WordBuilderQuestion(
      definition: 'A building for books.',
      syllables: ['LI', 'BRAR', 'Y'],
      answer: 'LIBRARY',
    ),
    const WordBuilderQuestion(
      definition: 'A place for making food.',
      syllables: ['RES', 'TAU', 'RANT'],
      answer: 'RESTAURANT',
    ),
    const WordBuilderQuestion(
      definition: 'A large shop.',
      syllables: ['SU', 'PER', 'MAR', 'KET'],
      answer: 'SUPERMARKET',
    ),
    const WordBuilderQuestion(
      definition: 'A place for baking bread.',
      syllables: ['BAK', 'ER', 'Y'],
      answer: 'BAKERY',
    ),
    const WordBuilderQuestion(
      definition: 'A shop selling medicines.',
      syllables: ['PHAR', 'MA', 'CY'],
      answer: 'PHARMACY',
    ),

    // Level 251-260
    const WordBuilderQuestion(
      definition: 'A sweet brown food.',
      syllables: ['CHOC', 'O', 'LATE'],
      answer: 'CHOCOLATE',
    ),
    const WordBuilderQuestion(
      definition: 'A popular flavor.',
      syllables: ['VA', 'NIL', 'LA'],
      answer: 'VANILLA',
    ),
    const WordBuilderQuestion(
      definition: 'A red fruit.',
      syllables: ['TO', 'MA', 'TO'],
      answer: 'TOMATO',
    ),
    const WordBuilderQuestion(
      definition: 'A leafy green.',
      syllables: ['LET', 'TUCE', 'LEAF'],
      answer: 'LETTUCE',
    ), // LET-TUCE is 2.
    // Let's use ASPARAGUS
    const WordBuilderQuestion(
      definition: 'A green stalk vegetable.',
      syllables: ['A', 'SPAR', 'A', 'GUS'],
      answer: 'ASPARAGUS',
    ),
    const WordBuilderQuestion(
      definition: 'A purple vegetable.',
      syllables: ['AU', 'BER', 'GINE'],
      answer: 'AUBERGINE',
    ),
    const WordBuilderQuestion(
      definition: 'A hot spicy powder.',
      syllables: ['PA', 'PRI', 'KA'],
      answer: 'PAPRIKA',
    ),
    const WordBuilderQuestion(
      definition: 'An aromatic spice.',
      syllables: ['CIN', 'NA', 'MON'],
      answer: 'CINNAMON',
    ),
    const WordBuilderQuestion(
      definition: 'A flat Italian bread.',
      syllables: ['FOC', 'AC', 'CIA'],
      answer: 'FOCACCIA',
    ),
    const WordBuilderQuestion(
      definition: 'A type of pasta.',
      syllables: ['MAC', 'A', 'RO', 'NI'],
      answer: 'MACARONI',
    ),
    const WordBuilderQuestion(
      definition: 'Long thin pasta.',
      syllables: ['SPA', 'GHET', 'TI'],
      answer: 'SPAGHETTI',
    ),

    // Level 261-270
    const WordBuilderQuestion(
      definition: 'Grain eaten for breakfast.',
      syllables: ['CE', 'RE', 'AL'],
      answer: 'CEREAL',
    ),
    const WordBuilderQuestion(
      definition: 'A seasoned smoked sausage.',
      syllables: ['PEP', 'PER', 'O', 'NI'],
      answer: 'PEPPERONI',
    ),
    const WordBuilderQuestion(
      definition: 'A liquid dish.',
      syllables: ['MIN', 'E', 'STRO', 'NE'],
      answer: 'MINESTRONE',
    ),
    const WordBuilderQuestion(
      definition: 'A spicy meat dish.',
      syllables: ['CO', 'RI', 'AN', 'DER'],
      answer: 'CORIANDER',
    ),
    const WordBuilderQuestion(
      definition: 'A sweet course.',
      syllables: ['TIR', 'A', 'MI', 'SU'],
      answer: 'TIRAMISU',
    ),
    const WordBuilderQuestion(
      definition: 'A drink from leaves.',
      syllables: ['PEP', 'PER', 'MINT'],
      answer: 'PEPPERMINT',
    ),
    const WordBuilderQuestion(
      definition: 'A drink made from beans.',
      syllables: ['CAP', 'PUC', 'CI', 'NO'],
      answer: 'CAPPUCCINO',
    ),
    const WordBuilderQuestion(
      definition: 'A drink of fruit juice.',
      syllables: ['LEM', 'ON', 'ADE'],
      answer: 'LEMONADE',
    ),
    const WordBuilderQuestion(
      definition: 'Sparkling mineral water.',
      syllables: ['CAR', 'BON', 'AT', 'ED'],
      answer: 'CARBONATED',
    ),
    const WordBuilderQuestion(
      definition: 'The main meal of the day.',
      syllables: ['DIN', 'NER', 'TIME'],
      answer: 'DINNERTIME',
    ),

    // Level 271-280
    const WordBuilderQuestion(
      definition: 'A set of clothes.',
      syllables: ['U', 'NI', 'FORM'],
      answer: 'UNIFORM',
    ),
    const WordBuilderQuestion(
      definition: 'A waterproof coat.',
      syllables: ['MACK', 'IN', 'TOSH'],
      answer: 'MACKINTOSH',
    ),
    const WordBuilderQuestion(
      definition: 'A piece of woolen clothing.',
      syllables: ['CAR', 'DI', 'GAN'],
      answer: 'CARDIGAN',
    ),
    const WordBuilderQuestion(
      definition: 'Trousers made of denim.',
      syllables: ['DUN', 'GA', 'REES'],
      answer: 'DUNGAREES',
    ),
    const WordBuilderQuestion(
      definition: 'Clothing worn for sleep.',
      syllables: ['PA', 'JA', 'MAS'],
      answer: 'PAJAMAS',
    ),
    const WordBuilderQuestion(
      definition: 'Footwear mostly for sports.',
      syllables: ['MOC', 'CA', 'SIN'],
      answer: 'MOCCASIN',
    ),
    const WordBuilderQuestion(
      definition: 'Ornaments worn on the body.',
      syllables: ['JEW', 'EL', 'RY'],
      answer: 'JEWELRY',
    ),
    const WordBuilderQuestion(
      definition: 'A decorative stone.',
      syllables: ['DI', 'A', 'MOND'],
      answer: 'DIAMOND',
    ),
    const WordBuilderQuestion(
      definition: 'Precious green stone.',
      syllables: ['EM', 'ER', 'ALD'],
      answer: 'EMERALD',
    ),
    const WordBuilderQuestion(
      definition: 'A timepiece worn on the wrist.',
      syllables: ['CHRO', 'NOM', 'E', 'TER'],
      answer: 'CHRONOMETER',
    ),

    // Level 281-290
    const WordBuilderQuestion(
      definition: 'A game played with a ball.',
      syllables: ['BAS', 'KET', 'BALL'],
      answer: 'BASKETBALL',
    ),
    const WordBuilderQuestion(
      definition: 'A game played with a racquet.',
      syllables: ['BAD', 'MIN', 'TON'],
      answer: 'BADMINTON',
    ),
    const WordBuilderQuestion(
      definition: 'A game played on a court.',
      syllables: ['VOL', 'LEY', 'BALL'],
      answer: 'VOLLEYBALL',
    ),
    const WordBuilderQuestion(
      definition: 'A winter team sport.',
      syllables: ['ICE', 'HOCK', 'EY'],
      answer: 'ICEHOCKEY',
    ),
    const WordBuilderQuestion(
      definition: 'A combat sport.',
      syllables: ['KAR', 'A', 'TE'],
      answer: 'KARATE',
    ),
    const WordBuilderQuestion(
      definition: 'An athletic contest.',
      syllables: ['OL', 'YM', 'PICS'],
      answer: 'OLYMPICS',
    ),
    const WordBuilderQuestion(
      definition: 'A long distance race.',
      syllables: ['MAR', 'A', 'THON'],
      answer: 'MARATHON',
    ),
    const WordBuilderQuestion(
      definition: 'Physical activity.',
      syllables: ['EX', 'ER', 'CISE'],
      answer: 'EXERCISE',
    ),
    const WordBuilderQuestion(
      definition: 'The art of swimming.',
      syllables: ['A', 'QUAT', 'ICS'],
      answer: 'AQUATICS',
    ),
    const WordBuilderQuestion(
      definition: 'Activity for pleasure.',
      syllables: ['REC', 'RE', 'A', 'TION'],
      answer: 'RECREATION',
    ),

    // Level 291-300
    const WordBuilderQuestion(
      definition: 'A trip or journey.',
      syllables: ['EX', 'CUR', 'SION'],
      answer: 'EXCURSION',
    ),
    const WordBuilderQuestion(
      definition: 'A journey for pleasure.',
      syllables: ['VAC', 'A', 'TION'],
      answer: 'VACATION',
    ),
    const WordBuilderQuestion(
      definition: 'A flight to a destination.',
      syllables: ['A', 'VI', 'A', 'TION'],
      answer: 'AVIATION',
    ),
    const WordBuilderQuestion(
      definition: 'Travel arrangements.',
      syllables: ['I', 'TIN', 'ER', 'AR', 'Y'],
      answer: 'ITINERARY',
    ),
    const WordBuilderQuestion(
      definition: 'A person visiting a place.',
      syllables: ['VIS', 'I', 'TOR'],
      answer: 'VISITOR',
    ),
    const WordBuilderQuestion(
      definition: 'The business of travel.',
      syllables: ['TOUR', 'IS', 'M'],
      answer: 'TOURISM',
    ),
    const WordBuilderQuestion(
      definition: 'Someone who travels deeply.',
      syllables: ['AD', 'VEN', 'TUR', 'ER'],
      answer: 'ADVENTURER',
    ),
    const WordBuilderQuestion(
      definition: 'An unusual experience.',
      syllables: ['AD', 'VEN', 'TURE'],
      answer: 'ADVENTURE',
    ),
    const WordBuilderQuestion(
      definition: 'The detailed study of geography.',
      syllables: ['GE', 'OG', 'RA', 'PHY'],
      answer: 'GEOGRAPHY',
    ),
    const WordBuilderQuestion(
      definition: 'The remote areas of a country.',
      syllables: ['COUN', 'TRY', 'SIDE'],
      answer: 'COUNTRYSIDE',
    ),

    // Level 301-310
    const WordBuilderQuestion(
      definition: 'A large seabird.',
      syllables: ['AL', 'BA', 'TROSS'],
      answer: 'ALBATROSS',
    ),
    const WordBuilderQuestion(
      definition: 'A large black water bird.',
      syllables: ['PEL', 'I', 'CAN'],
      answer: 'PELICAN',
    ),
    const WordBuilderQuestion(
      definition: 'A brightly colored bird.',
      syllables: ['KING', 'FISH', 'ER'],
      answer: 'KINGFISHER',
    ),
    const WordBuilderQuestion(
      definition: 'A bird known for its song.',
      syllables: ['NIGH', 'TIN', 'GALE'],
      answer: 'NIGHTINGALE',
    ),
    const WordBuilderQuestion(
      definition: 'A large flightless bird.',
      syllables: ['CAS', 'SO', 'WAR', 'Y'],
      answer: 'CASSOWARY',
    ),
    const WordBuilderQuestion(
      definition: 'A bird that imitates sounds.',
      syllables: ['MOCK', 'ING', 'BIRD'],
      answer: 'MOCKINGBIRD',
    ),
    const WordBuilderQuestion(
      definition: 'A tiny hovering bird.',
      syllables: ['HUM', 'MING', 'BIRD'],
      answer: 'HUMMINGBIRD',
    ),
    const WordBuilderQuestion(
      definition: 'The sport of hunting with birds.',
      syllables: ['FAL', 'CON', 'RY'],
      answer: 'FALCONRY',
    ),
    const WordBuilderQuestion(
      definition: 'A small parrot.',
      syllables: ['PAR', 'A', 'KEET'],
      answer: 'PARAKEET',
    ),
    const WordBuilderQuestion(
      definition: 'A dark diving bird.',
      syllables: ['COR', 'MO', 'RANT'],
      answer: 'CORMORANT',
    ),

    // Level 311-320
    const WordBuilderQuestion(
      definition: 'A deep red wine color.',
      syllables: ['BUR', 'GUN', 'DY'],
      answer: 'BURGUNDY',
    ),
    const WordBuilderQuestion(
      definition: 'A purple flower color.',
      syllables: ['VI', 'O', 'LET'],
      answer: 'VIOLET',
    ),
    const WordBuilderQuestion(
      definition: 'A dark blue dye.',
      syllables: ['IN', 'DI', 'GO'],
      answer: 'INDIGO',
    ),
    const WordBuilderQuestion(
      definition: 'A purple gemstone.',
      syllables: ['AM', 'E', 'THYST'],
      answer: 'AMETHYST',
    ),
    const WordBuilderQuestion(
      definition: 'A green copper mineral.',
      syllables: ['MAL', 'A', 'CHITE'],
      answer: 'MALACHITE',
    ),
    const WordBuilderQuestion(
      definition: 'A heavy precious metal.',
      syllables: ['PLAT', 'I', 'NUM'],
      answer: 'PLATINUM',
    ),
    const WordBuilderQuestion(
      definition: 'A strong light metal.',
      syllables: ['TI', 'TA', 'NI', 'UM'],
      answer: 'TITANIUM',
    ),
    const WordBuilderQuestion(
      definition: 'A light silvery metal.',
      syllables: ['A', 'LU', 'MI', 'NUM'],
      answer: 'ALUMINUM',
    ),
    const WordBuilderQuestion(
      definition: 'A liquid metal element.',
      syllables: ['MER', 'CU', 'RY'],
      answer: 'MERCURY',
    ),
    const WordBuilderQuestion(
      definition: 'A radioactive metal.',
      syllables: ['U', 'RA', 'NI', 'UM'],
      answer: 'URANIUM',
    ),

    // Level 321-330
    const WordBuilderQuestion(
      definition: 'A musical composition.',
      syllables: ['CON', 'CERT', 'O'],
      answer: 'CONCERTO',
    ),
    const WordBuilderQuestion(
      definition: 'A large group of musicians.',
      syllables: ['OR', 'CHES', 'TRA'],
      answer: 'ORCHESTRA',
    ),
    const WordBuilderQuestion(
      definition: 'A deep male voice.',
      syllables: ['BAR', 'I', 'TONE'],
      answer: 'BARITONE',
    ),
    const WordBuilderQuestion(
      definition: 'A high female voice.',
      syllables: ['SO', 'PRAN', 'O'],
      answer: 'SOPRANO',
    ),
    const WordBuilderQuestion(
      definition: 'A stringed instrument.',
      syllables: ['VI', 'O', 'LIN'],
      answer: 'VIOLIN',
    ),
    const WordBuilderQuestion(
      definition: 'A large double bass.',
      syllables: ['CON', 'TRA', 'BASS'],
      answer: 'CONTRABASS',
    ),
    const WordBuilderQuestion(
      definition: 'A woodwind instrument.',
      syllables: ['CLAR', 'I', 'NET'],
      answer: 'CLARINET',
    ),
    const WordBuilderQuestion(
      definition: 'A brass jazz instrument.',
      syllables: ['SAX', 'O', 'PHONE'],
      answer: 'SAXOPHONE',
    ),
    const WordBuilderQuestion(
      definition: 'A large keyboard instrument.',
      syllables: ['PI', 'AN', 'O'],
      answer: 'PIANO',
    ),
    const WordBuilderQuestion(
      definition: 'A portable keyboard.',
      syllables: ['AC', 'COR', 'DI', 'ON'],
      answer: 'ACCORDION',
    ),

    // Level 331-340
    const WordBuilderQuestion(
      definition: 'A person who performs.',
      syllables: ['PER', 'FORM', 'ER'],
      answer: 'PERFORMER',
    ),
    const WordBuilderQuestion(
      definition: 'A writer of novels.',
      syllables: ['NOV', 'EL', 'IST'],
      answer: 'NOVELIST',
    ),
    const WordBuilderQuestion(
      definition: 'A creator of designs.',
      syllables: ['DE', 'SIGN', 'ER'],
      answer: 'DESIGNER',
    ),
    const WordBuilderQuestion(
      definition: 'Someone who takes photos.',
      syllables: ['PHO', 'TOG', 'RA', 'PHER'],
      answer: 'PHOTOGRAPHER',
    ),
    const WordBuilderQuestion(
      definition: 'An artist who draws.',
      syllables: ['IL', 'LUS', 'TRA', 'TOR'],
      answer: 'ILLUSTRATOR',
    ),
    const WordBuilderQuestion(
      definition: 'A female ballet dancer.',
      syllables: ['BAL', 'LE', 'RI', 'NA'],
      answer: 'BALLERINA',
    ),
    const WordBuilderQuestion(
      definition: 'A scientist of biology.',
      syllables: ['BI', 'OL', 'O', 'GIST'],
      answer: 'BIOLOGIST',
    ),
    const WordBuilderQuestion(
      definition: 'A person doing science.',
      syllables: ['SCI', 'EN', 'TIST'],
      answer: 'SCIENTIST',
    ),
    const WordBuilderQuestion(
      definition: 'An expert in astronomy.',
      syllables: ['AS', 'TRON', 'O', 'MER'],
      answer: 'ASTRONOMER',
    ),
    const WordBuilderQuestion(
      definition: 'A pilot of aircraft.',
      syllables: ['A', 'VI', 'A', 'TOR'],
      answer: 'AVIATOR',
    ),

    // Level 341-350
    const WordBuilderQuestion(
      definition: 'Absolutely needed.',
      syllables: ['NEC', 'ES', 'SAR', 'Y'],
      answer: 'NECESSARY',
    ),
    const WordBuilderQuestion(
      definition: 'Ideally important.',
      syllables: ['SIG', 'NIF', 'I', 'CANT'],
      answer: 'SIGNIFICANT',
    ),
    const WordBuilderQuestion(
      definition: 'Hard to believe.',
      syllables: ['IN', 'CRED', 'I', 'BLE'],
      answer: 'INCREDIBLE',
    ),
    const WordBuilderQuestion(
      definition: 'Not to be believed.',
      syllables: ['UN', 'BE', 'LIEV', 'A', 'BLE'],
      answer: 'UNBELIEVABLE',
    ),
    const WordBuilderQuestion(
      definition: 'Splendid or grand.',
      syllables: ['MAG', 'NIF', 'I', 'CENT'],
      answer: 'MAGNIFICENT',
    ),
    const WordBuilderQuestion(
      definition: 'Extremely bad.',
      syllables: ['TER', 'RI', 'BLE'],
      answer: 'TERRIBLE',
    ),
    const WordBuilderQuestion(
      definition: 'Causing horror.',
      syllables: ['HOR', 'RI', 'BLE'],
      answer: 'HORRIBLE',
    ),
    const WordBuilderQuestion(
      definition: 'Extremely good quality.',
      syllables: ['EX', 'CEL', 'LENT'],
      answer: 'EXCELLENT',
    ),
    const WordBuilderQuestion(
      definition: 'Unusually excellent.',
      syllables: ['EX', 'CEP', 'TION', 'AL'],
      answer: 'EXCEPTIONAL',
    ),
    const WordBuilderQuestion(
      definition: 'Having usual qualities.',
      syllables: ['TYP', 'I', 'CAL'],
      answer: 'TYPICAL',
    ),

    // Level 351-360
    const WordBuilderQuestion(
      definition: 'Occurring often.',
      syllables: ['FRE', 'QUENT', 'LY'],
      answer: 'FREQUENTLY',
    ),
    const WordBuilderQuestion(
      definition: 'Occurring now and then.',
      syllables: ['OC', 'CA', 'SION', 'AL'],
      answer: 'OCCASIONAL',
    ),
    const WordBuilderQuestion(
      definition: 'At once.',
      syllables: ['IN', 'STANT', 'LY'],
      answer: 'INSTANTLY',
    ),
    const WordBuilderQuestion(
      definition: 'Without any delay.',
      syllables: ['IM', 'ME', 'DI', 'ATE'],
      answer: 'IMMEDIATE',
    ),
    const WordBuilderQuestion(
      definition: 'Step by step.',
      syllables: ['GRAD', 'U', 'AL', 'LY'],
      answer: 'GRADUALLY',
    ),
    const WordBuilderQuestion(
      definition: 'Unexpectedly.',
      syllables: ['SUD', 'DEN', 'LY'],
      answer: 'SUDDENLY',
    ),
    const WordBuilderQuestion(
      definition: 'With care.',
      syllables: ['CARE', 'FUL', 'LY'],
      answer: 'CAREFULLY',
    ),
    const WordBuilderQuestion(
      definition: 'Involving risk.',
      syllables: ['DAN', 'GER', 'OUS'],
      answer: 'DANGEROUS',
    ),
    const WordBuilderQuestion(
      definition: 'Achieving the goal.',
      syllables: ['SUC', 'CESS', 'FUL'],
      answer: 'SUCCESSFUL',
    ),
    const WordBuilderQuestion(
      definition: 'Pleasing the senses.',
      syllables: ['BEAU', 'TI', 'FUL'],
      answer: 'BEAUTIFUL',
    ),

    // Level 361-370
    const WordBuilderQuestion(
      definition: 'Courageous behavior.',
      syllables: ['BRAV', 'ER', 'Y'],
      answer: 'BRAVERY',
    ),
    const WordBuilderQuestion(
      definition: 'Truthfulness.',
      syllables: ['HON', 'ES', 'TY'],
      answer: 'HONESTY',
    ),
    const WordBuilderQuestion(
      definition: 'Faithfulness.',
      syllables: ['LOY', 'AL', 'TY'],
      answer: 'LOYALTY',
    ),
    const WordBuilderQuestion(
      definition: 'State of being extremely poor.',
      syllables: ['POV', 'ER', 'TY'],
      answer: 'POVERTY',
    ),
    const WordBuilderQuestion(
      definition: 'Possessions owned.',
      syllables: ['PROP', 'ER', 'TY'],
      answer: 'PROPERTY',
    ),
    const WordBuilderQuestion(
      definition: 'State of being free from danger.',
      syllables: ['SE', 'CU', 'RI', 'TY'],
      answer: 'SECURITY',
    ),
    const WordBuilderQuestion(
      definition: 'State of being equal.',
      syllables: ['E', 'QUAL', 'I', 'TY'],
      answer: 'EQUALITY',
    ),
    const WordBuilderQuestion(
      definition: 'Variety.',
      syllables: ['DI', 'VER', 'SI', 'TY'],
      answer: 'DIVERSITY',
    ),
    const WordBuilderQuestion(
      definition: 'Community of people.',
      syllables: ['SO', 'CI', 'E', 'TY'],
      answer: 'SOCIETY',
    ),
    const WordBuilderQuestion(
      definition: 'The state of things as they are.',
      syllables: ['RE', 'AL', 'I', 'TY'],
      answer: 'REALITY',
    ),

    // Level 371-380
    const WordBuilderQuestion(
      definition: 'Not sure.',
      syllables: ['UN', 'CER', 'TAIN'],
      answer: 'UNCERTAIN',
    ),
    const WordBuilderQuestion(
      definition: 'Sad or not satisfied.',
      syllables: ['UN', 'HAP', 'PY'],
      answer: 'UNHAPPY',
    ),
    const WordBuilderQuestion(
      definition: 'Unlucky.',
      syllables: ['UN', 'FOR', 'TU', 'NATE'],
      answer: 'UNFORTUNATE',
    ),
    const WordBuilderQuestion(
      definition: 'Causing physical pain.',
      syllables: ['UN', 'COM', 'FORT', 'A', 'BLE'],
      answer: 'UNCOMFORTABLE',
    ),
    const WordBuilderQuestion(
      definition: 'Boring.',
      syllables: ['UN', 'IN', 'TER', 'EST', 'ING'],
      answer: 'UNINTERESTING',
    ),
    const WordBuilderQuestion(
      definition: 'Of little value.',
      syllables: ['UN', 'IM', 'POR', 'TANT'],
      answer: 'UNIMPORTANT',
    ),
    const WordBuilderQuestion(
      definition: 'Not needed.',
      syllables: ['UN', 'NEC', 'ES', 'SAR', 'Y'],
      answer: 'UNNECESSARY',
    ),
    const WordBuilderQuestion(
      definition: 'Rare or strange.',
      syllables: ['UN', 'U', 'SU', 'AL'],
      answer: 'UNUSUAL',
    ),
    const WordBuilderQuestion(
      definition: 'Surprising.',
      syllables: ['UN', 'EX', 'PECT', 'ED'],
      answer: 'UNEXPECTED',
    ),
    const WordBuilderQuestion(
      definition: 'Cannot be seen.',
      syllables: ['IN', 'VIS', 'I', 'BLE'],
      answer: 'INVISIBLE',
    ),

    // Level 381-390
    const WordBuilderQuestion(
      definition: 'Appliance for keeping food cold.',
      syllables: ['RE', 'FRIG', 'ER', 'A', 'TOR'],
      answer: 'REFRIGERATOR',
    ),
    const WordBuilderQuestion(
      definition: 'Machine for washing dishes.',
      syllables: ['DISH', 'WASH', 'ER'],
      answer: 'DISHWASHER',
    ),
    const WordBuilderQuestion(
      definition: 'Cleaner using suction.',
      syllables: ['VAC', 'U', 'UM'],
      answer: 'VACUUM',
    ),
    const WordBuilderQuestion(
      definition: 'Heater usually filled with water.',
      syllables: ['RA', 'DI', 'A', 'TOR'],
      answer: 'RADIATOR',
    ),
    const WordBuilderQuestion(
      definition: 'Machine converting energy.',
      syllables: ['GEN', 'ER', 'A', 'TOR'],
      answer: 'GENERATOR',
    ),
    const WordBuilderQuestion(
      definition: 'Device for fresh air.',
      syllables: ['VEN', 'TI', 'LA', 'TOR'],
      answer: 'VENTILATOR',
    ),
    const WordBuilderQuestion(
      definition: 'Lift for people.',
      syllables: ['EL', 'E', 'VA', 'TOR'],
      answer: 'ELEVATOR',
    ),
    const WordBuilderQuestion(
      definition: 'Moving staircase.',
      syllables: ['ES', 'CA', 'LA', 'TOR'],
      answer: 'ESCALATOR',
    ),
    const WordBuilderQuestion(
      definition: 'Temperature regulator.',
      syllables: ['THER', 'MOS', 'TAT'],
      answer: 'THERMOSTAT',
    ),
    const WordBuilderQuestion(
      definition: 'Machine projecting images.',
      syllables: ['PRO', 'JEC', 'TOR'],
      answer: 'PROJECTOR',
    ),

    // Level 391-400
    const WordBuilderQuestion(
      definition: 'A flower with a trumpet shape.',
      syllables: ['DAF', 'FO', 'DIL'],
      answer: 'DAFFODIL',
    ),
    const WordBuilderQuestion(
      definition: 'A yellow wildflower.',
      syllables: ['DAN', 'DE', 'LI', 'ON'],
      answer: 'DANDELION',
    ),
    const WordBuilderQuestion(
      definition: 'A woody plant with colorful flowers.',
      syllables: ['RHO', 'DO', 'DEN', 'DRON'],
      answer: 'RHODODENDRON',
    ),
    const WordBuilderQuestion(
      definition: 'A popular autumn flower.',
      syllables: ['CHRYS', 'AN', 'THE', 'MUM'],
      answer: 'CHRYSANTHEMUM',
    ),
    const WordBuilderQuestion(
      definition: 'A tropical American climber.',
      syllables: ['PHILO', 'DEN', 'DRON'],
      answer: 'PHILODENDRON',
    ),
    const WordBuilderQuestion(
      definition: 'A large mallow flower.',
      syllables: ['HI', 'BIS', 'CUS'],
      answer: 'HIBISCUS',
    ),
    const WordBuilderQuestion(
      definition: 'A plant with purple aromatic flowers.',
      syllables: ['LAV', 'EN', 'DER'],
      answer: 'LAVENDER',
    ),
    const WordBuilderQuestion(
      definition: 'An Australian gum tree.',
      syllables: ['EU', 'CA', 'LYP', 'TUS'],
      answer: 'EUCALYPTUS',
    ),
    const WordBuilderQuestion(
      definition: 'A very fragrant white flower.',
      syllables: ['GAR', 'DE', 'NIA'],
      answer: 'GARDENIA',
    ),
    const WordBuilderQuestion(
      definition: 'A climbing vine with purple flowers.',
      syllables: ['WIST', 'E', 'RIA'],
      answer: 'WISTERIA',
    ),

    // Level 401-410
    const WordBuilderQuestion(
      definition: 'The time before sunrise.',
      syllables: ['AU', 'RO', 'RA'],
      answer: 'AURORA',
    ),
    const WordBuilderQuestion(
      definition: 'The time after noon.',
      syllables: ['AF', 'TER', 'NOON'],
      answer: 'AFTERNOON',
    ),
    const WordBuilderQuestion(
      definition: 'The highest point.',
      syllables: ['ME', 'RID', 'I', 'AN'],
      answer: 'MERIDIAN',
    ),
    const WordBuilderQuestion(
      definition: 'A period of 100 years.',
      syllables: ['CEN', 'TU', 'RY'],
      answer: 'CENTURY',
    ),
    const WordBuilderQuestion(
      definition: 'A period of 1000 years.',
      syllables: ['MIL', 'LEN', 'NI', 'UM'],
      answer: 'MILLENNIUM',
    ),
    const WordBuilderQuestion(
      definition: 'A date remembered.',
      syllables: ['AN', 'NI', 'VER', 'SAR', 'Y'],
      answer: 'ANNIVERSARY',
    ),
    const WordBuilderQuestion(
      definition: 'Yearly.',
      syllables: ['AN', 'NU', 'AL'],
      answer: 'ANNUAL',
    ),
    const WordBuilderQuestion(
      definition: 'Forming an era.',
      syllables: ['EP', 'OCH', 'AL'],
      answer: 'EPOCHAL',
    ),
    const WordBuilderQuestion(
      definition: 'Relating to time.',
      syllables: ['TEM', 'PO', 'RAL'],
      answer: 'TEMPORAL',
    ),
    const WordBuilderQuestion(
      definition: 'Existing forever.',
      syllables: ['E', 'TER', 'NAL'],
      answer: 'ETERNAL',
    ),

    // Level 411-420
    const WordBuilderQuestion(
      definition: 'Relating to the ocean.',
      syllables: ['O', 'CEAN', 'IC'],
      answer: 'OCEANIC',
    ),
    const WordBuilderQuestion(
      definition: 'Relating to shipping.',
      syllables: ['MAR', 'I', 'TIME'],
      answer: 'MARITIME',
    ),
    const WordBuilderQuestion(
      definition: 'Growing in water.',
      syllables: ['A', 'QUAT', 'IC'],
      answer: 'AQUATIC',
    ),
    const WordBuilderQuestion(
      definition: 'Undersea boat.',
      syllables: ['SUB', 'MA', 'RINE'],
      answer: 'SUBMARINE',
    ),
    const WordBuilderQuestion(
      definition: 'A boat with two hulls.',
      syllables: ['CAT', 'A', 'MA', 'RAN'],
      answer: 'CATAMARAN',
    ),
    const WordBuilderQuestion(
      definition: 'A person who journeys.',
      syllables: ['VOY', 'AG', 'ER'],
      answer: 'VOYAGER',
    ),
    const WordBuilderQuestion(
      definition: 'Person steering a ship.',
      syllables: ['NAV', 'I', 'GA', 'TOR'],
      answer: 'NAVIGATOR',
    ),
    const WordBuilderQuestion(
      definition: 'Science of steering.',
      syllables: ['NAV', 'I', 'GA', 'TION'],
      answer: 'NAVIGATION',
    ),
    const WordBuilderQuestion(
      definition: 'A journey for purpose.',
      syllables: ['EX', 'PE', 'DI', 'TION'],
      answer: 'EXPEDITION',
    ),
    const WordBuilderQuestion(
      definition: 'An epic journey.',
      syllables: ['OD', 'YS', 'SEY'],
      answer: 'ODYSSEY',
    ),

    // Level 421-430
    const WordBuilderQuestion(
      definition: 'Aircraft with rotors.',
      syllables: ['HEL', 'I', 'COP', 'TER'],
      answer: 'HELICOPTER',
    ),
    const WordBuilderQuestion(
      definition: 'Study of places.',
      syllables: ['GE', 'OG', 'RA', 'PHY'],
      answer: 'GEOGRAPHY',
    ),
    const WordBuilderQuestion(
      definition: 'Book of definitions.',
      syllables: ['DIC', 'TION', 'AR', 'Y'],
      answer: 'DICTIONARY',
    ),
    const WordBuilderQuestion(
      definition: 'Comprehensive reference.',
      syllables: ['EN', 'CY', 'CLO', 'PE', 'DI', 'A'],
      answer: 'ENCYCLOPEDIA',
    ),
    const WordBuilderQuestion(
      definition: 'Annual calendar.',
      syllables: ['AL', 'MA', 'NAC'],
      answer: 'ALMANAC',
    ),
    const WordBuilderQuestion(
      definition: 'Ordered list.',
      syllables: ['CAT', 'A', 'LOG'],
      answer: 'CATALOG',
    ),
    const WordBuilderQuestion(
      definition: 'Periodical publication.',
      syllables: ['MAG', 'A', 'ZINE'],
      answer: 'MAGAZINE',
    ),
    const WordBuilderQuestion(
      definition: 'Daily news.',
      syllables: ['NEWS', 'PA', 'PER'],
      answer: 'NEWSPAPER',
    ),
    const WordBuilderQuestion(
      definition: 'Author\'s text.',
      syllables: ['MAN', 'U', 'SCRIPT'],
      answer: 'MANUSCRIPT',
    ),
    const WordBuilderQuestion(
      definition: 'One who revises text.',
      syllables: ['ED', 'I', 'TOR'],
      answer: 'EDITOR',
    ),

    // Level 431-440
    const WordBuilderQuestion(
      definition: 'Related to electricity.',
      syllables: ['E', 'LEC', 'TRI', 'CAL'],
      answer: 'ELECTRICAL',
    ),
    const WordBuilderQuestion(
      definition: 'Related to mechanics.',
      syllables: ['ME', 'CHAN', 'I', 'CAL'],
      answer: 'MECHANICAL',
    ),
    const WordBuilderQuestion(
      definition: 'Related to manufacturing.',
      syllables: ['IN', 'DUS', 'TRI', 'AL'],
      answer: 'INDUSTRIAL',
    ),
    const WordBuilderQuestion(
      definition: 'Related to technique.',
      syllables: ['TECH', 'NI', 'CAL'],
      answer: 'TECHNICAL',
    ),
    const WordBuilderQuestion(
      definition: 'Related to the galaxy.',
      syllables: ['GA', 'LAC', 'TIC'],
      answer: 'GALACTIC',
    ),
    const WordBuilderQuestion(
      definition: 'Applicable everywhere.',
      syllables: ['U', 'NI', 'VER', 'SAL'],
      answer: 'UNIVERSAL',
    ),
    const WordBuilderQuestion(
      definition: 'Worldwide.',
      syllables: ['GLOB', 'AL', 'LY'],
      answer: 'GLOBALLY',
    ),
    const WordBuilderQuestion(
      definition: 'Relating to a nation.',
      syllables: ['NA', 'TION', 'AL'],
      answer: 'NATIONAL',
    ),
    const WordBuilderQuestion(
      definition: 'Between countries.',
      syllables: ['IN', 'TER', 'NA', 'TION', 'AL'],
      answer: 'INTERNATIONAL',
    ),
    const WordBuilderQuestion(
      definition: 'Of a continent.',
      syllables: ['CON', 'TI', 'NEN', 'TAL'],
      answer: 'CONTINENTAL',
    ),

    // Level 441-450
    const WordBuilderQuestion(
      definition: 'Record of the past.',
      syllables: ['HIS', 'TO', 'RY'],
      answer: 'HISTORY',
    ),
    const WordBuilderQuestion(
      definition: 'Expert of history.',
      syllables: ['HIS', 'TO', 'RI', 'AN'],
      answer: 'HISTORIAN',
    ),
    const WordBuilderQuestion(
      definition: 'Legal subject of state.',
      syllables: ['CIT', 'I', 'ZEN'],
      answer: 'CITIZEN',
    ),
    const WordBuilderQuestion(
      definition: 'Head of state.',
      syllables: ['PRES', 'I', 'DENT'],
      answer: 'PRESIDENT',
    ),
    const WordBuilderQuestion(
      definition: 'One who lives there.',
      syllables: ['RES', 'I', 'DENT'],
      answer: 'RESIDENT',
    ),
    const WordBuilderQuestion(
      definition: 'State ruler.',
      syllables: ['GOV', 'ER', 'NOR'],
      answer: 'GOVERNOR',
    ),
    const WordBuilderQuestion(
      definition: 'Member of senate.',
      syllables: ['SEN', 'A', 'TOR'],
      answer: 'SENATOR',
    ),
    const WordBuilderQuestion(
      definition: 'Highest diplomat.',
      syllables: ['AM', 'BAS', 'SA', 'DOR'],
      answer: 'AMBASSADOR',
    ),
    const WordBuilderQuestion(
      definition: 'Expert in a field.',
      syllables: ['SPE', 'CIAL', 'IST'],
      answer: 'SPECIALIST',
    ),
    const WordBuilderQuestion(
      definition: 'Person holding office.',
      syllables: ['OF', 'FI', 'CIAL'],
      answer: 'OFFICIAL',
    ),

    // Level 451-460
    const WordBuilderQuestion(
      definition: 'Resolution of dispute.',
      syllables: ['SET', 'TLE', 'MENT'],
      answer: 'SETTLEMENT',
    ),
    const WordBuilderQuestion(
      definition: 'Dedication.',
      syllables: ['COM', 'MIT', 'MENT'],
      answer: 'COMMITMENT',
    ),
    const WordBuilderQuestion(
      definition: 'Relating to a budget.',
      syllables: ['BUD', 'GET', 'AR', 'Y'],
      answer: 'BUDGETARY',
    ),
    const WordBuilderQuestion(
      definition: 'Regular pay.',
      syllables: ['SAL', 'A', 'RY'],
      answer: 'SALARY',
    ),
    const WordBuilderQuestion(
      definition: 'Permitted amount.',
      syllables: ['AL', 'LOW', 'ANCE'],
      answer: 'ALLOWANCE',
    ),
    const WordBuilderQuestion(
      definition: 'Economic well-being.',
      syllables: ['PROS', 'PER', 'I', 'TY'],
      answer: 'PROSPERITY',
    ),
    const WordBuilderQuestion(
      definition: 'Financial ruin.',
      syllables: ['BANK', 'RUPT', 'CY'],
      answer: 'BANKRUPTCY',
    ),
    const WordBuilderQuestion(
      definition: 'System of money.',
      syllables: ['CUR', 'REN', 'CY'],
      answer: 'CURRENCY',
    ),
    const WordBuilderQuestion(
      definition: 'Asset for profit.',
      syllables: ['IN', 'VEST', 'MENT'],
      answer: 'INVESTMENT',
    ),
    const WordBuilderQuestion(
      definition: 'Intended for commerce.',
      syllables: ['COM', 'MER', 'CIAL'],
      answer: 'COMMERCIAL',
    ),

    // Level 461-470
    const WordBuilderQuestion(
      definition: 'Reasonable.',
      syllables: ['LOG', 'I', 'CAL'],
      answer: 'LOGICAL',
    ),
    const WordBuilderQuestion(
      definition: 'Useful and effective.',
      syllables: ['PRAC', 'TI', 'CAL'],
      answer: 'PRACTICAL',
    ),
    const WordBuilderQuestion(
      definition: 'Based on theory.',
      syllables: ['THE', 'O', 'RET', 'I', 'CAL'],
      answer: 'THEORETICAL',
    ),
    const WordBuilderQuestion(
      definition: 'Relating to medicine.',
      syllables: ['MED', 'I', 'CAL'],
      answer: 'MEDICAL',
    ),
    const WordBuilderQuestion(
      definition: 'Relating to surgery.',
      syllables: ['SUR', 'GI', 'CAL'],
      answer: 'SURGICAL',
    ),
    const WordBuilderQuestion(
      definition: 'Relating to the body.',
      syllables: ['PHYS', 'I', 'CAL'],
      answer: 'PHYSICAL',
    ),
    const WordBuilderQuestion(
      definition: 'Relating to chemicals.',
      syllables: ['CHEM', 'I', 'CAL'],
      answer: 'CHEMICAL',
    ),
    const WordBuilderQuestion(
      definition: 'Scientific procedure.',
      syllables: ['EX', 'PER', 'I', 'MENT'],
      answer: 'EXPERIMENT',
    ),
    const WordBuilderQuestion(
      definition: 'Musical device.',
      syllables: ['IN', 'STRU', 'MENT'],
      answer: 'INSTRUMENT',
    ),
    const WordBuilderQuestion(
      definition: 'Official document.',
      syllables: ['CER', 'TIF', 'I', 'CATE'],
      answer: 'CERTIFICATE',
    ),

    // Level 471-480
    const WordBuilderQuestion(
      definition: 'Promote a product.',
      syllables: ['AD', 'VER', 'TISE'],
      answer: 'ADVERTISE',
    ),
    const WordBuilderQuestion(
      definition: 'Establish identity.',
      syllables: ['I', 'DEN', 'TI', 'FY'],
      answer: 'IDENTIFY',
    ),
    const WordBuilderQuestion(
      definition: 'Proof of truth.',
      syllables: ['CON', 'FIR', 'MA', 'TION'],
      answer: 'CONFIRMATION',
    ),
    const WordBuilderQuestion(
      definition: 'Make less confusing.',
      syllables: ['CLAR', 'I', 'FY'],
      answer: 'CLARIFY',
    ),
    const WordBuilderQuestion(
      definition: 'Make easier.',
      syllables: ['SIM', 'PLI', 'FY'],
      answer: 'SIMPLIFY',
    ),
    const WordBuilderQuestion(
      definition: 'To enlarge.',
      syllables: ['MAG', 'NI', 'FY'],
      answer: 'MAGNIFY',
    ),
    const WordBuilderQuestion(
      definition: 'Promise or assurance.',
      syllables: ['GUAR', 'AN', 'TEE'],
      answer: 'GUARANTEE',
    ),
    const WordBuilderQuestion(
      definition: 'Suggest as good.',
      syllables: ['REC', 'OM', 'MEND'],
      answer: 'RECOMMEND',
    ),
    const WordBuilderQuestion(
      definition: 'Grasp mentally.',
      syllables: ['COM', 'PRE', 'HEND'],
      answer: 'COMPREHEND',
    ),
    const WordBuilderQuestion(
      definition: 'Object for holding.',
      syllables: ['CON', 'TAIN', 'ER'],
      answer: 'CONTAINER',
    ),

    // Level 481-490
    const WordBuilderQuestion(
      definition: 'Person in charge.',
      syllables: ['MAN', 'A', 'GER'],
      answer: 'MANAGER',
    ),
    const WordBuilderQuestion(
      definition: 'Person who supervises.',
      syllables: ['DI', 'REC', 'TOR'],
      answer: 'DIRECTOR',
    ),
    const WordBuilderQuestion(
      definition: 'Person making goods.',
      syllables: ['PRO', 'DUC', 'ER'],
      answer: 'PRODUCER',
    ),
    const WordBuilderQuestion(
      definition: 'Person who buys user.',
      syllables: ['CON', 'SUM', 'ER'],
      answer: 'CONSUMER',
    ),
    const WordBuilderQuestion(
      definition: 'Helper.',
      syllables: ['AS', 'SIS', 'TANT'],
      answer: 'ASSISTANT',
    ),
    const WordBuilderQuestion(
      definition: 'Service provider.',
      syllables: ['AT', 'TEN', 'DANT'],
      answer: 'ATTENDANT',
    ),
    const WordBuilderQuestion(
      definition: 'Onlooker.',
      syllables: ['SPEC', 'TA', 'TOR'],
      answer: 'SPECTATOR',
    ),
    const WordBuilderQuestion(
      definition: 'Financial professional.',
      syllables: ['AC', 'COUN', 'TANT'],
      answer: 'ACCOUNTANT',
    ),
    const WordBuilderQuestion(
      definition: 'Professional advisor.',
      syllables: ['CON', 'SUL', 'TANT'],
      answer: 'CONSULTANT',
    ),
    const WordBuilderQuestion(
      definition: 'Resident.',
      syllables: ['IN', 'HAB', 'I', 'TANT'],
      answer: 'INHABITANT',
    ),

    // Level 491-500
    const WordBuilderQuestion(
      definition: 'Highly pleasing.',
      syllables: ['DE', 'LIGHT', 'FUL'],
      answer: 'DELIGHTFUL',
    ),
    const WordBuilderQuestion(
      definition: 'Having many colors.',
      syllables: ['COL', 'OR', 'FUL'],
      answer: 'COLORFUL',
    ),
    const WordBuilderQuestion(
      definition: 'Quality of being useful.',
      syllables: ['HELP', 'FUL', 'NESS'],
      answer: 'HELPFULNESS',
    ),
    const WordBuilderQuestion(
      definition: 'Having great power.',
      syllables: ['POW', 'ER', 'FUL'],
      answer: 'POWERFUL',
    ),
    const WordBuilderQuestion(
      definition: 'Extremely good.',
      syllables: ['WON', 'DER', 'FUL'],
      answer: 'WONDERFUL',
    ),
    const WordBuilderQuestion(
      definition: 'Without conflict.',
      syllables: ['PEACE', 'FUL', 'LY'],
      answer: 'PEACEFULLY',
    ),
    const WordBuilderQuestion(
      definition: 'In a hopeful manner.',
      syllables: ['HOPE', 'FUL', 'LY'],
      answer: 'HOPEFULLY',
    ),
    const WordBuilderQuestion(
      definition: 'In a thankful way.',
      syllables: ['THANK', 'FUL', 'LY'],
      answer: 'THANKFULLY',
    ),
    const WordBuilderQuestion(
      definition: 'Ideally the truth.',
      syllables: ['TRUTH', 'FUL', 'LY'],
      answer: 'TRUTHFULLY',
    ),
    const WordBuilderQuestion(
      definition: 'Being the last.',
      syllables: ['UL', 'TI', 'MATE'],
      answer: 'ULTIMATE',
    ),
  ];
}
