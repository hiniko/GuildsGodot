extends KinematicBody2D

tool

enum CharacterStates{
	Attack,
	AttackBowDraw,
	AttackBowFire,
	AttackHeavy,
	AttackIdle,
	Dead,
	Dizzy,
	DizzTired,
	Idle,
	IdleLow,
	IdleTired,
	Item,
	MagicStart,
	MagicHold,
	Walk,
}

var CharacterStateMap = {
	CharacterStates.Attack: "attack",
	CharacterStates.AttackBowDraw: "attack_bow_draw",
	CharacterStates.AttackBowFire: "attack_bow_fire",
	CharacterStates.AttackHeavy: "attack_heavy",
	CharacterStates.AttackIdle: "attack_idle",
	CharacterStates.Dead: "dead",
	CharacterStates.Dizzy: "dizzy",
	CharacterStates.DizzTired: "dizzy_tired",
	CharacterStates.Idle: "idle",
	CharacterStates.IdleLow: "idle_low",
	CharacterStates.IdleTired: "idle_tired",
	CharacterStates.Item: "item",
	CharacterStates.MagicHold: "magic_hold",
	CharacterStates.MagicStart: "magic_start",
	CharacterStates.Walk: "walk",
}

enum CharacterTypes {
	MaleFighter	,
	FemaleFighter,
	MaleWarrior,
	FemaleWarrior,
	MaleWizard,
	FemaleWizard,
}

var CharacterSpritesMap = {
	CharacterTypes.MaleFighter: "MaleFighter.tres",
	CharacterTypes.FemaleFighter: "FemaleFighter.tres",
	CharacterTypes.MaleWarrior: "MaleWarrior.tres",
	CharacterTypes.FemaleWarrior: "FemaleWarrior.tres",
	CharacterTypes.MaleWizard: "MaleWizard.tres",
	CharacterTypes.FemaleWizard: "FemaleWizard.tres"
}

export (CharacterTypes) var SpriteSet setget UpdateSprite
export (CharacterStates) var CurrentState setget UpdateState

func UpdateSprite(value: int):
	if(value == null):
		return
		
	SpriteSet = value
	
	if is_inside_tree():
		var anim_sprite : AnimatedSprite = get_node("./AnimSprite")
		var sprite_frames = load("res://Assets/Characters/SpriteFrames/" + CharacterSpritesMap[value])
		anim_sprite.set_sprite_frames(sprite_frames)
		anim_sprite.play(CharacterStateMap[CurrentState])
		

func UpdateState(value: int):
	if(value == null):
		return
		
	CurrentState = value
		
	if is_inside_tree():
		var anim_sprite : AnimatedSprite = get_node("./AnimSprite")
		var state : String = CharacterStateMap[value]
		anim_sprite.play(state)


func _ready():
	UpdateSprite(SpriteSet)
	UpdateState(0)

func _input(event: InputEvent):
	if(event.is_action_pressed("debug_next_character")):
		SpriteSet = SpriteSet + 1
		if(SpriteSet > CharacterSpritesMap.size()-1):
			SpriteSet = 0
		UpdateSprite(SpriteSet)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
