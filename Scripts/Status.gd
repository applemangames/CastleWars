extends Node2D


func produce_all_materials():
    produce_material("Builder", "Brick")
    produce_material("Soldier", "Weapon")
    produce_material("Mage", "Crystal")
  
  
func produce_material(worker, material):
    find_node(material+"Num").text = str(int(find_node(material+"Num").text) + int(find_node(worker+"Num").text))