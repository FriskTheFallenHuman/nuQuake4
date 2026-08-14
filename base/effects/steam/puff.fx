effect effects/steam/puff
{
	size	82

	spawner "unnamed0"
	{
		count		5,5

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				velocity { box 200,-100,-100,200,100,100 }
				size { point 14,14 }
				tint { line 0.501961,0.501961,0.501961,0.752941,0.752941,0.752941 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope exp_x2 }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 30,30 }
			}
		}
	}
	spawner "unnamed1"
	{
		count		2,2

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				velocity { box 10,-10,-10,10,10,10 }
				size { point 14,14 }
				fade { point 0.5 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope exp_x2 }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 3,3 }
			}
		}
	}
	spawner "unnamed2"
	{
		count		5,5

		line
		{
			duration	0.25,0.25
			material	"gfx/effects/smoke/cloud_alpha3"
			generatedOriginNormal

			start
			{
				position { sphere 0.98,-1,-1,0.98,1,1 surface }
			}

			motion
			{
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				length { box 40,0,0,50,0,0 }
			}
		}
	}
	spawner "unnamed3"
	{
		count		1,1

		line
		{
			duration	0.25,0.25
			material	"gfx/effects/smoke/cloud_alpha"

			start
			{
				size { point 2 }
				fade { point 0.5 }
			}

			motion
			{
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				length { point 80,0,0 }
			}
		}
	}
}
