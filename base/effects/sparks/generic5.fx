effect effects/sparks/generic5
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
				tint { point 0.501961,0.501961,1 }
			}
		}
	}
	spawner "sparks_lines"
	{
		count		1,8
		locked

		line
		{
			duration	0.25,1
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line"
			gravity		0.15,0.25
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.5,-0.1,-0.1,-0.5,0.1,0.1 surface }
				velocity { box 10,0,0,100,0,0 }
				size { box 0.45,0.75 }
				tint { line 0,1,1,0.501961,0.501961,1 }
				length { box 2,0,0,3,0,0 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear offset 0.2,0.2,0.2 }
			}

			end
			{
				size { point 0 }
				tint { point 1,1,1 }
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

