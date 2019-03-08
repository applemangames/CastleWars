extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var type 
var price 
var currency
var player = 0
var is_played = false
var deck_position
var move_to_position
var move_from_position
var moving_type = ""
var on_start_game = false
var is_human_card = true
var disable = false
var drop = false

   

func get_width():
    return get_node("Front").texture.get_width() * get_node("Front").scale.x
    
func get_height():
    return get_node("Front").texture.get_height() * get_node("Front").scale.y

func reset_variables():
    is_played = false
    deck_position = ""
    move_to_position = ""
    move_from_position = ""
    moving_type = ""
    on_start_game = false
    
    
func show():
    if is_human_card:
        $"Front".visible = true
        $"Back".visible = false
        $"Description".visible = true
        
        
func disable():
    $"./Front".modulate = Color(0.3,0.3,0.3,1)
    self.disable = true
    
func enable():
    $"./Front".modulate = Color(1,1,1,1)
    self.disable = false
    
    
func _on_Button_pressed():
    var controller = $"../.."
    if controller.get_path() == "/root/Game":
        controller = $".."
        controller.lock_cards = false
    
    if controller.drop_mode:
        drop = !drop
        position.y -= 20 * int(drop)
    
    if (
        !is_played and !controller.drop_mode and !disable and
        !controller.lock_cards and moving_type != "to_deck"
    ):
        controller.play_card(self)
        controller.lock_cards = true
        
