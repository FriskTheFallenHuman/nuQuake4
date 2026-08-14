effect effects/weapons/railgun/trail
{
	size	111

	spawner "beam core"
	{
		count		1,1

		line
		{
			duration	0.4,0.4
			material	"gfx/effects/weapons/rail_trail3"

			start
			{
				size { point 8 }
				tint { point 0.752941,0.752941,0.752941 }
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
		density		60,60
		particleCap		512

		linked
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/weapons/rail_trail3"
			generatedNormal

			start
			{
				position { spiral -15,6,0,-15,6,0,50 useEndOrigin linearSpacing }
				velocity { point 30,0,0 }
				size { point 4 }
				tint { point 0.254902,0.745098,0.45098 }
				fade { point 0.75 }
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
		density		5,5
		particleCap		50

		sprite
		{
			duration	1.3,1.3
			blend	add
			persist
			material	"gfx/effects/energy_sparks/energy2"
			gravity		-0.03,0

			start
			{
				position { line 50,0,0,50,0,0 useEndOrigin linearSpacing }
				velocity { box 0,-5,-5,0,5,5 }
				angle { box 0,0,0,1,1,1 }
				size { line 30,30,40,40 }
				tint { point 0.603922,0.796079,0.54902 }
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















