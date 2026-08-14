effect effects/monsters/roller/sparks
{
	size	222

	emitter "sparks_lines"
	{
		duration	1,1
		count		20,20
		locked
		attenuateEmitter

		line
		{
			duration	1,1
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line"
			gravity		1,1
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.1,-0.1,-0.2,0.1,0.1 surface }
				velocity { box 100,0,0,500,0,0 }
				acceleration { point -100,0,0 }
				size { box 1,2 attenuate }
				tint { line 1,0.941177,0.8,0.94902,0.941177,0.839216 }
				length { box 6,0,0,20,0,0 attenuate }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear offset 0.2,0.2,0.2 }
			}

			end
			{
				size { point 0 attenuate }
				tint { line 0.858824,0.729412,0.309804,0.847059,0.568627,0.313726 }
			}
		}
	}
	emitter "sparks_lines2"
	{
		duration	1,1
		count		20,20
		attenuateEmitter

		line
		{
			duration	1,1
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2"
			gravity		1,1
			generatedOriginNormal

			start
			{
				position { cylinder 4.5,-5,-5,4.5,5,5 surface }
				velocity { box 50,0,0,400,0,0 }
				size { box 1,2 attenuate }
				tint { line 1,0.984314,0.831373,1,0.701961,0.364706 }
				length { box 5,0,0,20,0,0 attenuate }
			}

			motion
			{
				size { envelope linear }
				fade { envelope exp_x2 }
			}

			end
			{
				size { point 0 attenuate }
			}
		}
	}
	emitter "flash2"
	{
		duration	1,1
		count		30,30
		locked

		sprite
		{
			duration	0.06,0.06
			material	"gfx/effects/weapons/flash"

			start
			{
				size { line 30,30,70,70 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 2.5,2.5 }
			}
		}
	}
}
