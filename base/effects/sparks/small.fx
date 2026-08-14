effect effects/sparks/small
{
	size	140

	light "flash"
	{

		light
		{
			duration	0.05,0.1
			material	"lights/defaultPointLight"

			start
			{
				size { point 10,10,10 }
				tint { point 0.92549,0.870588,0.658824 }
			}

			motion
			{
				size { envelope arch }
			}

			end
			{
				size { point 64,64,64 }
			}
		}
	}
	emitter "sparks"
	{
		start		0,0.3
		duration	0.2,0.3
		count		3,13

		line
		{
			duration	0.2,0.5
			blend	add
			generatedLine
			persist
			material	"gfx/effects/energy_sparks/spark_line3"
			gravity		0.2,0.45
			trailType	motion
			trailTime	0.1,0.1
			trailCount	1,2

			start
			{
				position { line 0,-5,0,0,5,0 }
				velocity { box 250,-30,0,400,30,250 }
				size { box 0.5,1 }
				tint { line 1,1,0.501961,1,1,0 }
				length { point 2,0,0 }
			}

			motion
			{
				tint { envelope linear }
				fade { envelope linear offset -0.3 }
				length { envelope arch count 0.6,0.6,0.6 }
			}

			end
			{
				tint { line 1,0.501961,0,1,0,0 }
				length { point 20,20,20 }
			}
		}
	}
	emitter "smoke"
	{
		duration	1,1
		count		1,2

		sprite
		{
			duration	1,2
			persist
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.06,-0.02

			start
			{
				velocity { box 20,-20,-20,40,20,20 }
				acceleration { box -10,-10,-10,10,10,10 }
				size { box 10,10,15,15 }
				tint { line 0,0,0,0.752941,0.752941,0.752941 }
				fade { point 0.3 }
			}

			motion
			{
				size { envelope arch }
				fade { envelope linear }
			}

			end
			{
				size { line 30,30,50,50 }
			}
		}
	}
	sound "sound"
	{
		soundShader	"effects_sparks02_quiet"
	}
}