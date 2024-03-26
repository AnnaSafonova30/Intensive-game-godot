extends Node2D

# signal damaged(by)
# signal killed()

const HP_MAX = 100.0
var hp = HP_MAX

func take_damage(impact):
	impact = clamp(impact, 0.0, 1.0)
	var damage = HP_MAX * impact
	var prev_hp = hp
	hp -= damage
	hp = clamp(hp, 0, HP_MAX)

	if prev_hp != hp:
		print("Damaged")
		# emit_signal("damaged", damage)

	if hp <= 0.0:
		queue_free()
		# emit_signal("killed")
