effect effects/levels/convoy/weld_sparks_impact
{
	size	83

	spawner "flash"
	{
		count		3,3

		sprite
		{
			duration	0.06,0.06
			blend	add
			material	"gfx/effects/weapons/flash"
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { point 2,2 }
				fade { point 0.6 }
			}

			motion
			{
				tint { envelope linear }
			}
		}
	}
	spawner "sparks_trails"
	{
		count		3,5

		sprite
		{
			duration	0.35,0.5
			material	"gfx/effects/particles_shapes/blank"
			gravity		0.5,1
			trailType	motion
			trailTime	0.1,0.1
			trailCount	3,3

			start
			{
				velocity { box 100,-150,-150,300,150,150 }
				size { box 0.5,0.5,1.5,1.5 }
				tint { point 0.917647,0.858824,0.733333 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
			}

			end
			{
				size { point 0.5,0.5 }
				tint { line 0.933333,0.796079,0.32549,0.909804,0.517647,0.384314 }
			}
		}
	}
}



