extends Resource
class_name PropIDResource

enum PROP_ENUM {
	PRESENT
}

var PROPS: Dictionary = {
	PROP_ENUM.PRESENT: [preload("res://source/objects/GiftBlue.tscn")]
}

func get_prop(prop_id: int):
	var prop_collection: Array = PROPS[prop_id]
	var prop_variations_amount: int = PROPS[prop_id].size()
	return prop_collection[randi() % prop_variations_amount]
