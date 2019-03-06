extends Node2D

export (String) var NAME = "Player1"
var is_playing = false
var is_human = true
var lock_cards = false


# Called when the node enters the scene tree for the first time.
func _ready():
    if name == "Player2":
        change_tower_start_position("Tower")
        change_status_start_position("Status")
        

func change_tower_start_position(nodeName):
    var node = get_node("Tower")
    var width = node.texture.get_width()
    var window_width = get_viewport().get_texture().get_width()
    node.position.x = window_width - node.position.x
    node.position.y = node.position.y


func change_status_start_position(nodeName):
    var node = get_node("Status")
    var image = node.get_node("StatusImage")
    var width = image.texture.get_width() * image.scale.x
    var window_width = get_viewport().get_texture().get_width()
    node.position.x = window_width - (node.position.x + width)
    node.position.y = node.position.y
    
    
        
func show_cards():
    is_playing = true
    get_node("CardDeck").visible = true
    lock_cards = false
    check_cards_prices()
    
    
func check_cards_prices():
    var status = get_node("Status")
    print($"./Status/VBoxContainer/BrickNum".text)
    
    var material_num = {
        "builder": int($"./Status/VBoxContainer/BrickNum".text),
        "soldier": int($"./Status/VBoxContainer/WeaponNum".text),
        "wizard": int($"./Status/VBoxContainer/CrystalNum".text)
    }
    
    for card in get_node("CardDeck").get_children():
        print(card)
        if card.price >= material_num[card.type]:
            card.disable()
        else:
            card.enable()
    
    
func hide_cards():
    is_playing = false
    get_node("CardDeck").visible = false
    lock_cards = true
    

    