extends "Player.gd"

export (int) var PLAYER_NUM = 1
export (int) var CARDS_NUM = 8
export (int) var SPACE_BETWEEN_CARDS = 20


var all_cards = []
var deck_cards = []
var played_cards = []
var moving_cards = {}

func _ready():    
    all_cards = $"/root/Game/".load_cards()
    
    for i in CARDS_NUM:   
        var card_position = Vector2(0.0, 0.0)
        var card_width = all_cards[0].get_width()
        card_position.x = (card_width + SPACE_BETWEEN_CARDS) * i
        add_new_card_to_deck(card_position)
        

func _process(delta):
    for card in moving_cards.keys():
        var pos = moving_cards[card]
        var diff_pos = pos - card.position 
        
        if round(pos.x) != round(card.position.x) or round(pos.y) != round(card.position.y):
            card.position.x += diff_pos.x * delta * 7
            card.position.y += diff_pos.y * delta * 7
        else:
            print("played")
            moving_cards.erase(card)
            add_card_into_played(card)
            add_new_card_to_deck(card.deck_position)


func play_card(card):
    var card_position = card.position
    remove_from_deck(card)
    move_to_played(card)
    #add_card_into_played(card)
    card.is_played = true
    
    #add_new_card_to_deck(card_position)
    
    
func remove_from_deck(card):
    var card_deck = $"./CardDeck"
    var index = deck_cards.find(card)
    deck_cards.remove(index)
    card_deck.remove_child(card)


func move_to_played(card):
    add_child(card)
    
    var goal_pos = $"Cards/Played".position + $"Cards".position
    card.deck_position = card.position
    card.position += $"CardDeck".rect_position 
    moving_cards[card] = goal_pos
    

func add_card_into_played(card):
    var played = get_node("Cards/Played")
    remove_child(card)
    card.position = Vector2(0.0, 0.0)
    for child in played.get_children():
        played.remove_child(child)
        
    card.z_index -= 10
    played.add_child(card)
    played_cards.append(card)
    
    
func add_new_card_to_deck(card_position):
    var deck = get_node("Deck")
    var card_deck = $"./CardDeck"
    randomize()
    var card = all_cards[randi()%29+1].duplicate()
    card.position = card_position
    deck_cards.append(card)
    card_deck.add_child(card)
    
  