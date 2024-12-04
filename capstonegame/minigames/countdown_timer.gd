extends Panel

var time: float = 15.0
var minutes: int = 0
var seconds: int = 0
var msec: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var game_end = false
	time -= delta
	msec = fmod(time, 1) * 100
	seconds = fmod(time, 60)
	minutes = fmod(time, 3600) / 60
	$Minutes.text = "%02d:" % minutes
	$Seconds.text = "%02d:" % seconds
	$Msecs.text = "%03d" % msec
	
	if msec == 0 and seconds == 0 and minutes == 0:
		game_end == true
		stop()
	
func stop() -> void:
	set_process(false)
func get_time_fomatted() -> String:
	return "%02d:%02d:%03d" % [minutes, seconds, msec]
