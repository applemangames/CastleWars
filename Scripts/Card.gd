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
var on_start_game = false
var is_human_card = true

# Called when the node enters the scene tree for the first time.
func _ready():
    pass
    
func get_width():
    return get_node("Front").texture.get_width() * get_node("Front").scale.x
    
func get_height():
    return get_node("Front").texture.get_height() * get_node("Front").scale.y

    
func show():
    if is_human_card:
        $"Front".visible = true
        $"Back".visible = false
        $"Description".visible = true
    
func _on_Button_pressed():
    var controller = $"../.."
    if controller.get_path() == "/root/Game":
        controller = $".."
        controller.lock_cards = false
    
    if !is_played and !controller.lock_cards:
        controller.play_card(self)
        controller.lock_cards = true
        
