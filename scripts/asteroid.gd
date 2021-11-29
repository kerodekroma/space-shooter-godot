extends Area2D

var explosion_scene = preload('res://scenes/Explosion.tscn')
var move_speed = 100.0
var score_emitted = false

signal score
func _ready():
	score_emitted = false
	connect("area_entered", self, "_on_asteroid_area_entered")
	
func _process(delta):
	position -= Vector2(move_speed * delta, 0.0)
	if position.x <= -100:
		queue_free()

func _on_asteroid_area_entered(area):
	if area.is_in_group('shot') and not area.is_in_group('player'):
		if not score_emitted:
			score_emitted = true
			emit_signal('score')
	
	if area.is_in_group('shot') or area.is_in_group('player'):
		# showing the explosion scene
		var stage_node = get_parent()
		var explosion_instance = explosion_scene.instance()
		explosion_instance.position = position
		stage_node.add_child(explosion_instance)
		queue_free()
