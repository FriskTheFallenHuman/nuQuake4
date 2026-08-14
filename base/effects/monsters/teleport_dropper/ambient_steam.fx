effect effects/monsters/teleport_dropper/ambient_steam
{
	size	91

	emitter "main steam"
	{
		duration	1,1
		count		15,15

		sprite
		{
			duration	2.5,2.5
			persist
			material	"gfx/effects/smoke/cloud_alpha2"
			gravity		-0.005,0.025

			start
			{
				velocity { box 5,-2,-2,10,2,2 }
				friction { point -10,0,0 }
				tint { line 0.603922,0.905882,0.847059,0.611765,0.894118,0.635294 }
				rotate { box 0,-0.5 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope exp_x2 }
				fade { envelope guitable_10_5 }
				rotate { envelope linear }
			}

			end
			{
				size { line 15,15,30,30 }
				tint { point 0.501961,0.501961,0.501961 }
				rotate { box -0.5,0.5 relative }
			}
		}
	}
	emitter "steam"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/steam_alpha"
			gravity		0.06,0.06

			start
			{
				velocity { point 30,0,0 }
				tint { point 0.266667,0.607843,0.470588 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope pop_hold_fadefast }
				rotate { envelope linear }
			}

			end
			{
				size { point 55,55 }
				fade { point 0.18 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}
