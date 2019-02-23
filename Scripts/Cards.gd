extends "Player.gd"

export (int) var PLAYER_NUM = 1
export (int) var CARDS_NUM = 8
export (int) var SPACE_BETWEEN_CARDS = 20


var all_cards = []
var deck_cards = []
var played_cards = []
var moving_cards = []



func _ready(): 
    all_cards = $"/root/Game/".load_cards(is_human)
    
    for i in CARDS_NUM:
        var card_position = Vector2(0.0, 0.0)
        var card_width = all_cards[0].get_width()
        card_position.x = (card_width + SPACE_BETWEEN_CARDS) * i 
        add_new_card_to_deck(card_position + $"CardDeck".rect_position, true)
        
    

func _process(delta):
    for card in moving_cards:
        var to_pos = card.move_to_position
        var diff_pos = to_pos - card.position

        if round(to_pos.x) != round(card.position.x) or round(to_pos.y) != round(card.position.y):
            card.position.x += diff_pos.x * delta * 8
            card.position.y += diff_pos.y * delta * 8
        else:
            if card.moving_type == "to_played":
                add_card_into_played(card)
                add_new_card_to_deck(card.move_from_position, false)
                card.moving_type = ""
                
                #moving_cards.erase(card)
            if card.moving_type == "to_deck":
                remove_child(card)
                deck_cards.append(card)
                card.position -= $"CardDeck".rect_position
                $"CardDeck".add_child(card)
                card.show()
                card.moving_type = ""
                card.position += Vector2(0.1, 0.1) 
                
                if !card.on_start_game:
                    $"/root/Game/".change_player()
                    
            moving_cards.erase(card)
       
        
                

func play_card(card):
    card.is_played = true
    remove_from_deck(card)
    move_to_played(card)
    
    
func remove_from_deck(card):
    var index = deck_cards.find(card)
    deck_cards.remove(index)
    $"CardDeck".remove_child(card)


func move_to_played(card):
    add_child(card)
    
    var goal_pos = $"/root/Game/Cards/Played".position + $"/root/Game/Cards".position
    card.move_from_position = card.position
    card.position += $"CardDeck".rect_position 
    card.move_from_position = card.position
    card.move_to_position = goal_pos
    card.moving_type = "to_played"
    moving_cards.append(card)
        
    
func add_card_into_played(card):
    var played = get_node("/root/Game/Cards/Played")
    remove_child(card)
    card.position = Vector2(0.0, 0.0)
    for child in played.get_children():
        child.z_index += 10
        child.is_played = false
        #child.moving_type = ""
        played.remove_child(child)
        
    card.z_index -= 10
    played.add_child(card)
    played_cards.append(card)
    

func add_new_card_to_deck(card_position, on_start_game):
    
    if all_cards.size() == 0:
        while played_cards.size() > 1:
            var card2 = played_cards.pop_front()
            card2.reset_variables()
            all_cards.append(card2)
            
    #randomize()
    all_cards.shuffle()
    var card = all_cards.pop_front()
    print(all_cards)
    print(moving_cards)
    
    card.position = $"/root/Game/Cards".position
    add_child(card)
    card.move_from_position = card.position
    card.move_to_position = card_position
    card.moving_type = "to_deck"
    
    moving_cards.append(card)
    card.on_start_game = on_start_game
    if !on_start_game: 
        card.show()
    
     