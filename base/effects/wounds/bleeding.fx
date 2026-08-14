effect effects/wounds/bleeding
{
	size	91

	emitter "unnamed0"
	{
		duration	0.7,0.9
		count		1,2

		sprite
		{
			duration	2,2
			material	"textures/decals/dsplat2"
			gravity		0.5,0.5
			generatedOriginNormal

			start
			{
				position { cylinder 0.01,-0.005,-0.005,0.01,0.005,0.005 }
				velocity { box 70,0,0,100,0,0 }
				size { point 2,2 }
			}

			impact
			{
				remove	1
				effect	"effects/wounds/blood_splat"
			}
		}
	}
	emitter "unnamed1"
	{
		start		0.25,0.3
		duration	0.5,1.2
		count		1,2

		sprite
		{
			duration	2,2
			material	"textures/decals/dsplat2"
			gravity		0.5,0.5
			generatedOriginNormal

			start
			{
				position { cylinder 0.01,-0.005,-0.005,0.01,0.005,0.005 }
				velocity { box 70,0,0,100,0,0 }
				size { point 2,2 }
				rotate { box 0,1 }
			}
		}
	}
	emitter "unnamed2"
	{
		start		0.15,0.25
		duration	0.8,1
		count		1,2

		sprite
		{
			duration	2,2
			material	"textures/decals/dsplat2"
			gravity		0.5,0.5

			start
			{
				velocity { box 70,0,0,100,0,0 }
				size { point 2,2 }
			}
		}
	}
}


