effect effects/mp/haste
{
	size	81

	emitter "spirals"
	{
		duration	1,1
		count		25,25

		sprite
		{
			duration	0.5,1
			blend	add
			material	"gfx/effects/energy_sparks/spark3"
			gravity		-0.15,-0.15
			trailType	burn
			trailTime	0.5,0.5
			trailCount	10,10

			start
			{
				position { cylinder -25,-25,-10,25,25,40 }
				velocity { point 20,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { line 10,10,20,20 }
				fade { point 0 }
				offset { point 0,0,20 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope fastinslowout }
				angle { envelope linear }
			}

			end
			{
				size { line 5,5,10,10 }
				fade { point 0.8 }
				angle { box -1,-1,-1,1,1,1 relative }
			}
		}
	}
}
