extends PlaceableObjectResource
class_name PlaceableTileResource

enum TILE_ID {
	NULL,
	FENCE = 5
}
enum TILE_PLACEMENT {
	SURFACE,
	GROUND
}

export(TILE_ID) var tile_id: int
export(TILE_PLACEMENT) var tile_placement: int
