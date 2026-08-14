effect effects/mapobjects/pistonb_release
{
	size	255

	emitter "inwardlines"
	{
		duration	2.6,2.6
		count		40,40
		locked

		line
		{
			duration	0.4,0.4
			blend	add
			material	"gfx/effects/energy_sparks/spark_line2"
			generatedOriginNormal

			start
			{
				position { cylinder 0.1,-0.2,-0.2,0.1,0.2,0.2 }
				size { box 5,8 }
				tint { line 0.823529,0.913726,1,0.823529,1,1 }
				fade { point 0.25 }
				length { box 20,0,0,30,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { box 1,2 }
			}
		}
	}
	emitter "sidesprites"
	{
		duration	2.6,2.6
		count		50,50

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/spark_blue"

			start
			{
				velocity { point 0,0,-50 }
				size { point 20,20 }
				tint { line 1,1,1,0.823529,1,0.776471 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine }
			}

			end
			{
				size { point 30,30 }
				fade { point 0.05 }
			}
		}
	}
	emitter "sidesprites2"
	{
		duration	2.6,2.6
		count		50,50

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/spark_blue"

			start
			{
				velocity { point 0,0,50 }
				size { point 20,20 }
				tint { line 1,1,1,0.823529,1,0.776471 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine }
			}

			end
			{
				size { point 30,30 }
				fade { point 0.05 }
			}
		}
	}
	spawner "pistonflare"
	{
		count		1,1
		locked

		sprite
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/energy_sparks/spark_blue"

			start
			{
				size { point 180,180 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine }
			}

			end
			{
				size { point 30,30 }
				fade { point 1 }
			}
		}
	}
	sound "unnamed4"
	{
		soundShader	"effects_sparks02"
	}
}





