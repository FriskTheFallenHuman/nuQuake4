effect effects/levels/hub/charge_up
{
	size	525

	emitter "origin pillar"
	{
		duration	1,1
		count		25,25

		sprite
		{
			duration	1,3
			blend	add
			material	"gfx/effects/weapons/plasma1"

			start
			{
				position { cylinder 0,-31,-30,250,30,30 surface }
				angle { box 0,0,-1.66667,0,0,1.66667 }
				acceleration { box 0,0,0,100,0,0 }
				size { point 30,30 }
				tint { line 0.4,0.54902,0.839216,0.501961,0.501961,1 }
				fade { point 0.25 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine offset 0.5 }
				offset { envelope linear }
				angle { envelope linear }
			}

			end
			{
				size { line 80,80,150,150 }
				offset { box 0,-10,-10,0,10,10 }
			}
		}
	}
	emitter "unnamed1"
	{
		duration	1,1
		count		1,5

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				velocity { box 300,0,0,500,0,0 }
				size { point 100,100 }
				tint { point 0.4,0.54902,0.839216 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 150,150 }
			}
		}
	}
}
