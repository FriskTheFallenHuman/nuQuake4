effect effects/sparks/generic_large3
{
	size	185

	light "light"
	{
		locked

		light
		{
			duration	0.12,0.12
			material	"lights/defaultPointLight"

			start
			{
				position { point 10,0,0 }
				size { point 50,50,50 }
				tint { point 0,0,0 }
				fade { point 0.5 }
			}

			motion
			{
				tint { envelope pop_fade }
			}

			end
			{
				tint { point 0.819608,0.627451,0.337255 }
			}
		}
	}
	emitter "spark_blank"
	{
		duration	0.25,0.25
		count		10,15

		sprite
		{
			duration	0.5,1
			blend	add
			material	"gfx/effects/particles_shapes/blank"
			gravity		0.4,0.8
			trailType	motion
			trailTime	0.15,0.15
			trailCount	4,4

			start
			{
				position { point 1,0,0 }
				velocity { box 50,-150,-150,350,150,150 }
				size { line 1.5,1.5,3.5,3.5 }
				tint { line 1,1,1,1,0.956863,0.466667 }
			}

			motion
			{
				tint { envelope linear_flicker }
				fade { envelope linear_flicker }
			}
		}
	}
	sound "sound"
	{
		soundShader	"effects_sparks02_quiet"
	}
	delay "delay"
	{
		duration	0.5,4
	}
}
