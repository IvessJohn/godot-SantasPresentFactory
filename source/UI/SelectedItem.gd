extends PanelContainer

var _selected_resource: PlaceableObjectResource

onready var itemIcon = $VBoxContainer/ItemIcon
onready var itemLabel = $VBoxContainer/ItemLabel
onready var typeLabel = $VBoxContainer/TypeLabel


func _update_selected_object(value):
	if _selected_resource != value:
		_selected_resource = value
		itemIcon.texture = _selected_resource.ui_icon
		itemLabel.text = _selected_resource.name
		typeLabel.text = _get_object_type_in_text(_selected_resource.type)


func _on_TileVerticalList_tile_chosen(tile_resource):
	_update_selected_object(tile_resource)


func _get_object_type_in_text(object_type: int):
	match object_type:
		PlaceableObjectResource.OBJECT_TYPES.PROP:
			return "Prop"
		PlaceableObjectResource.OBJECT_TYPES.TILE:
			return "Tile"
		PlaceableObjectResource.OBJECT_TYPES.ACTOR:
			return "NPC"
		PlaceableObjectResource.OBJECT_TYPES.DECORATION:
			return "Decoration"
		PlaceableObjectResource.OBJECT_TYPES.BUILDING:
			return "Building"
		_:
			return "Undefined"
