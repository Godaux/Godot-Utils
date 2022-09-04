extends SplitContainer

export (int, 100) var override_offset_percent

onready var _index: int = 0 if (get_class() == "HSplitContainer") else 1
onready var _base_size: int = rect_size[_index]

onready var _base_split_offset: int = split_offset

var _base_split_percent: float

func _ready() -> void:
	_connect_signals()
	if override_offset_percent:
		_base_split_offset = _percent_to_offset(override_offset_percent, _base_size)
	_base_split_percent = _offset_to_percent(_base_split_offset, _base_size)
	split_offset = _base_split_offset
	
func _connect_signals() -> void:
	var __ = connect("resized", self, "_resize_split")
	__ = connect("dragged", self, "_dragged")
	
func _resize_split() -> void:
	split_offset = _percent_to_offset(_base_split_percent, _get_current_size())

func _dragged(offset: int) -> void:
	_base_split_percent = _offset_to_percent(offset, _get_current_size())

func _get_current_size() -> int:
	return int(rect_size[_index])
	
func _percent_to_offset(percent: float, length: int) -> int:
	return int(length * (percent - 50) / 100)

func _offset_to_percent(offset: float, length: int) -> float:
	return (100 * (offset / length)) + 50
