const wordData = [
    { 
        id: 1, 
        word: "abandon", 
        definition: "To leave a place, thing, or person, usually for ever.", 
        synonyms: "leave, give up", 
        example: "He decided to abandon the sinking ship." 
    },
    { 
        id: 2, 
        word: "abbreviate", 
        definition: "To make a word or phrase shorter.", 
        synonyms: "shorten", 
        example: "USA is an abbreviation for United States of America." 
    },
    { 
        id: 3, 
        word: "abolish", 
        definition: "To end an activity or custom officially.", 
        synonyms: "do away with", 
        example: "Slavery was abolished in the 19th century." 
    },
    { 
        id: 4, 
        word: "absorb", 
        definition: "To take something in, especially gradually.", 
        synonyms: "suck up", 
        example: "Plants absorb sunlight." 
    },
    { 
        id: 5, 
        word: "abstain from", 
        definition: "To not do something, especially something enjoyable that you think might be bad.", 
        synonyms: "avoid", 
        example: "He abstained from alcohol for health reasons." 
    },
    { 
        id: 6, 
        word: "abundance", 
        definition: "The situation in which there is more than enough of something.", 
        synonyms: "plenty", 
        example: "There was an abundance of food at the wedding." 
    },
    { 
        id: 7, 
        word: "abundant", 
        definition: "Existing in large quantities.", 
        synonyms: "plentiful", 
        example: "Fish are abundant in this lake." 
    },
    { 
        id: 8, 
        word: "accelerate", 
        definition: "To happen or make something happen sooner or faster.", 
        synonyms: "speed up", 
        example: "The car accelerated to pass the truck." 
    },
    { 
        id: 9, 
        word: "accept", 
        definition: "To agree to take something.", 
        synonyms: "agree, receive", 
        example: "Please accept my apology." 
    },
    { 
        id: 10, 
        word: "access", 
        definition: "The method or possibility of getting near to a place or person.", 
        synonyms: "enter, approach", 
        example: "You need a password to access the file." 
    },
    { 
        id: 11, 
        word: "accessible to", 
        definition: "Able to be reached or easily got.", 
        synonyms: "reachable, available", 
        example: "The building is accessible to disabled people." 
    },
    { 
        id: 12, 
        word: "accommodate", 
        definition: "To provide with a place to live or to be stored in.", 
        synonyms: "put up, house", 
        example: "The hotel can accommodate 500 guests." 
    },
    { 
        id: 13, 
        word: "accompany", 
        definition: "To go with someone or to be provided or exist at the same time as something.", 
        synonyms: "escort, go with", 
        example: "She accompanied him on the piano." 
    },
    { 
        id: 14, 
        word: "accomplish", 
        definition: "To finish something successfully or to achieve something.", 
        synonyms: "achieve, succeed", 
        example: "Mission accomplished." 
    },
    { 
        id: 15, 
        word: "accumulate", 
        definition: "To collect a large number of things over a long period of time.", 
        synonyms: "gather, collect", 
        example: "Dust accumulated on the furniture." 
    },
    { 
        id: 16, 
        word: "accuracy", 
        definition: "The fact of being exact or correct.", 
        synonyms: "precision, correctness", 
        example: "Check the accuracy of the data." 
    },
    { 
        id: 17, 
        word: "accurate", 
        definition: "Correct, exact, and without any mistakes.", 
        synonyms: "precise, correct", 
        example: "Accurate information is vital." 
    },
    { 
        id: 18, 
        word: "accurately", 
        definition: "In a way that is correct, exact, and without any mistakes.", 
        synonyms: "precisely, correctly", 
        example: "The map accurately shows the area." 
    },
    { 
        id: 19, 
        word: "accuse (of)", 
        definition: "To say that someone has done something morally wrong, illegal, or unkind.", 
        synonyms: "blame, charge", 
        example: "He was accused of theft." 
    },
    { 
        id: 20, 
        word: "achieve", 
        definition: "To succeed in finishing something or reaching an aim, especially after a lot of work or effort.", 
        synonyms: "accomplish, succeed", 
        example: "She achieved her goal." 
    },
    { 
        id: 21, 
        word: "acknowledge", 
        definition: "To accept, admit, or recognize something, or the truth or existence of something.", 
        synonyms: "admit, recognize", 
        example: "He acknowledged his mistake." 
    },
    { 
        id: 22, 
        word: "acquainted with", 
        definition: "Knowing or being familiar with a person or thing.", 
        synonyms: "familiar with", 
        example: "Are you acquainted with the rules?" 
    },
    { 
        id: 23, 
        word: "acquire", 
        definition: "To get or buy something.", 
        synonyms: "obtain, gain", 
        example: "Acquire new skills." 
    },
    { 
        id: 24, 
        word: "acquisition", 
        definition: "The process of getting something.", 
        synonyms: "gaining", 
        example: "Language acquisition takes time." 
    },
    { 
        id: 25, 
        word: "activity", 
        definition: "The situation in which a lot of things are happening or people are moving around.", 
        synonyms: "action", 
        example: "Outdoor activities are fun." 
    },
    { 
        id: 26, 
        word: "adapt", 
        definition: "To change, or to change something, to suit different conditions or uses.", 
        synonyms: "adjust", 
        example: "Adapt to the new environment." 
    },
    { 
        id: 27, 
        word: "addict", 
        definition: "A person who cannot stop doing or using something, especially something harmful.", 
        synonyms: "junkie", 
        example: "He is a coffee addict." 
    },
    { 
        id: 28, 
        word: "addiction", 
        definition: "An inability to stop doing or using something, especially something harmful.", 
        synonyms: "dependence", 
        example: "Addiction to social media is common." 
    },
    { 
        id: 29, 
        word: "addition", 
        definition: "Something that has been added to something else.", 
        synonyms: "extra", 
        example: "In addition to this..." 
    },
    { 
        id: 30, 
        word: "additionally", 
        definition: "Also or in addition.", 
        synonyms: "furthermore, moreover", 
        example: "Additionally, the service is free." 
    },
    { 
        id: 31, 
        word: "adequately", 
        definition: "In a way that is enough or satisfactory for a particular purpose.", 
        synonyms: "sufficiently", 
        example: "The staff were adequately trained." 
    },
    { 
        id: 32, 
        word: "adjust", 
        definition: "To change something slightly, especially to make it more correct, effective, or suitable.", 
        synonyms: "adapt, regulate", 
        example: "Adjust the volume." 
    },
    { 
        id: 33, 
        word: "adjustment", 
        definition: "A small change.", 
        synonyms: "correction", 
        example: "Make minor adjustments." 
    },
    { 
        id: 34, 
        word: "administer", 
        definition: "To control the operation or arrangement of something.", 
        synonyms: "manage", 
        example: "Administer the exam." 
    },
    { 
        id: 35, 
        word: "admire", 
        definition: "To find someone or something attractive and pleasant to look at.", 
        synonyms: "respect", 
        example: "I admire your courage." 
    },
    { 
        id: 36, 
        word: "admit", 
        definition: "To agree that something is true, especially unwillingly.", 
        synonyms: "confess, accept", 
        example: "He admitted the truth." 
    },
    { 
        id: 37, 
        word: "adopt", 
        definition: "To legally take another person's child into your own family and take care of him or her as your own child.", 
        synonyms: "embrace, take up", 
        example: "They decided to adopt a child." 
    },
    { 
        id: 38, 
        word: "adore", 
        definition: "To love someone very much, especially in a way that shows a lot of admiration or respect.", 
        synonyms: "love, cherish", 
        example: "She adores her cat." 
    },
    { 
        id: 39, 
        word: "adverse", 
        definition: "Having a negative or harmful effect on something.", 
        synonyms: "unfavorable, bad", 
        example: "Adverse weather conditions." 
    },
    { 
        id: 40, 
        word: "advocate", 
        definition: "To publicly support or suggest an idea, development, or way of doing something.", 
        synonyms: "defend, support", 
        example: "He advocates for human rights." 
    },
    { 
        id: 41, 
        word: "affect", 
        definition: "To have an influence on someone or something, or to cause a change in someone or something.", 
        synonyms: "influence, impact", 
        example: "Smoking affects health." 
    },
    { 
        id: 42, 
        word: "aggravate", 
        definition: "To make a bad situation worse.", 
        synonyms: "deteriorate, worsen", 
        example: "Stress aggravates the pain." 
    },
    { 
        id: 43, 
        word: "aggressive", 
        definition: "Behaving in an angry and violent way towards another person.", 
        synonyms: "hostile", 
        example: "Aggressive behavior." 
    },
    { 
        id: 44, 
        word: "aid", 
        definition: "Help or support.", 
        synonyms: "help, assist", 
        example: "First aid kit." 
    },
    { 
        id: 45, 
        word: "alien (to)", 
        definition: "Coming from a different country, race, or group.", 
        synonyms: "foreign", 
        example: "This concept is alien to me." 
    },
    { 
        id: 46, 
        word: "alongside", 
        definition: "Next to, or together with.", 
        synonyms: "beside, next to", 
        example: "Park alongside the curb." 
    },
    { 
        id: 47, 
        word: "alter", 
        definition: "To change something, usually slightly, or to cause the characteristics of something to change.", 
        synonyms: "change, modify", 
        example: "We had to alter our plans." 
    },
    { 
        id: 48, 
        word: "alteration", 
        definition: "A change, usually a slight change, in the appearance, character, or structure of something.", 
        synonyms: "change", 
        example: "The dress needs alteration." 
    },
    { 
        id: 49, 
        word: "amazing", 
        definition: "Extremely surprising.", 
        synonyms: "astonishing", 
        example: "It was an amazing experience." 
    },
    { 
        id: 50, 
        word: "amend", 
        definition: "To change the words of a text, especially a law or a legal document.", 
        synonyms: "revise, modify", 
        example: "Amend the constitution." 
    },
    { 
        id: 51, 
        word: "amendment", 
        definition: "A minor change or addition designed to improve a text, piece of legislation, etc.", 
        synonyms: "alteration, modification", 
        example: "They made an amendment to the constitution." 
    },
    { 
        id: 52, 
        word: "amusing", 
        definition: "Causing laughter and providing entertainment.", 
        synonyms: "funny, entertaining", 
        example: "I found the movie very amusing." 
    },
    { 
        id: 53, 
        word: "announce", 
        definition: "To make something known or tell people about something officially.", 
        synonyms: "declare, proclaim", 
        example: "They announced the winner of the competition." 
    },
    { 
        id: 54, 
        word: "anticipate", 
        definition: "To imagine or expect that something will happen.", 
        synonyms: "expect, predict", 
        example: "We anticipate a huge increase in sales." 
    },
    { 
        id: 55, 
        word: "apologize", 
        definition: "To tell someone that you are sorry for having done something that has caused inconvenience or unhappiness.", 
        synonyms: "say sorry", 
        example: "You should apologize for your rude behavior." 
    },
    { 
        id: 56, 
        word: "appalling", 
        definition: "Shocking and very bad.", 
        synonyms: "dreadful, horrendous", 
        example: "The prisoners were living in appalling conditions." 
    },
    { 
        id: 57, 
        word: "appointment", 
        definition: "A formal arrangement to meet or visit someone at a particular time and place.", 
        synonyms: "meeting", 
        example: "I have a dentist appointment at 3 PM." 
    },
    { 
        id: 58, 
        word: "appreciate", 
        definition: "To recognize how good someone or something is and to value him, her, or it.", 
        synonyms: "value, cherish", 
        example: "I really appreciate your help." 
    },
    { 
        id: 59, 
        word: "approach", 
        definition: "To come near or nearer to something or someone in space, time, quality, or amount.", 
        synonyms: "come near", 
        example: "Winter is approaching fast." 
    },
    { 
        id: 60, 
        word: "appropriately", 
        definition: "In a way that is suitable or right for a particular situation or occasion.", 
        synonyms: "suitably", 
        example: "She was dressed appropriately for the interview." 
    },
    { 
        id: 61, 
        word: "approve of", 
        definition: "To have a positive opinion of someone or something.", 
        synonyms: "agree with", 
        example: "Her parents didn't approve of her marriage." 
    },
    { 
        id: 62, 
        word: "arrange", 
        definition: "To plan, prepare for, or organize something.", 
        synonyms: "organize", 
        example: "We need to arrange a meeting." 
    },
    { 
        id: 63, 
        word: "artefact", 
        definition: "An object that is made by a person, such as a tool or a decoration, especially one that is of historical interest.", 
        synonyms: "item, relic", 
        example: "The museum has many ancient artefacts." 
    },
    { 
        id: 64, 
        word: "ascend", 
        definition: "To move up or climb something.", 
        synonyms: "climb up, go up", 
        example: "They slowly ascended the mountain." 
    },
    { 
        id: 65, 
        word: "ask for", 
        definition: "To request something.", 
        synonyms: "request", 
        example: "Don't be afraid to ask for help." 
    },
    { 
        id: 66, 
        word: "aspire", 
        definition: "To have a strong want or hope to do or have something.", 
        synonyms: "desire, aim", 
        example: "He aspires to be a great writer." 
    },
    { 
        id: 67, 
        word: "assemble", 
        definition: "To come together in a single place or bring parts together in a single group.", 
        synonyms: "gather, build", 
        example: "We assembled in the meeting room." 
    },
    { 
        id: 68, 
        word: "assess", 
        definition: "To judge or decide the amount, value, quality, or importance of something.", 
        synonyms: "evaluate", 
        example: "They assessed the cost of the flood damage." 
    },
    { 
        id: 69, 
        word: "assign", 
        definition: "To give a particular job or piece of work to someone.", 
        synonyms: "appoint", 
        example: "The teacher assigned us a lot of homework." 
    },
    { 
        id: 70, 
        word: "assist", 
        definition: "To help.", 
        synonyms: "help, aid", 
        example: "The nurse assisted the doctor during the surgery." 
    },
    { 
        id: 71, 
        word: "associate", 
        definition: "To connect someone or something in your mind with someone or something else.", 
        synonyms: "link, connect", 
        example: "I associate rain with sadness." 
    },
    { 
        id: 72, 
        word: "assume", 
        definition: "To accept something to be true without question or proof.", 
        synonyms: "presume, suppose", 
        example: "I assume you are tired after the journey." 
    },
    { 
        id: 73, 
        word: "assure", 
        definition: "To tell someone confidently that something is true, especially so that they do not worry.", 
        synonyms: "guarantee, promise", 
        example: "I assure you that everything will be fine." 
    },
    { 
        id: 74, 
        word: "astonishment", 
        definition: "Very great surprise.", 
        synonyms: "amazement", 
        example: "She looked at him in astonishment." 
    },
    { 
        id: 75, 
        word: "attach", 
        definition: "To fasten, join, or connect something.", 
        synonyms: "connect, join", 
        example: "Please attach a photo to your application." 
    },
    { 
        id: 76, 
        word: "attack", 
        definition: "To try to hurt or defeat using violence.", 
        synonyms: "assault", 
        example: "The army attacked the city at dawn." 
    },
    { 
        id: 77, 
        word: "attain", 
        definition: "To reach or succeed in getting something.", 
        synonyms: "gain, achieve", 
        example: "He has attained the highest grade in the music exam." 
    },
    { 
        id: 78, 
        word: "attainment", 
        definition: "The act of achieving something.", 
        synonyms: "achievement", 
        example: "The attainment of his goals made him happy." 
    },
    { 
        id: 79, 
        word: "attend", 
        definition: "To go to an event, place, etc.", 
        synonyms: "be present at", 
        example: "I will attend the meeting tomorrow." 
    },
    { 
        id: 80, 
        word: "attribute", 
        definition: "To say or think that something is the result of a particular thing.", 
        synonyms: "ascribe", 
        example: "He attributes his success to hard work." 
    },
    { 
        id: 81, 
        word: "auditorium", 
        definition: "The part of a theatre, or similar building, where the people who are watching and listening sit.", 
        synonyms: "hall", 
        example: "The auditorium was packed with people." 
    },
    { 
        id: 82, 
        word: "available", 
        definition: "Able to be bought or used.", 
        synonyms: "accessible", 
        example: "Is this seat available?" 
    },
    { 
        id: 83, 
        word: "avert", 
        definition: "To prevent something bad from happening.", 
        synonyms: "prevent, avoid", 
        example: "We managed to avert the crisis." 
    },
    { 
        id: 84, 
        word: "avoidable", 
        definition: "Possible to avoid.", 
        synonyms: "preventable", 
        example: "It was an avoidable mistake." 
    },
    { 
        id: 85, 
        word: "award", 
        definition: "To give money or a prize following an official decision.", 
        synonyms: "prize, grant", 
        example: "He was awarded the Nobel Prize." 
    },
    { 
        id: 86, 
        word: "backward", 
        definition: "Towards the direction that is behind you.", 
        synonyms: "rearward", 
        example: "She took a step backward." 
    },
    { 
        id: 87, 
        word: "badly in need of", 
        definition: "Desperately requiring something.", 
        synonyms: "desperate for", 
        example: "The house is badly in need of repair." 
    },
    { 
        id: 88, 
        word: "barely", 
        definition: "By the smallest amount.", 
        synonyms: "hardly, scarcely", 
        example: "I could barely see the road in the fog." 
    },
    { 
        id: 89, 
        word: "bargain", 
        definition: "Something on sale at a lower price than its true value.", 
        synonyms: "deal", 
        example: "This coat was a real bargain." 
    },
    { 
        id: 90, 
        word: "barren", 
        definition: "Unable to produce plants or fruit.", 
        synonyms: "infertile, arid", 
        example: "The land is barren and dry." 
    },
    { 
        id: 91, 
        word: "basic", 
        definition: "Simple and not complicated, so able to provide the starting point from which something can develop.", 
        synonyms: "fundamental, essential", 
        example: "Food and shelter are basic human needs." 
    },
    { 
        id: 92, 
        word: "bazaar", 
        definition: "An area of small shops and people selling things, especially in West and South Asia.", 
        synonyms: "market", 
        example: "We bought spices at the Grand Bazaar." 
    },
    { 
        id: 93, 
        word: "behave", 
        definition: "To act in a particular way.", 
        synonyms: "act", 
        example: "The children behaved very well." 
    },
    { 
        id: 94, 
        word: "believe", 
        definition: "To think that something is true, correct, or real.", 
        synonyms: "trust", 
        example: "I believe you can do it." 
    },
    { 
        id: 95, 
        word: "belongings", 
        definition: "The things that a person owns, especially those that can be carried.", 
        synonyms: "possessions", 
        example: "Please take your personal belongings with you." 
    },
    { 
        id: 96, 
        word: "beloved", 
        definition: "Loved very much.", 
        synonyms: "dear, cherished", 
        example: "He lost his beloved wife last year." 
    },
    { 
        id: 97, 
        word: "bitingly satirical", 
        definition: "Using humor to criticize someone or something in a very sharp or cruel way.", 
        synonyms: "sarcastic", 
        example: "He wrote a bitingly satirical article about the government." 
    },
    { 
        id: 98, 
        word: "bizarre", 
        definition: "Very strange and unusual.", 
        synonyms: "strange, weird", 
        example: "That was a bizarre situation." 
    },
    { 
        id: 99, 
        word: "blanket", 
        definition: "A flat cover made of wool or similar warm material, usually used on a bed.", 
        synonyms: "cover", 
        example: "It's cold, take an extra blanket." 
    },
    { 
        id: 100, 
        word: "blaze", 
        definition: "A large, strong fire.", 
        synonyms: "fire, flame", 
        example: "Firefighters fought the blaze for hours." 
    },
{ 
        id: 101, 
        word: "bolt", 
        definition: "To move very fast, especially as a result of being frightened.", 
        synonyms: "dash, flee", 
        example: "The cat bolted out the door when it heard the noise." 
    },
    { 
        id: 102, 
        word: "branch", 
        definition: "A part of something larger, such as an organization or a tree.", 
        synonyms: "division, section", 
        example: "Our company has a new branch in Tokyo." 
    },
    { 
        id: 103, 
        word: "break off", 
        definition: "To end a relationship or a discussion suddenly.", 
        synonyms: "terminate, end", 
        example: "They decided to break off their engagement." 
    },
    { 
        id: 104, 
        word: "breed", 
        definition: "To keep animals for the purpose of producing young.", 
        synonyms: "reproduce, raise", 
        example: "They breed horses on this farm." 
    },
    { 
        id: 105, 
        word: "bribery", 
        definition: "The crime of giving someone money or something else of value to persuade them to do something.", 
        synonyms: "corruption", 
        example: "The official was arrested for bribery." 
    },
    { 
        id: 106, 
        word: "bride", 
        definition: "A woman who is about to get married or has just got married.", 
        synonyms: "-", 
        example: "The bride looked beautiful in her white dress." 
    },
    { 
        id: 107, 
        word: "brief", 
        definition: "Lasting only a short time or containing few words.", 
        synonyms: "short, concise", 
        example: "We had a brief meeting this morning." 
    },
    { 
        id: 108, 
        word: "bring up", 
        definition: "To care for a child until they are an adult.", 
        synonyms: "raise, rear", 
        example: "She was brought up by her grandmother." 
    },
    { 
        id: 109, 
        word: "broadcast", 
        definition: "To send out a programme on television or radio.", 
        synonyms: "air, transmit", 
        example: "The interview was broadcast live on TV." 
    },
    { 
        id: 110, 
        word: "broadly speaking", 
        definition: "Used to say that something is generally true.", 
        synonyms: "generally, mostly", 
        example: "Broadly speaking, the project was a success." 
    },
    { 
        id: 111, 
        word: "broil", 
        definition: "To cook meat or fish under direct heat.", 
        synonyms: "grill, roast", 
        example: "I will broil the steak for dinner." 
    },
    { 
        id: 112, 
        word: "bullfight", 
        definition: "A traditional public entertainment in Spain in which a person fights a bull.", 
        synonyms: "-", 
        example: "Bullfighting is a controversial tradition." 
    },
    { 
        id: 113, 
        word: "bully", 
        definition: "Someone who hurts or frightens someone else, often over a period of time.", 
        synonyms: "persecutor, tormentor", 
        example: "He was a bully at school, but now he is kind." 
    },
    { 
        id: 114, 
        word: "burial", 
        definition: "The act of putting a dead body into the ground.", 
        synonyms: "funeral, interment", 
        example: "The burial took place yesterday afternoon." 
    },
    { 
        id: 115, 
        word: "burn", 
        definition: "To be hurt, damaged, or destroyed by fire or extreme heat.", 
        synonyms: "ignite, scorch", 
        example: "Be careful not to burn the toast." 
    },
    { 
        id: 116, 
        word: "button", 
        definition: "A small, usually round object used to fasten clothes.", 
        synonyms: "-", 
        example: "I lost a button on my favorite shirt." 
    },
    { 
        id: 117, 
        word: "calculator", 
        definition: "A small electronic device that is used for doing calculations.", 
        synonyms: "-", 
        example: "You can use a calculator during the math exam." 
    },
    { 
        id: 118, 
        word: "call for", 
        definition: "To need or deserve a particular action, remark, or quality.", 
        synonyms: "require, demand", 
        example: "This situation calls for immediate action." 
    },
    { 
        id: 119, 
        word: "calm", 
        definition: "Peaceful, quiet, and without worry.", 
        synonyms: "relaxed, serene", 
        example: "Try to stay calm in an emergency." 
    },
    { 
        id: 120, 
        word: "cancel", 
        definition: "To decide that an organized event will not happen.", 
        synonyms: "call off, annul", 
        example: "The flight was cancelled due to heavy fog." 
    },
    { 
        id: 121, 
        word: "captivating", 
        definition: "Holding your attention by being extremely interesting or attractive.", 
        synonyms: "fascinating, charming", 
        example: "She told a captivating story about her travels." 
    },
    { 
        id: 122, 
        word: "captive", 
        definition: "A person or animal whose ability to move or act freely is limited by being closed in a space.", 
        synonyms: "prisoner, hostage", 
        example: "He was held captive by the rebels for months." 
    },
    { 
        id: 123, 
        word: "captivity", 
        definition: "The situation of being kept as a prisoner or in a confined space.", 
        synonyms: "imprisonment, confinement", 
        example: "Animals bred in captivity often cannot survive in the wild." 
    },
    { 
        id: 124, 
        word: "capture", 
        definition: "To take someone as a prisoner, or to take something into your possession.", 
        synonyms: "seize, catch", 
        example: "The soldiers captured the enemy base." 
    },
    { 
        id: 125, 
        word: "careless", 
        definition: "Not taking or showing enough care and attention.", 
        synonyms: "negligent, sloppy", 
        example: "It was a careless mistake that cost us time." 
    },
    { 
        id: 126, 
        word: "carry out", 
        definition: "To perform or complete a job or activity.", 
        synonyms: "execute, conduct", 
        example: "Scientists carried out a survey on sleep patterns." 
    },
    { 
        id: 127, 
        word: "carve", 
        definition: "To make something by cutting into especially wood or stone.", 
        synonyms: "sculpt, cut", 
        example: "He carved a beautiful statue from wood." 
    },
    { 
        id: 128, 
        word: "casually", 
        definition: "In a way that is not serious or does not show much interest.", 
        synonyms: "informally", 
        example: "He was dressed casually in jeans and a t-shirt." 
    },
    { 
        id: 129, 
        word: "caution", 
        definition: "Great care and attention.", 
        synonyms: "care, wariness", 
        example: "You should proceed with caution." 
    },
    { 
        id: 130, 
        word: "cease", 
        definition: "To stop something.", 
        synonyms: "stop, end", 
        example: "The company ceased operations last year." 
    },
    { 
        id: 131, 
        word: "ceaseless", 
        definition: "Without stopping, or seeming to have no end.", 
        synonyms: "constant, unending", 
        example: "The ceaseless rain made everyone depressed." 
    },
    { 
        id: 132, 
        word: "celebration", 
        definition: "A special social event, such as a party, when you celebrate something.", 
        synonyms: "festivity, party", 
        example: "We had a big celebration for her birthday." 
    },
    { 
        id: 133, 
        word: "celebrity", 
        definition: "Someone who is famous, especially in the entertainment business.", 
        synonyms: "star, famous person", 
        example: "She became a celebrity overnight." 
    },
    { 
        id: 134, 
        word: "census", 
        definition: "A count for official purposes, especially one to count the number of people living in a country.", 
        synonyms: "survey, count", 
        example: "A national census is taken every ten years." 
    },
    { 
        id: 135, 
        word: "ceremony", 
        definition: "A set of formal acts performed on important social or religious occasions.", 
        synonyms: "ritual, service", 
        example: "The wedding ceremony was very beautiful." 
    },
    { 
        id: 136, 
        word: "charge (with)", 
        definition: "To make a formal statement saying that someone is accused of a crime.", 
        synonyms: "accuse, indict", 
        example: "He was charged with robbery." 
    },
    { 
        id: 137, 
        word: "circulate", 
        definition: "To go around or through something, or to make something go around or through something.", 
        synonyms: "flow, move around", 
        example: "Hot water circulates through the pipes." 
    },
    { 
        id: 138, 
        word: "circulation", 
        definition: "The movement of blood around the body.", 
        synonyms: "flow", 
        example: "Regular exercise improves blood circulation." 
    },
    { 
        id: 139, 
        word: "cite", 
        definition: "To mention something as proof for a theory or as a reason why something has happened.", 
        synonyms: "quote, mention", 
        example: "She cited three reasons for her decision." 
    },
    { 
        id: 140, 
        word: "citizen", 
        definition: "A person who is a member of a particular country.", 
        synonyms: "resident, national", 
        example: "He is a US citizen." 
    },
    { 
        id: 141, 
        word: "clarify", 
        definition: "To make something clear or easier to understand.", 
        synonyms: "explain, clear up", 
        example: "Could you clarify the first point?" 
    },
    { 
        id: 142, 
        word: "claw", 
        definition: "One of the sharp curved nails at the end of each of the toes of some animals.", 
        synonyms: "nail, talon", 
        example: "The cat sharpened its claws on the tree." 
    },
    { 
        id: 143, 
        word: "clearance", 
        definition: "The process of removing things that are not wanted.", 
        synonyms: "removal, authorization", 
        example: "We bought the furniture at a clearance sale." 
    },
    { 
        id: 144, 
        word: "close", 
        definition: "Having direct family connections or shared beliefs, support, and sympathy.", 
        synonyms: "intimate, near", 
        example: "They are very close friends." 
    },
    { 
        id: 145, 
        word: "closed", 
        definition: "Not open.", 
        synonyms: "shut", 
        example: "The shop is closed on Sundays." 
    },
    { 
        id: 146, 
        word: "closure", 
        definition: "The fact of a business, organization, etc. stopping operating.", 
        synonyms: "end, conclusion", 
        example: "The factory faces closure due to lack of funds." 
    },
    { 
        id: 147, 
        word: "coincide", 
        definition: "To happen at or near the same time.", 
        synonyms: "occur simultaneously", 
        example: "My birthday coincides with a national holiday." 
    },
    { 
        id: 148, 
        word: "collapse", 
        definition: "To fall down suddenly because of pressure or having no strength.", 
        synonyms: "fall down, cave in", 
        example: "The roof collapsed under the weight of the snow." 
    },
    { 
        id: 149, 
        word: "collapsible", 
        definition: "Able to be folded into a small shape.", 
        synonyms: "foldable", 
        example: "We brought collapsible chairs for the picnic." 
    },
    { 
        id: 150, 
        word: "collar", 
        definition: "The part around the neck of a piece of clothing.", 
        synonyms: "-", 
        example: "He turned up his collar against the wind." 
    },
{ 
        id: 151, 
        word: "colleague", 
        definition: "One of a group of people who work together.", 
        synonyms: "coworker, associate", 
        example: "I am going to lunch with a colleague." 
    },
    { 
        id: 152, 
        word: "collide", 
        definition: "To hit something violently.", 
        synonyms: "crash into, hit", 
        example: "The two cars collided at the intersection." 
    },
    { 
        id: 153, 
        word: "commence", 
        definition: "To begin something.", 
        synonyms: "start, begin", 
        example: "The meeting is scheduled to commence at noon." 
    },
    { 
        id: 154, 
        word: "comment", 
        definition: "To express an opinion.", 
        synonyms: "remark, state", 
        example: "He refused to comment on the situation." 
    },
    { 
        id: 155, 
        word: "commercial", 
        definition: "Related to buying and selling things.", 
        synonyms: "trading, business", 
        example: "The film was a huge commercial success." 
    },
    { 
        id: 156, 
        word: "commit", 
        definition: "To do something illegal or something that is considered wrong.", 
        synonyms: "perpetrate, carry out", 
        example: "He was sent to prison for a crime that he didn't commit." 
    },
    { 
        id: 157, 
        word: "common", 
        definition: "Happening often or existing in large numbers.", 
        synonyms: "usual, widespread", 
        example: "Colds are very common in winter." 
    },
    { 
        id: 158, 
        word: "commonplace", 
        definition: "Happening often or often seen or experienced and so not considered to be special.", 
        synonyms: "ordinary, normal", 
        example: "Electric cars are becoming commonplace." 
    },
    { 
        id: 159, 
        word: "commuter", 
        definition: "Someone who regularly travels between work and home.", 
        synonyms: "traveler", 
        example: "The train was packed with commuters." 
    },
    { 
        id: 160, 
        word: "companion", 
        definition: "A person you spend a lot of time with often because you are friends or are travelling together.", 
        synonyms: "partner, friend", 
        example: "The dog has been her constant companion." 
    },
    { 
        id: 161, 
        word: "company", 
        definition: "An organization that sells goods or services in order to make money.", 
        synonyms: "firm, business", 
        example: "She works for a software company." 
    },
    { 
        id: 162, 
        word: "compel", 
        definition: "To force someone to do something.", 
        synonyms: "force, oblige", 
        example: "Illness compelled him to stay in bed." 
    },
    { 
        id: 163, 
        word: "compensation", 
        definition: "Money that is paid to someone in exchange for something that has been lost or damaged.", 
        synonyms: "reimbursement, repayment", 
        example: "She received compensation for her injuries." 
    },
    { 
        id: 164, 
        word: "compete", 
        definition: "To try to be more successful than someone or something else.", 
        synonyms: "contend, vie", 
        example: "Athletes from around the world compete in the Olympics." 
    },
    { 
        id: 165, 
        word: "competition", 
        definition: "An organized event in which people try to win a prize by being the best.", 
        synonyms: "contest, tournament", 
        example: "He won first prize in the competition." 
    },
    { 
        id: 166, 
        word: "compile", 
        definition: "To collect information from different places and arrange it in a book, report, or list.", 
        synonyms: "gather, collect", 
        example: "We are compiling a list of potential customers." 
    },
    { 
        id: 167, 
        word: "complain", 
        definition: "To say that something is wrong or not satisfactory.", 
        synonyms: "grumble, moan", 
        example: "He is always complaining about the weather." 
    },
    { 
        id: 168, 
        word: "completely", 
        definition: "In every way or as much as possible.", 
        synonyms: "totally, entirely", 
        example: "I completely forgot about the meeting." 
    },
    { 
        id: 169, 
        word: "comply", 
        definition: "To act according to an order, set of rules, or request.", 
        synonyms: "obey, follow", 
        example: "The factory must comply with safety regulations." 
    },
    { 
        id: 170, 
        word: "compose", 
        definition: "To produce music, poetry, or formal writing.", 
        synonyms: "create, write", 
        example: "Beethoven composed nine symphonies." 
    },
    { 
        id: 171, 
        word: "compound", 
        definition: "A mixture of two or more different things.", 
        synonyms: "mixture, combination", 
        example: "Salt is a compound of sodium and chlorine." 
    },
    { 
        id: 172, 
        word: "comprise", 
        definition: "To consist of particular parts or members.", 
        synonyms: "contain, include", 
        example: "The course comprises a class book and a practice book." 
    },
    { 
        id: 173, 
        word: "compute", 
        definition: "To calculate an answer or amount by using a machine.", 
        synonyms: "calculate, reckon", 
        example: "The software computes the final score." 
    },
    { 
        id: 174, 
        word: "conceal", 
        definition: "To prevent something from being seen or known about.", 
        synonyms: "hide, cover", 
        example: "He tried to conceal his heavy drinking from his family." 
    },
    { 
        id: 175, 
        word: "conceive", 
        definition: "To imagine something.", 
        synonyms: "imagine, visualize", 
        example: "I cannot conceive of a world without music." 
    },
    { 
        id: 176, 
        word: "conclude", 
        definition: "To end a speech, meeting, or piece of writing.", 
        synonyms: "finish, end", 
        example: "She concluded the speech by thanking everyone." 
    },
    { 
        id: 177, 
        word: "conclusion", 
        definition: "The final part of something.", 
        synonyms: "ending, result", 
        example: "In conclusion, I would like to say thank you." 
    },
    { 
        id: 178, 
        word: "condition", 
        definition: "The particular state that something or someone is in.", 
        synonyms: "state, situation", 
        example: "The car is in excellent condition." 
    },
    { 
        id: 179, 
        word: "conditionally", 
        definition: "In a way that depends on something else happening.", 
        synonyms: "provisionally", 
        example: "He was released conditionally." 
    },
    { 
        id: 180, 
        word: "conduct", 
        definition: "To organize and perform a particular activity.", 
        synonyms: "manage, direct", 
        example: "They conducted a survey." 
    },
    { 
        id: 181, 
        word: "confess", 
        definition: "To admit that you have done something wrong or that is illegal.", 
        synonyms: "admit, own up", 
        example: "He confessed to the crime." 
    },
    { 
        id: 182, 
        word: "confident", 
        definition: "Being certain of your abilities or having trust in people, plans, or the future.", 
        synonyms: "sure, certain", 
        example: "I am confident that we will win." 
    },
    { 
        id: 183, 
        word: "confine", 
        definition: "To limit an activity, person, or problem in some way.", 
        synonyms: "restrict, limit", 
        example: "Please confine your remarks to the topic." 
    },
    { 
        id: 184, 
        word: "confirm", 
        definition: "To make an arrangement or meeting certain, often by phone or writing.", 
        synonyms: "verify, prove", 
        example: "Please confirm your reservation." 
    },
    { 
        id: 185, 
        word: "conflict", 
        definition: "An active disagreement between people with opposing opinions or principles.", 
        synonyms: "dispute, clash", 
        example: "There was a lot of conflict between him and his father." 
    },
    { 
        id: 186, 
        word: "conform", 
        definition: "To behave according to the usual standards of behavior that are expected by a group or society.", 
        synonyms: "comply, follow", 
        example: "Students must conform to the school rules." 
    },
    { 
        id: 187, 
        word: "confront", 
        definition: "To face, meet, or deal with a difficult situation or person.", 
        synonyms: "face, challenge", 
        example: "You need to confront your fears." 
    },
    { 
        id: 188, 
        word: "confuse", 
        definition: "To mix up two separate things or people in your mind.", 
        synonyms: "puzzle, baffle", 
        example: "You are confusing me with my sister." 
    },
    { 
        id: 189, 
        word: "conquer", 
        definition: "To take control or possession of foreign land, or a group of people, by force.", 
        synonyms: "defeat, overcome", 
        example: "The Spanish conquered the New World." 
    },
    { 
        id: 190, 
        word: "consent", 
        definition: "Permission or agreement.", 
        synonyms: "permission, agreement", 
        example: "They can't publish your name without your consent." 
    },
    { 
        id: 191, 
        word: "consequence", 
        definition: "A result of a particular action or situation, often one that is bad or not convenient.", 
        synonyms: "result, outcome", 
        example: "He didn't think about the consequences of his actions." 
    },
    { 
        id: 192, 
        word: "conserve", 
        definition: "To keep and protect something from damage, change, or waste.", 
        synonyms: "save, preserve", 
        example: "To conserve electricity, we are cutting down on our heating." 
    },
    { 
        id: 193, 
        word: "considerable", 
        definition: "Large or of noticeable importance.", 
        synonyms: "significant, substantial", 
        example: "The fire caused considerable damage." 
    },
    { 
        id: 194, 
        word: "considerably", 
        definition: "To a large, noticeable, or important degree.", 
        synonyms: "significantly, greatly", 
        example: "He is considerably fatter than he was when I knew him." 
    },
    { 
        id: 195, 
        word: "considerately", 
        definition: "In a way that shows you care about other people's feelings and needs.", 
        synonyms: "thoughtfully, kindly", 
        example: "She always acts considerately towards her neighbors." 
    },
    { 
        id: 196, 
        word: "consideration", 
        definition: "The act of thinking about something carefully.", 
        synonyms: "thought, reflection", 
        example: "After some consideration, we've decided to sell the house." 
    },
    { 
        id: 197, 
        word: "consist of", 
        definition: "To be made of or formed from something.", 
        synonyms: "be composed of", 
        example: "The team consists of four Europeans and two Americans." 
    },
    { 
        id: 198, 
        word: "conspire", 
        definition: "To plan secretly with other people to do something bad, illegal, or against someone's wishes.", 
        synonyms: "plot, scheme", 
        example: "He felt that his colleagues were conspiring together to remove him from his job." 
    },
    { 
        id: 199, 
        word: "constantly", 
        definition: "All the time or often.", 
        synonyms: "continuously, always", 
        example: "He's constantly changing his mind." 
    },
    { 
        id: 200, 
        word: "constitute", 
        definition: "To be or be considered as something.", 
        synonyms: "make up, form", 
        example: "This defeat constitutes a real setback for our team." 
    },
{ 
        id: 201, 
        word: "constrain", 
        definition: "To control and limit something.", 
        synonyms: "restrict, limit", 
        example: "Financial factors constrained the company's growth." 
    },
    { 
        id: 202, 
        word: "construct", 
        definition: "To build something or put together different parts.", 
        synonyms: "build, erect", 
        example: "They are planning to construct a new bridge." 
    },
    { 
        id: 203, 
        word: "consult", 
        definition: "To get information or advice from a person, book, etc. with special knowledge on a particular subject.", 
        synonyms: "ask, seek advice", 
        example: "You should consult a doctor if symptoms persist." 
    },
    { 
        id: 204, 
        word: "consume", 
        definition: "To use fuel, energy, or time, especially in large amounts.", 
        synonyms: "use up, deplete", 
        example: "This car consumes a lot of fuel." 
    },
    { 
        id: 205, 
        word: "contact", 
        definition: "Communication with someone, especially by speaking or writing to them.", 
        synonyms: "communicate, reach", 
        example: "Please contact me if you have any questions." 
    },
    { 
        id: 206, 
        word: "contemporary", 
        definition: "Existing or happening now.", 
        synonyms: "modern, current", 
        example: "Contemporary art can be difficult to understand." 
    },
    { 
        id: 207, 
        word: "content", 
        definition: "Pleased with your situation and not hoping for change or improvement.", 
        synonyms: "satisfied, pleased", 
        example: "He seems fairly content with his life." 
    },
    { 
        id: 208, 
        word: "contest", 
        definition: "A competition to do better than other people, usually in which prizes are given.", 
        synonyms: "competition, match", 
        example: "She entered a beauty contest." 
    },
    { 
        id: 209, 
        word: "continent", 
        definition: "One of the seven large land masses on the earth's surface.", 
        synonyms: "landmass", 
        example: "Asia is the largest continent." 
    },
    { 
        id: 210, 
        word: "contract", 
        definition: "A legal document that states and explains a formal agreement between two different people or groups.", 
        synonyms: "agreement, deal", 
        example: "They signed a contract for the new house." 
    },
    { 
        id: 211, 
        word: "contradict", 
        definition: "To say the opposite of what someone else has said.", 
        synonyms: "disagree with, oppose", 
        example: "He didn't dare contradict his parents." 
    },
    { 
        id: 212, 
        word: "contradictory", 
        definition: "If two or more facts, pieces of advice, etc. are contradictory, they are very different from each other.", 
        synonyms: "inconsistent, conflicting", 
        example: "We received contradictory reports about the accident." 
    },
    { 
        id: 213, 
        word: "contribute", 
        definition: "To give something, especially money, in order to provide or achieve something together with other people.", 
        synonyms: "donate, supply", 
        example: "Everyone contributed to the charity fund." 
    },
    { 
        id: 214, 
        word: "controversial", 
        definition: "Causing disagreement or discussion.", 
        synonyms: "debatable, disputed", 
        example: "The book was very controversial." 
    },
    { 
        id: 215, 
        word: "controversy", 
        definition: "A lot of disagreement or argument about something, usually because it affects or is important to many people.", 
        synonyms: "dispute, debate", 
        example: "There was a huge controversy over the new law." 
    },
    { 
        id: 216, 
        word: "conventional", 
        definition: "Traditional and ordinary.", 
        synonyms: "traditional, standard", 
        example: "He prefers conventional medicine to alternative therapies." 
    },
    { 
        id: 217, 
        word: "converse", 
        definition: "To have a conversation with someone.", 
        synonyms: "talk, speak", 
        example: "She enjoys conversing with people from other countries." 
    },
    { 
        id: 218, 
        word: "convert", 
        definition: "To change to a new religion, belief, opinion, etc., or to make someone do this.", 
        synonyms: "change, transform", 
        example: "They converted the old warehouse into apartments." 
    },
    { 
        id: 219, 
        word: "convict", 
        definition: "Someone who is in prison because they are guilty of a crime.", 
        synonyms: "prisoner, inmate", 
        example: "The escaped convict was caught by the police." 
    },
    { 
        id: 220, 
        word: "convince", 
        definition: "To persuade someone or make someone certain.", 
        synonyms: "persuade, assure", 
        example: "I managed to convince him to stay." 
    },
    { 
        id: 221, 
        word: "correctly", 
        definition: "In a way that is accurate or true; without error.", 
        synonyms: "accurately, rightly", 
        example: "Did you answer all the questions correctly?" 
    },
    { 
        id: 222, 
        word: "correspond", 
        definition: "To match or be similar or equal.", 
        synonyms: "match, agree", 
        example: "His story doesn't correspond with the facts." 
    },
    { 
        id: 223, 
        word: "counterpart", 
        definition: "A person or thing that has the same purpose as another one in a different place or organization.", 
        synonyms: "equivalent, peer", 
        example: "The prime minister met with his German counterpart." 
    },
    { 
        id: 224, 
        word: "couple", 
        definition: "Two or a few things that are similar or the same.", 
        synonyms: "pair, duo", 
        example: "I have a couple of questions." 
    },
    { 
        id: 225, 
        word: "course", 
        definition: "A set of classes or a plan of study on a particular subject.", 
        synonyms: "class, program", 
        example: "I signed up for an English course." 
    },
    { 
        id: 226, 
        word: "cramped", 
        definition: "Not having enough space or time.", 
        synonyms: "crowded, tight", 
        example: "We were in a very cramped room." 
    },
    { 
        id: 227, 
        word: "crash", 
        definition: "An accident involving a vehicle, usually a serious one.", 
        synonyms: "collision, accident", 
        example: "He was injured in a car crash." 
    },
    { 
        id: 228, 
        word: "crawl", 
        definition: "To move along on hands and knees or with your body stretched out along the ground.", 
        synonyms: "creep", 
        example: "The baby started to crawl." 
    },
    { 
        id: 229, 
        word: "create", 
        definition: "To make something new, or invent something.", 
        synonyms: "make, produce", 
        example: "The project will create more than 500 jobs." 
    },
    { 
        id: 230, 
        word: "credibly", 
        definition: "In a way that is easy to believe or trust.", 
        synonyms: "plausibly, believably", 
        example: "He could not explain credibly where he had been." 
    },
    { 
        id: 231, 
        word: "criminal", 
        definition: "Someone who has committed a crime.", 
        synonyms: "offender, lawbreaker", 
        example: "Police are looking for a dangerous criminal." 
    },
    { 
        id: 232, 
        word: "crippled", 
        definition: "Unable to walk or move easily or effectively because of serious injury or permanent disability.", 
        synonyms: "disabled, handicapped", 
        example: "The accident left him crippled." 
    },
    { 
        id: 233, 
        word: "crocodile", 
        definition: "A large reptile with a hard skin that lives in and near rivers and lakes.", 
        synonyms: "-", 
        example: "Be careful of crocodiles in the river." 
    },
    { 
        id: 234, 
        word: "cross out", 
        definition: "To draw a line through something you have written, usually because it is wrong.", 
        synonyms: "delete, strike out", 
        example: "Cross out the incorrect word." 
    },
    { 
        id: 235, 
        word: "crumble", 
        definition: "To break, or cause something to break, into small pieces.", 
        synonyms: "disintegrate, break up", 
        example: "The old wall started to crumble." 
    },
    { 
        id: 236, 
        word: "cultivate", 
        definition: "To prepare land and grow crops on it.", 
        synonyms: "farm, grow", 
        example: "They cultivate rice in this region." 
    },
    { 
        id: 237, 
        word: "curator", 
        definition: "A person in charge of a museum, library, etc.", 
        synonyms: "keeper, custodian", 
        example: "The museum curator gave us a tour." 
    },
    { 
        id: 238, 
        word: "currency", 
        definition: "The money that is used in a particular country at a particular time.", 
        synonyms: "money, cash", 
        example: "You should exchange some currency before you travel." 
    },
    { 
        id: 239, 
        word: "curve", 
        definition: "A line that bends continuously and has no straight parts.", 
        synonyms: "bend, arc", 
        example: "The road has a sharp curve." 
    },
    { 
        id: 240, 
        word: "custom", 
        definition: "A way of behaving or a belief that has been established for a long time.", 
        synonyms: "tradition, practice", 
        example: "It is a local custom to take off shoes." 
    },
    { 
        id: 241, 
        word: "customary", 
        definition: "Usual.", 
        synonyms: "traditional, usual", 
        example: "It is customary to offer a gift." 
    },
    { 
        id: 242, 
        word: "debate", 
        definition: "Serious discussion of a subject in which many people take part.", 
        synonyms: "discussion, argument", 
        example: "There was a heated debate about the new policy." 
    },
    { 
        id: 243, 
        word: "debt", 
        definition: "Money that is owed to someone else.", 
        synonyms: "liability, due", 
        example: "He is trying to pay off his debts." 
    },
    { 
        id: 244, 
        word: "deceit", 
        definition: "The act of keeping the truth hidden, especially to get an advantage.", 
        synonyms: "deception, fraud", 
        example: "He was accused of lies and deceit." 
    },
    { 
        id: 245, 
        word: "deceive", 
        definition: "To persuade someone that something false is the truth.", 
        synonyms: "trick, fool", 
        example: "Don't try to deceive me." 
    },
    { 
        id: 246, 
        word: "decipher", 
        definition: "To discover the meaning of something written badly or in a difficult or hidden way.", 
        synonyms: "decode, solve", 
        example: "I couldn't decipher his handwriting." 
    },
    { 
        id: 247, 
        word: "declare", 
        definition: "To announce something clearly, firmly, publicly, or officially.", 
        synonyms: "announce, proclaim", 
        example: "They declared their independence." 
    },
    { 
        id: 248, 
        word: "decline", 
        definition: "To gradually become less, worse, or lower.", 
        synonyms: "decrease, diminish", 
        example: "His health began to decline." 
    },
    { 
        id: 249, 
        word: "dedicate", 
        definition: "To give all of your energy, time, etc.", 
        synonyms: "devote, commit", 
        example: "He dedicated his life to science." 
    },
    { 
        id: 250, 
        word: "deduce", 
        definition: "To reach an answer or a decision by thinking carefully about the known facts.", 
        synonyms: "infer, conclude", 
        example: "We can deduce a lot from these figures." 
    },
{ 
        id: 251, 
        word: "deepen", 
        definition: "To make something deeper, or to become deeper.", 
        synonyms: "intensify, grow", 
        example: "The economic crisis has deepened." 
    },
    { 
        id: 252, 
        word: "defeat", 
        definition: "To win against someone in a fight, war, or competition.", 
        synonyms: "beat, conquer", 
        example: "Our team was defeated in the final match." 
    },
    { 
        id: 253, 
        word: "defect", 
        definition: "A fault or problem in something or someone that spoils that thing or person or causes it, him, or her not to work correctly.", 
        synonyms: "flaw, fault", 
        example: "There is a genetic defect in his family." 
    },
    { 
        id: 254, 
        word: "defend", 
        definition: "To protect someone or something against attack or criticism.", 
        synonyms: "protect, guard", 
        example: "They fought to defend their country." 
    },
    { 
        id: 255, 
        word: "define", 
        definition: "To say what the meaning of something, especially a word, is.", 
        synonyms: "describe, explain", 
        example: "It is difficult to define the word 'love'." 
    },
    { 
        id: 256, 
        word: "degeneration", 
        definition: "The process by which something gets worse.", 
        synonyms: "deterioration, decline", 
        example: "There is a degeneration of moral values in society." 
    },
    { 
        id: 257, 
        word: "delay", 
        definition: "To make something happen at a later time than originally planned or expected.", 
        synonyms: "postpone, put off", 
        example: "The flight was delayed due to bad weather." 
    },
    { 
        id: 258, 
        word: "delightful", 
        definition: "Very pleasant, attractive, or enjoyable.", 
        synonyms: "pleasant, charming", 
        example: "We had a delightful evening." 
    },
    { 
        id: 259, 
        word: "deliver", 
        definition: "To take goods, letters, parcels, etc. to people's houses or places of work.", 
        synonyms: "distribute, bring", 
        example: "The postman delivers mail every morning." 
    },
    { 
        id: 260, 
        word: "demand", 
        definition: "To ask for something forcefully, in a way that shows that you do not expect to be refused.", 
        synonyms: "request, claim", 
        example: "The workers demanded a pay rise." 
    },
    { 
        id: 261, 
        word: "demolish", 
        definition: "To completely destroy a building, especially in order to use the land for something else.", 
        synonyms: "destroy, knock down", 
        example: "They demolished the old factory." 
    },
    { 
        id: 262, 
        word: "demonstrate", 
        definition: "To show or make make something clear.", 
        synonyms: "show, prove", 
        example: "The teacher demonstrated how to use the equipment." 
    },
    { 
        id: 263, 
        word: "deny", 
        definition: "To say that something is not true.", 
        synonyms: "refuse, reject", 
        example: "He denied stealing the money." 
    },
    { 
        id: 264, 
        word: "depress", 
        definition: "To cause someone to feel unhappy and without hope.", 
        synonyms: "sadden, discourage", 
        example: "This weather really depresses me." 
    },
    { 
        id: 265, 
        word: "derive from", 
        definition: "To come from something.", 
        synonyms: "originate in, stem from", 
        example: "Many English words are derived from Latin." 
    },
    { 
        id: 266, 
        word: "descend", 
        definition: "To go or come down.", 
        synonyms: "go down, drop", 
        example: "The plane began to descend." 
    },
    { 
        id: 267, 
        word: "desert", 
        definition: "An area, often covered with sand or rocks, where there is very little rain and not many plants.", 
        synonyms: "wilderness, wasteland", 
        example: "They got lost in the Sahara Desert." 
    },
    { 
        id: 268, 
        word: "deserve", 
        definition: "To have earned or to be given something because of the way you have behaved or the qualities you have.", 
        synonyms: "merit, earn", 
        example: "You deserve a holiday after all that hard work." 
    },
    { 
        id: 269, 
        word: "design", 
        definition: "To make or draw plans for something, for example clothes or buildings.", 
        synonyms: "plan, create", 
        example: "She designs wedding dresses." 
    },
    { 
        id: 270, 
        word: "desire", 
        definition: "To want something, especially strongly.", 
        synonyms: "want, wish", 
        example: "I desire only to be left in peace." 
    },
    { 
        id: 271, 
        word: "desolate", 
        definition: "A desolate place is empty and not attractive, with no people or nothing pleasant in it.", 
        synonyms: "barren, bleak", 
        example: "The house stood in a desolate landscape." 
    },
    { 
        id: 272, 
        word: "dessert", 
        definition: "Sweet food eaten at the end of a meal.", 
        synonyms: "sweet", 
        example: "We had ice cream for dessert." 
    },
    { 
        id: 273, 
        word: "destination", 
        definition: "The place where someone is going or where something is being sent or taken.", 
        synonyms: "goal, target", 
        example: "We arrived at our destination late at night." 
    },
    { 
        id: 274, 
        word: "destiny", 
        definition: "The things that will happen in the future.", 
        synonyms: "fate, fortune", 
        example: "He believes it is his destiny to become famous." 
    },
    { 
        id: 275, 
        word: "destroy", 
        definition: "To damage something so badly that it cannot be used.", 
        synonyms: "ruin, demolish", 
        example: "The fire destroyed the building." 
    },
    { 
        id: 276, 
        word: "detain", 
        definition: "To force someone officially to stay in a place.", 
        synonyms: "hold, arrest", 
        example: "Police detained the suspect for questioning." 
    },
    { 
        id: 277, 
        word: "detect", 
        definition: "To notice something that is partly hidden or not clear, or to discover something.", 
        synonyms: "discover, notice", 
        example: "The alarm detects smoke." 
    },
    { 
        id: 278, 
        word: "detection", 
        definition: "The fact of noticing or discovering something.", 
        synonyms: "discovery, identification", 
        example: "Early detection of cancer is important." 
    },
    { 
        id: 279, 
        word: "deter (from)", 
        definition: "To prevent someone from doing something or to make someone less enthusiastic about doing it.", 
        synonyms: "discourage, prevent", 
        example: "High prices deter people from buying new cars." 
    },
    { 
        id: 280, 
        word: "deteriorate", 
        definition: "To become worse.", 
        synonyms: "worsen, decline", 
        example: "Her health began to deteriorate rapidly." 
    },
    { 
        id: 281, 
        word: "determination", 
        definition: "The ability to continue trying to do something, although it is very difficult.", 
        synonyms: "resolve, perseverance", 
        example: "He fought the illness with great determination." 
    },
    { 
        id: 282, 
        word: "devastate", 
        definition: "To destroy a place or thing completely or cause great damage.", 
        synonyms: "ruin, destroy", 
        example: "The bomb devastated the city center." 
    },
    { 
        id: 283, 
        word: "develop", 
        definition: "To (cause something to) grow or change into a more advanced, larger, or stronger form.", 
        synonyms: "grow, evolve", 
        example: "The child is developing normally." 
    },
    { 
        id: 284, 
        word: "deviate", 
        definition: "To do something that is different from the usual or common way of behaving.", 
        synonyms: "stray, diverge", 
        example: "He never deviates from his routine." 
    },
    { 
        id: 285, 
        word: "devote", 
        definition: "To give your time or effort completely to something you believe in.", 
        synonyms: "dedicate, commit", 
        example: "He devoted his life to serving his country." 
    },
    { 
        id: 286, 
        word: "diagnose", 
        definition: "To recognize and name the exact character of a disease or a problem, by examining it.", 
        synonyms: "identify, determine", 
        example: "She was diagnosed with diabetes." 
    },
    { 
        id: 287, 
        word: "differentiate", 
        definition: "To show or find the difference between things that are compared.", 
        synonyms: "distinguish, discriminate", 
        example: "It is hard to differentiate between the two twins." 
    },
    { 
        id: 288, 
        word: "diminish", 
        definition: "To reduce or be reduced in size or importance.", 
        synonyms: "decrease, reduce", 
        example: "His influence has diminished over the years." 
    },
    { 
        id: 289, 
        word: "direct", 
        definition: "To control or be in charge of an activity, organization, etc.", 
        synonyms: "manage, lead", 
        example: "She directs a large team of engineers." 
    },
    { 
        id: 290, 
        word: "disappearance", 
        definition: "The fact of someone or something stopping being visible.", 
        synonyms: "vanishing", 
        example: "Police are investigating the disappearance of the child." 
    },
    { 
        id: 291, 
        word: "disclose", 
        definition: "To make something known publicly, or to show something that was hidden.", 
        synonyms: "reveal, expose", 
        example: "The company refused to disclose its profits." 
    },
    { 
        id: 292, 
        word: "discover", 
        definition: "To find information, a place, or an object, especially for the first time.", 
        synonyms: "find, uncover", 
        example: "Columbus discovered America." 
    },
    { 
        id: 293, 
        word: "discriminate", 
        definition: "To treat a person or particular group of people differently, especially in a worse way.", 
        synonyms: "segregate, prejudice", 
        example: "It is illegal to discriminate on the grounds of race." 
    },
    { 
        id: 294, 
        word: "discuss", 
        definition: "To talk about a subject with someone and tell each other your ideas or opinions.", 
        synonyms: "talk about, debate", 
        example: "We need to discuss this matter further." 
    },
    { 
        id: 295, 
        word: "disease", 
        definition: "Illness of people, animals, plants, etc.", 
        synonyms: "illness, sickness", 
        example: "Heart disease is a major cause of death." 
    },
    { 
        id: 296, 
        word: "dismiss", 
        definition: "To decide that something or someone is not important and not worth considering.", 
        synonyms: "reject, discard", 
        example: "He dismissed the idea as nonsense." 
    },
    { 
        id: 297, 
        word: "dismissal", 
        definition: "The situation in which an employer officially makes someone leave their job.", 
        synonyms: "firing, removal", 
        example: "He sued the company for unfair dismissal." 
    },
    { 
        id: 298, 
        word: "dispatch", 
        definition: "To send something, especially goods or a message, somewhere for a particular purpose.", 
        synonyms: "send, ship", 
        example: "Two loads of cloth were dispatched to the factory." 
    },
    { 
        id: 299, 
        word: "display", 
        definition: "To arrange something or a collection of things so that it can be seen by the public.", 
        synonyms: "show, exhibit", 
        example: "Family photographs were displayed on the wall." 
    },
    { 
        id: 300, 
        word: "displeased", 
        definition: "Angry or annoyed.", 
        synonyms: "annoyed, unhappy", 
        example: "She was displeased with the service." 
    },
{ 
        id: 301, 
        word: "dispose of", 
        definition: "To get rid of something, especially by throwing it away.", 
        synonyms: "discard, dump", 
        example: "How should I dispose of these old batteries?" 
    },
    { 
        id: 302, 
        word: "dispute", 
        definition: "An argument or disagreement, especially an official one.", 
        synonyms: "conflict, argument", 
        example: "They have been in a legal dispute for years." 
    },
    { 
        id: 303, 
        word: "disqualify", 
        definition: "To stop someone from being in a competition or doing something because they have broken a rule.", 
        synonyms: "ban, prohibit", 
        example: "He was disqualified from the race for using drugs." 
    },
    { 
        id: 304, 
        word: "disseminate", 
        definition: "To spread or give out something, especially news, information, ideas, etc., to a lot of people.", 
        synonyms: "distribute, spread", 
        example: "The organization disseminates information about health issues." 
    },
    { 
        id: 305, 
        word: "distinct", 
        definition: "Clearly noticeable; that certainly exists.", 
        synonyms: "clear, obvious", 
        example: "There is a distinct smell of gas in here." 
    },
    { 
        id: 306, 
        word: "distinguish", 
        definition: "To notice or understand the difference between two things, or to make one person or thing seem different from another.", 
        synonyms: "differentiate, separate", 
        example: "It's hard to distinguish between the twins." 
    },
    { 
        id: 307, 
        word: "distort", 
        definition: "To change something from its usual, original, natural, or intended meaning, condition, or shape.", 
        synonyms: "twist, warp", 
        example: "The media often distorts the truth." 
    },
    { 
        id: 308, 
        word: "distress", 
        definition: "A feeling of extreme worry, sadness, or pain.", 
        synonyms: "anguish, suffering", 
        example: "The news caused her a great deal of distress." 
    },
    { 
        id: 309, 
        word: "distribute", 
        definition: "To give something out to several people, or to spread or supply something.", 
        synonyms: "hand out, allocate", 
        example: "Clothes were distributed to the homeless." 
    },
    { 
        id: 310, 
        word: "divert", 
        definition: "To cause something or someone to change direction.", 
        synonyms: "redirect, deflect", 
        example: "Traffic was diverted because of the accident." 
    },
    { 
        id: 311, 
        word: "dizzy", 
        definition: "Feeling as if everything is turning around, and that you are not able to balance and may fall over.", 
        synonyms: "lightheaded, giddy", 
        example: "I felt dizzy after spinning around." 
    },
    { 
        id: 312, 
        word: "docile", 
        definition: "Quiet and easy to influence, persuade, or control.", 
        synonyms: "obedient, submissive", 
        example: "The once wild horse became docile." 
    },
    { 
        id: 313, 
        word: "dominate", 
        definition: "To have control over a place or person.", 
        synonyms: "control, rule", 
        example: "He tends to dominate the conversation." 
    },
    { 
        id: 314, 
        word: "donate", 
        definition: "To give money or goods to help a person or organization.", 
        synonyms: "give, contribute", 
        example: "They donated money to the Red Cross." 
    },
    { 
        id: 315, 
        word: "donation", 
        definition: "Money or goods that are given to help a person or organization.", 
        synonyms: "contribution, gift", 
        example: "Every donation helps us save lives." 
    },
    { 
        id: 316, 
        word: "dowry", 
        definition: "An amount of money or property that a woman's parents give to the man she marries.", 
        synonyms: "-", 
        example: "Her father gave a large dowry." 
    },
    { 
        id: 317, 
        word: "dramatic", 
        definition: "Very sudden or noticeable, or full of action and excitement.", 
        synonyms: "striking, theatrical", 
        example: "There was a dramatic change in the weather." 
    },
    { 
        id: 318, 
        word: "draw", 
        definition: "To produce a picture with a pen, pencil, etc.", 
        synonyms: "sketch, depict", 
        example: "She drew a picture of a horse." 
    },
    { 
        id: 319, 
        word: "dress code", 
        definition: "A set of rules about what you should wear in a particular place or at a particular event.", 
        synonyms: "-", 
        example: "The company has a strict dress code." 
    },
    { 
        id: 320, 
        word: "drug dealer", 
        definition: "A person who sells illegal drugs.", 
        synonyms: "-", 
        example: "Police arrested the drug dealer." 
    },
    { 
        id: 321, 
        word: "dustbin", 
        definition: "A large container for rubbish from a house or other building.", 
        synonyms: "trash can, garbage bin", 
        example: "Put the rubbish in the dustbin." 
    },
    { 
        id: 322, 
        word: "earthquake", 
        definition: "A sudden violent movement of the earth's surface.", 
        synonyms: "quake, tremor", 
        example: "The earthquake destroyed many buildings." 
    },
    { 
        id: 323, 
        word: "edit", 
        definition: "To correct or change a text, film, etc.", 
        synonyms: "revise, correct", 
        example: "I need to edit my essay before submitting it." 
    },
    { 
        id: 324, 
        word: "edition", 
        definition: "A particular form in which a book, magazine, or newspaper is published.", 
        synonyms: "version, issue", 
        example: "This is the first edition of the book." 
    },
    { 
        id: 325, 
        word: "educate", 
        definition: "To teach someone, especially using a formal system of school, college, or university.", 
        synonyms: "teach, instruct", 
        example: "Parents want to educate their children well." 
    },
    { 
        id: 326, 
        word: "effect", 
        definition: "The result of a particular influence.", 
        synonyms: "result, outcome", 
        example: "The medicine had an immediate effect." 
    },
    { 
        id: 327, 
        word: "elect", 
        definition: "To decide on or choose, especially to choose a person for a particular job, by voting.", 
        synonyms: "vote for, choose", 
        example: "He was elected as the new president." 
    },
    { 
        id: 328, 
        word: "eliminate", 
        definition: "To remove or take away someone or something.", 
        synonyms: "remove, get rid of", 
        example: "We need to eliminate unnecessary costs." 
    },
    { 
        id: 329, 
        word: "elimination", 
        definition: "The process of removing something.", 
        synonyms: "removal, exclusion", 
        example: "The elimination of poverty is a major goal." 
    },
    { 
        id: 330, 
        word: "embarrass", 
        definition: "To cause someone to feel nervous, worried, or uncomfortable.", 
        synonyms: "shame, humiliate", 
        example: "I didn't mean to embarrass you in front of everyone." 
    },
    { 
        id: 331, 
        word: "embrace", 
        definition: "To hold someone tightly with both arms to express love, liking, or sympathy, or to accept something enthusiastically.", 
        synonyms: "hug, accept", 
        example: "She embraced her son warmly." 
    },
    { 
        id: 332, 
        word: "emerge", 
        definition: "To appear by coming out of something or out from behind something.", 
        synonyms: "appear, come out", 
        example: "The sun emerged from behind the clouds." 
    },
    { 
        id: 333, 
        word: "emphasize", 
        definition: "To show that something is very important or worth giving attention to.", 
        synonyms: "highlight, stress", 
        example: "He emphasized the importance of good nutrition." 
    },
    { 
        id: 334, 
        word: "employ", 
        definition: "To have someone work or do a job for you and pay them for it.", 
        synonyms: "hire, recruit", 
        example: "The company employs 200 people." 
    },
    { 
        id: 335, 
        word: "empty", 
        definition: "Not containing any things or people.", 
        synonyms: "vacant, void", 
        example: "The glass is empty." 
    },
    { 
        id: 336, 
        word: "emulate", 
        definition: "To copy something achieved by someone else and try to do it as well as they have.", 
        synonyms: "imitate, mimic", 
        example: "He tried to emulate his father's success." 
    },
    { 
        id: 337, 
        word: "enable", 
        definition: "To make someone able to do something, or to make something possible.", 
        synonyms: "allow, permit", 
        example: "This money enabled me to buy a new car." 
    },
    { 
        id: 338, 
        word: "enclose", 
        definition: "To surround something.", 
        synonyms: "surround, circle", 
        example: "The garden is enclosed by a high wall." 
    },
    { 
        id: 339, 
        word: "encounter", 
        definition: "To meet someone unexpectedly, or to experience something unpleasant.", 
        synonyms: "meet, face", 
        example: "We encountered some problems during the project." 
    },
    { 
        id: 340, 
        word: "encourage", 
        definition: "To make someone more likely to do something, or to make something more likely to happen.", 
        synonyms: "inspire, motivate", 
        example: "My parents encouraged me to learn French." 
    },
    { 
        id: 341, 
        word: "endure", 
        definition: "To suffer something difficult, unpleasant, or painful.", 
        synonyms: "bear, tolerate", 
        example: "She endured the pain without complaining." 
    },
    { 
        id: 342, 
        word: "enhance", 
        definition: "To improve the quality, amount, or strength of something.", 
        synonyms: "improve, boost", 
        example: "These new glasses enhance my vision." 
    },
    { 
        id: 343, 
        word: "enhancement", 
        definition: "A change or addition that improves something.", 
        synonyms: "improvement", 
        example: "The software enhancement fixed the bugs." 
    },
    { 
        id: 344, 
        word: "enlarge", 
        definition: "To become bigger or to make something bigger.", 
        synonyms: "expand, increase", 
        example: "We need to enlarge the kitchen." 
    },
    { 
        id: 345, 
        word: "enquire", 
        definition: "To ask for information.", 
        synonyms: "ask, question", 
        example: "I enquired about the train times." 
    },
    { 
        id: 346, 
        word: "enslave", 
        definition: "To force someone to remain in a situation where they are not free.", 
        synonyms: "-", 
        example: "They were enslaved by the conquerors." 
    },
    { 
        id: 347, 
        word: "ensure", 
        definition: "To make something certain to happen.", 
        synonyms: "guarantee, make sure", 
        example: "Please ensure that the door is locked." 
    },
    { 
        id: 348, 
        word: "entertain", 
        definition: "To keep a group of people interested or enjoying themselves.", 
        synonyms: "amuse, delight", 
        example: "The clown entertained the children." 
    },
    { 
        id: 349, 
        word: "entirely", 
        definition: "Completely.", 
        synonyms: "wholly, totally", 
        example: "I entirely agree with you." 
    },
    { 
        id: 350, 
        word: "entrance", 
        definition: "A door, gate, etc. by which you can enter a building or place.", 
        synonyms: "entry, access", 
        example: "The main entrance is around the corner." 
    },
{ 
        id: 351, 
        word: "envy", 
        definition: "To wish that you had something that another person has.", 
        synonyms: "jealousy, covet", 
        example: "I envy her ability to talk to people so easily." 
    },
    { 
        id: 352, 
        word: "epic", 
        definition: "A film, poem, or book that is long and contains a lot of action, usually dealing with a historical subject.", 
        synonyms: "legendary, heroic", 
        example: "It was an epic journey across the mountains." 
    },
    { 
        id: 353, 
        word: "equal", 
        definition: "The same in amount, number, or size.", 
        synonyms: "identical, equivalent", 
        example: "All men are created equal." 
    },
    { 
        id: 354, 
        word: "equality", 
        definition: "The right of different groups of people to have a similar social position and receive the same treatment.", 
        synonyms: "fairness, parity", 
        example: "We are fighting for racial equality." 
    },
    { 
        id: 355, 
        word: "equate", 
        definition: "To consider one thing to be the same as or equal to another thing.", 
        synonyms: "associate, link", 
        example: "People sometimes equate money with happiness." 
    },
    { 
        id: 356, 
        word: "equip", 
        definition: "To provide a person or a place with objects that are necessary for a particular purpose.", 
        synonyms: "supply, arm", 
        example: "The soldiers were equipped with new weapons." 
    },
    { 
        id: 357, 
        word: "erode", 
        definition: "To rub or be rubbed away gradually.", 
        synonyms: "wear away, corrode", 
        example: "Wind and rain have eroded the statues." 
    },
    { 
        id: 358, 
        word: "erupt", 
        definition: "To explode or burst out suddenly.", 
        synonyms: "explode, blow up", 
        example: "The volcano erupted last night." 
    },
    { 
        id: 359, 
        word: "establish", 
        definition: "To start a company or organization that will continue for a long time.", 
        synonyms: "set up, found", 
        example: "The company was established in 1860." 
    },
    { 
        id: 360, 
        word: "estimate", 
        definition: "To guess or calculate the cost, size, value, etc. of something.", 
        synonyms: "guess, evaluate", 
        example: "They estimate that the journey will take two hours." 
    },
    { 
        id: 361, 
        word: "eternal", 
        definition: "Lasting forever or for a very long time.", 
        synonyms: "everlasting, endless", 
        example: "She promised him eternal love." 
    },
    { 
        id: 362, 
        word: "evaluate", 
        definition: "To judge or calculate the quality, importance, amount, or value of something.", 
        synonyms: "assess, appraise", 
        example: "It's impossible to evaluate these results without more information." 
    },
    { 
        id: 363, 
        word: "evaluation", 
        definition: "The process of judging or calculating the quality, importance, amount, or value of something.", 
        synonyms: "assessment, analysis", 
        example: "Evaluation of this new evidence is crucial." 
    },
    { 
        id: 364, 
        word: "evidently", 
        definition: "In a way that is easy to see.", 
        synonyms: "obviously, clearly", 
        example: "He was evidently upset by the news." 
    },
    { 
        id: 365, 
        word: "evolve", 
        definition: "To develop gradually, or to cause something or someone to develop gradually.", 
        synonyms: "develop, progress", 
        example: "The company has evolved over the years into a multi-million dollar organization." 
    },
    { 
        id: 366, 
        word: "exaggerated", 
        definition: "Seeming larger, more important, better, or worse than it really is.", 
        synonyms: "overstated, inflated", 
        example: "He made exaggerated claims about his achievements." 
    },
    { 
        id: 367, 
        word: "excavate", 
        definition: "To remove earth that is covering very old objects buried in the ground.", 
        synonyms: "dig up, unearth", 
        example: "Archaeologists are excavating the site." 
    },
    { 
        id: 368, 
        word: "exceed", 
        definition: "To be greater than a number or amount, or to go past an allowed limit.", 
        synonyms: "surpass, go beyond", 
        example: "The final cost should not exceed $5,000." 
    },
    { 
        id: 369, 
        word: "excessive", 
        definition: "Too much.", 
        synonyms: "extreme, immoderate", 
        example: "Excessive exercise can be harmful." 
    },
    { 
        id: 370, 
        word: "exchange", 
        definition: "The act of giving something to someone and them giving you something else.", 
        synonyms: "swap, trade", 
        example: "We exchanged phone numbers." 
    },
    { 
        id: 371, 
        word: "exclude", 
        definition: "To prevent someone or something from entering a place or taking part in an activity.", 
        synonyms: "keep out, ban", 
        example: "Women are still excluded from the club." 
    },
    { 
        id: 372, 
        word: "exclusive", 
        definition: "Limited to only one person or group of people.", 
        synonyms: "private, restricted", 
        example: "This room is for the exclusive use of guests." 
    },
    { 
        id: 373, 
        word: "exclusively", 
        definition: "Only.", 
        synonyms: "solely, purely", 
        example: "This offer is available exclusively to our members." 
    },
    { 
        id: 374, 
        word: "excursion", 
        definition: "A short journey usually made for pleasure, often by a group of people.", 
        synonyms: "trip, outing", 
        example: "We went on an excursion to the city center." 
    },
    { 
        id: 375, 
        word: "exhibit", 
        definition: "To show something publicly.", 
        synonyms: "display, show", 
        example: "He exhibited his paintings at the gallery." 
    },
    { 
        id: 376, 
        word: "exist", 
        definition: "To be, or to be real.", 
        synonyms: "live, survive", 
        example: "I don't think ghosts exist." 
    },
    { 
        id: 377, 
        word: "existence", 
        definition: "The fact of something or someone existing.", 
        synonyms: "being, reality", 
        example: "Many people question the existence of God." 
    },
    { 
        id: 378, 
        word: "expand", 
        definition: "To increase in size, number, or importance.", 
        synonyms: "grow, enlarge", 
        example: "They expanded their business into new markets." 
    },
    { 
        id: 379, 
        word: "expect", 
        definition: "To think or believe something will happen.", 
        synonyms: "anticipate, await", 
        example: "We are expecting a lot of visitors." 
    },
    { 
        id: 380, 
        word: "expectation", 
        definition: "The feeling that good things are going to happen in the future.", 
        synonyms: "hope, prospect", 
        example: "The holiday exceeded our expectations." 
    },
    { 
        id: 381, 
        word: "expense", 
        definition: "The use of money, time, or effort.", 
        synonyms: "cost, charge", 
        example: "We went on holiday at our own expense." 
    },
    { 
        id: 382, 
        word: "experience", 
        definition: "Knowledge or skill that comes from having done certain things.", 
        synonyms: "knowledge, skill", 
        example: "Do you have any experience working with kids?" 
    },
    { 
        id: 383, 
        word: "expire", 
        definition: "To come to an end or stop being in use.", 
        synonyms: "run out, end", 
        example: "My passport expires next month." 
    },
    { 
        id: 384, 
        word: "explode", 
        definition: "To break up into pieces violently.", 
        synonyms: "blow up, burst", 
        example: "A bomb exploded in the city center." 
    },
    { 
        id: 385, 
        word: "exploit", 
        definition: "To use something in a way that helps you.", 
        synonyms: "utilize, use", 
        example: "We need to make sure that we exploit our resources as fully as possible." 
    },
    { 
        id: 386, 
        word: "explore", 
        definition: "To search and discover (about something).", 
        synonyms: "investigate, examine", 
        example: "The best way to explore the countryside is on foot." 
    },
    { 
        id: 387, 
        word: "export", 
        definition: "To send goods to another country for sale.", 
        synonyms: "send abroad, trade", 
        example: "French cheeses are exported to many different countries." 
    },
    { 
        id: 388, 
        word: "expose", 
        definition: "To remove what is covering something so that it can be seen.", 
        synonyms: "reveal, uncover", 
        example: "The plaster on the walls has been removed to expose the original bricks." 
    },
    { 
        id: 389, 
        word: "express", 
        definition: "To show a feeling, opinion, or fact.", 
        synonyms: "state, articulate", 
        example: "I would like to express my thanks for your kindness." 
    },
    { 
        id: 390, 
        word: "extend", 
        definition: "To add to something in order to make it bigger or longer.", 
        synonyms: "prolong, stretch", 
        example: "We have planned to extend our house." 
    },
    { 
        id: 391, 
        word: "extract", 
        definition: "To remove or take out something.", 
        synonyms: "remove, pull out", 
        example: "They used torture to extract information from the prisoner." 
    },
    { 
        id: 392, 
        word: "extraordinary", 
        definition: "Very unusual, special, unexpected, or strange.", 
        synonyms: "remarkable, amazing", 
        example: "He told the extraordinary story of his escape." 
    },
    { 
        id: 393, 
        word: "fabricate", 
        definition: "To invent or produce something false in order to deceive someone.", 
        synonyms: "make up, invent", 
        example: "He was late, so he fabricated an excuse to avoid trouble." 
    },
    { 
        id: 394, 
        word: "facilitate", 
        definition: "To make something possible or easier.", 
        synonyms: "ease, assist", 
        example: "The new ramp will facilitate the entry of wheelchairs." 
    },
    { 
        id: 395, 
        word: "fade", 
        definition: "To lose colour, brightness, or strength gradually.", 
        synonyms: "dim, disappear", 
        example: "If you hang your clothes out in the bright sun, they will fade." 
    },
    { 
        id: 396, 
        word: "failure", 
        definition: "The fact of someone or something not succeeding.", 
        synonyms: "defeat, loss", 
        example: "The meeting was a complete failure." 
    },
    { 
        id: 397, 
        word: "faint", 
        definition: "To suddenly become unconscious for a short time, usually falling down.", 
        synonyms: "pass out, blackout", 
        example: "He faints at the sight of blood." 
    },
    { 
        id: 398, 
        word: "fairly", 
        definition: "More than average, but less than very.", 
        synonyms: "quite, reasonably", 
        example: "I'm fairly sure that this is the right address." 
    },
    { 
        id: 399, 
        word: "falsify", 
        definition: "To change something, such as a document, in order to deceive people.", 
        synonyms: "forge, fake", 
        example: "He was accused of falsifying employment records." 
    },
    { 
        id: 400, 
        word: "familiar", 
        definition: "Easy to recognize because of being seen, met, heard, etc. before.", 
        synonyms: "recognizable, known", 
        example: "The street was familiar to me." 
    },
{ 
        id: 401, 
        word: "famish", 
        definition: "To suffer from extreme hunger.", 
        synonyms: "starve", 
        example: "The refugees were famished after the long journey." 
    },
    { 
        id: 402, 
        word: "fare", 
        definition: "The money that you pay for a journey in a vehicle such as a bus or train.", 
        synonyms: "price, ticket price", 
        example: "Train fares have increased again." 
    },
    { 
        id: 403, 
        word: "fatal", 
        definition: "Causing death.", 
        synonyms: "deadly, lethal", 
        example: "He suffered a fatal injury." 
    },
    { 
        id: 404, 
        word: "favourable", 
        definition: "Giving you an advantage or more chance of success.", 
        synonyms: "positive, advantageous", 
        example: "The weather conditions are favourable for sailing." 
    },
    { 
        id: 405, 
        word: "fearful", 
        definition: "Frightened or worried about something.", 
        synonyms: "scared, afraid", 
        example: "She was fearful of the dark." 
    },
    { 
        id: 406, 
        word: "fertilize", 
        definition: "To spread a natural or chemical substance on land or plants to make them grow well.", 
        synonyms: "feed, enrich", 
        example: "Farmers use manure to fertilize their fields." 
    },
    { 
        id: 407, 
        word: "fetch", 
        definition: "To go to another place to get something or someone and bring it, him, or her back.", 
        synonyms: "get, bring", 
        example: "Could you fetch me a glass of water?" 
    },
    { 
        id: 408, 
        word: "fiancé", 
        definition: "The man who a woman is engaged to be married to.", 
        synonyms: "future husband", 
        example: "She introduced her fiancé to her parents." 
    },
    { 
        id: 409, 
        word: "fiancée", 
        definition: "The woman who a man is engaged to be married to.", 
        synonyms: "future wife", 
        example: "He bought a ring for his fiancée." 
    },
    { 
        id: 410, 
        word: "field trip", 
        definition: "A visit made by students to study something away from their school.", 
        synonyms: "excursion, outing", 
        example: "We went on a geography field trip to the mountains." 
    },
    { 
        id: 411, 
        word: "fierce", 
        definition: "Physically violent and frightening.", 
        synonyms: "ferocious, intense", 
        example: "The lion looked fierce." 
    },
    { 
        id: 412, 
        word: "figure", 
        definition: "A number or an amount.", 
        synonyms: "number, digit", 
        example: "The unemployment figure is rising." 
    },
    { 
        id: 413, 
        word: "filthy", 
        definition: "Extremely dirty.", 
        synonyms: "dirty, grimy", 
        example: "Wash your hands, they're filthy!" 
    },
    { 
        id: 414, 
        word: "finance", 
        definition: "To provide the money needed for something to happen.", 
        synonyms: "fund, subsidize", 
        example: "The project was financed by the government." 
    },
    { 
        id: 415, 
        word: "fine", 
        definition: "An amount of money that has to be paid as a punishment for not obeying a rule or law.", 
        synonyms: "penalty, fee", 
        example: "I got a parking fine yesterday." 
    },
    { 
        id: 416, 
        word: "firework", 
        definition: "A small container filled with explosive chemicals that produces bright coloured patterns or loud noises when it explodes.", 
        synonyms: "-", 
        example: "We watched the firework display at midnight." 
    },
    { 
        id: 417, 
        word: "fit", 
        definition: "Healthy and strong, especially as a result of exercise.", 
        synonyms: "healthy, robust", 
        example: "He runs every day to keep fit." 
    },
    { 
        id: 418, 
        word: "flatmate", 
        definition: "A person who shares an apartment with another person.", 
        synonyms: "roommate", 
        example: "My flatmate is very messy." 
    },
    { 
        id: 419, 
        word: "flattery", 
        definition: "The act of praising someone, often in a way that is not sincere.", 
        synonyms: "adulation, praise", 
        example: "He tried to win her over with flattery." 
    },
    { 
        id: 420, 
        word: "flee", 
        definition: "To escape by running away, especially because of danger or fear.", 
        synonyms: "escape, run away", 
        example: "Thousands of people fled the war zone." 
    },
    { 
        id: 421, 
        word: "fleece", 
        definition: "The thick covering of wool on a sheep.", 
        synonyms: "wool", 
        example: "The sheep are shorn of their fleece in spring." 
    },
    { 
        id: 422, 
        word: "flight", 
        definition: "A journey in an aircraft.", 
        synonyms: "trip, journey", 
        example: "The flight to New York takes eight hours." 
    },
    { 
        id: 423, 
        word: "flow", 
        definition: "To move in one direction, especially continuously and easily.", 
        synonyms: "stream, run", 
        example: "The river flows into the sea." 
    },
    { 
        id: 424, 
        word: "fluctuate", 
        definition: "To change, especially continuously and between one level or thing and another.", 
        synonyms: "vary, waver", 
        example: "Vegetable prices fluctuate according to the season." 
    },
    { 
        id: 425, 
        word: "focus on", 
        definition: "To give a lot of attention to one particular person, subject, or thing.", 
        synonyms: "concentrate on", 
        example: "Today's lesson will focus on grammar." 
    },
    { 
        id: 426, 
        word: "fold", 
        definition: "To bend something, especially paper or cloth, so that one part of it lies on the other part.", 
        synonyms: "bend, crease", 
        example: "Fold the paper in half." 
    },
    { 
        id: 427, 
        word: "force", 
        definition: "To make something happen or make someone do something difficult, unpleasant, or unusual.", 
        synonyms: "compel, coerce", 
        example: "You can't force her to make a decision." 
    },
    { 
        id: 428, 
        word: "forceful", 
        definition: "Expressing opinions strongly and demanding attention or action.", 
        synonyms: "strong, powerful", 
        example: "She has a very forceful personality." 
    },
    { 
        id: 429, 
        word: "forecast", 
        definition: "A statement of what is judged likely to happen in the future.", 
        synonyms: "prediction, projection", 
        example: "The weather forecast predicts rain." 
    },
    { 
        id: 430, 
        word: "forge", 
        definition: "To make an illegal copy of something in order to deceive.", 
        synonyms: "falsify, counterfeit", 
        example: "He was caught trying to forge a signature." 
    },
    { 
        id: 431, 
        word: "forgery", 
        definition: "An illegal copy of a document, painting, etc.", 
        synonyms: "fake, counterfeit", 
        example: "The painting was revealed to be a forgery." 
    },
    { 
        id: 432, 
        word: "former", 
        definition: "Of or in an earlier time; before the present time or in the past.", 
        synonyms: "previous, ex-", 
        example: "He is a former president of the company." 
    },
    { 
        id: 433, 
        word: "formerly", 
        definition: "In the past.", 
        synonyms: "previously", 
        example: "Istanbul was formerly known as Constantinople." 
    },
    { 
        id: 434, 
        word: "formulate", 
        definition: "To develop all the details of a plan for doing something.", 
        synonyms: "devise, develop", 
        example: "They formulated a plan to save the company." 
    },
    { 
        id: 435, 
        word: "forthcoming", 
        definition: "Happening soon.", 
        synonyms: "upcoming, imminent", 
        example: "We are preparing for the forthcoming elections." 
    },
    { 
        id: 436, 
        word: "fortify", 
        definition: "To make something stronger, especially in order to protect it.", 
        synonyms: "strengthen, reinforce", 
        example: "They fortified the castle against attack." 
    },
    { 
        id: 437, 
        word: "fracture", 
        definition: "If a bone fractures, it breaks or cracks.", 
        synonyms: "break, crack", 
        example: "She suffered a skull fracture." 
    },
    { 
        id: 438, 
        word: "frail", 
        definition: "Weak or unhealthy, or easily damaged, broken, or harmed.", 
        synonyms: "weak, fragile", 
        example: "She looked old and frail." 
    },
    { 
        id: 439, 
        word: "frame", 
        definition: "A border that surrounds and supports a picture, door, or window.", 
        synonyms: "casing, border", 
        example: "I bought a nice frame for the photo." 
    },
    { 
        id: 440, 
        word: "freed", 
        definition: "Released from captivity or slavery.", 
        synonyms: "liberated, released", 
        example: "The freed hostages returned home." 
    },
    { 
        id: 441, 
        word: "fulfil", 
        definition: "To do something that is expected, hoped for, or promised.", 
        synonyms: "achieve, accomplish", 
        example: "He finally fulfilled his dream of becoming a doctor." 
    },
    { 
        id: 442, 
        word: "fundamental", 
        definition: "Forming the base, from which everything else develops.", 
        synonyms: "basic, essential", 
        example: "Freedom of speech is a fundamental right." 
    },
    { 
        id: 443, 
        word: "funeral", 
        definition: "A ceremony for burying or burning the body of a dead person.", 
        synonyms: "burial", 
        example: "The funeral will be held on Friday." 
    },
    { 
        id: 444, 
        word: "fussy", 
        definition: "Not easily satisfied, or having very high standards about particular things.", 
        synonyms: "choosy, picky", 
        example: "He is very fussy about his food." 
    },
    { 
        id: 445, 
        word: "fuzzy", 
        definition: "Not clear.", 
        synonyms: "blurred, unclear", 
        example: "The image on the TV was fuzzy." 
    },
    { 
        id: 446, 
        word: "gather", 
        definition: "To collect several things, often from different places or people.", 
        synonyms: "collect, assemble", 
        example: "She gathered flowers from the garden." 
    },
    { 
        id: 447, 
        word: "gender", 
        definition: "The physical and/or social condition of being male or female.", 
        synonyms: "sex", 
        example: "Discrimination based on gender is illegal." 
    },
    { 
        id: 448, 
        word: "generate", 
        definition: "To cause something to exist.", 
        synonyms: "create, produce", 
        example: "The new project will generate jobs." 
    },
    { 
        id: 449, 
        word: "genre", 
        definition: "A style, especially in the arts, that involves a particular set of characteristics.", 
        synonyms: "type, category", 
        example: "What is your favorite music genre?" 
    },
    { 
        id: 450, 
        word: "get rid of", 
        definition: "To remove or throw away something unwanted.", 
        synonyms: "eliminate, dispose of", 
        example: "I need to get rid of these old clothes." 
    },
{ 
        id: 451, 
        word: "giant", 
        definition: "An imaginary creature like a man but extremely tall and strong.", 
        synonyms: "huge, colossal", 
        example: "He took giant steps to reach the door." 
    },
    { 
        id: 452, 
        word: "give up", 
        definition: "To stop trying to do something before you have finished.", 
        synonyms: "quit, surrender", 
        example: "Don't give up on your dreams." 
    },
    { 
        id: 453, 
        word: "glance", 
        definition: "To give a quick short look.", 
        synonyms: "peek, glimpse", 
        example: "She glanced at her watch." 
    },
    { 
        id: 454, 
        word: "gloom", 
        definition: "Feelings of great unhappiness and loss of hope.", 
        synonyms: "sadness, darkness", 
        example: "The news cast a gloom over the village." 
    },
    { 
        id: 455, 
        word: "glorify", 
        definition: "To praise or honor someone or something.", 
        synonyms: "praise, exalt", 
        example: "The movie glorifies violence." 
    },
    { 
        id: 456, 
        word: "goal", 
        definition: "An aim or purpose.", 
        synonyms: "aim, objective", 
        example: "My main goal is to learn English." 
    },
    { 
        id: 457, 
        word: "govern", 
        definition: "To control and direct the public business of a country, city, group of people, etc.", 
        synonyms: "rule, control", 
        example: "The country is governed by a coalition." 
    },
    { 
        id: 458, 
        word: "government", 
        definition: "The group of people with the authority to govern a country or state.", 
        synonyms: "administration, regime", 
        example: "The government has announced new taxes." 
    },
    { 
        id: 459, 
        word: "grab", 
        definition: "To take hold of something or someone suddenly and roughly.", 
        synonyms: "seize, snatch", 
        example: "He grabbed his keys and left." 
    },
    { 
        id: 460, 
        word: "gradually", 
        definition: "Slowly over a period of time or a distance.", 
        synonyms: "slowly, steadily", 
        example: "The situation is gradually improving." 
    },
    { 
        id: 461, 
        word: "grant", 
        definition: "To give or allow someone something, usually in an official way.", 
        synonyms: "allow, award", 
        example: "They granted him a visa." 
    },
    { 
        id: 462, 
        word: "grasp", 
        definition: "To quickly take something in your hand(s) and hold it firmly.", 
        synonyms: "grip, hold", 
        example: "He grasped my hand firmly." 
    },
    { 
        id: 463, 
        word: "graveyard", 
        definition: "A place, often next to a church, where dead people are buried.", 
        synonyms: "cemetery, burial ground", 
        example: "It was quiet in the graveyard." 
    },
    { 
        id: 464, 
        word: "groom", 
        definition: "A man who is about to get married or has just got married.", 
        synonyms: "bridegroom", 
        example: "The groom looked nervous." 
    },
    { 
        id: 465, 
        word: "grow tired of", 
        definition: "To become bored or impatient with something.", 
        synonyms: "become fed up", 
        example: "I grew tired of his constant complaining." 
    },
    { 
        id: 466, 
        word: "growl", 
        definition: "To make a low, rough sound, usually in anger.", 
        synonyms: "snarl, rumble", 
        example: "The dog growled at the stranger." 
    },
    { 
        id: 467, 
        word: "guide", 
        definition: "To show someone how to do something difficult.", 
        synonyms: "lead, direct", 
        example: "He guided us through the museum." 
    },
    { 
        id: 468, 
        word: "harass", 
        definition: "To continue to annoy or upset someone over a period of time.", 
        synonyms: "bother, pester", 
        example: "Stop harassing me!" 
    },
    { 
        id: 469, 
        word: "harbour", 
        definition: "An area of water next to the coast, often protected from the sea by a thick wall, where ships and boats can shelter.", 
        synonyms: "port, dock", 
        example: "The boat sailed into the harbour." 
    },
    { 
        id: 470, 
        word: "hardship", 
        definition: "Something that causes difficult or unpleasant conditions of life.", 
        synonyms: "suffering, difficulty", 
        example: "The war caused great hardship." 
    },
    { 
        id: 471, 
        word: "harshly", 
        definition: "In an unkind or severe way.", 
        synonyms: "severely, roughly", 
        example: "He was treated harshly by the guards." 
    },
    { 
        id: 472, 
        word: "hasten", 
        definition: "To make something happen sooner or more quickly.", 
        synonyms: "hurry, accelerate", 
        example: "We must hasten our departure." 
    },
    { 
        id: 473, 
        word: "havoc", 
        definition: "Confusion and lack of order, especially causing damage or trouble.", 
        synonyms: "chaos, destruction", 
        example: "The storm wreaked havoc on the city." 
    },
    { 
        id: 474, 
        word: "hazard", 
        definition: "Something that is dangerous and likely to cause damage.", 
        synonyms: "danger, risk", 
        example: "Smoking is a health hazard." 
    },
    { 
        id: 475, 
        word: "hazardous", 
        definition: "Dangerous.", 
        synonyms: "risky, unsafe", 
        example: "These chemicals are hazardous to health." 
    },
    { 
        id: 476, 
        word: "hectic", 
        definition: "Full of activity, or very busy and fast.", 
        synonyms: "busy, frantic", 
        example: "I had a hectic day at the office." 
    },
    { 
        id: 477, 
        word: "hesitate", 
        definition: "To pause before you do or say something, often because you are uncertain or nervous about it.", 
        synonyms: "pause, waver", 
        example: "Don't hesitate to call me." 
    },
    { 
        id: 478, 
        word: "highly", 
        definition: "Very, to a large degree, or at a high level.", 
        synonyms: "extremely, very", 
        example: "It is highly likely that it will rain." 
    },
    { 
        id: 479, 
        word: "hinder", 
        definition: "To limit the ability of someone to do something.", 
        synonyms: "obstruct, impede", 
        example: "High winds hindered the rescue attempt." 
    },
    { 
        id: 480, 
        word: "hire", 
        definition: "To employ someone or pay to use something for a short period.", 
        synonyms: "employ, rent", 
        example: "We hired a car for the weekend." 
    },
    { 
        id: 481, 
        word: "hitchhiker", 
        definition: "Someone who travels by getting free rides in someone else's vehicle.", 
        synonyms: "-", 
        example: "We picked up a hitchhiker on the way." 
    },
    { 
        id: 482, 
        word: "hollow", 
        definition: "Having a hole or empty space inside.", 
        synonyms: "empty, void", 
        example: "The tree trunk was hollow." 
    },
    { 
        id: 483, 
        word: "hopefully", 
        definition: "Used, often at the start of a sentence, to express what you would like to happen.", 
        synonyms: "optimistically", 
        example: "Hopefully, we will arrive on time." 
    },
    { 
        id: 484, 
        word: "horrible", 
        definition: "Very unpleasant or bad.", 
        synonyms: "terrible, awful", 
        example: "The coffee tasted horrible." 
    },
    { 
        id: 485, 
        word: "huge", 
        definition: "Extremely large in size or amount.", 
        synonyms: "enormous, massive", 
        example: "There was a huge crowd at the concert." 
    },
    { 
        id: 486, 
        word: "humiliate", 
        definition: "To make someone feel ashamed or lose respect for himself or herself.", 
        synonyms: "embarrass, shame", 
        example: "He humiliated his opponent in the debate." 
    },
    { 
        id: 487, 
        word: "hunter", 
        definition: "A person or animal that hunts animals for food or for sport.", 
        synonyms: "-", 
        example: "The lion is a skilled hunter." 
    },
    { 
        id: 488, 
        word: "hurricane", 
        definition: "A violent wind that has a circular movement.", 
        synonyms: "cyclone, typhoon", 
        example: "The hurricane destroyed many houses." 
    },
    { 
        id: 489, 
        word: "iceberg", 
        definition: "A very large mass of ice that floats in the sea.", 
        synonyms: "-", 
        example: "The Titanic hit an iceberg." 
    },
    { 
        id: 490, 
        word: "identify", 
        definition: "To recognize someone or something and say or prove who or what that person or thing is.", 
        synonyms: "recognize, pinpoint", 
        example: "Can you identify the man in the picture?" 
    },
    { 
        id: 491, 
        word: "idle", 
        definition: "Not working or being used.", 
        synonyms: "inactive, lazy", 
        example: "The machines have been idle for weeks." 
    },
    { 
        id: 492, 
        word: "ignore", 
        definition: "To intentionally not listen or give attention to.", 
        synonyms: "disregard, neglect", 
        example: "He ignored my advice." 
    },
    { 
        id: 493, 
        word: "illusion", 
        definition: "An idea or belief that is not true.", 
        synonyms: "delusion, mirage", 
        example: "He is under the illusion that I am rich." 
    },
    { 
        id: 494, 
        word: "illustrate", 
        definition: "To draw pictures for a book, magazine, etc.", 
        synonyms: "demonstrate, depict", 
        example: "The book is illustrated with beautiful photographs." 
    },
    { 
        id: 495, 
        word: "imagine", 
        definition: "To form or have a mental picture or idea of something.", 
        synonyms: "visualize, envision", 
        example: "Imagine you are on a tropical island." 
    },
    { 
        id: 496, 
        word: "imitate", 
        definition: "To behave in a similar way to someone or something else.", 
        synonyms: "copy, mimic", 
        example: "Children often imitate their parents." 
    },
    { 
        id: 497, 
        word: "immediate", 
        definition: "Happening or done without delay.", 
        synonyms: "instant, prompt", 
        example: "We need an immediate decision." 
    },
    { 
        id: 498, 
        word: "immobilize", 
        definition: "To stop something or someone from moving.", 
        synonyms: "paralyze, disable", 
        example: "The broken leg was immobilized with a cast." 
    },
    { 
        id: 499, 
        word: "impact", 
        definition: "The force or action of one object hitting another.", 
        synonyms: "effect, collision", 
        example: "The impact of the crash was severe." 
    },
    { 
        id: 500, 
        word: "impeach", 
        definition: "To make a formal statement saying that a public official is guilty of a serious offence.", 
        synonyms: "indict, charge", 
        example: "The president was impeached for misconduct." 
    },
{ 
        id: 501, 
        word: "implement", 
        definition: "To start using a plan or system.", 
        synonyms: "execute, apply", 
        example: "The changes to the national health system will be implemented next year." 
    },
    { 
        id: 502, 
        word: "implicate", 
        definition: "To show that someone is involved in a crime or partly responsible for something bad that has happened.", 
        synonyms: "incriminate, involve", 
        example: "He tried to avoid saying anything that would implicate him further." 
    },
    { 
        id: 503, 
        word: "imply", 
        definition: "To communicate an idea or feeling without saying it directly.", 
        synonyms: "suggest, hint", 
        example: "Are you implying that I am fat?" 
    },
    { 
        id: 504, 
        word: "impose", 
        definition: "To officially force a rule, tax, punishment, etc. to be obeyed or received.", 
        synonyms: "enforce, inflict", 
        example: "The council has imposed a ban on alcohol in the city parks." 
    },
    { 
        id: 505, 
        word: "imprisonment", 
        definition: "The act of putting someone in prison or the condition of being kept in prison.", 
        synonyms: "incarceration, confinement", 
        example: "He was sentenced to life imprisonment." 
    },
    { 
        id: 506, 
        word: "improve", 
        definition: "To get better, or to make something better.", 
        synonyms: "enhance, upgrade", 
        example: "I thought the best way to improve my French was to live in France." 
    },
    { 
        id: 507, 
        word: "inaudible", 
        definition: "Unable to be heard.", 
        synonyms: "silent, unheard", 
        example: "The noise of the machinery made his voice inaudible." 
    },
    { 
        id: 508, 
        word: "incapable (of)", 
        definition: "Unable to do something.", 
        synonyms: "unable, incompetent", 
        example: "He seems incapable of walking past a music shop without going in." 
    },
    { 
        id: 509, 
        word: "incapacitate", 
        definition: "To make someone unable to work or do things normally, or unable to do what they intended to do.", 
        synonyms: "disable, cripple", 
        example: "The accident incapacitated him for six months." 
    },
    { 
        id: 510, 
        word: "incessant", 
        definition: "Never stopping, especially in an annoying or unpleasant way.", 
        synonyms: "constant, continuous", 
        example: "The incessant noise from the construction site drove me crazy." 
    },
    { 
        id: 511, 
        word: "incline", 
        definition: "To (make someone) feel something or want to do something.", 
        synonyms: "tend, lean", 
        example: "The prime minister is believed to be inclining towards an April election." 
    },
    { 
        id: 512, 
        word: "include", 
        definition: "To contain something as a part of something else.", 
        synonyms: "contain, involve", 
        example: "The bill includes tax and service." 
    },
    { 
        id: 513, 
        word: "incorporate (into)", 
        definition: "To include something as part of something larger.", 
        synonyms: "integrate, combine", 
        example: "Suggestions from the survey have been incorporated into the final design." 
    },
    { 
        id: 514, 
        word: "incredible", 
        definition: "Impossible, or very difficult, to believe.", 
        synonyms: "unbelievable, amazing", 
        example: "It seems incredible that no one foresaw the crisis." 
    },
    { 
        id: 515, 
        word: "indicate", 
        definition: "To show, point, or make clear in another way.", 
        synonyms: "show, signal", 
        example: "Please indicate which free gift you would like to receive." 
    },
    { 
        id: 516, 
        word: "indifference (to)", 
        definition: "Lack of interest in someone or something.", 
        synonyms: "apathy, unconcern", 
        example: "His total indifference to what people thought of him was amazing." 
    },
    { 
        id: 517, 
        word: "induce", 
        definition: "To persuade someone to do something.", 
        synonyms: "persuade, cause", 
        example: "Nothing could induce me to climb a mountain." 
    },
    { 
        id: 518, 
        word: "inevitable", 
        definition: "Certain to happen and unable to be avoided or prevented.", 
        synonyms: "unavoidable, inescapable", 
        example: "The accident was the inevitable consequence of carelessness." 
    },
    { 
        id: 519, 
        word: "infer", 
        definition: "To form an opinion or guess that something is true because of the information that you have.", 
        synonyms: "deduce, conclude", 
        example: "What do you infer from her refusal?" 
    },
    { 
        id: 520, 
        word: "influence", 
        definition: "The power to have an effect on people or things.", 
        synonyms: "impact, effect", 
        example: "He has a huge amount of influence over the city council." 
    },
    { 
        id: 521, 
        word: "influential", 
        definition: "Having a lot of influence on someone or something.", 
        synonyms: "powerful, dominant", 
        example: "She wanted to work for a bigger and more influential newspaper." 
    },
    { 
        id: 522, 
        word: "inherit", 
        definition: "To receive money, a house, etc. from someone after they have died.", 
        synonyms: "receive, be left", 
        example: "She inherited a fortune from her grandmother." 
    },
    { 
        id: 523, 
        word: "inhibit", 
        definition: "To prevent someone from doing something by making them feel nervous or embarrassed.", 
        synonyms: "restrain, hinder", 
        example: "Fear can inhibit people from expressing their opinions." 
    },
    { 
        id: 524, 
        word: "initially", 
        definition: "At the beginning.", 
        synonyms: "at first, originally", 
        example: "Initially, I didn't want to go." 
    },
    { 
        id: 525, 
        word: "initiate", 
        definition: "To cause something to begin.", 
        synonyms: "start, launch", 
        example: "Who initiated the violence?" 
    },
    { 
        id: 526, 
        word: "injure", 
        definition: "To hurt or cause physical harm to a person or animal.", 
        synonyms: "hurt, wound", 
        example: "She was injured in a car accident." 
    },
    { 
        id: 527, 
        word: "injustice", 
        definition: "A situation in which there is no fairness and justice.", 
        synonyms: "unfairness, wrong", 
        example: "They were protesting against the injustice of the legal system." 
    },
    { 
        id: 528, 
        word: "innovate", 
        definition: "To introduce changes and new ideas.", 
        synonyms: "invent, create", 
        example: "The fashion industry is always desperate to innovate." 
    },
    { 
        id: 529, 
        word: "innovation", 
        definition: "A new idea or method.", 
        synonyms: "novelty, invention", 
        example: "The latest innovation in computer technology." 
    },
    { 
        id: 530, 
        word: "innovative", 
        definition: "Using new methods or ideas.", 
        synonyms: "creative, original", 
        example: "She was an imaginative and innovative manager." 
    },
    { 
        id: 531, 
        word: "insatiable", 
        definition: "Too great to be satisfied.", 
        synonyms: "greedy, ravenous", 
        example: "He has an insatiable appetite for knowledge." 
    },
    { 
        id: 532, 
        word: "insignificant", 
        definition: "Small or not noticeable, and therefore not considered important.", 
        synonyms: "unimportant, trivial", 
        example: "The difference between the two results was insignificant." 
    },
    { 
        id: 533, 
        word: "insist (on)", 
        definition: "To state or demand forcefully, especially despite opposition.", 
        synonyms: "persist, demand", 
        example: "She insisted on seeing her lawyer." 
    },
    { 
        id: 534, 
        word: "inspect", 
        definition: "To look at something or someone carefully in order to discover information.", 
        synonyms: "examine, check", 
        example: "After the crash both cars were inspected for damage." 
    },
    { 
        id: 535, 
        word: "instantaneously", 
        definition: "In a way that happens immediately, without any delay.", 
        synonyms: "immediately, instantly", 
        example: "The driver was killed instantaneously." 
    },
    { 
        id: 536, 
        word: "institute", 
        definition: "An organization where people do a particular type of scientific, educational, or social work.", 
        synonyms: "organization, establishment", 
        example: "The National Institute of Health." 
    },
    { 
        id: 537, 
        word: "instruct", 
        definition: "To order or tell someone to do something, especially in a formal way.", 
        synonyms: "teach, command", 
        example: "The police have been instructed to patrol the building." 
    },
    { 
        id: 538, 
        word: "insulate", 
        definition: "To cover and surround something with a material or substance in order to stop heat, sound, or electricity from escaping or entering.", 
        synonyms: "protect, cover", 
        example: "You can insulate a house against heat loss." 
    },
    { 
        id: 539, 
        word: "integrate", 
        definition: "To mix with and join society or a group of people, often changing to suit their way of life, habits, and customs.", 
        synonyms: "combine, merge", 
        example: "He seems to find it difficult to integrate socially." 
    },
    { 
        id: 540, 
        word: "intelligence", 
        definition: "The ability to learn, understand, and make judgments or have opinions that are based on reason.", 
        synonyms: "intellect, wit", 
        example: "It's the intelligence of her writing that impresses me." 
    },
    { 
        id: 541, 
        word: "intention", 
        definition: "Something that you want and plan to do.", 
        synonyms: "aim, purpose", 
        example: "I've no intention of changing my plans." 
    },
    { 
        id: 542, 
        word: "intentional", 
        definition: "Planned or intended.", 
        synonyms: "deliberate, calculated", 
        example: "I'm sorry I ignored you, it wasn't intentional." 
    },
    { 
        id: 543, 
        word: "interaction", 
        definition: "An occasion when two or more people or things communicate with or react to each other.", 
        synonyms: "communication, contact", 
        example: "There's not enough interaction between the management and the workers." 
    },
    { 
        id: 544, 
        word: "interfere", 
        definition: "To involve yourself in a situation when your involvement is not wanted or is not helpful.", 
        synonyms: "meddle, intrude", 
        example: "It's their problem and I'm not going to interfere." 
    },
    { 
        id: 545, 
        word: "interfere with", 
        definition: "To prevent something from working effectively or from developing successfully.", 
        synonyms: "hinder, obstruct", 
        example: "Even a low level of noise interferes with my concentration." 
    },
    { 
        id: 546, 
        word: "interpretation", 
        definition: "An explanation or opinion of what something means.", 
        synonyms: "explanation, reading", 
        example: "The dispute is based on two differing interpretations of the law." 
    },
    { 
        id: 547, 
        word: "interrogate", 
        definition: "To ask someone a lot of questions for a long time in order to get information, sometimes using threats or violence.", 
        synonyms: "question, examine", 
        example: "Thousands of dissidents have been interrogated or imprisoned in recent weeks." 
    },
    { 
        id: 548, 
        word: "interview", 
        definition: "A meeting in which someone asks you questions to see if you are suitable for a job or course.", 
        synonyms: "-", 
        example: "I have a job interview tomorrow." 
    },
    { 
        id: 549, 
        word: "intimate", 
        definition: "Having, or being likely to cause, a very close friendship or personal or sexual relationship.", 
        synonyms: "close, familiar", 
        example: "Intimate relationships." 
    },
    { 
        id: 550, 
        word: "introduce", 
        definition: "To tell someone another person's name the first time that they meet.", 
        synonyms: "present, acquaint", 
        example: "I'd like to introduce my son, Mark." 
    },
{ 
        id: 551, 
        word: "invade", 
        definition: "To enter a country by force with large numbers of soldiers in order to take possession of it.", 
        synonyms: "occupy, conquer", 
        example: "The army prepared to invade the neighboring country." 
    },
    { 
        id: 552, 
        word: "invaluable", 
        definition: "Extremely useful.", 
        synonyms: "priceless, indispensable", 
        example: "Her advice was invaluable to the project." 
    },
    { 
        id: 553, 
        word: "invent", 
        definition: "To design and/or create something that has never been made before.", 
        synonyms: "create, devise", 
        example: "Alexander Graham Bell invented the telephone." 
    },
    { 
        id: 554, 
        word: "invest", 
        definition: "To put money, effort, time, etc. into something to make a profit or get an advantage.", 
        synonyms: "fund, spend", 
        example: "He invested all his savings in the new business." 
    },
    { 
        id: 555, 
        word: "investigate", 
        definition: "To examine a crime, problem, statement, etc. carefully, especially to discover the truth.", 
        synonyms: "examine, research", 
        example: "Police are investigating the cause of the accident." 
    },
    { 
        id: 556, 
        word: "invoke", 
        definition: "To call on something or someone for help or inspiration.", 
        synonyms: "call upon, appeal to", 
        example: "She invoked the memory of her ancestors." 
    },
    { 
        id: 557, 
        word: "involve", 
        definition: "To include someone or something in an activity.", 
        synonyms: "entail, include", 
        example: "The job involves a lot of traveling." 
    },
    { 
        id: 558, 
        word: "involvement", 
        definition: "The act or process of taking part in something.", 
        synonyms: "participation, engagement", 
        example: "His involvement in the project was crucial." 
    },
    { 
        id: 559, 
        word: "irregularity", 
        definition: "The state or fact of not being regular or continuous.", 
        synonyms: "abnormality, anomaly", 
        example: "There were some irregularities in the voting process." 
    },
    { 
        id: 560, 
        word: "isolate", 
        definition: "To separate something from other things with which it is connected or mixed.", 
        synonyms: "separate, segregate", 
        example: "They isolated the infected patients." 
    },
    { 
        id: 561, 
        word: "jeopardize", 
        definition: "To put something such as a plan or system in danger of being harmed or damaged.", 
        synonyms: "endanger, risk", 
        example: "Bad weather could jeopardize the mission." 
    },
    { 
        id: 562, 
        word: "join", 
        definition: "To connect or fasten things together.", 
        synonyms: "connect, unite", 
        example: "We should join the two tables together." 
    },
    { 
        id: 563, 
        word: "joint", 
        definition: "Belonging to or shared between two or more people.", 
        synonyms: "shared, mutual", 
        example: "It was a joint effort by the whole team." 
    },
    { 
        id: 564, 
        word: "justify", 
        definition: "To show that something is reasonable, right, or true.", 
        synonyms: "validate, defend", 
        example: "He tried to justify his rude behavior." 
    },
    { 
        id: 565, 
        word: "kennel", 
        definition: "A small house for a dog.", 
        synonyms: "doghouse", 
        example: "The dog slept in its kennel outside." 
    },
    { 
        id: 566, 
        word: "keyhole", 
        definition: "The hole in a lock that you put a key into.", 
        synonyms: "-", 
        example: "He peeped through the keyhole." 
    },
    { 
        id: 567, 
        word: "kidnapper", 
        definition: "A person who takes someone away by force and demands money for their return.", 
        synonyms: "abductor", 
        example: "The kidnapper demanded a ransom." 
    },
    { 
        id: 568, 
        word: "knock", 
        definition: "To repeatedly hit something, producing a noise.", 
        synonyms: "hit, strike", 
        example: "Someone is knocking at the door." 
    },
    { 
        id: 569, 
        word: "knowledge", 
        definition: "Understanding of or information about a subject that you get by experience or study.", 
        synonyms: "wisdom, understanding", 
        example: "He has a deep knowledge of history." 
    },
    { 
        id: 570, 
        word: "label", 
        definition: "A piece of paper or other material that gives you information about the object it is attached to.", 
        synonyms: "tag, sticker", 
        example: "Read the label on the bottle." 
    },
    { 
        id: 571, 
        word: "lamb", 
        definition: "A young sheep, or the flesh of this animal eaten as meat.", 
        synonyms: "-", 
        example: "We had roast lamb for dinner." 
    },
    { 
        id: 572, 
        word: "latter", 
        definition: "Near or towards the end of something.", 
        synonyms: "last, later", 
        example: "The latter part of the book was boring." 
    },
    { 
        id: 573, 
        word: "lawyer", 
        definition: "Someone whose job is to give advice to people about the law and speak for them in court.", 
        synonyms: "attorney, solicitor", 
        example: "She wants to be a lawyer." 
    },
    { 
        id: 574, 
        word: "leak", 
        definition: "To allow liquid or gas to escape from a hole or crack.", 
        synonyms: "drip, seep", 
        example: "The roof is leaking." 
    },
    { 
        id: 575, 
        word: "legend", 
        definition: "A very old story or set of stories from ancient times.", 
        synonyms: "myth, tale", 
        example: "The legend of King Arthur is famous." 
    },
    { 
        id: 576, 
        word: "legislate", 
        definition: "To make a law or laws.", 
        synonyms: "enact, ordain", 
        example: "The government promised to legislate against discrimination." 
    },
    { 
        id: 577, 
        word: "leisure", 
        definition: "The time when you are not working or doing other duties.", 
        synonyms: "free time, spare time", 
        example: "I don't have much leisure time these days." 
    },
    { 
        id: 578, 
        word: "lessen", 
        definition: "To become or make something smaller in amount or degree.", 
        synonyms: "reduce, decrease", 
        example: "The pain began to lessen after taking the medicine." 
    },
    { 
        id: 579, 
        word: "levy", 
        definition: "To officially force people to pay a tax or other amount of money.", 
        synonyms: "impose, charge", 
        example: "A new tax was levied on luxury goods." 
    },
    { 
        id: 580, 
        word: "likewise", 
        definition: "In the same way.", 
        synonyms: "similarly, also", 
        example: "Watch him and do likewise." 
    },
    { 
        id: 581, 
        word: "listless", 
        definition: "Having no energy and enthusiasm and unwilling to do anything needing effort.", 
        synonyms: "lethargic, sluggish", 
        example: "He's been feeling listless lately." 
    },
    { 
        id: 582, 
        word: "literacy", 
        definition: "The ability to read and write.", 
        synonyms: "-", 
        example: "The literacy rate has improved significantly." 
    },
    { 
        id: 583, 
        word: "litter", 
        definition: "Small pieces of rubbish that have been left lying on the ground in public places.", 
        synonyms: "trash, garbage", 
        example: "Please do not drop litter." 
    },
    { 
        id: 584, 
        word: "loathe", 
        definition: "To hate someone or something.", 
        synonyms: "hate, detest", 
        example: "I absolutely loathe spinach." 
    },
    { 
        id: 585, 
        word: "locate", 
        definition: "To find or discover the exact position of something.", 
        synonyms: "find, pinpoint", 
        example: "Police are trying to locate the suspect." 
    },
    { 
        id: 586, 
        word: "location", 
        definition: "A place or position.", 
        synonyms: "place, site", 
        example: "The hotel is in a beautiful location." 
    },
    { 
        id: 587, 
        word: "loose", 
        definition: "Not firmly held or fastened in place.", 
        synonyms: "slack, free", 
        example: "There is a loose screw on this chair." 
    },
    { 
        id: 588, 
        word: "lovely", 
        definition: "Pleasant or enjoyable.", 
        synonyms: "beautiful, charming", 
        example: "We had a lovely time at the party." 
    },
    { 
        id: 589, 
        word: "luggage", 
        definition: "The bags, suitcases, etc. that contain your possessions and that you take with you when you are travelling.", 
        synonyms: "baggage, cases", 
        example: "We checked our luggage at the airport." 
    },
    { 
        id: 590, 
        word: "magical", 
        definition: "Produced by or using magic.", 
        synonyms: "enchanted, supernatural", 
        example: "It was a magical experience." 
    },
    { 
        id: 591, 
        word: "mainstream", 
        definition: "Considered normal, and having or using ideas, beliefs, etc. that are accepted by most people.", 
        synonyms: "conventional, standard", 
        example: "This music is becoming more mainstream." 
    },
    { 
        id: 592, 
        word: "maintain", 
        definition: "To continue to have; to keep in existence, or not allow to become less.", 
        synonyms: "sustain, keep", 
        example: "We need to maintain a steady speed." 
    },
    { 
        id: 593, 
        word: "make a decision", 
        definition: "To decide.", 
        synonyms: "decide, choose", 
        example: "You need to make a decision soon." 
    },
    { 
        id: 594, 
        word: "manage", 
        definition: "To succeed in doing or dealing with something, especially something difficult.", 
        synonyms: "handle, cope", 
        example: "I don't know how he manages to work so hard." 
    },
    { 
        id: 595, 
        word: "management", 
        definition: "The control and organization of something.", 
        synonyms: "administration, direction", 
        example: "The company needs better management." 
    },
    { 
        id: 596, 
        word: "manipulate", 
        definition: "To control something or someone to your advantage, often unfairly or dishonestly.", 
        synonyms: "control, influence", 
        example: "He knows how to manipulate people." 
    },
    { 
        id: 597, 
        word: "manner", 
        definition: "The way in which something is done.", 
        synonyms: "way, method", 
        example: "She smiled in a friendly manner." 
    },
    { 
        id: 598, 
        word: "manufacture", 
        definition: "To produce goods in large numbers, usually in a factory using machines.", 
        synonyms: "produce, make", 
        example: "They manufacture car parts." 
    },
    { 
        id: 599, 
        word: "march", 
        definition: "To walk with regular steps and keeping the body stiff, usually in a formal group of people who are walking in the same way.", 
        synonyms: "walk, parade", 
        example: "Soldiers marched through the town." 
    },
    { 
        id: 600, 
        word: "massacre", 
        definition: "An act of killing a lot of people.", 
        synonyms: "slaughter, killing", 
        example: "The village was the scene of a terrible massacre." 
    },
{ 
        id: 601, 
        word: "master", 
        definition: "To learn to control an emotion or situation, or to learn how to do something well.", 
        synonyms: "conquer, grasp", 
        example: "He mastered the art of cooking." 
    },
    { 
        id: 602, 
        word: "masterpiece", 
        definition: "A work of art such as a painting, film, or book that is an excellent example of its type.", 
        synonyms: "-", 
        example: "This painting is considered a masterpiece." 
    },
    { 
        id: 603, 
        word: "mature", 
        definition: "Mature people behave like adults in a way that shows they are well developed emotionally.", 
        synonyms: "adult, grown-up", 
        example: "She is very mature for her age." 
    },
    { 
        id: 604, 
        word: "meadow", 
        definition: "A field with grass and often wild flowers in it.", 
        synonyms: "field, pasture", 
        example: "Cows were grazing in the meadow." 
    },
    { 
        id: 605, 
        word: "meander", 
        definition: "To walk slowly without any clear direction.", 
        synonyms: "wander, ramble", 
        example: "We meandered through the streets of the old town." 
    },
    { 
        id: 606, 
        word: "measure", 
        definition: "To discover the exact size or amount of something.", 
        synonyms: "gauge, calculate", 
        example: "Can you measure the length of this table?" 
    },
    { 
        id: 607, 
        word: "mediate", 
        definition: "To talk to two separate people or groups involved in a disagreement to try to help them agree.", 
        synonyms: "arbitrate, intervene", 
        example: "Negotiators were called in to mediate between the two sides." 
    },
    { 
        id: 608, 
        word: "meet", 
        definition: "To fulfill, satisfy, or achieve.", 
        synonyms: "satisfy, fulfill", 
        example: "We need to work hard to meet the deadline." 
    },
    { 
        id: 609, 
        word: "memorial", 
        definition: "An object or structure established in memory of a person or event.", 
        synonyms: "monument, tribute", 
        example: "They built a war memorial in the town square." 
    },
    { 
        id: 610, 
        word: "memory", 
        definition: "The ability to remember information, experiences, and people.", 
        synonyms: "recollection, recall", 
        example: "He has a very good memory for names." 
    },
    { 
        id: 611, 
        word: "merge", 
        definition: "To combine or join together, or to cause things to do this.", 
        synonyms: "unite, combine", 
        example: "The two companies decided to merge." 
    },
    { 
        id: 612, 
        word: "migrate", 
        definition: "To move from one place to another.", 
        synonyms: "move, relocate", 
        example: "Birds migrate south for the winter." 
    },
    { 
        id: 613, 
        word: "minor", 
        definition: "Having little importance, influence, or effect, especially when compared with other things of the same type.", 
        synonyms: "small, slight", 
        example: "It's only a minor problem." 
    },
    { 
        id: 614, 
        word: "miraculously", 
        definition: "In a way that is very surprising or difficult to believe.", 
        synonyms: "amazingly, incredibly", 
        example: "He miraculously survived the crash." 
    },
    { 
        id: 615, 
        word: "misbehave", 
        definition: "To behave badly.", 
        synonyms: "act up, disobey", 
        example: "The children were punished for misbehaving." 
    },
    { 
        id: 616, 
        word: "mischief", 
        definition: "Behavior, especially a child's, that is slightly bad but is not intended to cause serious harm.", 
        synonyms: "naughtiness, trouble", 
        example: "He needs to stop getting into mischief." 
    },
    { 
        id: 617, 
        word: "misunderstanding", 
        definition: "An occasion when someone does not understand something correctly.", 
        synonyms: "confusion, mistake", 
        example: "There must be some misunderstanding." 
    },
    { 
        id: 618, 
        word: "mix up", 
        definition: "To mistake someone or something for someone or something else.", 
        synonyms: "confuse, muddle", 
        example: "I always mix up the twins." 
    },
    { 
        id: 619, 
        word: "mock (at)", 
        definition: "To laugh at someone, often by copying them in a funny but unkind way.", 
        synonyms: "ridicule, tease", 
        example: "They mocked him for his accent." 
    },
    { 
        id: 620, 
        word: "modify", 
        definition: "To change something such as a plan, opinion, law, or way of behavior slightly.", 
        synonyms: "alter, adjust", 
        example: "We need to modify the design." 
    },
    { 
        id: 621, 
        word: "mood", 
        definition: "The way you feel at a particular time.", 
        synonyms: "temper, spirit", 
        example: "He is in a bad mood today." 
    },
    { 
        id: 622, 
        word: "mourning", 
        definition: "Great sadness felt because someone has died.", 
        synonyms: "grief, sorrow", 
        example: "The whole nation was in mourning." 
    },
    { 
        id: 623, 
        word: "move", 
        definition: "To go to a different place to live or work.", 
        synonyms: "relocate, transfer", 
        example: "We are planning to move to Canada." 
    },
    { 
        id: 624, 
        word: "movement", 
        definition: "A group of people with a particular set of aims.", 
        synonyms: "campaign, drive", 
        example: "She was active in the women's movement." 
    },
    { 
        id: 625, 
        word: "multinational", 
        definition: "Involving several different countries, or (of a business) producing and selling goods in several different countries.", 
        synonyms: "international, global", 
        example: "He works for a large multinational corporation." 
    },
    { 
        id: 626, 
        word: "municipality", 
        definition: "A city or town with its own local government.", 
        synonyms: "city, town", 
        example: "The municipality is responsible for road maintenance." 
    },
    { 
        id: 627, 
        word: "murder", 
        definition: "The crime of intentionally killing a person.", 
        synonyms: "homicide, killing", 
        example: "He was charged with attempted murder." 
    },
    { 
        id: 628, 
        word: "mystery", 
        definition: "Something strange or not known that has not yet been explained or understood.", 
        synonyms: "enigma, puzzle", 
        example: "The origin of the universe remains a mystery." 
    },
    { 
        id: 629, 
        word: "narrowly", 
        definition: "Only by a very small amount.", 
        synonyms: "barely, just", 
        example: "He narrowly escaped death." 
    },
    { 
        id: 630, 
        word: "native to", 
        definition: "Used to refer to plants and animals that grow naturally in a place, and have not been brought there from somewhere else.", 
        synonyms: "indigenous, local", 
        example: "This species is native to North America." 
    },
    { 
        id: 631, 
        word: "neglect", 
        definition: "To not give enough care or attention to people or things that are your responsibility.", 
        synonyms: "ignore, disregard", 
        example: "He neglected his studies." 
    },
    { 
        id: 632, 
        word: "nervous", 
        definition: "Worried and anxious.", 
        synonyms: "anxious, tense", 
        example: "I felt very nervous before the interview." 
    },
    { 
        id: 633, 
        word: "neutrality", 
        definition: "A neutral position, especially in a war.", 
        synonyms: "impartiality, nonalignment", 
        example: "Switzerland is famous for its neutrality." 
    },
    { 
        id: 634, 
        word: "notice", 
        definition: "To see or become conscious of something or someone.", 
        synonyms: "observe, detect", 
        example: "I noticed a small crack in the ceiling." 
    },
    { 
        id: 635, 
        word: "obese", 
        definition: "Extremely fat in a way that is dangerous for health.", 
        synonyms: "overweight, stout", 
        example: "Obese patients are at risk of heart disease." 
    },
    { 
        id: 636, 
        word: "obey", 
        definition: "To act according to what you have been asked or ordered to do.", 
        synonyms: "comply, follow", 
        example: "Soldiers must obey orders." 
    },
    { 
        id: 637, 
        word: "objection", 
        definition: "The act of expressing or feeling opposition to or dislike of something or someone.", 
        synonyms: "protest, complaint", 
        example: "He raised no objection to the plan." 
    },
    { 
        id: 638, 
        word: "obligation", 
        definition: "The fact that you are obliged to do something.", 
        synonyms: "duty, responsibility", 
        example: "I have a moral obligation to help him." 
    },
    { 
        id: 639, 
        word: "obscure", 
        definition: "Not clear and difficult to understand or see.", 
        synonyms: "unclear, vague", 
        example: "His answers were obscure and confusing." 
    },
    { 
        id: 640, 
        word: "observe", 
        definition: "To watch carefully the way something happens or the way someone does something.", 
        synonyms: "watch, monitor", 
        example: "Scientists observed the behavior of the monkeys." 
    },
    { 
        id: 641, 
        word: "obsolete", 
        definition: "Not in use any more, having been replaced by something newer and better.", 
        synonyms: "outdated, old-fashioned", 
        example: "Typewriters have become obsolete." 
    },
    { 
        id: 642, 
        word: "obtain", 
        definition: "To get something, especially by asking for it, buying it, working for it, or producing it from something else.", 
        synonyms: "get, acquire", 
        example: "He obtained a loan from the bank." 
    },
    { 
        id: 643, 
        word: "occasion", 
        definition: "A particular time, especially when something happens or has happened.", 
        synonyms: "event, instance", 
        example: "We met on several occasions." 
    },
    { 
        id: 644, 
        word: "occasional", 
        definition: "Happening once in a while.", 
        synonyms: "infrequent, sporadic", 
        example: "He pays me occasional visits." 
    },
    { 
        id: 645, 
        word: "occupy", 
        definition: "To fill, exist in, or use a place or period of time.", 
        synonyms: "inhabit, take up", 
        example: "The meeting occupied the whole morning." 
    },
    { 
        id: 646, 
        word: "occur", 
        definition: "To happen.", 
        synonyms: "happen, take place", 
        example: "The accident occurred at night." 
    },
    { 
        id: 647, 
        word: "occurrence", 
        definition: "Something that happens.", 
        synonyms: "event, incident", 
        example: "Flooding is a common occurrence in this area." 
    },
    { 
        id: 648, 
        word: "odd", 
        definition: "Strange or unexpected.", 
        synonyms: "weird, peculiar", 
        example: "It's odd that she didn't call." 
    },
    { 
        id: 649, 
        word: "oddly", 
        definition: "In a strange or surprising way.", 
        synonyms: "strangely, curiously", 
        example: "He was behaving very oddly." 
    },
    { 
        id: 650, 
        word: "odour", 
        definition: "A smell, often one that is unpleasant.", 
        synonyms: "smell, scent", 
        example: "There was a strong odour of cooking." 
    },
{ 
        id: 651, 
        word: "offend", 
        definition: "To make someone upset or angry.", 
        synonyms: "insult, upset", 
        example: "I didn't mean to offend you." 
    },
    { 
        id: 652, 
        word: "offer", 
        definition: "To ask someone if they would like to have something or if they would like you to do something.", 
        synonyms: "propose, present", 
        example: "Can I offer you a drink?" 
    },
    { 
        id: 653, 
        word: "officially", 
        definition: "In a formal and public way.", 
        synonyms: "formally, legally", 
        example: "The library was officially opened yesterday." 
    },
    { 
        id: 654, 
        word: "opportunity", 
        definition: "An occasion or situation that makes it possible to do something that you want to do.", 
        synonyms: "chance, occasion", 
        example: "This is a great opportunity to learn." 
    },
    { 
        id: 655, 
        word: "opposition", 
        definition: "Strong disagreement.", 
        synonyms: "resistance, objection", 
        example: "There was a lot of opposition to the new plan." 
    },
    { 
        id: 656, 
        word: "oppress", 
        definition: "To govern people in an unfair and cruel way.", 
        synonyms: "persecute, suppress", 
        example: "The dictator oppressed the people for years." 
    },
    { 
        id: 657, 
        word: "ordinary", 
        definition: "Not different or special or unexpected in any way.", 
        synonyms: "normal, common", 
        example: "It was just an ordinary day." 
    },
    { 
        id: 658, 
        word: "originally", 
        definition: "In the beginning.", 
        synonyms: "initially, at first", 
        example: "The house was originally a barn." 
    },
    { 
        id: 659, 
        word: "ornament", 
        definition: "An object that is beautiful rather than useful.", 
        synonyms: "decoration, adornment", 
        example: "She bought some glass ornaments for the tree." 
    },
    { 
        id: 660, 
        word: "orphan", 
        definition: "A child whose parents are dead.", 
        synonyms: "-", 
        example: "The war left many children as orphans." 
    },
    { 
        id: 661, 
        word: "outcrop", 
        definition: "A large rock or group of rocks that sticks out of the ground.", 
        synonyms: "-", 
        example: "We climbed a rocky outcrop to get a better view." 
    },
    { 
        id: 662, 
        word: "outcry", 
        definition: "A strong expression of anger and disapproval about something, made by a group of people or by the public.", 
        synonyms: "protest, uproar", 
        example: "There was a public outcry over the decision." 
    },
    { 
        id: 663, 
        word: "outdo", 
        definition: "To be, or do something, better than someone else.", 
        synonyms: "surpass, beat", 
        example: "He always tries to outdo his brother." 
    },
    { 
        id: 664, 
        word: "outing", 
        definition: "A short journey made by a group of people, usually for pleasure or education.", 
        synonyms: "excursion, trip", 
        example: "We went on a family outing to the beach." 
    },
    { 
        id: 665, 
        word: "outlet", 
        definition: "A way, especially a pipe or hole, for liquid or gas to go out.", 
        synonyms: "exit, vent", 
        example: "Writing poetry is a good emotional outlet." 
    },
    { 
        id: 666, 
        word: "overlap", 
        definition: "If two or more activities, subjects, or periods of time overlap, they have some parts that are the same.", 
        synonyms: "coincide, intersect", 
        example: "My holiday overlaps with yours." 
    },
    { 
        id: 667, 
        word: "overlook", 
        definition: "To provide a view of, especially from above.", 
        synonyms: "look onto", 
        example: "Our room overlooks the ocean." 
    },
    { 
        id: 668, 
        word: "overtake", 
        definition: "To go past something by being a greater amount or degree.", 
        synonyms: "surpass, exceed", 
        example: "Our spending has overtaken our income." 
    },
    { 
        id: 669, 
        word: "partially", 
        definition: "Not completely.", 
        synonyms: "partly, somewhat", 
        example: "The road was partially blocked." 
    },
    { 
        id: 670, 
        word: "participate", 
        definition: "To take part in or become involved in an activity.", 
        synonyms: "take part, join", 
        example: "She didn't participate in the discussion." 
    },
    { 
        id: 671, 
        word: "participation", 
        definition: "The act of taking part in an event or activity.", 
        synonyms: "involvement, engagement", 
        example: "We want to encourage participation in sports." 
    },
    { 
        id: 672, 
        word: "particular", 
        definition: "Special, or this and not any other.", 
        synonyms: "specific, certain", 
        example: "Is there a particular type of book you are looking for?" 
    },
    { 
        id: 673, 
        word: "particularly", 
        definition: "Especially, or more than usual.", 
        synonyms: "especially, notably", 
        example: "I enjoyed the play, particularly the second half." 
    },
    { 
        id: 674, 
        word: "passenger", 
        definition: "A person who is travelling in a vehicle but is not driving it.", 
        synonyms: "traveler, rider", 
        example: "The car was carrying two passengers." 
    },
    { 
        id: 675, 
        word: "passionately", 
        definition: "In a way that shows strong feelings or beliefs.", 
        synonyms: "intensely, fervently", 
        example: "He spoke passionately about the need for change." 
    },
    { 
        id: 676, 
        word: "patiently", 
        definition: "In a patient way.", 
        synonyms: "calmly, quietly", 
        example: "They waited patiently for the bus." 
    },
    { 
        id: 677, 
        word: "pavement", 
        definition: "A path with a hard surface on one or both sides of a road, that people walk on.", 
        synonyms: "sidewalk, footpath", 
        example: "Don't ride your bike on the pavement." 
    },
    { 
        id: 678, 
        word: "peace", 
        definition: "Freedom from war and violence.", 
        synonyms: "tranquility, harmony", 
        example: "Everyone wants to live in peace." 
    },
    { 
        id: 679, 
        word: "peak", 
        definition: "The highest, strongest, or best point, value, or level of skill.", 
        synonyms: "summit, top", 
        example: "Traffic reaches its peak at 8 AM." 
    },
    { 
        id: 680, 
        word: "peculiar", 
        definition: "Unusual and strange.", 
        synonyms: "odd, weird", 
        example: "She has the most peculiar ideas." 
    },
    { 
        id: 681, 
        word: "pedestrian", 
        definition: "A person who is walking, especially in an area where vehicles go.", 
        synonyms: "walker", 
        example: "The area is closed to traffic and open to pedestrians." 
    },
    { 
        id: 682, 
        word: "penalize", 
        definition: "To punish someone for breaking a rule.", 
        synonyms: "punish, discipline", 
        example: "He was penalized for time-wasting." 
    },
    { 
        id: 683, 
        word: "perceive", 
        definition: "To come to an opinion about something, or have a belief about something.", 
        synonyms: "see, view", 
        example: "How do the French perceive the British?" 
    },
    { 
        id: 684, 
        word: "permission", 
        definition: "If you are given permission to do something, you are allowed to do it.", 
        synonyms: "authorization, consent", 
        example: "You need permission to park here." 
    },
    { 
        id: 685, 
        word: "persevering", 
        definition: "Continuing to try to do something despite difficulties.", 
        synonyms: "persistent, determined", 
        example: "She was a persevering student." 
    },
    { 
        id: 686, 
        word: "persist", 
        definition: "To try to do or continue doing something in a determined but often unreasonable way.", 
        synonyms: "continue, insist", 
        example: "If the pain persists, consult a doctor." 
    },
    { 
        id: 687, 
        word: "persuade", 
        definition: "To make someone do or believe something by giving them a good reason to do it.", 
        synonyms: "convince, influence", 
        example: "He tried to persuade me to buy the car." 
    },
    { 
        id: 688, 
        word: "pessimism", 
        definition: "Emphasizing or thinking of the bad part of a situation rather than the good part.", 
        synonyms: "negativity, gloom", 
        example: "There is a mood of pessimism in the company." 
    },
    { 
        id: 689, 
        word: "pet", 
        definition: "An animal that is kept in the home as a companion and treated kindly.", 
        synonyms: "-", 
        example: "They have a pet dog." 
    },
    { 
        id: 690, 
        word: "pioneer", 
        definition: "A person who is one of the first people to do something.", 
        synonyms: "innovator, trailblazer", 
        example: "He was a pioneer in the field of computer science." 
    },
    { 
        id: 691, 
        word: "placement", 
        definition: "The act of placing something in a particular position.", 
        synonyms: "positioning, location", 
        example: "The placement of the furniture is perfect." 
    },
    { 
        id: 692, 
        word: "plague", 
        definition: "A serious disease that kills many people.", 
        synonyms: "epidemic, disease", 
        example: "Millions died in the plague." 
    },
    { 
        id: 693, 
        word: "plain", 
        definition: "Not decorated in any way; with nothing added.", 
        synonyms: "simple, clear", 
        example: "She wore a plain blue dress." 
    },
    { 
        id: 694, 
        word: "plead", 
        definition: "To make an urgent, emotional statement or request for something.", 
        synonyms: "beg, implore", 
        example: "He pleaded for mercy." 
    },
    { 
        id: 695, 
        word: "please", 
        definition: "To make someone feel happy or satisfied.", 
        synonyms: "satisfy, delight", 
        example: "It's impossible to please everyone." 
    },
    { 
        id: 696, 
        word: "pledge", 
        definition: "A serious or formal promise.", 
        synonyms: "promise, vow", 
        example: "He made a pledge to support the charity." 
    },
    { 
        id: 697, 
        word: "poem", 
        definition: "A piece of writing in which the words are arranged in separate lines.", 
        synonyms: "verse", 
        example: "She wrote a beautiful poem." 
    },
    { 
        id: 698, 
        word: "point", 
        definition: "An idea, opinion, or piece of information that is said or written.", 
        synonyms: "opinion, view", 
        example: "I see your point, but I disagree." 
    },
    { 
        id: 699, 
        word: "policy", 
        definition: "A set of ideas or a plan of what to do in particular situations.", 
        synonyms: "strategy, plan", 
        example: "The company has a strict no-smoking policy." 
    },
    { 
        id: 700, 
        word: "polio", 
        definition: "A serious infectious disease that can cause permanent paralysis.", 
        synonyms: "-", 
        example: "Vaccines have almost eliminated polio." 
    },
{ 
        id: 701, 
        word: "pose", 
        definition: "To cause something, especially a problem or difficulty.", 
        synonyms: "create, present", 
        example: "Nuclear weapons pose a threat to everyone." 
    },
    { 
        id: 702, 
        word: "possess", 
        definition: "To have or own something, or to have a particular quality.", 
        synonyms: "own, have", 
        example: "He was found to possess illegal drugs." 
    },
    { 
        id: 703, 
        word: "possession", 
        definition: "The fact that you have or own something.", 
        synonyms: "ownership, belonging", 
        example: "The possession of large amounts of money is dangerous." 
    },
    { 
        id: 704, 
        word: "post", 
        definition: "A job in a company or organization.", 
        synonyms: "position, job", 
        example: "He has held the post for three years." 
    },
    { 
        id: 705, 
        word: "postpone", 
        definition: "To delay an event and plan or decide that it should happen at a later time.", 
        synonyms: "delay, put off", 
        example: "They decided to postpone their holiday." 
    },
    { 
        id: 706, 
        word: "practically", 
        definition: "Almost or very nearly.", 
        synonyms: "almost, virtually", 
        example: "It's practically impossible to predict the future." 
    },
    { 
        id: 707, 
        word: "praise", 
        definition: "To express admiration or approval of the achievements or characteristics of a person or thing.", 
        synonyms: "commend, applaud", 
        example: "He should be praised for his honesty." 
    },
    { 
        id: 708, 
        word: "precede", 
        definition: "To be or go before something or someone in time or space.", 
        synonyms: "go before, come before", 
        example: "A short speech will precede the dinner." 
    },
    { 
        id: 709, 
        word: "predict", 
        definition: "To say that an event or action will happen in the future.", 
        synonyms: "forecast, foresee", 
        example: "It is impossible to predict what will happen." 
    },
    { 
        id: 710, 
        word: "predictable", 
        definition: "Happening or behaving in a way that you expect.", 
        synonyms: "expected, foreseeable", 
        example: "The ending of the movie was very predictable." 
    },
    { 
        id: 711, 
        word: "prejudice", 
        definition: "An unfair and unreasonable opinion or feeling, especially when formed without enough thought or knowledge.", 
        synonyms: "bias, discrimination", 
        example: "Laws against racial prejudice must be strictly enforced." 
    },
    { 
        id: 712, 
        word: "present", 
        definition: "To give, provide, or make something known.", 
        synonyms: "introduce, offer", 
        example: "The winners were presented with medals." 
    },
    { 
        id: 713, 
        word: "preserve", 
        definition: "To keep something as it is, especially in order to prevent it from decaying or being damaged or destroyed.", 
        synonyms: "protect, maintain", 
        example: "We must preserve our natural resources." 
    },
    { 
        id: 714, 
        word: "pressure", 
        definition: "The force you produce when you press something.", 
        synonyms: "stress, force", 
        example: "He put too much pressure on the door handle." 
    },
    { 
        id: 715, 
        word: "prevent", 
        definition: "To stop something from happening or someone from doing something.", 
        synonyms: "stop, avoid", 
        example: "Label your suitcases to prevent confusion." 
    },
    { 
        id: 716, 
        word: "previously", 
        definition: "Before the present time or the time referred to.", 
        synonyms: "formerly, earlier", 
        example: "She was previously employed as a teacher." 
    },
    { 
        id: 717, 
        word: "prior (to)", 
        definition: "Existing or happening before something else.", 
        synonyms: "earlier, preceding", 
        example: "The course requires no prior knowledge of Spanish." 
    },
    { 
        id: 718, 
        word: "prison", 
        definition: "A building where criminals are forced to live as a punishment.", 
        synonyms: "jail, penitentiary", 
        example: "He was sent to prison for five years." 
    },
    { 
        id: 719, 
        word: "probability", 
        definition: "The level of possibility of something happening or being true.", 
        synonyms: "likelihood, chance", 
        example: "There is a high probability that it will rain." 
    },
    { 
        id: 720, 
        word: "process", 
        definition: "A series of actions that you take in order to achieve a result.", 
        synonyms: "procedure, operation", 
        example: "Learning a language is a slow process." 
    },
    { 
        id: 721, 
        word: "progress", 
        definition: "Movement to an improved or more developed state, or to a forward position.", 
        synonyms: "advancement, improvement", 
        example: "We are making good progress on the project." 
    },
    { 
        id: 722, 
        word: "promote", 
        definition: "To encourage people to like, buy, use, do, or support something.", 
        synonyms: "advertise, encourage", 
        example: "The government is promoting healthy eating." 
    },
    { 
        id: 723, 
        word: "prompt", 
        definition: "Done or acting quickly and without waiting.", 
        synonyms: "immediate, quick", 
        example: "They've written back already - that was a very prompt reply." 
    },
    { 
        id: 724, 
        word: "promptly", 
        definition: "Quickly, without delay, or at the arranged time.", 
        synonyms: "immediately, punctually", 
        example: "She arrived promptly at 9 o'clock." 
    },
    { 
        id: 725, 
        word: "proofread", 
        definition: "To read and correct a piece of written or printed work.", 
        synonyms: "check, edit", 
        example: "I need to proofread my essay before submitting it." 
    },
    { 
        id: 726, 
        word: "properly", 
        definition: "Correctly, or in a satisfactory way.", 
        synonyms: "correctly, appropriately", 
        example: "The door doesn't close properly." 
    },
    { 
        id: 727, 
        word: "property", 
        definition: "An object or objects that belong to someone.", 
        synonyms: "belongings, estate", 
        example: "The club does not accept responsibility for loss of personal property." 
    },
    { 
        id: 728, 
        word: "proportion", 
        definition: "The number or amount of a group or part of something when compared to the whole.", 
        synonyms: "ratio, percentage", 
        example: "A high proportion of the population is unemployed." 
    },
    { 
        id: 729, 
        word: "protection", 
        definition: "The act of protecting or state of being protected.", 
        synonyms: "defense, safety", 
        example: "Evidence was given under police protection." 
    },
    { 
        id: 730, 
        word: "provoke", 
        definition: "To cause a reaction, especially a negative one.", 
        synonyms: "incite, trigger", 
        example: "The article was intended to provoke discussion." 
    },
    { 
        id: 731, 
        word: "publish", 
        definition: "To make information available to people, especially in a book, magazine, or newspaper.", 
        synonyms: "issue, release", 
        example: "She has published several novels." 
    },
    { 
        id: 732, 
        word: "purchase", 
        definition: "To buy something.", 
        synonyms: "buy, acquire", 
        example: "Tickets must be purchased two weeks in advance." 
    },
    { 
        id: 733, 
        word: "purpose", 
        definition: "Why you do something or why something exists.", 
        synonyms: "goal, objective", 
        example: "The main purpose of the meeting is to discuss the future." 
    },
    { 
        id: 734, 
        word: "pursue", 
        definition: "To follow someone or something, usually to try to catch him, her, or it.", 
        synonyms: "chase, follow", 
        example: "The police pursued the car for miles." 
    },
    { 
        id: 735, 
        word: "push", 
        definition: "To use physical pressure or force, especially with your hands, in order to move something.", 
        synonyms: "shove, press", 
        example: "He helped me push my car off the road." 
    },
    { 
        id: 736, 
        word: "put forth", 
        definition: "To suggest an idea for consideration.", 
        synonyms: "propose, suggest", 
        example: "He put forth a proposal for a new project." 
    },
    { 
        id: 737, 
        word: "queue", 
        definition: "A line of people, usually standing or in cars, waiting for something.", 
        synonyms: "line, row", 
        example: "We had to wait in a queue for hours." 
    },
    { 
        id: 738, 
        word: "race", 
        definition: "A competition in which all the competitors try to be the fastest and to finish first.", 
        synonyms: "contest, competition", 
        example: "He won the 100-meter race." 
    },
    { 
        id: 739, 
        word: "racism", 
        definition: "The belief that some races are superior to others.", 
        synonyms: "prejudice, discrimination", 
        example: "We must fight against racism." 
    },
    { 
        id: 740, 
        word: "raid", 
        definition: "A short sudden attack, usually by a small group of people.", 
        synonyms: "attack, assault", 
        example: "The police carried out a raid on the house." 
    },
    { 
        id: 741, 
        word: "raise", 
        definition: "To lift something to a higher position.", 
        synonyms: "lift, elevate", 
        example: "She raised her hand to ask a question." 
    },
    { 
        id: 742, 
        word: "rate", 
        definition: "The speed at which something happens or changes.", 
        synonyms: "speed, pace", 
        example: "The population is growing at an alarming rate." 
    },
    { 
        id: 743, 
        word: "receive", 
        definition: "To get or be given something.", 
        synonyms: "get, accept", 
        example: "Did you receive my email?" 
    },
    { 
        id: 744, 
        word: "reckless", 
        definition: "Doing something dangerous and not worrying about the risks and the possible results.", 
        synonyms: "careless, rash", 
        example: "He was found guilty of reckless driving." 
    },
    { 
        id: 745, 
        word: "recklessly", 
        definition: "In a way that is dangerous and shows that you are not worrying about the risks and possible results.", 
        synonyms: "carelessly, rashly", 
        example: "She spends money recklessly." 
    },
    { 
        id: 746, 
        word: "recognize", 
        definition: "To know someone or something because you have seen or heard him or her or experienced it before.", 
        synonyms: "identify, know", 
        example: "I didn't recognize you with your new haircut." 
    },
    { 
        id: 747, 
        word: "recommendation", 
        definition: "A suggestion that something is good or suitable for a particular purpose or job.", 
        synonyms: "suggestion, advice", 
        example: "I bought this book on your recommendation." 
    },
    { 
        id: 748, 
        word: "referee", 
        definition: "A person who is in charge of a sports game and who makes certain that the rules are followed.", 
        synonyms: "umpire, judge", 
        example: "The referee blew his whistle." 
    },
    { 
        id: 749, 
        word: "refreshing", 
        definition: "Making you feel less hot or tired.", 
        synonyms: "invigorating, cooling", 
        example: "A cold shower is very refreshing in summer." 
    },
    { 
        id: 750, 
        word: "refugee", 
        definition: "A person who has escaped from their own country for political, religious, or economic reasons or because of a war.", 
        synonyms: "exile, fugitive", 
        example: "Thousands of refugees crossed the border." 
    },
{ 
        id: 751, 
        word: "refund", 
        definition: "An amount of money that is given back to you, especially because you are not happy with a product or service.", 
        synonyms: "repayment, reimbursement", 
        example: "I took the radio back to the shop and asked for a refund." 
    },
    { 
        id: 752, 
        word: "regard", 
        definition: "To consider or think of someone or something in a specified way.", 
        synonyms: "consider, view", 
        example: "He is highly regarded by his colleagues." 
    },
    { 
        id: 753, 
        word: "regional", 
        definition: "Relating to or coming from a particular part of a country or the world.", 
        synonyms: "local, provincial", 
        example: "We must respect regional differences." 
    },
    { 
        id: 754, 
        word: "register", 
        definition: "To put information, especially your name, into an official list or record.", 
        synonyms: "enroll, record", 
        example: "You need to register for the conference." 
    },
    { 
        id: 755, 
        word: "regret", 
        definition: "To feel sad or sorry about something that you did or did not do.", 
        synonyms: "repent, rue", 
        example: "I regret not studying harder for the exam." 
    },
    { 
        id: 756, 
        word: "regretful", 
        definition: "Showing that you feel sorry about something.", 
        synonyms: "remorseful, apologetic", 
        example: "He gave a regretful smile." 
    },
    { 
        id: 757, 
        word: "regrettable", 
        definition: "Making you feel sad and sorry about something.", 
        synonyms: "unfortunate, sad", 
        example: "It was a regrettable mistake." 
    },
    { 
        id: 758, 
        word: "regularly", 
        definition: "At repeated times, with equal amounts of time between.", 
        synonyms: "frequently, routinely", 
        example: "I exercise regularly to stay fit." 
    },
    { 
        id: 759, 
        word: "rehearse", 
        definition: "To practice a play, a piece of music, etc. in order to prepare for a public performance.", 
        synonyms: "practice, train", 
        example: "The musicians rehearsed for the concert." 
    },
    { 
        id: 760, 
        word: "reject", 
        definition: "To refuse to accept, use, or believe something or someone.", 
        synonyms: "refuse, decline", 
        example: "The committee rejected the proposal." 
    },
    { 
        id: 761, 
        word: "rejection", 
        definition: "The act of refusing to accept, use, or believe someone or something.", 
        synonyms: "refusal, denial", 
        example: "Fear of rejection prevents many people from trying." 
    },
    { 
        id: 762, 
        word: "relate", 
        definition: "To find or show the connection between two or more things.", 
        synonyms: "connect, link", 
        example: "I cannot relate to his problems." 
    },
    { 
        id: 763, 
        word: "release", 
        definition: "To give freedom or free movement to someone or something.", 
        synonyms: "free, liberate", 
        example: "He was released from prison after five years." 
    },
    { 
        id: 764, 
        word: "relentless", 
        definition: "Continuing in a severe or extreme way.", 
        synonyms: "persistent, unyielding", 
        example: "The relentless heat made it difficult to work." 
    },
    { 
        id: 765, 
        word: "relief", 
        definition: "A feeling of happiness that something unpleasant has not happened or has ended.", 
        synonyms: "comfort, ease", 
        example: "It was a huge relief to hear that she was safe." 
    },
    { 
        id: 766, 
        word: "relocate", 
        definition: "To move or move something or someone from one place to another.", 
        synonyms: "move, transfer", 
        example: "The company decided to relocate to London." 
    },
    { 
        id: 767, 
        word: "reluctant", 
        definition: "Not willing to do something and therefore slow to do it.", 
        synonyms: "unwilling, hesitant", 
        example: "He was reluctant to leave his house." 
    },
    { 
        id: 768, 
        word: "remain", 
        definition: "To stay in the same place or in the same condition.", 
        synonyms: "stay, persist", 
        example: "Please remain seated until the bus stops." 
    },
    { 
        id: 769, 
        word: "remark", 
        definition: "Something that you say, giving your opinion about something or stating a fact.", 
        synonyms: "comment, observation", 
        example: "He made a rude remark about her appearance." 
    },
    { 
        id: 770, 
        word: "remembrance", 
        definition: "The act of remembering and showing respect for someone who has died.", 
        synonyms: "commemoration, memory", 
        example: "A service was held in remembrance of the victims." 
    },
    { 
        id: 771, 
        word: "reminiscent of", 
        definition: "Making you remember a particular person, event, or thing.", 
        synonyms: "evocative, suggestive", 
        example: "That song is reminiscent of my childhood." 
    },
    { 
        id: 772, 
        word: "remote", 
        definition: "Far away in distance.", 
        synonyms: "distant, isolated", 
        example: "They live in a remote village in the mountains." 
    },
    { 
        id: 773, 
        word: "removal", 
        definition: "The act of taking something or someone away from somewhere or something.", 
        synonyms: "elimination, extraction", 
        example: "The removal of rubbish is expensive." 
    },
    { 
        id: 774, 
        word: "remove", 
        definition: "To take something or someone away from somewhere, or off something.", 
        synonyms: "take away, delete", 
        example: "Please remove your shoes before entering." 
    },
    { 
        id: 775, 
        word: "repeatedly", 
        definition: "Many times.", 
        synonyms: "again and again, frequently", 
        example: "I told him repeatedly to stop making noise." 
    },
    { 
        id: 776, 
        word: "repetitive", 
        definition: "Involving doing or saying the same thing several times, especially in a way that is boring.", 
        synonyms: "monotonous, recurrent", 
        example: "Factory work can be very repetitive." 
    },
    { 
        id: 777, 
        word: "replace", 
        definition: "To take the place of something, or to put something or someone in the place of something or someone else.", 
        synonyms: "substitute, exchange", 
        example: "We need to replace the broken window." 
    },
    { 
        id: 778, 
        word: "replica", 
        definition: "An exact copy of an object.", 
        synonyms: "copy, duplicate", 
        example: "It is a replica of the Eiffel Tower." 
    },
    { 
        id: 779, 
        word: "request", 
        definition: "The act of politely or officially asking for something.", 
        synonyms: "ask, demand", 
        example: "She made a request for more information." 
    },
    { 
        id: 780, 
        word: "require", 
        definition: "To need something or make something necessary.", 
        synonyms: "need, necessitate", 
        example: "This job requires a lot of patience." 
    },
    { 
        id: 781, 
        word: "requirement", 
        definition: "Something that you must do, or something you need.", 
        synonyms: "necessity, prerequisite", 
        example: "Experience is a requirement for this job." 
    },
    { 
        id: 782, 
        word: "resentful", 
        definition: "Feeling angry because you have been forced to accept someone or something that you do not like.", 
        synonyms: "bitter, offended", 
        example: "She felt resentful about being ignored." 
    },
    { 
        id: 783, 
        word: "reside", 
        definition: "To live, have your home, or stay in a place.", 
        synonyms: "live, dwell", 
        example: "He resides in New York." 
    },
    { 
        id: 784, 
        word: "resident", 
        definition: "A person who lives or has their home in a place.", 
        synonyms: "inhabitant, dweller", 
        example: "Local residents are complaining about the noise." 
    },
    { 
        id: 785, 
        word: "resign", 
        definition: "To give up a job or position by telling your employer that you are leaving.", 
        synonyms: "quit, step down", 
        example: "He resigned from the board." 
    },
    { 
        id: 786, 
        word: "resolve", 
        definition: "To solve or end a problem or difficulty.", 
        synonyms: "solve, settle", 
        example: "We need to resolve this issue quickly." 
    },
    { 
        id: 787, 
        word: "resort", 
        definition: "To do something that you do not want to do because you cannot find any other way of achieving something.", 
        synonyms: "turn to", 
        example: "They resorted to violence to get what they wanted." 
    },
    { 
        id: 788, 
        word: "response", 
        definition: "An answer or reaction.", 
        synonyms: "reply, answer", 
        example: "I am still waiting for a response to my letter." 
    },
    { 
        id: 789, 
        word: "restlessness", 
        definition: "The quality of being unwilling or unable to stay still or to be quiet and calm.", 
        synonyms: "unease, agitation", 
        example: "His restlessness made it hard for him to sleep." 
    },
    { 
        id: 790, 
        word: "result", 
        definition: "Something that happens or exists because of something else.", 
        synonyms: "outcome, consequence", 
        example: "The result was better than expected." 
    },
    { 
        id: 791, 
        word: "reveal", 
        definition: "To make known or show something that is surprising or that was previously secret.", 
        synonyms: "disclose, unveil", 
        example: "He revealed the secret to his friends." 
    },
    { 
        id: 792, 
        word: "revenge", 
        definition: "Harm done to someone as a punishment for something that they have done to someone else.", 
        synonyms: "vengeance, retaliation", 
        example: "He sought revenge for his father's death." 
    },
    { 
        id: 793, 
        word: "revolve", 
        definition: "To move or cause something to move around a central point or line.", 
        synonyms: "rotate, spin", 
        example: "The earth revolves around the sun." 
    },
    { 
        id: 794, 
        word: "reward", 
        definition: "Something given in exchange for good behavior or good work, etc.", 
        synonyms: "prize, award", 
        example: "There is a reward for the missing cat." 
    },
    { 
        id: 795, 
        word: "ride", 
        definition: "To sit on something such as a bicycle, motorbike, or horse and travel along on it.", 
        synonyms: "drive", 
        example: "I learned to ride a bike when I was five." 
    },
    { 
        id: 796, 
        word: "rightfully", 
        definition: "In a way that is morally or legally correct.", 
        synonyms: "justly, legitimately", 
        example: "The money belongs rightfully to her." 
    },
    { 
        id: 797, 
        word: "rise", 
        definition: "To move upwards.", 
        synonyms: "go up, ascend", 
        example: "The sun rises in the east." 
    },
    { 
        id: 798, 
        word: "rob", 
        definition: "To take money or property illegally from a place, organization, or person, often using violence.", 
        synonyms: "steal from, burgle", 
        example: "They robbed the bank yesterday." 
    },
    { 
        id: 799, 
        word: "robust", 
        definition: "Strong and healthy; vigorous.", 
        synonyms: "strong, sturdy", 
        example: "He looks very robust for his age." 
    },
    { 
        id: 800, 
        word: "rough", 
        definition: "Not even or smooth, often because of being in bad condition.", 
        synonyms: "coarse, uneven", 
        example: "The road was very rough." 
    },
{ 
        id: 801, 
        word: "rubble", 
        definition: "Broken stones or bricks from a building or wall that has been destroyed.", 
        synonyms: "debris, wreckage", 
        example: "The bomb reduced the house to rubble." 
    },
    { 
        id: 802, 
        word: "sacrifice", 
        definition: "To give up something that is valuable to you in order to help another person.", 
        synonyms: "surrender, give up", 
        example: "Many women sacrifice their careers for their family." 
    },
    { 
        id: 803, 
        word: "salute", 
        definition: "To honor or express admiration publicly.", 
        synonyms: "greet, honor", 
        example: "The soldiers saluted the general." 
    },
    { 
        id: 804, 
        word: "satisfaction", 
        definition: "A pleasant feeling that you get when you receive something you wanted, or when you have done something you wanted to do.", 
        synonyms: "contentment, pleasure", 
        example: "She looked at the finished painting with satisfaction." 
    },
    { 
        id: 805, 
        word: "savage", 
        definition: "Extremely violent, wild, or frightening.", 
        synonyms: "wild, brutal", 
        example: "He was killed in a savage attack." 
    },
    { 
        id: 806, 
        word: "scald", 
        definition: "To burn the skin with boiling liquid or steam.", 
        synonyms: "burn", 
        example: "She scalded her mouth on the hot coffee." 
    },
    { 
        id: 807, 
        word: "scalp", 
        definition: "The skin on the top of a person's head where hair usually grows.", 
        synonyms: "-", 
        example: "He had a small cut on his scalp." 
    },
    { 
        id: 808, 
        word: "scarce", 
        definition: "Not easy to find or get.", 
        synonyms: "rare, insufficient", 
        example: "Food and water were becoming scarce." 
    },
    { 
        id: 809, 
        word: "scarcely", 
        definition: "Almost not.", 
        synonyms: "barely, hardly", 
        example: "I was scarcely able to move my arm." 
    },
    { 
        id: 810, 
        word: "scatter", 
        definition: "To (cause to) move far apart in different directions.", 
        synonyms: "disperse, spread", 
        example: "The protesters scattered when the police arrived." 
    },
    { 
        id: 811, 
        word: "sceptical", 
        definition: "Doubting that something is true or useful.", 
        synonyms: "doubtful, cynical", 
        example: "I'm a bit sceptical about his chances of success." 
    },
    { 
        id: 812, 
        word: "scratch", 
        definition: "To cut or damage a surface or your skin slightly with or on something sharp or rough.", 
        synonyms: "scrape, graze", 
        example: "The cat scratched my hand." 
    },
    { 
        id: 813, 
        word: "sculpture", 
        definition: "The art of forming solid objects that represent a thing, person, idea, etc.", 
        synonyms: "statue, carving", 
        example: "He collects modern sculpture." 
    },
    { 
        id: 814, 
        word: "seam", 
        definition: "A line where two things join, especially a line of sewing joining two pieces of cloth or leather.", 
        synonyms: "joint, line", 
        example: "The seam on my shoulder is coming undone." 
    },
    { 
        id: 815, 
        word: "seasonal", 
        definition: "Relating to or happening during a particular period in the year.", 
        synonyms: "periodic", 
        example: "Seasonal changes affect my mood." 
    },
    { 
        id: 816, 
        word: "secure", 
        definition: "Positioned or fixed firmly and correctly and therefore not likely to move, fall, or break.", 
        synonyms: "safe, stable", 
        example: "Ensure that the ladder is secure." 
    },
    { 
        id: 817, 
        word: "sedate", 
        definition: "To cause a person or animal to be very calm or go to sleep by giving them a drug.", 
        synonyms: "calm, tranquilize", 
        example: "The vet sedated the dog before the operation." 
    },
    { 
        id: 818, 
        word: "seed", 
        definition: "A small, round or oval object produced by a plant and from which, when it is planted, a new plant can grow.", 
        synonyms: "grain, germ", 
        example: "Sow the seeds in late March." 
    },
    { 
        id: 819, 
        word: "seize", 
        definition: "To take something quickly and keep or hold it.", 
        synonyms: "grab, capture", 
        example: "He seized the opportunity to leave." 
    },
    { 
        id: 820, 
        word: "sense", 
        definition: "An ability to understand, recognize, value, or react to something.", 
        synonyms: "feeling, awareness", 
        example: "She has a good sense of humor." 
    },
    { 
        id: 821, 
        word: "sentence", 
        definition: "A punishment given by a judge in court to a person or organization after they have been found guilty of doing something wrong.", 
        synonyms: "punishment, judgment", 
        example: "He received a long prison sentence." 
    },
    { 
        id: 822, 
        word: "sentimental", 
        definition: "A sentimental person is strongly influenced by emotional feelings.", 
        synonyms: "emotional, nostalgic", 
        example: "She kept the letters for sentimental reasons." 
    },
    { 
        id: 823, 
        word: "session", 
        definition: "A period of time or meeting arranged for a particular activity.", 
        synonyms: "meeting, period", 
        example: "The course is made up of 12 two-hour sessions." 
    },
    { 
        id: 824, 
        word: "sewage", 
        definition: "Waste matter such as water or human urine or solid waste.", 
        synonyms: "waste, refuse", 
        example: "Raw sewage is being dumped into the sea." 
    },
    { 
        id: 825, 
        word: "shade", 
        definition: "Slight darkness caused by something blocking the direct light from the sun.", 
        synonyms: "shadow, shelter", 
        example: "We sat in the shade of a large tree." 
    },
    { 
        id: 826, 
        word: "shortcoming", 
        definition: "A fault or a failure to reach a particular standard.", 
        synonyms: "defect, flaw", 
        example: "Her only shortcoming is that she is sometimes late." 
    },
    { 
        id: 827, 
        word: "shorten", 
        definition: "To become shorter or to make something shorter.", 
        synonyms: "abbreviate, cut", 
        example: "The days are shortening as winter approaches." 
    },
    { 
        id: 828, 
        word: "show off", 
        definition: "To behave in a way that is intended to attract attention or admiration.", 
        synonyms: "boast, brag", 
        example: "He's always showing off his new car." 
    },
    { 
        id: 829, 
        word: "shuffle", 
        definition: "To mix a set of playing cards without seeing their values.", 
        synonyms: "mix", 
        example: "He shuffled the cards and dealt them." 
    },
    { 
        id: 830, 
        word: "sigh", 
        definition: "To breathe out slowly and noisily, expressing tiredness, sadness, pleasure, etc.", 
        synonyms: "moan", 
        example: "She sighed deeply and sat down." 
    },
    { 
        id: 831, 
        word: "significant", 
        definition: "Important or noticeable.", 
        synonyms: "important, meaningful", 
        example: "There has been a significant increase in sales." 
    },
    { 
        id: 832, 
        word: "silent", 
        definition: "Without any sound.", 
        synonyms: "quiet, noiseless", 
        example: "The house was completely silent." 
    },
    { 
        id: 833, 
        word: "simply", 
        definition: "Only.", 
        synonyms: "merely, just", 
        example: "I don't know why, I simply haven't had the time." 
    },
    { 
        id: 834, 
        word: "simulate", 
        definition: "To do or make something that looks real but is not real.", 
        synonyms: "imitate, pretend", 
        example: "The computer simulates different flying conditions." 
    },
    { 
        id: 835, 
        word: "sink", 
        definition: "To (cause something or someone to) go down below the surface or to the bottom of a liquid or soft substance.", 
        synonyms: "submerge, go down", 
        example: "The Titanic sank after hitting an iceberg." 
    },
    { 
        id: 836, 
        word: "situate", 
        definition: "To put something in a particular position.", 
        synonyms: "locate, place", 
        example: "The hotel is situated near the beach." 
    },
    { 
        id: 837, 
        word: "size", 
        definition: "How large or small something or someone is.", 
        synonyms: "dimension, magnitude", 
        example: "What size shoes do you wear?" 
    },
    { 
        id: 838, 
        word: "skill", 
        definition: "An ability to do an activity or job well, especially because you have practised it.", 
        synonyms: "ability, talent", 
        example: "Reading and writing are essential skills." 
    },
    { 
        id: 839, 
        word: "slaughter", 
        definition: "The killing of many people cruelly and unfairly.", 
        synonyms: "massacre, killing", 
        example: "The slaughter of innocent civilians must stop." 
    },
    { 
        id: 840, 
        word: "slavery", 
        definition: "The condition of being a slave, or the practice of owning slaves.", 
        synonyms: "bondage, servitude", 
        example: "Slavery was abolished in the US in 1865." 
    },
    { 
        id: 841, 
        word: "sleeve", 
        definition: "The part of a piece of clothing that covers some or all of the arm.", 
        synonyms: "-", 
        example: "She rolled up her sleeves and started working." 
    },
    { 
        id: 842, 
        word: "slight", 
        definition: "Small in amount or degree.", 
        synonyms: "small, minor", 
        example: "I have a slight headache." 
    },
    { 
        id: 843, 
        word: "slip", 
        definition: "To slide without intending to.", 
        synonyms: "slide, skid", 
        example: "She slipped on the ice and fell." 
    },
    { 
        id: 844, 
        word: "smash", 
        definition: "To cause something to break noisily into a lot of small pieces.", 
        synonyms: "break, shatter", 
        example: "He smashed the window with a rock." 
    },
    { 
        id: 845, 
        word: "smother", 
        definition: "To kill someone by covering their face so that they cannot breathe.", 
        synonyms: "suffocate, stifle", 
        example: "He tried to smother the fire with a blanket." 
    },
    { 
        id: 846, 
        word: "snap", 
        definition: "To cause something that is thin to break suddenly and quickly with a cracking sound.", 
        synonyms: "break, crack", 
        example: "The dry branch snapped under his weight." 
    },
    { 
        id: 847, 
        word: "soap", 
        definition: "A substance used for washing the body or other things.", 
        synonyms: "-", 
        example: "Wash your hands with soap and water." 
    },
    { 
        id: 848, 
        word: "sociable", 
        definition: "Sociable people like to meet and spend time with other people.", 
        synonyms: "friendly, outgoing", 
        example: "He is a very sociable person." 
    },
    { 
        id: 849, 
        word: "solely", 
        definition: "Only and not involving anyone or anything else.", 
        synonyms: "only, exclusively", 
        example: "He is solely responsible for the accident." 
    },
    { 
        id: 850, 
        word: "soothing", 
        definition: "Making you feel calm.", 
        synonyms: "calming, relaxing", 
        example: "She put on some soothing music." 
    },
{ 
        id: 851, 
        word: "spectacular", 
        definition: "Very exciting to look at.", 
        synonyms: "impressive, magnificent", 
        example: "The view from the top was spectacular." 
    },
    { 
        id: 852, 
        word: "spend", 
        definition: "To give money as a payment for something.", 
        synonyms: "pay, expend", 
        example: "She spends a lot of money on clothes." 
    },
    { 
        id: 853, 
        word: "spillage", 
        definition: "A liquid that has been spilled.", 
        synonyms: "leak, spill", 
        example: "There was a chemical spillage on the road." 
    },
    { 
        id: 854, 
        word: "spin", 
        definition: "To turn around and around, or to cause something or someone to turn.", 
        synonyms: "rotate, whirl", 
        example: "The wheels started to spin." 
    },
    { 
        id: 855, 
        word: "spine", 
        definition: "The line of bones down the centre of the back that provides support for the body.", 
        synonyms: "backbone", 
        example: "He injured his spine in the accident." 
    },
    { 
        id: 856, 
        word: "spiritual", 
        definition: "Relating to deep feelings and beliefs, especially religious beliefs.", 
        synonyms: "religious, divine", 
        example: "Painting helps him fulfill a spiritual need." 
    },
    { 
        id: 857, 
        word: "spoiled", 
        definition: "Allowed to do or have anything that you want to, usually so that you behave badly.", 
        synonyms: "pampered, rotten", 
        example: "He acts like a spoiled child." 
    },
    { 
        id: 858, 
        word: "spouse", 
        definition: "A person's husband or wife.", 
        synonyms: "partner, mate", 
        example: "Employees and their spouses are invited." 
    },
    { 
        id: 859, 
        word: "spread", 
        definition: "To cover or reach a wider or increasing area.", 
        synonyms: "expand, extend", 
        example: "The fire spread quickly through the building." 
    },
    { 
        id: 860, 
        word: "spring", 
        definition: "The season of the year between winter and summer.", 
        synonyms: "-", 
        example: "Flowers bloom in spring." 
    },
    { 
        id: 861, 
        word: "stability", 
        definition: "A situation in which something is not likely to move or change.", 
        synonyms: "steadiness, firmness", 
        example: "Political stability is essential for economic growth." 
    },
    { 
        id: 862, 
        word: "staff", 
        definition: "The group of people who work for an organization.", 
        synonyms: "employees, personnel", 
        example: "The hospital has a large staff." 
    },
    { 
        id: 863, 
        word: "stage", 
        definition: "A part of an activity or a period of development.", 
        synonyms: "phase, step", 
        example: "The project is in its final stage." 
    },
    { 
        id: 864, 
        word: "startle", 
        definition: "To do something unexpected that surprises and sometimes worries a person.", 
        synonyms: "surprise, frighten", 
        example: "The loud noise startled me." 
    },
    { 
        id: 865, 
        word: "statement", 
        definition: "Something that someone says or writes officially.", 
        synonyms: "declaration, announcement", 
        example: "The prime minister made a statement." 
    },
    { 
        id: 866, 
        word: "statue", 
        definition: "An object made from a hard material, especially stone or metal, to look like a person or animal.", 
        synonyms: "sculpture, figure", 
        example: "There is a statue of a lion in the square." 
    },
    { 
        id: 867, 
        word: "steadily", 
        definition: "Gradually and in an even and regular way.", 
        synonyms: "continuously, constantly", 
        example: "Prices have risen steadily." 
    },
    { 
        id: 868, 
        word: "steal", 
        definition: "To take something without the permission or knowledge of the owner and keep it.", 
        synonyms: "theft, take", 
        example: "Someone stole my wallet." 
    },
    { 
        id: 869, 
        word: "stealthily", 
        definition: "Quietly and carefully in order not to be seen or heard.", 
        synonyms: "secretly, furtively", 
        example: "The cat moved stealthily through the grass." 
    },
    { 
        id: 870, 
        word: "stem", 
        definition: "To start or develop as the result of something.", 
        synonyms: "originate, arise", 
        example: "Most of her health problems stem from an accident." 
    },
    { 
        id: 871, 
        word: "stimulate", 
        definition: "To encourage something to grow, develop, or become active.", 
        synonyms: "encourage, inspire", 
        example: "The government plans to stimulate the economy." 
    },
    { 
        id: 872, 
        word: "stir", 
        definition: "To mix a liquid or other substance by moving an object such as a spoon in a circular pattern.", 
        synonyms: "mix, blend", 
        example: "Stir the sauce until it thickens." 
    },
    { 
        id: 873, 
        word: "store", 
        definition: "To put or keep things in a special place for use in the future.", 
        synonyms: "keep, save", 
        example: "Squirrels store nuts for the winter." 
    },
    { 
        id: 874, 
        word: "storm", 
        definition: "An extreme weather condition with very strong wind, heavy rain, and often thunder and lightning.", 
        synonyms: "tempest, gale", 
        example: "The storm caused a lot of damage." 
    },
    { 
        id: 875, 
        word: "stranger", 
        definition: "Someone you do not know.", 
        synonyms: "outsider, foreigner", 
        example: "I was approached by a complete stranger." 
    },
    { 
        id: 876, 
        word: "stray", 
        definition: "A pet that no longer has a home or cannot find its home.", 
        synonyms: "homeless, lost", 
        example: "We adopted a stray cat." 
    },
    { 
        id: 877, 
        word: "stress", 
        definition: "Great worry caused by a difficult situation.", 
        synonyms: "anxiety, pressure", 
        example: "He is under a lot of stress at work." 
    },
    { 
        id: 878, 
        word: "stretch", 
        definition: "To cause something to reach, often as far as possible, in a particular direction.", 
        synonyms: "extend, expand", 
        example: "She stretched out her hand to help him." 
    },
    { 
        id: 879, 
        word: "strike", 
        definition: "To refuse to continue working because of an argument with an employer.", 
        synonyms: "walkout, hit", 
        example: "The teachers are on strike." 
    },
    { 
        id: 880, 
        word: "stroll", 
        definition: "To walk in a slow, relaxed manner.", 
        synonyms: "walk, wander", 
        example: "We took a stroll along the beach." 
    },
    { 
        id: 881, 
        word: "subject to", 
        definition: "Likely to experience or suffer from something.", 
        synonyms: "susceptible to, exposed to", 
        example: "Flights are subject to delay." 
    },
    { 
        id: 882, 
        word: "substantial", 
        definition: "Large in size, value, or importance.", 
        synonyms: "significant, considerable", 
        example: "He inherited a substantial amount of money." 
    },
    { 
        id: 883, 
        word: "sue", 
        definition: "To take legal action against a person or organization.", 
        synonyms: "prosecute, litigate", 
        example: "She is suing the company for damages." 
    },
    { 
        id: 884, 
        word: "sufficiently", 
        definition: "Enough for a particular purpose.", 
        synonyms: "adequately, enough", 
        example: "The meat was not sufficiently cooked." 
    },
    { 
        id: 885, 
        word: "suffrage", 
        definition: "The right to vote in an election.", 
        synonyms: "voting rights", 
        example: "Women fought for suffrage for many years." 
    },
    { 
        id: 886, 
        word: "suggestion", 
        definition: "An idea, plan, or action that is suggested or the act of suggesting it.", 
        synonyms: "proposal, advice", 
        example: "I have a suggestion for the party." 
    },
    { 
        id: 887, 
        word: "suggestive of", 
        definition: "Making you think about or remember a particular thing.", 
        synonyms: "indicative of, reminiscent of", 
        example: "The music is suggestive of the 1960s." 
    },
    { 
        id: 888, 
        word: "suit", 
        definition: "To be right for a particular person, situation, or occasion.", 
        synonyms: "fit, match", 
        example: "Red really suits you." 
    },
    { 
        id: 889, 
        word: "supply", 
        definition: "To provide something that is wanted or needed.", 
        synonyms: "provide, furnish", 
        example: "The lake supplies the city with water." 
    },
    { 
        id: 890, 
        word: "support", 
        definition: "To agree with and give encouragement to someone or something.", 
        synonyms: "back, help", 
        example: "I support your decision." 
    },
    { 
        id: 891, 
        word: "supportive", 
        definition: "Showing agreement and giving encouragement.", 
        synonyms: "helpful, encouraging", 
        example: "Her family was very supportive." 
    },
    { 
        id: 892, 
        word: "suppress", 
        definition: "To end something by force.", 
        synonyms: "crush, subdue", 
        example: "The rebellion was suppressed by the army." 
    },
    { 
        id: 893, 
        word: "surpass", 
        definition: "To do or be better than.", 
        synonyms: "exceed, outdo", 
        example: "His performance surpassed all expectations." 
    },
    { 
        id: 894, 
        word: "surrender", 
        definition: "To stop fighting and admit defeat.", 
        synonyms: "give up, yield", 
        example: "The enemy troops surrendered." 
    },
    { 
        id: 895, 
        word: "suspend", 
        definition: "To stop something from being active, either temporarily or permanently.", 
        synonyms: "halt, delay", 
        example: "The ferry service has been suspended." 
    },
    { 
        id: 896, 
        word: "suspicion", 
        definition: "A belief or idea that something may be true.", 
        synonyms: "doubt, mistrust", 
        example: "I have a suspicion that he is lying." 
    },
    { 
        id: 897, 
        word: "symptom", 
        definition: "Any feeling of illness or physical or mental change that is caused by a particular disease.", 
        synonyms: "sign, indication", 
        example: "Fever is a symptom of the flu." 
    },
    { 
        id: 898, 
        word: "take off", 
        definition: "If an aircraft, bird, or insect takes off, it leaves the ground and begins to fly.", 
        synonyms: "depart, lift off", 
        example: "The plane took off on time." 
    },
    { 
        id: 899, 
        word: "take on", 
        definition: "To accept a particular job or responsibility.", 
        synonyms: "undertake, accept", 
        example: "I can't take on any more work." 
    },
    { 
        id: 900, 
        word: "tame", 
        definition: "Not wild or dangerous.", 
        synonyms: "domesticated, docile", 
        example: "The bird became quite tame." 
    },
{ 
        id: 901, 
        word: "tapestry", 
        definition: "A piece of heavy cloth with a picture sewn on it, used as a wall decoration.", 
        synonyms: "-", 
        example: "A colorful tapestry hung on the wall." 
    },
    { 
        id: 902, 
        word: "tasteful", 
        definition: "Attractive and chosen for style and quality.", 
        synonyms: "stylish, elegant", 
        example: "The house was decorated in a tasteful manner." 
    },
    { 
        id: 903, 
        word: "tasty", 
        definition: "Food that has a strong and very pleasant flavor.", 
        synonyms: "delicious, yummy", 
        example: "This soup is very tasty." 
    },
    { 
        id: 904, 
        word: "temple", 
        definition: "A building used for the worship of a god or gods.", 
        synonyms: "shrine, sanctuary", 
        example: "We visited an ancient Buddhist temple." 
    },
    { 
        id: 905, 
        word: "tenderness", 
        definition: "A gentle, loving, or kind feeling or quality.", 
        synonyms: "affection, kindness", 
        example: "She treated the injured bird with great tenderness." 
    },
    { 
        id: 906, 
        word: "terminal", 
        definition: "Extreme, or (of a disease) leading to death.", 
        synonyms: "incurable, fatal", 
        example: "He was diagnosed with a terminal illness." 
    },
    { 
        id: 907, 
        word: "terminate", 
        definition: "To (cause something to) end or stop.", 
        synonyms: "end, conclude", 
        example: "They terminated the contract." 
    },
    { 
        id: 908, 
        word: "territory", 
        definition: "Area of land controlled by a government or ruler.", 
        synonyms: "region, land", 
        example: "The army entered enemy territory." 
    },
    { 
        id: 909, 
        word: "the rest of", 
        definition: "The remaining part of something.", 
        synonyms: "remainder, others", 
        example: "I spent the rest of the day reading." 
    },
    { 
        id: 910, 
        word: "thoughtless", 
        definition: "Not considering how your actions or words may upset someone.", 
        synonyms: "inconsiderate, rude", 
        example: "It was thoughtless of him to forget your birthday." 
    },
    { 
        id: 911, 
        word: "throughout", 
        definition: "In every part, or during the whole period of time.", 
        synonyms: "all over, during", 
        example: "It rained throughout the night." 
    },
    { 
        id: 912, 
        word: "throw", 
        definition: "To send something through the air with force, especially by a sudden movement of the arm.", 
        synonyms: "toss, cast", 
        example: "Don't throw stones at the window." 
    },
    { 
        id: 913, 
        word: "throw out", 
        definition: "To get rid of something that you do not want any more.", 
        synonyms: "discard, dispose of", 
        example: "I threw out all my old clothes." 
    },
    { 
        id: 914, 
        word: "thunderstorm", 
        definition: "A storm with thunder and lightning and usually heavy rain.", 
        synonyms: "-", 
        example: "The plane was grounded due to a thunderstorm." 
    },
    { 
        id: 915, 
        word: "tomb", 
        definition: "A place where a dead person is buried, usually with a stone structure.", 
        synonyms: "grave, mausoleum", 
        example: "They discovered an ancient Egyptian tomb." 
    },
    { 
        id: 916, 
        word: "tough", 
        definition: "Strong; not easily broken or made weaker.", 
        synonyms: "strong, hard", 
        example: "He is a tough guy." 
    },
    { 
        id: 917, 
        word: "trace", 
        definition: "To discover the causes or origins of something.", 
        synonyms: "track, follow", 
        example: "Police are trying to trace the missing woman." 
    },
    { 
        id: 918, 
        word: "trade", 
        definition: "The activity of buying and selling, or exchanging, goods and/or services.", 
        synonyms: "commerce, business", 
        example: "International trade is important for the economy." 
    },
    { 
        id: 919, 
        word: "traditional", 
        definition: "Following or belonging to the customs or ways of behaving that have continued in a group of people for a long time.", 
        synonyms: "conventional, customary", 
        example: "It is traditional to eat turkey on Thanksgiving." 
    },
    { 
        id: 920, 
        word: "trail", 
        definition: "A path through a countryside, mountain, or forest area.", 
        synonyms: "path, track", 
        example: "We followed a trail through the forest." 
    },
    { 
        id: 921, 
        word: "train", 
        definition: "To prepare someone or yourself for a job, activity, or sport, by learning skills and/or by mental or physical exercise.", 
        synonyms: "teach, coach", 
        example: "He is training for the marathon." 
    },
    { 
        id: 922, 
        word: "transmit", 
        definition: "To broadcast something, or to send out or carry signals.", 
        synonyms: "broadcast, send", 
        example: "The game was transmitted live via satellite." 
    },
    { 
        id: 923, 
        word: "trash", 
        definition: "Waste material or things that are no longer wanted or needed.", 
        synonyms: "garbage, rubbish", 
        example: "Please take out the trash." 
    },
    { 
        id: 924, 
        word: "treasure", 
        definition: "Very valuable things, usually in the form of a store of precious metals, precious stones, or money.", 
        synonyms: "fortune, riches", 
        example: "Pirates buried their treasure on the island." 
    },
    { 
        id: 925, 
        word: "treat", 
        definition: "To behave towards someone or deal with something in a particular way.", 
        synonyms: "handle, deal with", 
        example: "He treats his employees well." 
    },
    { 
        id: 926, 
        word: "trick", 
        definition: "An action that is intended to deceive, either as a way of cheating someone, or as a joke or form of entertainment.", 
        synonyms: "deception, stunt", 
        example: "He played a trick on his sister." 
    },
    { 
        id: 927, 
        word: "trim", 
        definition: "To make something tidier or more level by cutting a small amount off it.", 
        synonyms: "cut, clip", 
        example: "I need to have my hair trimmed." 
    },
    { 
        id: 928, 
        word: "tripe", 
        definition: "The covering of the stomach of an animal, such as a cow, used as food.", 
        synonyms: "-", 
        example: "Tripe soup is popular in some countries." 
    },
    { 
        id: 929, 
        word: "truthful", 
        definition: "Honest and not containing any lies.", 
        synonyms: "honest, sincere", 
        example: "She was always truthful with her parents." 
    },
    { 
        id: 930, 
        word: "turn in", 
        definition: "To go to bed.", 
        synonyms: "go to sleep", 
        example: "I'm tired, I think I'll turn in." 
    },
    { 
        id: 931, 
        word: "unattended", 
        definition: "Not being watched or taken care of.", 
        synonyms: "alone, abandoned", 
        example: "Do not leave your luggage unattended." 
    },
    { 
        id: 932, 
        word: "unbearable", 
        definition: "Too painful or unpleasant for you to continue to experience.", 
        synonyms: "intolerable, insufferable", 
        example: "The heat was unbearable." 
    },
    { 
        id: 933, 
        word: "uncultured", 
        definition: "Not having good manners or education.", 
        synonyms: "rude, coarse", 
        example: "He was considered uncultured by the elite." 
    },
    { 
        id: 934, 
        word: "undermine", 
        definition: "To make someone less confident, less powerful, or less likely to succeed.", 
        synonyms: "weaken, sabotage", 
        example: "Criticism just undermines their confidence." 
    },
    { 
        id: 935, 
        word: "undertake", 
        definition: "To do or begin to do something, especially something that will take a long time or be difficult.", 
        synonyms: "take on, attempt", 
        example: "He undertook a dangerous mission." 
    },
    { 
        id: 936, 
        word: "unfortunate", 
        definition: "Unlucky or having bad effects.", 
        synonyms: "unlucky, regrettable", 
        example: "It was an unfortunate accident." 
    },
    { 
        id: 937, 
        word: "unlimited", 
        definition: "Not limited; having the greatest possible amount, number, or level.", 
        synonyms: "boundless, infinite", 
        example: "You have unlimited access to the internet." 
    },
    { 
        id: 938, 
        word: "unreliable", 
        definition: "Not able to be trusted or believed.", 
        synonyms: "untrustworthy, dependable", 
        example: "Public transport here is very unreliable." 
    },
    { 
        id: 939, 
        word: "untimely", 
        definition: "Happening too soon or sooner than you expected.", 
        synonyms: "premature, early", 
        example: "His untimely death shocked everyone." 
    },
    { 
        id: 940, 
        word: "unusual", 
        definition: "Different from others of the same type in a way that is surprising, interesting, or attractive.", 
        synonyms: "strange, rare", 
        example: "It's unusual for him to be late." 
    },
    { 
        id: 941, 
        word: "unwind", 
        definition: "To relax and allow your mind to be free from worry after a period of work or some other activity.", 
        synonyms: "relax, chill out", 
        example: "I like to unwind with a good book." 
    },
    { 
        id: 942, 
        word: "upgrade", 
        definition: "To improve the quality or usefulness of something.", 
        synonyms: "improve, modernize", 
        example: "We need to upgrade our computer system." 
    },
    { 
        id: 943, 
        word: "urgent", 
        definition: "Needing attention very soon, especially before anything else, because important.", 
        synonyms: "pressing, critical", 
        example: "This is an urgent message." 
    },
    { 
        id: 944, 
        word: "vacation", 
        definition: "A time when someone does not go to work or school but is free to do what they want, such as travel or relax.", 
        synonyms: "holiday, break", 
        example: "We are going on vacation next week." 
    },
    { 
        id: 945, 
        word: "vague", 
        definition: "Not clearly expressed, known, described, or decided.", 
        synonyms: "unclear, indistinct", 
        example: "He gave a vague answer." 
    },
    { 
        id: 946, 
        word: "valley", 
        definition: "An area of low land between hills or mountains.", 
        synonyms: "dale, hollow", 
        example: "The river runs through the valley." 
    },
    { 
        id: 947, 
        word: "vanish", 
        definition: "To disappear or stop being present or existing, especially in a sudden, surprising way.", 
        synonyms: "disappear, fade", 
        example: "The magician made the rabbit vanish." 
    },
    { 
        id: 948, 
        word: "variety", 
        definition: "A different type of something.", 
        synonyms: "diversity, assortment", 
        example: "The store offers a wide variety of goods." 
    },
    { 
        id: 949, 
        word: "vast", 
        definition: "Extremely big.", 
        synonyms: "huge, enormous", 
        example: "A vast amount of money was spent." 
    },
    { 
        id: 950, 
        word: "vet", 
        definition: "A person with a medical degree trained to take care of the health of animals.", 
        synonyms: "veterinarian", 
        example: "We took our cat to the vet." 
    },
{ 
        id: 951, 
        word: "via", 
        definition: "Going through or stopping at a place on the way to another place.", 
        synonyms: "by way of, through", 
        example: "We flew to Athens via Paris." 
    },
    { 
        id: 952, 
        word: "viable", 
        definition: "Able to work as intended or able to succeed.", 
        synonyms: "feasible, workable", 
        example: "The company needs a viable financial plan." 
    },
    { 
        id: 953, 
        word: "vibrant", 
        definition: "Energetic, exciting, and full of enthusiasm.", 
        synonyms: "lively, vivid", 
        example: "She has a vibrant personality." 
    },
    { 
        id: 954, 
        word: "victim", 
        definition: "Someone or something that has been hurt, damaged, or killed.", 
        synonyms: "casualty, sufferer", 
        example: "He was a victim of a crime." 
    },
    { 
        id: 955, 
        word: "victory", 
        definition: "An occasion when you win a game, competition, election, war, etc.", 
        synonyms: "triumph, win", 
        example: "They celebrated their victory." 
    },
    { 
        id: 956, 
        word: "view", 
        definition: "An opinion, belief, or idea, or a way of thinking about something.", 
        synonyms: "opinion, perspective", 
        example: "What is your view on this matter?" 
    },
    { 
        id: 957, 
        word: "vigorously", 
        definition: "In a way that is very forceful or energetic.", 
        synonyms: "strongly, energetically", 
        example: "He vigorously denied the accusations." 
    },
    { 
        id: 958, 
        word: "violate", 
        definition: "To break or act against something, especially a law, agreement, principle, or something that should be treated with respect.", 
        synonyms: "breach, infringe", 
        example: "They violated the ceasefire agreement." 
    },
    { 
        id: 959, 
        word: "violent", 
        definition: "Using force to hurt or attack.", 
        synonyms: "aggressive, brutal", 
        example: "He has a violent temper." 
    },
    { 
        id: 960, 
        word: "virtually", 
        definition: "Almost.", 
        synonyms: "practically, nearly", 
        example: "It is virtually impossible to predict the future." 
    },
    { 
        id: 961, 
        word: "virtue", 
        definition: "A good moral quality in a person, or the general quality of being morally good.", 
        synonyms: "merit, goodness", 
        example: "Patience is a virtue." 
    },
    { 
        id: 962, 
        word: "visible", 
        definition: "Able to be seen.", 
        synonyms: "observable, clear", 
        example: "The stars were visible in the dark sky." 
    },
    { 
        id: 963, 
        word: "vision", 
        definition: "The ability to see.", 
        synonyms: "sight, eyesight", 
        example: "She has very good vision." 
    },
    { 
        id: 964, 
        word: "vital", 
        definition: "Necessary for the success or continued existence of something; extremely important.", 
        synonyms: "essential, crucial", 
        example: "It is vital to be honest." 
    },
    { 
        id: 965, 
        word: "vivid", 
        definition: "Producing powerful feelings or strong, clear images in the mind.", 
        synonyms: "clear, bright", 
        example: "I have vivid memories of my childhood." 
    },
    { 
        id: 966, 
        word: "vocation", 
        definition: "A type of work that you feel you are suited to doing and to which you should give all your time and energy.", 
        synonyms: "calling, career", 
        example: "Teaching is not just a job, it's a vocation." 
    },
    { 
        id: 967, 
        word: "voice", 
        definition: "To say what you think about a particular subject.", 
        synonyms: "express, articulate", 
        example: "He voiced his concern about the new policy." 
    },
    { 
        id: 968, 
        word: "void", 
        definition: "A large hole or empty space.", 
        synonyms: "emptiness, gap", 
        example: "She felt a great void in her life." 
    },
    { 
        id: 969, 
        word: "volunteer", 
        definition: "A person who does something, especially helping other people, willingly and without being forced or paid to do it.", 
        synonyms: "-", 
        example: "She works as a volunteer at the hospital." 
    },
    { 
        id: 970, 
        word: "vote (for)", 
        definition: "To express your choice or opinion, especially by officially writing a mark on a paper.", 
        synonyms: "elect, choose", 
        example: "I voted for the Green Party." 
    },
    { 
        id: 971, 
        word: "vow", 
        definition: "To make a determined decision or promise to do something.", 
        synonyms: "promise, swear", 
        example: "He vowed to find the killer." 
    },
    { 
        id: 972, 
        word: "voyage", 
        definition: "A long journey, especially by ship.", 
        synonyms: "journey, trip", 
        example: "The voyage to India took six weeks." 
    },
    { 
        id: 973, 
        word: "vulnerable", 
        definition: "Able to be easily physically, emotionally, or mentally hurt, influenced, or attacked.", 
        synonyms: "susceptible, weak", 
        example: "Old people are particularly vulnerable to the flu." 
    },
    { 
        id: 974, 
        word: "wage", 
        definition: "A particular amount of money that is paid, usually every week, to an employee.", 
        synonyms: "salary, pay", 
        example: "The minimum wage has increased." 
    },
    { 
        id: 975, 
        word: "wander", 
        definition: "To walk around slowly in a relaxed way or without any clear purpose or direction.", 
        synonyms: "roam, stroll", 
        example: "We wandered through the forest." 
    },
    { 
        id: 976, 
        word: "wantonly", 
        definition: "In a way that is intentional and causes harm without any reason.", 
        synonyms: "recklessly, maliciously", 
        example: "The building was wantonly destroyed." 
    },
    { 
        id: 977, 
        word: "warn", 
        definition: "To make someone realize a possible danger or problem.", 
        synonyms: "alert, caution", 
        example: "I warned him not to go there." 
    },
    { 
        id: 978, 
        word: "waste", 
        definition: "To use too much of something or use something badly.", 
        synonyms: "squander, misuse", 
        example: "Don't waste your money on useless things." 
    },
    { 
        id: 979, 
        word: "wealth", 
        definition: "A large amount of money or valuable possessions that someone has.", 
        synonyms: "fortune, riches", 
        example: "He accumulated great wealth." 
    },
    { 
        id: 980, 
        word: "weapon", 
        definition: "Any object used in fighting or war, such as a gun, bomb, knife, etc.", 
        synonyms: "arm", 
        example: "The police found a weapon in his car." 
    },
    { 
        id: 981, 
        word: "wear", 
        definition: "To have clothing, jewellery, etc. on your body.", 
        synonyms: "dress in", 
        example: "She was wearing a red dress." 
    },
    { 
        id: 982, 
        word: "weep", 
        definition: "To cry tears.", 
        synonyms: "cry, sob", 
        example: "She wept when she heard the news." 
    },
    { 
        id: 983, 
        word: "weigh", 
        definition: "To have a heaviness of a stated amount, or to measure the heaviness of an object.", 
        synonyms: "-", 
        example: "How much do you weigh?" 
    },
    { 
        id: 984, 
        word: "welfare", 
        definition: "Physical and mental health and happiness.", 
        synonyms: "well-being", 
        example: "Parents are responsible for the welfare of their children." 
    },
    { 
        id: 985, 
        word: "whirl", 
        definition: "To turn or spin around very quickly.", 
        synonyms: "spin, rotate", 
        example: "Leaves whirled in the wind." 
    },
    { 
        id: 986, 
        word: "wholly", 
        definition: "Completely.", 
        synonyms: "entirely, fully", 
        example: "I wholly agree with you." 
    },
    { 
        id: 987, 
        word: "widely", 
        definition: "Including a lot of different places, people, subjects, etc.", 
        synonyms: "broadly, extensively", 
        example: "English is widely spoken around the world." 
    },
    { 
        id: 988, 
        word: "widespread", 
        definition: "Existing or happening in many places and/or among many people.", 
        synonyms: "common, prevalent", 
        example: "There is widespread support for the new law." 
    },
    { 
        id: 989, 
        word: "widow", 
        definition: "A woman whose husband has died and who has not married again.", 
        synonyms: "-", 
        example: "She became a widow at the age of 40." 
    },
    { 
        id: 990, 
        word: "wisdom", 
        definition: "The ability to use your knowledge and experience to make good decisions and judgments.", 
        synonyms: "insight, prudence", 
        example: "He is a man of great wisdom." 
    },
    { 
        id: 991, 
        word: "withdraw", 
        definition: "To take or move out or back, or to remove.", 
        synonyms: "remove, extract", 
        example: "He withdrew $100 from the bank." 
    },
    { 
        id: 992, 
        word: "withdrawn", 
        definition: "Shy and quiet and preferring to be alone rather than with other people.", 
        synonyms: "introverted, reserved", 
        example: "He became withdrawn after his wife died." 
    },
    { 
        id: 993, 
        word: "wither", 
        definition: "To become weak and dry and decay.", 
        synonyms: "dry up, shrivel", 
        example: "The flowers withered in the heat." 
    },
    { 
        id: 994, 
        word: "withhold", 
        definition: "To refuse to give something or to keep back something.", 
        synonyms: "keep back, conceal", 
        example: "She withheld the truth from the police." 
    },
    { 
        id: 995, 
        word: "witness", 
        definition: "A person who sees an event happening, especially a crime or an accident.", 
        synonyms: "observer, onlooker", 
        example: "Police are looking for witnesses to the accident." 
    },
    { 
        id: 996, 
        word: "worthless", 
        definition: "Having no value in money.", 
        synonyms: "valueless, useless", 
        example: "The painting turned out to be worthless." 
    },
    { 
        id: 997, 
        word: "wound", 
        definition: "A damaged area of the body, such as a cut or hole in the skin or flesh.", 
        synonyms: "injury, cut", 
        example: "He died from a gunshot wound." 
    },
    { 
        id: 998, 
        word: "yard", 
        definition: "A piece of land next to a house, usually used for growing flowers, grass, and other plants.", 
        synonyms: "garden", 
        example: "The children are playing in the yard." 
    },
    { 
        id: 999, 
        word: "yield", 
        definition: "To supply or produce something positive such as a profit, an amount of food or information.", 
        synonyms: "produce, generate", 
        example: "The investigation yielded some interesting results." 
    },
    { 
        id: 1000, 
        word: "zip", 
        definition: "A device consisting of two rows of metal or plastic teeth-like parts that are brought together by sliding a small piece along them.", 
        synonyms: "zipper, fastener", 
        example: "The zip on my jacket is broken." 
    }
];