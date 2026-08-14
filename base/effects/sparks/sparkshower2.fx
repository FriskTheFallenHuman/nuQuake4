effect effects/sparks/sparkshower2
{
	size	140

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
				size { point 64,64,64 }
				tint { point 0,0,0 }
				fade { point 0.5 }
			}

			motion
			{
				tint { envelope "pop_fade" }
			}

			end
			{
				tint { point 0.890196,0.780392,0.607843 }
			}
		}
	}
	emitter "sparks_lines"
	{
		duration	0.15,0.15
		count		120,120
		locked

		line
		{
			duration	1,1.5
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line3"
			gravity		0.15,0.2
			generatedOriginNormal

			start
			{
				position { cylinder 5,-5,-5,5,5,5 }
				velocity { box 20,0,0,160,0,0 }
				size { box 1,2.5 }
				tint { line 1,0.941177,0.8,1,1,1 }
				length { box 6,0,0,8,0,0 }
			}

			motion
			{
				size { envelope "exp_x2" }
				tint { envelope "linear" offset 0.2,0.2,0.2 }
			}

			end
			{
				size { point 0 }
				tint { line 0.941177,0.639216,0.219608,0.74902,0.447059,0.164706 }
			}
		}
	}
	sound "sound"
	{
		soundShader	"effects_sparks02"
		freqshift	1.1,1.1
	}
	delay "delay"
	{
		duration	1,3
	}
}



