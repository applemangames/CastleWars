extends Node2D


var card_scene = load("res://Scenes/Card.tscn")
var playing_player = 1
var played = false

# Called when the node enters the scene tree for the first time.
func _ready():
    $Player1.show_cards()
    $Player1.active()
    $Player2.is_human = false


func toogle(player1, player2):
    print("Now is playing " + player2.NAME)
    player2.get_node("Status").produce_all_materials()
    player2.show_cards()
    player1.hide_cards()
    player2.active()
    player1.deactive()
    

func change_player():        
    if playing_player == 1:
        playing_player = 2
        toogle(find_node("Player1"), find_node("Player2"))
    else: if playing_player == 2:
        playing_player = 1
        toogle(find_node("Player2"), find_node("Player1"))


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
    card.find_node("Action").text = card.description
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
        card.description = line[4].split(', ').join("\n").split('.').join("\n  ").strip_edges()
        card.is_human_card = for_human
        card_deck.append(create_card(card))
    file.close()
    return card_deck


func _on_DropCardsButton_pressed():
    var label = find_node("DropCardsLabel")
    if !label.visible:
        find_node("Player"+str(playing_player)).select_cards()
    else:
        find_node("Player"+str(playing_player)).drop_cards()
    
    label.visible = !label.visible
        
