effect effects/vehicles/walker/rocket/trail2
{
	size	95

	emitter "unnamed1"
	{
		duration	1,1
		count		75,75

		line
		{
			duration	1,1
			persist
			material	"gfx/effects/smoke/soft_alpha_trail"

			start
			{
				size { box 4,5 }
				tint { line 0.792157,0.776471,0.709804,0.584314,0.482353,0.411765 }
				length { point -70,0,0 }
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
		count		75,75

		line
		{
			duration	0.2,0.2
			persist
			material	"gfx/effects/weapons/flash"

			start
			{
				size { box 3,6 }
				tint { line 0.74902,0.74902,0.74902,0.494118,0.494118,0.494118 }
				length { point -60,0,0 }
			}

			motion
			{
				tint { envelope fire_smokefade count 2,2,2 }
				fade { envelope linear }
			}
		}
	}
}
