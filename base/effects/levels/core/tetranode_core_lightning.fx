effect effects/levels/core/tetranode_core_lightning
{
	size	269

	spawner "bolt core"
	{
		count		1,1
		locked
		constant

		line
		{
			duration	1,1
			material	"gfx/test/lgun"
			tiling	128

			start
			{
				position { point -2,0,0 }
				size { point 100 }
				tint { point 0.580392,0.709804,0.921569 }
				length { line 0,0,0,0,0,0 useEndOrigin }
			}

			motion
			{
				tint { envelope neontable2 count 2,2,2 }
			}

			end
			{
				tint { point 0.247059,0.247059,0.247059 }
			}
		}
	}
	spawner "core_beam"
	{
		count		1,1
		constant

		line
		{
			duration	1,1
			material	"gfx/effects/energy_sparks/blue_beam"

			start
			{
				size { point 12 }
				tint { point 0.733333,0.733333,1 }
				length { line 0,0,0,0,0,0 useEndOrigin }
			}
		}
	}
	emitter "pulse"
	{
		duration	1,1
		count		5,5

		line
		{
			duration	1,1
			material	"gfx/effects/energy_sparks/blue_beam_pulse"

			start
			{
				velocity { point 350,0,0 }
				size { box 5,15 }
				length { box 10,0,0,100,0,0 }
			}

			motion
			{
				size { envelope linear }
			}
		}
	}
}
