effect effects/ships/droppod_trail
{
	size	222

	emitter "unnamed0"
	{
		duration	1,1
		count		120,120

		line
		{
			duration	0.5,1
			persist
			material	"gfx/effects/smoke/steam_alpha"

			start
			{
				position { box -2,-2,-2,2,2,2 }
				size { box 20,50 }
				tint { line 0,0,0,0.752941,0.752941,0.752941 }
				fade { point 0 }
				length { box 50,0,0,120,0,0 }
			}

			motion
			{
				size { envelope linear_flicker }
				fade { envelope arch }
			}

			end
			{
				size { box 40,100 }
				fade { line 0.1,0.2 }
			}
		}
	}
	emitter "unnamed1"
	{
		duration	1,1
		count		20,20

		sprite
		{
			duration	0.5,1
			material	"gfx/effects/smoke/steam_alpha"

			start
			{
				size { point 50,50 }
				tint { line 1,1,1,0.752941,0.752941,0.752941 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope arch }
			}

			end
			{
				size { point 100,100 }
				fade { line 0.4,0.2 }
			}
		}
	}
}


