extends Node

@onready var sprite_holder = $SpriteHolder
@onready var flip_button = $FlipButton
@onready var heads = $SpriteHolder/Heads
@onready var tails = $SpriteHolder/Tails
@onready var result_label = $ResultLabel

func _ready():
	randomize()
	heads.visible = false
	tails.visible = false
	result_label.text = "Press Flip to start"

	flip_button.pressed.connect(_on_flip_pressed)


func _on_flip_pressed():
	var result = randi() % 2
	var tween = create_tween()

	# Step 1: shrink horizontally (turning sideways)
	tween.tween_property(sprite_holder, "scale:x", 0.0, 0.15)

	# Step 2: swap the visible side at the midpoint
	tween.tween_callback(func():
		if result == 0:
			heads.visible = true
			tails.visible = false
			result_label.text = "Heads!"
		else:
			heads.visible = false
			tails.visible = true
			result_label.text = "Tails!"
	)

	# Step 3: expand back to full width
	tween.tween_property(sprite_holder, "scale:x", 1.0, 0.15)
