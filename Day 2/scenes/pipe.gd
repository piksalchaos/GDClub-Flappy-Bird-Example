extends Area2D

signal scored

func _on_score_area_body_entered(_body: Node2D) -> void:
	scored.emit()
