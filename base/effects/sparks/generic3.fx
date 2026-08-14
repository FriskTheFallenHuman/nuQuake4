effect effects/sparks/generic3
{
	size	92

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
	spawner "sparks_lines"
	{
		count		1,8
		locked

		line
		{
			duration	0.3,0.6
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line"
			gravity		0.15,0.25
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.5,-0.1,-0.1,-0.5,0.1,0.1 surface }
				velocity { box 100,0,0,200,0,0 }
				acceleration { point -100,0,0 }
				size { box 0.45,0.75 }
				tint { line 1,0.941177,0.8,0.952941,0.941177,0.839216 }
				length { box 3,0,0,9,0,0 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear offset 0.2,0.2,0.2 }
			}

			end
			{
				size { point 0 }
				tint { line 0.858824,0.733333,0.309804,0.85098,0.572549,0.317647 }
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




