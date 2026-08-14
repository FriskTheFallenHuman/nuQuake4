effect effects/monsters/pain25_metal
{
	size	135

	sound "unnamed0"
	{
		soundShader	"bullet_impact_metal"
	}
	spawner "unnamed1"
	{
		count		1,1

		sprite
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/weapons/nailgun_flash2"
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { point 3,3 }
				fade { point 0.2 }
			}
		}
	}
	spawner "unnamed2"
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
				size { box 15,15,20,20 }
			}
		}
	}
	spawner "unnamed3"
	{
		count		5,7
		locked

		line
		{
			duration	0.2,0.2
			material	"gfx/effects/weapons/nailgun_flash2"
			gravity		0.1,0.1
			generatedOriginNormal

			start
			{
				position { cylinder 1,-0.5,-0.5,1,0.5,1 surface }
				velocity { box 30,0,0,40,0,0 }
				size { point 0.6 }
				tint { point 0.501961,0.501961,0.501961 }
				length { box 7,0,0,9,0,0 }
			}
		}
	}
	spawner "unnamed4"
	{
		count		1,2

		sprite
		{
			duration	2,2
			material	"textures/decals/dsplat2"
			generatedOriginNormal

			start
			{
				position { cylinder 0.01,-0.005,-0.005,0.01,0.005,0.005 }
				velocity { box -100,0,0,-150,0,0 }
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


