effect effects/monsters/pain
{
	size	135

	sound "unnamed0"
	{
		soundShader	"bullet_impact_flesh"
	}
	spawner "unnamed1"
	{
		count		3,3

		sprite
		{
			duration	0.25,0.25
			blend	add
			material	"textures/decals/dsplat2"
			gravity		0.1,0.1

			start
			{
				velocity { box 10,-5,-5,20,5,5 }
				size { point 3,3 }
				rotate { line 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { box 8,8,10,10 }
			}
		}
	}
	spawner "unnamed2"
	{
		count		1,2

		sprite
		{
			duration	2,2
			material	"textures/decals/dsplat2"
			flipNormal

			start
			{
				velocity { box 100,-1,-1,150,1,1 }
				size { point 2,2 }
			}

			impact
			{
				remove	1
				effect	"effects/wounds/blood_splat"
			}
		}
	}
}


