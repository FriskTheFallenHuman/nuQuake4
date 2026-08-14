effect effects/vehicles/walker/shield
{
	size	99

	spawner "unnamed1"
	{
		count		3,3
		locked

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/particles_shapes/ripple"

			start
			{
				size { line 10,10,15,15 }
				tint { point 1,0.835294,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { line 60,60,70,70 }
			}
		}
	}
	spawner "sparks"
	{
		count		10,12

		sprite
		{
			duration	1,2
			blend	add
			material	"gfx/effects/energy_sparks/spark3"
			gravity		0.1,0.2
			flipNormal

			start
			{
				velocity { box 0,-20,-20,100,20,20 }
				size { line 2,2,3,3 }
				tint { line 0.501961,0,0.501961,1,0.415686,1 }
			}

			motion
			{
				fade { envelope linear_flicker }
			}
		}
	}
	sound "unnamed2"
	{
		soundShader	"effects_bulletimpact_absorb"
	}
}



