effect effects/vehicles/gev/maingun/impact_monstermetal_exp
{
	size	291

	sound "sound"
	{
		soundShader	"effects_walker_squish"
	}
	sound "sound2"
	{
		soundShader	"vehicle_walker_cannon_impact"
	}
	spawner "sparks_trails"
	{
		count		6,6

		sprite
		{
			duration	0.3,0.6
			blend	add
			material	"gfx/effects/particles_shapes/blank"
			gravity		1,1
			trailType	motion
			trailTime	0.2,0.2
			trailCount	3,3

			start
			{
				velocity { box -500,-500,-500,500,500,500 }
				size { box 6,6,10,10 }
				tint { point 0.913726,0.858824,0.729412 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 3,3 }
				tint { line 0.929412,0.796079,0.321569,0.909804,0.501961,0.364706 }
			}
		}
	}
	spawner "blood3"
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
}
