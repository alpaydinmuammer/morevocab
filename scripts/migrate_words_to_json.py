import re
import json
import os

def parse_dart_file(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Regex to find WordCard instantiations
    # This is a bit complex because of nested braces in meanings map
    # We will try to match individual WordCard(...) blocks roughly
    
    word_cards = []
    
    # Strategy: Find "WordCard(" and then count matching parentheses to find the end
    start_indices = [m.start() for m in re.finditer(r'WordCard\(', content)]
    
    for start in start_indices:
        balance = 0
        end = -1
        for i in range(start, len(content)):
            if content[i] == '(':
                balance += 1
            elif content[i] == ')':
                balance -= 1
                if balance == 0:
                    end = i + 1
                    break
        
        if end != -1:
            block = content[start:end]
            card = parse_word_card(block)
            if card:
                word_cards.append(card)
                
    return word_cards

def parse_word_card(block):
    card = {}
    
    # Extract ID
    id_match = re.search(r'id:\s*(\d+)', block)
    if id_match:
        card['id'] = int(id_match.group(1))
        
    # Extract Word
    word_match = re.search(r'word:\s*[\'"](.*?)[\'"]', block)
    if word_match:
        card['word'] = word_match.group(1)
        
    # Extract Meanings
    # Find meanings: { ... } block
    meanings_match = re.search(r'meanings:\s*\{(.*?)\}', block, re.DOTALL)
    if meanings_match:
        meanings_block = meanings_match.group(1)
        meanings = {}
        # Find 'en': '...' entries
        pairs = re.finditer(r'[\'"](\w+)[\'"]:\s*[\'"](.*?)[\'"]', meanings_block)
        for p in pairs:
            meanings[p.group(1)] = p.group(2)
        card['meanings'] = meanings
        
    # Extract Example Sentence
    # Handle single quotes properly, sometimes they are escaped or string is in double quotes
    example_match = re.search(r'exampleSentence:\s*(?:\'\'\'(.*?)\'\'\'|\"(.*?)\"|\'(.*?)\')', block, re.DOTALL)
    if example_match:
        # group 1: triple, 2: double, 3: single
        val = example_match.group(1) or example_match.group(2) or example_match.group(3)
        if val:
            card['exampleSentence'] = val.replace("\\'", "'").strip()

    # Extract Local Asset
    asset_match = re.search(r'localAsset:\s*[\'"](.*?)[\'"]', block)
    if asset_match:
        card['localAsset'] = asset_match.group(1).replace('\n', '').replace(' ', '').replace("'+'", "")

    # Extract Difficulty
    diff_match = re.search(r'difficulty:\s*(\d+)', block)
    if diff_match:
        card['difficulty'] = int(diff_match.group(1))
    else:
        card['difficulty'] = 1 # Default
        
    # Extract Deck
    deck_match = re.search(r'deck:\s*WordDeck\.(\w+)', block)
    if deck_match:
        card['deck'] = deck_match.group(1)
    else:
        card['deck'] = 'mixed' # Default
        
    return card

def main():
    dart_file = r'lib\data\datasources\word_local_datasource.dart'
    output_file = r'assets\data\words.json'
    
    if not os.path.exists(dart_file):
        print(f"Error: {dart_file} not found")
        return

    print("Parsing Dart file...")
    cards = parse_dart_file(dart_file)
    print(f"Found {len(cards)} cards.")
    
    # Sort by ID just in case
    cards.sort(key=lambda x: x.get('id', 0))
    
    print("Writing to JSON...")
    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump(cards, f, ensure_ascii=False, indent=2)
        
    print(f"Success! Written to {output_file}")

if __name__ == '__main__':
    main()
