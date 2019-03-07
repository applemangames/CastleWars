extends Node2D


func produce_all_materials():
    produce_material("Builder", "Brick")
    produce_material("Soldier", "Weapon")
    produce_material("Wizard", "Crystal")
  
  
func produce_material(worker, material):
    find_node(material+"Num").text = str(int(find_node(material+"Num").text) + int(find_node(worker+"Num").text))
    
    
func remove_material(material, number):
    var material_number = int(find_node(material+"Num").text)
    if (material_number >= number):
        find_node(material+"Num").text = str(material_number - number)
    else:
        find_node(material+"Num").text = "0"
