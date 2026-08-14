effect effects/monsters/strogg_flyer/bomb_fly
{
	size	472

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
				rotate { envelope linear }
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
		locked

		sprite
		{
			duration	0.12,0.12
			blend	add
			material	"gfx/effects/weapons/flash"

			start
			{
				position { point 0,0,-10 }
				velocity { point 0,0,1000 }
				size { point 40,40 }
				rotate { box 0,7 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 100,100,300,300 }
				rotate { box -0.1,0.1 relative }
			}
		}
	}
	sound "unnamed2"
	{
		soundShader	"strogg_flyer_bomb_whistle"
	}
}


