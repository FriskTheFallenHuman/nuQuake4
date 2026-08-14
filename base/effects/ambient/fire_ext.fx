effect effects/ambient/fire_ext
{
	size	452

	spawner "unnamed1"
	{
		count		5,5

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/smoke/cloud_alpha2"

			start
			{
				velocity { point 30,0,0 }
				size { line 0,0,5,5 }
				tint { line 1,1,1,0.752941,0.752941,0.752941 }
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
				size { box 100,100,200,200 }
				rotate { point 0 relative }
			}
		}
	}
	spawner "powder"
	{
		count		8,8

		sprite
		{
			duration	0.75,0.75
			material	"gfx/effects/smoke/underlit_alpha"
			gravity		0.125,0.125

			start
			{
				position { point 30,0,0 }
				velocity { box 280,-150,-150,280,150,150 }
				friction { point -4000,0,0 }
				size { line 2,2,10,10 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 100,100,250,250 }
				rotate { box -0.333333,0.333333 relative }
			}
		}
	}
	spawner "wall"
	{
		count		2,2

		oriented
		{
			duration	0.25,0.25
			material	"gfx/effects/smoke/cloud_alpha2"

			start
			{
				position { point 1,0,0 }
				size { point 0,0 }
				rotate { box 0,0,-1,0,0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 100,100,300,300 }
			}
		}
	}
	spawner "core_line"
	{
		count		3,3

		line
		{
			duration	0.25,0.25
			material	"gfx/effects/smoke/steam_source"

			start
			{
				size { point 20 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope exp_x2 }
				length { envelope linear }
			}

			end
			{
				size { point 80 }
				length { point 200,0,0 }
			}
		}
	}
	spawner "chunks"
	{
		count		3,5

		model
		{
			duration	1.25,1.25
			material	"gfx/test/rocket_chunks"
			model		"models/test/rocket_chunk.lwo"
			gravity		0.75,0.75
			generatedOriginNormal
			trailType	chunks_trail

			start
			{
				position { sphere 0.14,-0.2,-0.2,0.14,0.2,0.2 }
				velocity { box 300,0,0,550,0,0 }
				tint { point 0.501961,0.501961,0.501961 }
				rotate { box 0,0,0,0.333333,0.333333,0.333333 }
			}

			motion
			{
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				rotate { box 0.333333,0.333333,0.333333,0.666667,0.666667,0.666667 relative }
			}

			impact
			{
				bounce	0.4
			}
		}
	}
	trail "chunks_trail"
	{
		count		30,30

		sprite
		{
			duration	0.35,0.35
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				size { line 5,5,8,8 }
				tint { line 1,1,1,0.752941,0.752941,0.752941 }
				fade { point 0.6 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope exp_xoverx2 }
				fade { envelope linear }
				rotate { envelope exp_x2 }
			}

			end
			{
				size { line 10,10,30,30 }
				rotate { point 0 relative }
			}
		}
	}
	spawner "core_line2"
	{
		count		10,10

		line
		{
			duration	0.25,0.25
			material	"gfx/effects/smoke/steam_source"
			generatedOriginNormal

			start
			{
				position { cylinder 0.451,-0.5,-0.5,0.451,0.5,0.5 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope exp_x2 }
				length { envelope linear }
			}

			end
			{
				size { box 2,10 }
				length { box 50,0,0,200,0,0 }
			}
		}
	}
}

