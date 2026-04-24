extends TextureButton
class_name ItemIcon

signal interact(item)

@onready var stat_label: Label = %StatLabel
@onready var item_label: Label = %ItemLabel


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action("click"):
		interact.emit(self)
