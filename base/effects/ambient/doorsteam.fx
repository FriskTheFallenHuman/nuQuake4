effect effects/ambient/doorsteam
{
	size	321

	spawner "unnamed0"
	{
		count		5,5

		sprite
		{
			duration	3,5
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		0,0.0125

			start
			{
				position { line 0,-1,-80,0,-1,80 }
				velocity { box 0,-10,-10,0,10,10 }
				size { line 10,10,20,20 }
				tint { line 1,1,1,0.752941,0.752941,0.752941 }
				fade { line 0.25,0.5 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { line 150,150,180,180 }
			}
		}
	}
	spawner "unnamed1"
	{
		start		0.25,0.25
		count		20,20
		locked

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/smoke/cloud_alpha2"
			generatedOriginNormal

			start
			{
				position { line 0,0,-80,0,0,80 }
				velocity { box 0,-120,-120,0,120,120 }
				size { line 10,10,20,20 }
				tint { point 0.752941,0.752941,0.752941 }
				fade { line 0.25,0.5 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { line 10,10,50,50 }
			}
		}
	}
}

