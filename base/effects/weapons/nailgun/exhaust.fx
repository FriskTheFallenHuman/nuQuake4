effect effects/weapons/nailgun/exhaust
{
	size	4

	spawner "white smoke"
	{
		detail		0.5
		count		1,1
		locked

		line
		{
			duration	0.12,0.12
			material	"gfx/effects/weapons/rail_smoke3"

			start
			{
				size { point 0.25 }
				tint { point 0.490196,0.458824,0.376471 }
				fade { line 0.25,0.12 }
				length { point 2,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				length { point 1,0,0 }
			}
		}
	}
	spawner "colored_smoke"
	{
		count		3,4
		locked

		line
		{
			duration	0.06,0.06
			material	"gfx/effects/weapons/nailgun_flash"

			start
			{
				position { point -1,0.05,0 }
				size { point 0.25 }
				length { box 0.5,0,0,1,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { point 0.12 }
				length { point 3,0,0 }
			}
		}
	}
}



