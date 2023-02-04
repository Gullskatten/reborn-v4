extends ColorRect

@export_color_no_alpha var color1_dusk = Color( 0.627451, 0.411765, 0.572549, 1 )
@export_color_no_alpha var color2_dusk = Color( 0.619608, 0.219608, 0.32549, 1 )
@export_color_no_alpha var color1_dawn = Color( 0.419608, 0.239216, 0.4, 1 )
@export_color_no_alpha var color2_dawn = Color( 0.741176, 0.45098, 0.219608, 1 )
@export_color_no_alpha var color1_night = Color( 0.211765, 0.243137, 0.431373, 1 )
@export_color_no_alpha var color2_night = Color( 0.364706, 0.180392, 0.490196, 1 )
@export_color_no_alpha var color1_day = Color( 0.27451, 0.278431, 0.407843, 1 )
@export_color_no_alpha var color2_day = Color( 0.745098, 0.615686, 0.560784, 1 )

func _ready():
	InTime.connect("current_cycle_changed", _set_color_fx)
	_set_color_fx(InTime.current_cycle)

func _transition_colors(color1_to, color2_to):
		var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).set_parallel(true)
		
		tween.tween_property(
					material,
					"shader_parameter/color1",
					color1_to,	
					InTime.state_transition_duration
		)
		tween.tween_property(
					material,
					"shader_parameter/color2",
					color2_to,
					InTime.state_transition_duration
		)
		tween.play()
		

func _set_color_fx(cycle):
	if cycle == InTime.CycleState.DAWN:
		_transition_colors(color1_night, color2_night)
	elif cycle == InTime.CycleState.DUSK:
		_transition_colors(color1_day, color2_day)
	elif cycle == InTime.CycleState.NIGHT:
		_transition_colors(color1_dusk,color2_dusk)
	elif cycle == InTime.CycleState.DAY:
		_transition_colors(color1_dawn, color2_dawn)
