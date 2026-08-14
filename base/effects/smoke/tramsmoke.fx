effect effects/smoke/tramsmoke
{
	size	73

	emitter "smoke"
	{
		duration	1,1
		count		20,30

		sprite
		{
			duration	2,4
			material	"gfx/effects/smoke/smoke_dark"

			start
			{
				velocity { point 0,1,0 }
				size { box 5,5,10,10 }
				tint { line 0.752941,0.752941,0.752941,0.501961,0.501961,0.501961 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 30,30,50,50 }
				tint { point 0.203922,0.176471,0.14902 }
				fade { point 0.5 }
				rotate { box -0.166667,0.166667 relative }
			}
		}
	}
}
