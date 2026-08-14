effect effects/sparks/sparkshower5
{
	size	630

	emitter "sparks_lines"
	{
		duration	1,1
		count		75,100
		locked

		line
		{
			duration	1.5,2
			blend	add
			generatedLine
			persist
			material	"gfx/effects/energy_sparks/spark_line2"
			gravity		0.5,0.75
			generatedOriginNormal

			start
			{
				position { cylinder 5,-6,-6,5,6,6 cone }
				velocity { point 300,0,0 }
				size { box 0.75,1 }
				tint { line 1,0.960784,0.807843,1,1,1 }
				offset { box 0,0,0,2,2,2 }
				length { box 6,0,0,10,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" offset 0.2,0.2,0.2 }
				length { envelope "linear" }
			}

			end
			{
				size { point 0 }
				tint { line 0.941177,0.639216,0.219608,0.74902,0.447059,0.164706 }
			}
		}
	}
	emitter "smoke"
	{
		start		0.06,0.06
		duration	1,1
		count		5,5

		sprite
		{
			duration	1,1.5
			persist
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.06,-0.04
			generatedOriginNormal
			flipNormal

			start
			{
				size { line 4,4,12,12 }
				tint { line 0.556863,0.529412,0.439216,0.509804,0.537255,0.458824 }
				fade { point 0.6 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 25,25,50,50 }
				rotate { box -0.138889,0.138889 relative }
			}
		}
	}
	emitter "center"
	{
		duration	1,1
		count		1,2
		locked

		sprite
		{
			duration	2,2
			persist
			material	"gfx/effects/weapons/flash"
			flipNormal

			start
			{
				position { point 1,0,0 }
				size { box 15,15,20,20 }
			}

			motion
			{
				size { envelope "random" }
			}

			end
			{
				size { point 10,10 }
			}
		}
	}
	emitter "sparks_lines2"
	{
		start		0.2,0.5
		duration	1,1
		count		10,20
		locked

		line
		{
			duration	0.5,0.75
			blend	add
			generatedLine
			persist
			material	"gfx/effects/energy_sparks/spark_line"
			gravity		0.5,0.75
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.5,-0.5,-0.5,-0.5,0.5,0.5 surface }
				velocity { box 200,0,0,500,0,0 }
				acceleration { point -100,0,0 }
				size { box 1,1.5 }
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
	spawner "segment52"
	{
		count		20,20
		locked

		line
		{
			duration	0.12,0.12
			persist
			material	"gfx/effects/weapons/flash"
			gravity		0.1,0.1
			generatedOriginNormal

			start
			{
				position { sphere -0.5,-0.5,-0.5,0.5,0.5,0.5 }
				velocity { point 50,0,0 }
				size { box 0.5,1 }
				length { point 1,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { point 0 }
				length { box 15,0,0,20,0,0 }
			}
		}
	}
}
