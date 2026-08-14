effect effects/weapons/railgun/trail_mp
{
	size	111

	spawner "beam core"
	{
		count		1,1

		line
		{
			duration	0.5,0.5
			material	"gfx/effects/weapons/rail_trail_mp"

			start
			{
				size { point 9 }
				length { line 0,0,0,0,0,0 useEndOrigin }
			}

			motion
			{
				size { envelope "exp_x2" }
				tint { envelope "linear_flicker" }
			}

			end
			{
				size { point 3 }
			}
		}
	}
	spawner "spiral"
	{
		density		15,15
		particleCap		512

		linked
		{
			duration	0.6,0.6
			blend	add
			material	"gfx/effects/weapons/rail_trail_mp"
			generatedNormal

			start
			{
				position { spiral -15,6,0,-15,6,0,100 useEndOrigin linearSpacing }
				velocity { point 20,0,0 }
				size { point 4 }
				fade { point 0.4 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 10 }
			}
		}
	}
	spawner "leftover"
	{
		detail		0.5
		start		0.25,0.25
		density		2,2
		particleCap		50

		sprite
		{
			duration	1.3,1.3
			blend	add
			persist
			material	"gfx/effects/energy_sparks/energy_mp"
			gravity		-0.03,0

			start
			{
				position { line 50,0,0,50,0,0 useEndOrigin linearSpacing }
				velocity { box 0,-5,-5,0,5,5 }
				angle { box 0,0,0,1,1,1 }
				size { line 30,30,40,40 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 50,50,60,60 }
				fade { point 0.2 }
				angle { box -1,-1,-1,1,1,1 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}








