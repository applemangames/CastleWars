extends Node2D

var contains_effect = {
    "castle": "TowerSize",
    "wall": "WallSize",
    "builder": "BuilderNum",
    "soldier": "SoldierNum",
    "wizard": "WizardNum",
    "brick": "BrickNum",
    "weapon": "WeaponNum",
    "crystal": "CrystalNum"
}


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


func take_effect_by_description(description: String):
    var enemy = false
    var effects = description.split("\n")
    for effect in effects:
        var effect_count = int(effect.split(" ")[-1])

        if contains(effect, "attack"):
            make_attack(effect_count)
        elif contains(effect, "enemy"):
            enemy = true
        elif contains(effect, "all resources"):
            take_resources_effect(true, effect_count, enemy)
        elif contains(effect, "resources"):
            take_resources_effect(false, effect_count, enemy)
        else:
            for key in contains_effect:
                if contains(effect, key):
                    take_effect(contains_effect[key], effect_count, enemy)
                    break


func take_effect(target: String, effect: int, enemy: bool = false):
    var node = get_player(enemy).find_node(target)
    var result = int(node.text) + effect
    if result > 0:
        node.text = str(result)
        take_moving_effect(get_player(enemy), target, effect)
    else:
        node.text = "0"
        take_moving_effect(get_player(enemy), target, effect + result)
        
        
func take_moving_effect(player, target, value):
    if target == "TowerSize":
        player.move("Castle", value)
    elif target == "WallSize":
        player.move("Wall", value)
        

func make_attack(attack_size: int):
    var castle = get_player(true).find_node("TowerSize")
    var wall = get_player(true).find_node("WallSize")
    var wall_size = int(wall.text)
    
    if wall_size > 0:
        if wall_size >= attack_size:
            take_effect("WallSize", -attack_size, true)
        else:
            take_effect("TowerSize", -(attack_size - wall_size), true)
            take_effect("WallSize", -wall_size, true)
    else:
        take_effect("TowerSize", -attack_size, true)
        
    if int(castle.text) <= 0:
        print("END GAME")
    

func take_resources_effect(all, effect_count, enemy):
    take_effect("BrickNum", effect_count, enemy)
    take_effect("WeaponNum", effect_count, enemy)
    take_effect("CrystalNum", effect_count, enemy)
    if all:
        take_effect("BuilderNum", effect_count, enemy)
        take_effect("SoldierNum", effect_count, enemy)
        take_effect("WizardNum", effect_count, enemy)
        take_effect("TowerSize", effect_count, enemy)
        take_effect("WallSize", effect_count, enemy)


func get_player(enemy):
    if enemy:
        if get_parent() == $"/root/Game/Player1":
            return $"/root/Game/Player2"
        else:
            return $"/root/Game/Player1"
    else:
        return get_parent()
        
            
func contains(string: String, sub: String) -> bool:
    if string.find(sub) != -1:
        return true
    else:
        return false
        