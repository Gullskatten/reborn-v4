class_name DayNightCycle
extends CanvasModulate

## The color of the night state.
@export_color_no_alpha var color_night = Color(0.07, 0.09, 0.38, 1.0)
## The color of the dawn state.
@export_color_no_alpha var color_dawn = Color(0.86, 0.70, 0.70, 1.0)
## The color of the day state.
@export_color_no_alpha var color_day = Color(1.0, 1.0, 1.0, 1.0)
## The color of the dusk state.
@export_color_no_alpha var color_dusk = Color(0.59, 0.66, 0.78, 1.0)
## The amount of in-game seconds of delay.
@export var delay: int = 0



func _ready():
	# Connect signals.
	var current_cycle_changed_signal = InTime.connect(
		"current_cycle_changed", _on_current_cycle_changed
	)

	# Check if signals are connected correctly.
	if current_cycle_changed_signal != OK:
		printerr(current_cycle_changed_signal)

	# Sync the delay with in-game time.
	if delay < 0:
		delay = 0
		push_warning("The 'delay' (%s) in the '%s' node must be >= 0." % [delay, self.name])
	elif delay > 0:
		delay /= float(InTime.IN_GAME_SECONDS_PER_REAL_TIME_SECONDS)

	# Set the current cycle state.
	match InTime.current_cycle:
		InTime.CycleState.NIGHT:
			color = color_night
		InTime.CycleState.DAWN:
			color = color_dawn
		InTime.CycleState.DAY:
			color = color_day
		InTime.CycleState.DUSK:
			color = color_dusk


# CALLBACKS
# ---------
func _on_current_cycle_changed(_cycle):
	var color_transition_tween = create_tween()
	color_transition_tween.set_ease(Tween.EASE_OUT)
	color_transition_tween.set_trans(Tween.TRANS_SINE)
	
	match InTime.current_cycle:
		InTime.CycleState.NIGHT:
			
			if not InTime.changing_time_manually:
				if delay > 0:
					await get_tree().create_timer(delay).timeout
				color_transition_tween.tween_property(
					self,
					"color",
					color_night,	
					InTime.state_transition_duration
				).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
				color_transition_tween.play()
			else:
				color_transition_tween.kill()
				color = color_night
		InTime.CycleState.DAWN:
			if not InTime.changing_time_manually:
				if delay > 0:
					await get_tree().create_timer(delay).timeout

				color_transition_tween.tween_property(
					self,
					"color",
					color_dawn,	
					InTime.state_transition_duration
				)
				color_transition_tween.play()
			else:
				color_transition_tween.kill()
				color = color_dawn
		InTime.CycleState.DAY:
			if not InTime.changing_time_manually:
				if delay > 0:
					await get_tree().create_timer(delay).timeout
				color_transition_tween.tween_property(
					self,
					"color",
					color_day,	
					InTime.state_transition_duration
				)
				color_transition_tween.play()
			else:
				color_transition_tween.kill()
				color = color_day
		InTime.CycleState.DUSK:
			if not InTime.changing_time_manually:
				if delay > 0:
					await get_tree().create_timer(delay).timeout

				color_transition_tween.tween_property(
					self,
					"color",
					color_dusk,	
					InTime.state_transition_duration
				)
				color_transition_tween.play()
			else:
				color_transition_tween.kill()
				color = color_dusk
