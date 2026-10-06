extends AutoworkTest

const Rules = preload("res://scripts/rules.gd")

func test_lap_and_miss() -> void:
	var rules = Rules.new()
	assert_false(rules.note_stripe(false), "missed line")
	assert_eq(rules.laps, 0, "no lap")
	assert_false(rules.note_stripe(true), "start only")
	assert_eq(rules.laps, 0, "not counted")
	rules.note_stripe(false)
	rules.note_mid(true)
	assert_true(rules.note_stripe(true), "crossed")
	assert_eq(rules.laps, 1, "counted")
	assert_false(rules.note_stripe(true), "still on stripe")
	assert_eq(rules.laps, 1, "no double count")

func test_finish_gate() -> void:
	var rules = Rules.new()
	assert_false(rules.may_finish(), "no laps")
	rules.note_mid(true)
	rules.note_stripe(true)
	assert_false(rules.may_finish(), "one lap")
	rules.note_stripe(false)
	rules.note_mid(true)
	rules.note_stripe(true)
	assert_true(rules.may_finish(), "two laps")
	assert_true(load("res://scenes/finish.tscn") != null, "finish loads")
