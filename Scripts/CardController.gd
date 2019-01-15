extends Node2D


export (int) var CARDS_NUM = 8
export (int) var SPACE_BETWEEN_CARDS = 20


var card_scene = load("res://Scenes/Card.tscn")

func add_card(position):
    var card = card_scene.instance()
    card.position = position
    card.z_index = 100
    card.get_node("Back").visible = false
    card.get_node("Front").visible = true
    add_child(card)


func _ready():
    var start_position = $"/root/Game/CardsPosition".position
    start_position.x = -430
    var width = get_node("Played").get_rect().size.x/2
    print(width)
    #var width = 70.0
    for i in CARDS_NUM:
        start_position.x += i + width + SPACE_BETWEEN_CARDS
        add_card(start_position)
