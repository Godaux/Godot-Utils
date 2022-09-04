extends Control
onready var _split_node = $"%Split"

onready var _marker_label = $"%MarkerLabel"

onready var _blue_rect = $"%Blue"
onready var _blue_label = $"%BlueLabel"
onready var _red_rect = $"%Red"
onready var _red_label = $"%RedLabel"

onready var _init_size = rect_size.x

func _ready() -> void:
	_split_node.connect("resized", self, "_resized")
	_split_node.connect("dragged", self, "_resized")
	yield(get_tree(), "idle_frame")
	_resized()

func _resized(i=null):
	var blue_size = _blue_rect.rect_size.x
	var red_size = _red_rect.rect_size.x
	var offset_percent = 100*_split_node.split_offset/rect_size.x + 50
	_blue_label.text = "Blue: %s" % [blue_size]
	_red_label.text = "Red: %s" % [red_size]
	_marker_label.text = "Offset percentage: %s%%" % [int(offset_percent)]
	_marker_label.rect_position = Vector2(rect_size.x * (offset_percent/100), rect_size.y/2)
