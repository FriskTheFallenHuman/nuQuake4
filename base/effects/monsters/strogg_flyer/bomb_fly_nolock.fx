effect effects/monsters/strogg_flyer/bomb_fly_nolock
{
	size	430

	emitter "segment07"
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
	emitter "segment0"
	{
		duration	5,5
		count		30,30

		sprite
		{
			duration	0.12,0.2
			blend	add
			material	"gfx/effects/weapons/flash"

			start
			{
				position { point 0,0,-10 }
				size { point 50,50 }
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
				size { box 60,60,90,90 }
				rotate { box -0.6,0.6 relative }
			}
		}
	}
	sound "unnamed2"
	{
		soundShader	"strogg_flyer_bomb_whistle"
		volume	5,5
	}
}
