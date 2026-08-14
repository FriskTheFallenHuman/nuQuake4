effect effects/vehicles/walker/machinegun/impact_flesh_exp
{
	size	90

	sound "sound"
	{
		soundShader	"bullet_impact_flesh"
	}
	spawner "hit"
	{
		count		1,1

		sprite
		{
			duration	0.125,0.25
			blend	add
			material	"gfx/effects/energy_sparks/spark2"
			gravity		0.05,0.05

			start
			{
				position { line 0,0,0,10,0,0 linearSpacing }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
			}

			end
			{
				size { line 50,50,60,60 }
				fade { point 1 }
			}
		}
	}
}
