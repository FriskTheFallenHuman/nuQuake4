effect effects/vehicles/walker/rocket/trail
{
	size	65

	emitter "unnamed1"
	{
		duration	1,1
		count		60,60

		line
		{
			duration	1,1
			material	"gfx/effects/smoke/white_alpha"

			start
			{
				size { box 4,5 }
				tint { line 0.792157,0.776471,0.709804,0.584314,0.482353,0.415686 }
				fade { point 0.4 }
				length { point -40,0,0 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope fire_smokefade count 1.5,1.5,1.5 }
				fade { envelope linear }
			}

			end
			{
				size { box 10,25 }
			}
		}
	}
	emitter "unnamed2"
	{
		duration	1,1
		count		60,60

		line
		{
			duration	0.2,0.2
			material	"gfx/effects/weapons/flash"

			start
			{
				size { box 3,6 }
				tint { line 0.752941,0.752941,0.752941,0.498039,0.498039,0.498039 }
				length { point -40,0,0 }
			}

			motion
			{
				tint { envelope fire_smokefade count 2,2,2 }
				fade { envelope linear }
			}
		}
	}
}


