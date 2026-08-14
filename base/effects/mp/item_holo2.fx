effect effects/mp/item_holo2
{
	size	160

	emitter "thelight"
	{
		duration	1,1
		count		3,3

		line
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/ctf_grey_light"

			start
			{
				size { box 15,20 }
				tint { line 1,1,1,0.603922,0.580392,0.921569 }
				fade { point 0.25 }
				length { point 100,0,0 }
			}

			motion
			{
				size { envelope exp_x2 }
				fade { envelope cosine offset 0.5 }
			}

			end
			{
				size { box 15,20 }
			}
		}
	}
	emitter "thelight2"
	{
		duration	1,1
		count		4,4

		line
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/ctf_grey_light"

			start
			{
				size { box 3,4 }
				tint { line 1,1,1,0.603922,0.580392,0.921569 }
				fade { point 0.25 }
				length { point 5,0,0 }
			}

			motion
			{
				size { envelope exp_x2 }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { point 10 }
				length { box 80,0,0,150,0,0 }
			}
		}
	}
}

