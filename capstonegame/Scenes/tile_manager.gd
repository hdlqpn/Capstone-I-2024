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
	Vector2(0, 8): [Vector2(-2, 9), Vector2(0, 2)],
	Vector2(-2, 9): [Vector2(-3, 11)],
	Vector2(-3, 11): [Vector2(-3, 13)],
	Vector2(-10, -2): [Vector2(-11, 0), Vector2(-4, -2)],
	Vector2(-11, 0): [Vector2(-13, 1)],
	Vector2(-13, 1): [Vector2(-15, 1)],
	Vector2(-15, 1): [Vector2(-17, 1)],
	Vector2(-17, 1): [Vector2(-19, 1)],
	Vector2(-3, 13): [Vector2(-3, 15)],
	Vector2(-3, 15): [Vector2(-3, 17)],
	Vector2(-3, 17): [Vector2(-3, 19), Vector2(-5, 17)],
	Vector2(-3, 19): [Vector2(-3, 21)],
	Vector2(-3, 21): [Vector2(-3, 23)],
	Vector2(-3, 23): [Vector2(-2, 25)],
	Vector2(-2, 25): [Vector2(0, 26)],
	Vector2(0, 26): [Vector2(2, 25)],
	Vector2(2, 25): [Vector2(3, 23)],
	Vector2(3, 23): [Vector2(3 ,21)],
	Vector2(3, 21): [Vector2(3, 19)],
	Vector2(3, 19): [Vector2(3, 15)],
	Vector2(3, 15): [Vector2(3, 13)],
	Vector2(3, 13): [Vector2(3, 11)],
	Vector2(3, 11): [Vector2(2, 9)],
	Vector2(2, 9): [Vector2(0, 8)],
	Vector2(-5, 17): [Vector2(-8, 17)],
	Vector2(-8, 17): [Vector2(-14, 14)],
	Vector2(-14, 14): [Vector2(-16, 12)],
	Vector2(-16, 12): [Vector2(-18, 9)],
	Vector2(-18, 9): [Vector2(-19, 6)],
	Vector2(-19, 6): [Vector2(-19, 3)],
	Vector2(-19, 3): [Vector2(-21, 1)],
	Vector2(-21, 1): [Vector2(-23, 1)],
	Vector2(-23, 1): [Vector2(-25, 1)],
	Vector2(-25, 1): [Vector2(-27, 0)],
	Vector2(-27, 0): [Vector2(-28, -2)],
	Vector2(-28, -2): [Vector2(-27, -4)],
	Vector2(-27, -4): [Vector2(-25, -5)],
	Vector2(-25, -5): [Vector2(-23, -5)],
	Vector2(-21, -5): [Vector2(-19, -5)],
	Vector2(-19, -5): [Vector2(-17, -5), Vector2(-19, -7)],
	Vector2(-17, -5): [Vector2(-15, -5)],
	Vector2(-15, -5): [Vector2(-13, -5)],
	Vector2(-13, -5): [Vector2(-11, -4)],
	Vector2(-11, -4): [Vector2(-10, -2)],
	Vector2(-19, -7): [Vector2(-19, -10)],
	Vector2(-19,  -10): [Vector2(-18, -13)],
	Vector2(-18, -13): [Vector2(-16, -16)],
	Vector2(-16, -16): [Vector2(-14, -18)],
	Vector2(-14, -18): [Vector2(-11, -20)],
	Vector2(-11, -20): [Vector2(-8, -21)],
	Vector2(-8, -21): [Vector2(-5, -21)],
	Vector2(-5, -21): [Vector2(-3, -21)],
	Vector2(-3, -21): [Vector2(-3, -19)],
	Vector2(-3, -19): [Vector2(-3, -17)],
	Vector2(-3, -17): [Vector2(-3, -15)],
	Vector2(-3, -15): [Vector2(-2, -13)],
	Vector2(-2, -13): [Vector2(0, -12)],
	Vector2(0, -12): [Vector2(2, -13), Vector2(0, -6)],
	Vector2(2, -13): [Vector2(3, -15)],
	Vector2(3, -15): [Vector2(3, -17)],
	Vector2(3, -17): [Vector2(3, -19)],
	Vector2(3, -19): [Vector2(3, -21)],
	Vector2(3, -21): [Vector2(3, -23), Vector2(5, -21)],
	Vector2(3, -23): [Vector2(3, -25)],
	Vector2(3, -25): [Vector2(3, -27)],
	Vector2(3, -27): [Vector2(2, -29)],
	Vector2(2, -29): [Vector2(0, -30)],
	Vector2(0, -30): [Vector2(-2, -29)],
	Vector2(-2, -29): [Vector2(-3, -27)],
	Vector2(-3, -27): [Vector2(-3, -25)],
	Vector2(-3, -25): [Vector2(-3, -23)],
	Vector2(-3, -23): [Vector2(-3, -21)],
	Vector2(5, -21): [Vector2(8, -21)],
	Vector2(8, -21): [Vector2(11, -20)],
	Vector2(11, -20): [Vector2(14, -18)],
	Vector2(14, -18): [Vector2(16, -16)],
	Vector2(16, -16): [Vector2(18, -13)],
	Vector2(18, -13): [Vector2(19, -10)],
	Vector2(19, -10): [Vector2(19, -7)],
	Vector2(19, -7): [Vector2(19, -5)],
	Vector2(19, -5): [Vector2(21, -5)],
	Vector2(21, -5): [Vector2(23, -5)],
	Vector2(23, -5): [Vector2(25, -5)],
	Vector2(25, -5): [Vector2(27, -4)],
	Vector2(27, -4): [Vector2(28, -2)],
	Vector2(28, -2): [Vector2(27, 0)],
	Vector2(27, 0): [Vector2(25, 1)],
	Vector2(25, 1): [Vector2(23, 1)],
	Vector2(23, 1): [Vector2(21, 1)],
	Vector2(21, 1): [Vector2(19, 1)],
	Vector2(19, 1): [Vector2(17, 1), Vector2(19, 3)],
	Vector2(17, 1): [Vector2(15, 1)],
	Vector2(15, 1): [Vector2(13, 1)],
	Vector2(13, 1): [Vector2(11, 0)],
	Vector2(11, 0): [Vector2(10, -2)],
	Vector2(10, -2): [Vector2(11, -4), Vector2(4, -2)],
	Vector2(11, -4): [Vector2(13, -5)],
	Vector2(13, -5): [Vector2(15, -5)],
	Vector2(15, -5): [Vector2(17, -5)],
	Vector2(17, -5): [Vector2(19, -5)],
	Vector2(19, 3): [Vector2(19, 6)],
	Vector2(19, 6): [Vector2(18, 9)],
	Vector2(18, 9): [Vector2(16, 12)],
	Vector2(16, 12): [Vector2(14, 14)],
	Vector2(14, 14): [Vector2(11, 16)],
	Vector2(11, 16): [Vector2(8, 17)],
	Vector2(8, 17): [Vector2(5, 17)],
	Vector2(5, 17): [Vector2(3, 17)]
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
	Vector2(-13, 3): "blue",
	Vector2(-3, 15): "blue",
	Vector2(-3, 17): "fork",
	Vector2(-3, 19): "blue",
	Vector2(-3, 21): "blue",
	Vector2(-3, 23): "blue",
	Vector2(-2, 25): "blue",
	Vector2(0, 26): "blue",
	Vector2(2, 25): "blue",
	Vector2(3, 23): "blue",
	Vector2(3, 21): "blue",
	Vector2(3, 19): "blue",
	Vector2(3, 17): "fork",
	Vector2(3, 15): "blue",
	Vector2(3, 13): "blue",
	Vector2(3, 11): "blue",
	Vector2(2, 9): "blue",
	Vector2(-5, 17): "blue",
	Vector2(-8, 17): "blue",
	Vector2(-11, 16): "blue",
	Vector2(-14, 14): "blue",
	Vector2(-16, 12): "blue",
	Vector2(-18, 9): "blue",
	Vector2(-19, 6): "blue",
	Vector2(-19, 3): "blue",
	Vector2(-19, 1): "fork",
	Vector2(-21, 1): "blue",
	Vector2(-23, 1): "blue",
	Vector2(-25, 1): "blue",
	Vector2(-27, 0): "blue",
	Vector2(-28, -2): "blue",
	Vector2(-27, -4): "blue",
	Vector2(-25, -5): "blue",
	Vector2(-21, -5): "blue",
	Vector2(-19, -5): "fork",
	Vector2(-17, -5): "blue",
	Vector2(-15, -5): "blue",
	Vector2(-13, -5): "blue",
	Vector2(-11, -4): "blue",
	Vector2(-19, -7): "blue",
	Vector2(-19, -10): "blue",
	Vector2(-18, -13): "blue",
	Vector2(-16, -16): "blue",
	Vector2(-14, -18): "blue",
	Vector2(-11, -20): "blue",
	Vector2(-8, -21): "blue",
	Vector2(-5, -21): "blue",
	Vector2(-3, -21): "fork",
	Vector2(-3, -19): "blue",
	Vector2(-3, -17): "blue",
	Vector2(-3, -15): "blue",
	Vector2(-2, -13): "blue",
	Vector2(0, -12): "fork",
	Vector2(2, -13): "blue",
	Vector2(3, -15): "blue",
	Vector2(3, -17): "blue",
	Vector2(3, -19): "blue",
	Vector2(3, -21): "fork",
	Vector2(3, -23): "blue",
	Vector2(3, -25): "blue",
	Vector2(3, -27): "blue",
	Vector2(2, -29): "blue",
	Vector2(0, -30): "blue",
	Vector2(-2, -29): "blue",
	Vector2(-3, -27): "blue",
	Vector2(-3, -25): "blue",
	Vector2(-3, -23): "blue",
	Vector2(5, -21): "blue",
	Vector2(8, -21): "blue",
	Vector2(11, -20): "blue",
	Vector2(14, -18): "blue",
	Vector2(16, -16): "blue",
	Vector2(18, -13): "blue",
	Vector2(19, -10): "blue",
	Vector2(19, -7): "blue",
	Vector2(19, -5): "fork",
	Vector2(21, -5): "blue",
	Vector2(27, -4): "blue",
	Vector2(28, -2): "blue",
	Vector2(27, 0): "blue",
	Vector2(25, 1): "blue",
	Vector2(23, 1): "blue",
	Vector2(21, 1): "blue",
	Vector2(19, 1): "fork",
	Vector2(17, 1): "blue",
	Vector2(15, 1): "blue",
	Vector2(13, 1): "blue",
	Vector2(11, 0): "blue",
	Vector2(10, -2): "fork",
	Vector2(11, -4): "blue",
	Vector2(13, -5): "blue",
	Vector2(15, -5): "blue",
	Vector2(17, -5): "blue",
	Vector2(19, 3): "blue",
	Vector2(19, 6): "blue",
	Vector2(18, 9): "blue",
	Vector2(16, 12): "blue",
	Vector2(14, 14): "blue",
	Vector2(11, 16): "blue",
	Vector2(8, 17): "blue",
	Vector2(5, 17): "blue"
	}
	
