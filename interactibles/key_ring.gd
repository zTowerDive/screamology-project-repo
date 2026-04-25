extends Node

# Tracks which keys have been picked up. Objects that require keys will refer to this.
var key_ring: Dictionary[String, bool] = {"Green": false, "Blue": false, "Red": false}
