effect effects/monsters/hornet/bomb_fly
{
	size	425

	emitter "model"
	{
		duration	1,1
		count		1,1
		locked

		model
		{
			duration	5,5
			material	"models/monsters/gunner/grenade"
			model		"gfx/effects/monsters/gunner/grenade.lwo"

			start
			{
				size { point 3,3,3 }
			}

			motion
			{
				rotate { envelope "linear" }
			}

			end
			{
				rotate { point 0,3.08611,0 relative }
			}
		}
	}
	sound "sound1"
	{
		soundShader	"strogg_hover_bomb_whistle"
	}
	sound "sound2"
	{
		soundShader	"effects_rocket_loop"
		freqshift	0.7,0.7
	}
	emitter "fire1"
	{
		duration	5,5
		count		5,5
		locked

		sprite
		{
			duration	0.12,0.12
			blend	add
			material	"gfx/effects/weapons/flash"

			start
			{
				size { point 40,40 }
				rotate { box 0,7 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 100,100,300,300 }
				rotate { box -0.1,0.1 relative }
			}
		}
	}
	emitter "fire2"
	{
		duration	5,5
		count		20,20

		sprite
		{
			duration	0.15,0.35
			blend	add
			material	"gfx/effects/weapons/flash"

			start
			{
				size { point 60,80 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { box 20,40,30,50 }
			}
		}
	}
}
