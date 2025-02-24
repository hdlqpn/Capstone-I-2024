extends Node


var tile_paths: Dictionary = {
	Vector2(0, 2): [Vector2(-2, 2), Vector2(0, 8)],  # Fork (two paths!)
	Vector2(-2, 2): [Vector2(-4, 0)],  # Single path
	Vector2(-4, 0): [Vector2(-4, -2)],  # Single path
	Vector2(-4, -2): [Vector2(-10, -2), Vector2(-4, -4)],
	Vector2(-4, -4): [Vector2(-2, -6)],  # Single path
	Vector2(-2,-6): [Vector2(0, -6)],  # Single path
	Vector2(0, -6): [Vector2(0,-12), Vector2(2,-6)],  # Single path
	Vector2(2,-6): [Vector2(4, -4)],  # Single path
	Vector2(4, -4): [Vector2(4, -2)],  # Single path
	Vector2(4, -2): [Vector2(10, -2), Vector2(4, 0)],  # Single path
	Vector2(4, 0): [Vector2(2, 2)],  # Single path
	Vector2(2, 2): [Vector2(0, 2)],  # Single path
	Vector2(0,8): [Vector2(-2, 9)],
	Vector2(-2, 9): [Vector2(-3, 11)],
	Vector2(-3, 11): [Vector2(-3, 13)],
	Vector2(-10, -2): [Vector2(-11, 0)],
	Vector2(-11, 0): [Vector2(-13, 1)],
	Vector2(-13, 1): [Vector2(-15, 1)]

	
}
var tile_types: Dictionary = {
	Vector2(0, 2): "fork",
	Vector2(-2, 2): "blue",
	Vector2(-4, 0): "blue",
	Vector2(-4, -2): "fork",
	Vector2(-4, -4): "blue",
	Vector2(-2, -6): "blue",
	Vector2(0, -6): "fork",
	Vector2(2, -6): "blue",
	Vector2(4, -4): "blue",
	Vector2(4, -2): "fork",
	Vector2(4, 0): "blue",
	Vector2(2, 2): "blue",
	Vector2(0, 8): "fork",
	Vector2(-2, 9): "blue",
	Vector2(-3, 11): "blue",
	Vector2(-3, -13): "blue",
	Vector2(-10, -2): "fork",
	Vector2(-11, 0): "blue",
	Vector2(-13, 1): "blue",
	Vector2(-13, 3): "blue"
	}
	
