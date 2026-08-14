effect effects/sparks/sparkshower4
{
	size	89

	emitter "sparks_lines"
	{
		duration	0.15,0.15
		count		50,50

		line
		{
			duration	0.5,1
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line3"
			gravity		0.15,0.2
			generatedOriginNormal

			start
			{
				position { cylinder 5,-5,-5,5,5,5 }
				velocity { box 20,0,0,160,0,0 }
				size { box 0.5,1 }
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
	sound "unnamed1"
	{
		soundShader	"effects_sparks02"
		volume	0.5,0.5
		freqshift	2,2
	}
}


