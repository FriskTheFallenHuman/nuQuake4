effect effects/weapons/nailgun/fly
{
	size	49

	spawner "line_outter"
	{
		detail		0.5
		count		1,1
		locked
		constant

		line
		{
			duration	0.5,0.5
			material	"gfx/effects/weapons/flash_half"

			start
			{
				position { point 12,0,0 }
				size { point 3 }
				tint { point 0.501961,0.501961,0.501961 }
				length { point -35,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "pop_flicker_fade" }
			}

			end
			{
				size { point 8 }
			}
		}
	}
	spawner "line_inner"
	{
		detail		0.5
		count		1,1
		locked
		constant

		line
		{
			duration	0.5,0.5
			material	"gfx/effects/weapons/flash_half"

			start
			{
				position { point 12,0,0 }
				size { point 0.5 }
				length { point -35,0,0 }
			}

			motion
			{
				size { envelope "linear" }
			}

			end
			{
				size { point 3 }
			}
		}
	}
	spawner "sprite"
	{
		count		1,1
		locked
		constant

		sprite
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/weapons/flash"

			start
			{
				position { point -1,0,0 }
				size { point 5,5 }
			}

			motion
			{
				size { envelope "linear" }
			}

			end
			{
				size { point 10,10 }
			}
		}
	}
	emitter "trail"
	{
		start		0.05,0.05
		duration	1,1
		count		60,60

		line
		{
			duration	0.5,0.5
			persist
			material	"gfx/effects/smoke/cloud_alpha2"

			start
			{
				position { point 10,0,0 }
				size { point 2 }
				tint { line 0.227451,0.227451,0.227451,0.286275,0.286275,0.286275 }
				fade { point 0.8 }
				length { point -30,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 3 }
			}
		}
	}
}








