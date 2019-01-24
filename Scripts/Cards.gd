extends Node2D


export (int) var PLAYER_NUM = 1
export (int) var CARDS_NUM = 8
export (int) var SPACE_BETWEEN_CARDS = 20


var all_cards = []
var deck_cards = []
var played_cards = []

func _ready():    
    var card_deck = $"./../CardDeck"
    all_cards = $"/root/Game/".load_cards()
    
    for i in CARDS_NUM:
        randomize()
        var card = all_cards[randi()%29+1].duplicate()
        card.position.x += (card.get_width() + SPACE_BETWEEN_CARDS) * i
        deck_cards.append(card)
        card_deck.add_child(card)



func play_card(card):
    var card_deck = $"./../CardDeck"
    var index = deck_cards.find(card)
    deck_cards.remove(index)
    
    var played = get_node("Played")
    card.position = Vector2(0.0, 0.0)
    card_deck.remove_child(card)
    for child in played.get_children():
        played.remove_child(child)
    played.add_child(card)
    
    played_cards.append(card)
    print(played_cards)
    card.is_played = true