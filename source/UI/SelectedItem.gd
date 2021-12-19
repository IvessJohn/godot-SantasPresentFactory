extends PanelContainer

var _selected_resource: PlaceableObjectResource

onready var itemIcon = $VBoxContainer/ItemIcon
onready var itemLabel = $VBoxContainer/ItemLabel
onready var typeLabel = $VBoxContainer/TypeLabel


func _update_selected_object(value):
	if value != null and _selected_resource != value:
		_selected_resource = value
		itemIcon.texture = _selected_resource.ui_icon
		itemLabel.text = _selected_resource.name
		typeLabel.text = _selected_resource.get_type_in_string()
