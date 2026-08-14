effect effects/vehicles/gev/maingun/impact_flesh_exp
{
	size	218

	sound "sound"
	{
		soundShader	"effects_walker_squish"
	}
	spawner "blood2"
	{
		count		1,1

		sprite
		{
			duration	0.3,0.5
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
				size { line 100,100,150,150 }
				fade { point 1 }
			}
		}
	}
	sound "sound2"
	{
		soundShader	"vehicle_walker_cannon_impact"
	}
}
