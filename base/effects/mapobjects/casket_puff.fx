effect effects/mapobjects/casket_puff
{
	size	94

	spawner "unnamed0"
	{
		count		5,5

		sprite
		{
			duration	1,2
			material	"gfx/effects/smoke/cloud_alpha2"

			start
			{
				position { cylinder 0,-5,-5,0,5,5 }
				velocity { box 30,-5,-5,30,5,50 }
				size { line 5,5,10,10 }
				tint { line 1,1,1,0.439216,0.501961,0.560784 }
				fade { line 0.25,0.75 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 20,20,30,30 }
				rotate { point 0.5 relative }
			}
		}
	}
	spawner "unnamed1"
	{
		count		8,8

		sprite
		{
			duration	2,2
			material	"gfx/effects/smoke/steam_alpha"

			start
			{
				position { cylinder 0,-10,-10,0,10,10 }
				velocity { box 0,0,0,50,0,30 }
				size { point 10,10 }
				tint { line 1,1,1,0.439216,0.501961,0.556863 }
				fade { point 0.5 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine offset 0.5 }
				rotate { envelope linear }
			}

			end
			{
				size { box 20,20,35,35 }
				rotate { box -0.5,0.5 relative }
			}
		}
	}
	spawner "unnamed2"
	{
		count		20,20

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				velocity { box 50,-50,-50,50,50,50 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 5,5 }
				rotate { point 0.5 relative }
			}
		}
	}
}

