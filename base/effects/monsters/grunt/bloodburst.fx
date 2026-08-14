effect effects/monsters/grunt/bloodburst
{
	size	1

	emitter "unnamed1"
	{
		duration	1,1
		count		15,15

		sprite
		{
			duration	0.5,0.5
			blend	add
			material	"textures/decals/dsplat2"
			gravity		0.1,0.1

			start
			{
				velocity { box -2,-2,-2,2,2,2 }
				size { point 10,10 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope faststart_zero_one }
				fade { envelope linear }
			}

			end
			{
				size { point 20,20 }
			}
		}
	}
}


