effect effects/impact/fluid_big
{
	size	180

	sound "unnamed0"
	{
		soundShader	"bullet_impact_water"
	}
	spawner "unnamed1"
	{
		count		10,15
		attenuation	200,800

		sprite
		{
			duration	2,2
			material	"gfx/effects/fluids_drips/bubble_alpha"
			gravity		0.3,0.3

			start
			{
				position { point 1,0,0 }
				velocity { box 150,-15,-15,200,15,15 }
				tint { point 0,0.501961,0.247059 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
			}

			end
			{
				size { point 2,2 }
			}

			impact
			{
				remove	1
			}
		}
	}
}



