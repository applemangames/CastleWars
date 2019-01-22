extends Node2D


export (int) var PLAYER_NUM = 1
export (int) var CARDS_NUM = 8
export (int) var SPACE_BETWEEN_CARDS = 20


var card_scene = load("res://Scenes/Card.tscn")
var all_cards = []
var player_cards = []

func _ready():
    all_cards = load_cards()
    
    var start_position = $"/root/Game/CardsPosition".position
    start_position.x = -350
    #print(selected_card.name, selected_card.type)

    var width = 70.0
    for i in CARDS_NUM:
        var card = all_cards[randi()%29+1].duplicate()
        start_position.x += i + width + SPACE_BETWEEN_CARDS 
        card.position = start_position 
        card.player = PLAYER_NUM
        add_child(card)
        player_cards.append(card)



func create_card(card):
    match card.type:
        "builder":
            card.get_node("Front").texture = load("res://Images/card_front_brown.png")
            card.find_node("Currency").text = "bricks"
        "soldier":
            card.get_node("Front").texture = load("res://Images/card_front_green.png")
            card.find_node("Currency").text = "weapons"
        "wizard":
            card.get_node("Front").texture = load("res://Images/card_front_purple.png")
            card.find_node("Currency").text = "crystals"
    card.position = $"/root/Game/CardsPosition".position
    card.find_node("Name").text = card.name
    card.find_node("Price").text = card.price
    return card


func load_cards():
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
        card.price = line[3].strip_edges()
        card_deck.append(create_card(card))
    file.close()
    return card_deck
    
    

