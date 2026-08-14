effect effects/sparks/sparkshower1
{
	size	238

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
		duration	0.3,0.3
		count		100,100
		locked

		line
		{
			duration	1,1.5
			blend	add
			generatedLine
			persist
			material	"gfx/effects/energy_sparks/spark_line2"
			gravity		0.3,0.5
			generatedOriginNormal

			start
			{
				position { cylinder 5,-5,-5,5,5,5 }
				velocity { box 20,0,0,130,0,0 }
				size { box 0.75,1.25 }
				tint { line 1,0.941177,0.8,1,1,1 }
				length { box 3,0,0,4,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" offset 0.2,0.2,0.2 }
			}

			end
			{
				size { point 0 }
				tint { line 0.941177,0.639216,0.223529,0.74902,0.447059,0.168627 }
			}
		}
	}
	sound "sound"
	{
		soundShader	"effects_sparks02"
	}
	delay "delay"
	{
		duration	1,3
	}
}



