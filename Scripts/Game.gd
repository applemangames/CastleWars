extends Node2D


var card_scene = load("res://Scenes/Card.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
    get_node("Player1").is_playing = true
    #get_node("Player1").all_cards = load_cards()
    #get_node("Player2").all_cards = load_cards()




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
    #card.position = $"./../CardDeck".rect_position
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