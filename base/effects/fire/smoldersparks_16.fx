effect effects/fire/smoldersparks_16
{
	size	35

	emitter "smoke"
	{
		duration	1,1
		count		7,7

		sprite
		{
			duration	3,4
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.02,-0.02

			start
			{
				position { line 5,-1,-1,25,1,1 }
				velocity { box 0,-2,-2,0,2,2 }
				size { point 8,8 }
				tint { line 0.305882,0.247059,0.160784,0.176471,0.145098,0.117647 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { point 15,15 }
				fade { point 0.65 }
				rotate { box -0.166667,0.166667 relative }
			}
		}
	}
	emitter "embers"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	2,3
			blend	add
			material	"gfx/effects/energy_sparks/spark3"
			gravity		-0.05,0

			start
			{
				position { cylinder 10,-2,-2,10,2,2 }
				velocity { box 0,-5,-5,5,5,5 }
				angle { box 0,0,0,1,1,1 }
				size { line 0.25,0.25,1,1 }
				tint { line 1,1,1,0.941177,0.45098,0.243137 }
				offset { box 0,-3,-3,0,3,3 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope linear_flicker }
				angle { envelope linear }
			}

			end
			{
				angle { box -1,-1,-1,1,1,1 relative }
			}
		}
	}
}
