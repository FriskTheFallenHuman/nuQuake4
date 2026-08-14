effect effects/sparks/generic_large2
{
	size	365

	spawner "spark"
	{
		count		2,3

		sprite
		{
			duration	1,2
			blend	add
			material	"gfx/effects/energy_sparks/spark2"
			gravity		1,1.5
			trailType	motion
			trailTime	0.5,0.5
			trailCount	10,10

			start
			{
				position { point 1,0,0 }
				velocity { box 100,-150,-150,350,150,150 }
				size { line 0.5,0.5,1.5,1.5 }
				tint { point 0.921569,0.882353,0.752941 }
			}

			motion
			{
				tint { envelope linear_flicker }
				fade { envelope linear_flicker }
			}

			impact
			{
				bounce	0.3
			}
		}
	}
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
			blend	add
			material	"gfx/effects/particles_shapes/blank"
			gravity		0.4,0.8
			trailType	motion
			trailTime	0.2,0.2
			trailCount	5,5

			start
			{
				position { point 1,0,0 }
				velocity { box 50,-150,-150,350,150,150 }
				size { line 2.5,2.5,4.5,4.5 }
				tint { point 0.921569,0.882353,0.752941 }
			}

			motion
			{
				tint { envelope linear_flicker }
				fade { envelope linear_flicker }
			}

			impact
			{
				bounce	0.3
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




