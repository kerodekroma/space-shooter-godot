extends Node2D

const asteroid = preload("res://scenes/Asteroid.tscn")
const SCREEN_WIDTH = 320
const SCREEN_HEIGHT = 180
var is_game_over = false
var score = 0
const score_format_string = "Score: %s"

func _ready():
	$player.connect("destroyed", self, "_on_player_destroyed")
	$spawn_timer.connect("timeout", self, '_on_spawn_timer_timeout')
	
func _input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	if is_game_over and Input.is_key_pressed(KEY_ENTER):
		get_tree().change_scene("res://scenes/Stage.tscn")

func _on_player_destroyed():
	$ui/retry.show()
	is_game_over = true

func _on_spawn_timer_timeout():
	var asteroid_instance = asteroid.instance()
	asteroid_instance.position = Vector2(SCREEN_WIDTH + 8, rand_range(0, SCREEN_HEIGHT))
	asteroid_instance.connect('score', self, '_on_player_score')
	
	add_child(asteroid_instance)

func _on_player_score():
	score += 5
	$ui/score.text = score_format_string % str(score)
