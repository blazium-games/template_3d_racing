extends RefCounted

var laps := 0
var on_stripe := false
var mid_seen := false

func note_mid(touched: bool) -> void:
	if touched:
		mid_seen = true

func note_stripe(touching: bool) -> bool:
	if touching and not on_stripe:
		on_stripe = true
		if not mid_seen:
			return false
		laps += 1
		mid_seen = false
		return true
	if not touching:
		on_stripe = false
	return false

func wipe_oval() -> void:
	laps = 0
	on_stripe = false
	mid_seen = false

func may_finish() -> bool:
	return laps >= 2
