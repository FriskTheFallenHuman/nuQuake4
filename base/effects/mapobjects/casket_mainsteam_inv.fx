effect effects/mapobjects/casket_mainsteam_inv
{
	size	123

	emitter "unnamed0"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	0.45,0.45
			material	"gfx/effects/smoke/cloud_alpha2"
			gravity		-0.0125,0.095
			flipNormal

			start
			{
				velocity { point 0,50,-50 }
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
				size { line 50,50,80,80 }
				rotate { point 0.5 relative }
			}
		}
	}
	emitter "unnamed1"
	{
		duration	1,1
		count		8,8

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/steam_alpha"
			gravity		0.025,0.125
			flipNormal

			start
			{
				position { cylinder 0,-10,-10,0,10,10 }
				velocity { point 0,20,-20 }
				size { point 30,30 }
				tint { line 1,1,1,0.439216,0.501961,0.560784 }
				fade { point 0.5 }
				offset { point 0,15,20 }
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
				size { box 40,40,50,50 }
				rotate { box -0.5,0.5 relative }
			}
		}
	}
	emitter "unnamed2"
	{
		duration	1,1
		count		20,20

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.0125,0.095
			flipNormal

			start
			{
				velocity { point 0,50,-50 }
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
				size { point 10,10 }
				rotate { point 0.5 relative }
			}
		}
	}
}

