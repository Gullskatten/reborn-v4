extends Control

@onready var time_label = $GUI/CanvasLayer/DebugTimeLabel
@onready var fps_label = $GUI/CanvasLayer/DebugFPSLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	InTime.connect("current_minute_changed", _update_time_text)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fps_label.text = "FPS: " + str(Engine.get_frames_per_second()).pad_zeros(4)


func _update_time_text():
	time_label.text = InTime.current_cycle_to_string() + " " + InTime.current_time_string()
