effect effects/ambient/green_spray_fill
{
	size	960

	emitter "end"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	1,10
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.00125,0

			start
			{
				position { sphere 25,-300,-300,45,300,300 }
				velocity { box 0,-15,-15,0,15,15 }
				size { box 70,70,90,90 }
				tint { point 0.603922,0.631373,0.164706 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 300,300,450,450 }
				fade { point 0.2 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
}


