extends "Player.gd"

export (int) var PLAYER_NUM = 1
export (int) var CARDS_NUM = 8
export (int) var SPACE_BETWEEN_CARDS = 20


var all_cards = []
var deck_cards = []
var played_cards = []
var moving_cards = []
var drop_mode = false



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
                
            if card.moving_type == "to_deck":
                remove_child(card)
                deck_cards.append(card)
                card.position -= $"CardDeck".rect_position
                $"CardDeck".add_child(card)
                check_cards_prices([card])
                card.show()
                card.moving_type = ""
                card.position += Vector2(0.1, 0.1) 
                moving_cards.erase(card)
                
                if moving_cards.size() == 0:
                    $"/root/Game/".change_player()
                    
            moving_cards.erase(card)
                
func drop_card(card):
    card.is_played = true
    card.hide()
    card.find_node("AnimationPlayer").play_backwards("SelectCard")
    remove_from_deck(card)
    move_to_played(card)

func play_card(card):
    card.is_played = true
    remove_from_deck(card)
    move_to_played(card)
    $"./Status".remove_material(card.currency, card.price)
    
    
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
        played.remove_child(child)
        
    card.z_index -= 10
    played.add_child(card)
    played_cards.append(card)
    

func add_new_card_to_deck(card_position, on_start_game):
    if all_cards.empty():
        move_played_cards_into_all_cards()
            
    randomize()
    all_cards.shuffle()
    var card = all_cards.pop_front()
    
    card.position = $"/root/Game/Cards".position
    add_child(card)
    card.move_from_position = card.position
    card.move_to_position = card_position
    card.moving_type = "to_deck"
    
    moving_cards.append(card)
    if !on_start_game: 
        card.show()
    
    
func move_played_cards_into_all_cards():
    while played_cards.size() > 1:
        var card2 = played_cards.pop_front()
        card2.reset_variables()
        all_cards.append(card2)
        
    
    
func show_cards():
    is_playing = true
    get_node("CardDeck").visible = true
    lock_cards = false
    check_cards_prices(deck_cards)
    
    
func check_cards_prices(cards):    
    var material_num = {
        "builder": int($"./Status/VBoxContainer/BrickNum".text),
        "soldier": int($"./Status/VBoxContainer/WeaponNum".text),
        "wizard": int($"./Status/VBoxContainer/CrystalNum".text)
    }
    
    for card in cards:
        if card.price > material_num[card.type]:
            card.disable()
        else:
            card.enable()

   
func hide_cards():
    is_playing = false
    get_node("CardDeck").visible = false
    lock_cards = true
    
    
func select_cards():
    drop_mode = true
    for card in deck_cards:
        card.enable()
 
func drop_cards():
    drop_mode = false
    var drop_cards = []
    for card in deck_cards:
        if card.drop:
            drop_cards.append(card)
    
    for card in drop_cards:
        drop_card(card)
    
    check_cards_prices(deck_cards)
    