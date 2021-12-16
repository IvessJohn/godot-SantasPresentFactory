extends PlaceableObjectResource
class_name PlaceableTileResource

enum TILE_TYPE {
	NULL,
	FENCE
}
enum TILE_PLACEMENT {
	SURFACE,
	GROUND
}

export(TILE_TYPE) var tile_type: int
export(TILE_PLACEMENT) var tile_placement: int
