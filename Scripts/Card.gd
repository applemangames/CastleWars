extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var type = ""
var price = ""
var player = 0
var is_played = false
var deck_position
var move_to_position
var move_from_position
var moving_type = ""

# Called when the node enters the scene tree for the first time.
func _ready():
    pass
    
func get_width():
    return get_node("Front").texture.get_width() * get_node("Front").scale.x
    
func get_height():
    return get_node("Front").texture.get_height() * get_node("Front").scale.y

func see():
    $"Front".visible = true
    $"Back".visible = false
    $"Description".visible = true

func _on_Button_pressed():
    if !is_played:
        var controller = $"../.."
        controller.play_card(self)
