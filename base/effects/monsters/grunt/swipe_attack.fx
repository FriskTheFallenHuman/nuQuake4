effect effects/monsters/grunt/swipe_attack
{
	size	22

	emitter "steam1"
	{
		duration	0.2,0.2
		count		100,100

		sprite
		{
			duration	0.3,0.3
			material	"gfx/effects/smoke/steam_alpha"

			start
			{
				size { point 15,15 }
				fade { point 0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fast_in_slow_out }
			}

			end
			{
				size { point 5,5 }
				fade { point 0.15 }
			}
		}
	}
}


