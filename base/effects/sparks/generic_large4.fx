effect effects/sparks/generic_large4
{
	size	124

	spawner "sparks_lines"
	{
		count		20,30
		locked

		line
		{
			duration	0.2,0.3
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line"
			gravity		0.5,0.75
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.5,-0.1,-0.1,-0.5,0.1,0.1 surface }
				velocity { box 200,0,0,500,0,0 }
				acceleration { point -100,0,0 }
				size { box 1,2 }
				tint { line 1,0.941177,0.8,0.94902,0.941177,0.839216 }
				length { box 12,0,0,18,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" offset 0.2,0.2,0.2 }
			}

			end
			{
				size { point 0 }
				tint { line 0.858824,0.729412,0.309804,0.847059,0.568627,0.313726 }
			}
		}
	}
	sound "sound"
	{
		soundShader	"effects_sparks02_quiet"
	}
	spawner "sparks_lines2"
	{
		count		10,20
		locked

		line
		{
			duration	0.3,0.5
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2"
			gravity		0.5,0.75
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.5,-0.1,-0.1,-0.5,0.1,0.1 surface }
				velocity { box 200,0,0,500,0,0 }
				size { box 1,2 }
				tint { line 1,0.984314,0.831373,1,0.701961,0.364706 }
				length { box 7,0,0,9,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "exp_x2" }
			}

			end
			{
				size { point 0 }
			}
		}
	}
}
