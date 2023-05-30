extends Control

@onready var fuel_bar = $FuelBar

func _on_rocket_fuel_updated(fuel):
	fuel_bar.value = fuel
