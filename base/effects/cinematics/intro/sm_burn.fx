effect effects/cinematics/intro/sm_burn
{
	size	129

	emitter "flash2"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	3,3
			blend	add
			material	"gfx/effects/weapons/plasma1"

			start
			{
				position { box -1,-1,-1,1,1,1 }
				velocity { box -2,-2,-2,2,2,2 }
				size { line 5,5,10,10 }
				tint { line 1,0.501961,0,0.501961,0,0 }
				fade { line 0.25,1 }
			}

			motion
			{
				size { envelope cosine }
				tint { envelope linear }
				fade { envelope linear count 2 offset -1 }
				rotate { envelope linear }
			}

			end
			{
				size { line 10,10,20,20 }
				tint { point 0.4,0.54902,0.839216 }
				rotate { box -0.0555556,0.0555556 relative }
			}
		}
	}
	emitter "flash3"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	8,10
			blend	add
			material	"gfx/effects/weapons/plasma1"

			start
			{
				position { box -1,-1,-1,1,1,1 }
				size { line 5,5,10,10 }
				fade { line 0.125,0.25 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear count 2 offset -1 }
				rotate { envelope linear }
			}

			end
			{
				size { line 50,50,90,90 }
				rotate { box -0.166667,0.166667 relative }
			}
		}
	}
}

