extends Node2D


var card_scene = load("res://Scenes/Card.tscn")
var playing_player = 1
var played = false

# Called when the node enters the scene tree for the first time.
func _ready():
    $Player1.show_cards()
    $Player1.active()
    $Player2.is_human = false


func change_player():        
    if playing_player != 2:
        print("Now is playing player 2.")
        playing_player = 2
        $Player2/Status.produce_all_materials()
        $Player2.show_cards()
        $Player1.hide_cards()
        $Player2.active()
        $Player1.deactive()
    else: if playing_player != 1:
        print("Now is playing player 1.")
        playing_player = 1
        $Player1/Status.produce_all_materials()
        $Player1.show_cards()
        $Player2.hide_cards()
        $Player1.active()
        $Player2.deactive()


func create_card(card):
    match card.type:
        "builder":
            card.get_node("Front").texture = load("res://Images/card_front_brown.png")
            card.find_node("Currency").text = "bricks"
            card.currency = "Brick"
        "soldier":
            card.get_node("Front").texture = load("res://Images/card_front_green.png")
            card.find_node("Currency").text = "weapons"
            card.currency = "Weapon"
        "wizard":
            card.get_node("Front").texture = load("res://Images/card_front_purple.png")
            card.find_node("Currency").text = "crystals"
            card.currency = "Crystal"
    #card.position = $"./../CardDeck".rect_position
    card.find_node("Name").text = card.name
    card.find_node("Price").text = str(card.price)
    return card


func load_cards(for_human):
    var file = File.new()
    file.open("res://Configs/cards.txt", File.READ)
    var card_deck = []
    
    var line = file.get_line()
    var variable_list = line.split('|')
    while true:
        line = file.get_line()
        if file.eof_reached(): 
            break
        line = line.split('|')
        var card = card_scene.instance()
        card.name = line[1].strip_edges()
        card.type = line[2].strip_edges()
        card.price = int(line[3].strip_edges())
        card.is_human_card = for_human
        card_deck.append(create_card(card))
    file.close()
    return card_deck


func _on_DropCardsButton_pressed():
    var label = find_node("DropCardsLabel")
    label.visible = !label.visible
    match playing_player:
        1: $Player1.drop_cards()
        2: $Player2.drop_cards()
