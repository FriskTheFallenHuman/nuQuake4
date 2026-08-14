effect effects/vehicles/jet_smoke_trail
{
	size	272

	sound "sound"
	{
		soundShader	"effects_fire_small"
	}
	emitter "smoke"
	{
		duration	10,10
		count		30,30

		line
		{
			duration	2,3
			persist
			material	"gfx/effects/smoke/soft_alpha_trail.tga"
			flipNormal

			start
			{
				size { box 24,36 }
				tint { line 0.168627,0.168627,0.168627,0.0509804,0.0509804,0.0509804 }
				length { point 200,0,0 }
			}

			motion
			{
				size { envelope cosine count 0.8 offset 0.2 }
				fade { envelope linear count 2 offset -1 }
			}

			end
			{
				size { box 48,72 }
			}
		}
	}
	emitter "fire"
	{
		duration	10,10
		count		60,60

		line
		{
			duration	0.1,0.1
			blend	add
			persist
			material	"gfx/effects/fire/fire2a"
			flipNormal

			start
			{
				size { point 32 }
				length { box 50,0,0,70,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear count 2 offset -1 }
			}

			end
			{
				size { point 4 }
			}
		}
	}
	spawner "unnamed3"
	{
		count		1,1
		constant

		sprite
		{
			duration	1,1
			material	"gfx/effects/fire/fire2a"

			start
			{
				size { point 24,24 }
				offset { point -10,0,0 }
				rotate { box 0,1 }
			}
		}
	}
}


