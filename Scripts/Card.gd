extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var type = ""
var price = ""
var player = 0

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.



func _on_Button_pressed():
    var played = $"/root/Game/".find_node("Played")
    var pos = played.position
    self.z_index += 1
    self.position = pos
    