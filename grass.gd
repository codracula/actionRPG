extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func create_grass_effect():
	var grassEffect = load("res://grass_effect.tscn").instantiate()
	var main = get_tree().current_scene  #get parent node
	main.add_child(grassEffect)   #add grass instance to the parent node ( so it stays after grass disappear)
	grassEffect.global_position = global_position
	
func _on_hurtbox_area_entered(area):
	
	create_grass_effect()
	queue_free()
	
