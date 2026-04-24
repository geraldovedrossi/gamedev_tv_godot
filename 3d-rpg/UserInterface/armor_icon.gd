extends ItemIcon
class_name ArmorIcon

@export var power: int
@export var armor: armor_type

enum armor_type {
	IRON_PLATE, 
	STEEL_PLATE
}

func _ready() -> void:
	stat_label.text = "+" + str(power)
	item_label.text = armor_type.keys()[armor]
	item_label.text = item_label.text.capitalize()

func set_armor(armor: armor_type):
	match armor:
		armor_type.IRON_PLATE:
			print("armor is set to iron plate!")
		armor_type.STEEL_PLATE:
			print("armor is set to steel plate!")
