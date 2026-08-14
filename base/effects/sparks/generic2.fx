effect effects/sparks/generic2
{
	size	137

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
	spawner "spark_blank"
	{
		count		3,5

		sprite
		{
			duration	1,2
			material	"gfx/effects/particles_shapes/blank"
			gravity		0.25,0.5
			trailType	motion
			trailTime	0.1,0.1
			trailCount	3,3

			start
			{
				position { point 1,0,0 }
				velocity { box 50,-20,-20,150,20,20 }
				size { line 0.5,0.5,2,2 }
				tint { line 0.992157,0.972549,0.815686,0.854902,0.713726,0.458824 }
			}

			motion
			{
				tint { envelope linear_flicker }
				fade { envelope linear_flicker }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
	sound "sound"
	{
		soundShader	"effects_sparks02_quiet"
	}
	delay "delay"
	{
		duration	1,6
	}
}




