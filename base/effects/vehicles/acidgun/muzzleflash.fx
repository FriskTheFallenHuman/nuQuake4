effect effects/vehicles/acidgun/muzzleflash
{
	size	166

	emitter "spray"
	{
		duration	0.2,0.2
		count		100,100
		locked

		sprite
		{
			duration	0.5,0.75
			material	"gfx/effects/fluids_drips/bubble_alpha"
			gravity		0.12,0.25

			start
			{
				position { point 1,0,0 }
				velocity { box 75,-25,-100,125,25,100 }
				size { line 1,1,3,3 }
				tint { line 0.403922,0.572549,0.054902,0.501961,0.501961,0 }
				fade { point 0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope pop_hold_fade }
			}

			end
			{
				size { line 0.25,0.25,0.5,0.5 }
				fade { point 1 }
			}
		}
	}
	emitter "spout"
	{
		duration	0.2,0.2
		count		10,15
		locked

		line
		{
			duration	0.25,0.25
			material	"gfx/effects/smoke/steam_source"
			generatedOriginNormal

			start
			{
				position { cylinder 0.05,-0.01,-0.01,0.05,0.01,0.01 }
				size { box 1,6 }
				tint { point 0.486275,0.701961,0.301961 }
				length { box 25,0,0,45,0,0 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { box 33,45 }
				tint { point 0.486275,0.384314,0.00784314 }
				length { box 100,0,0,120,0,0 }
			}
		}
	}
	emitter "source1"
	{
		duration	0.25,0.25
		count		12,12

		sprite
		{
			duration	0.5,1
			material	"gfx/effects/smoke/steam_alpha"
			gravity		0.05,0.1

			start
			{
				position { line 0,-1,-1,0,1,1 }
				velocity { box 25,-3,-3,75,3,3 }
				size { line 2,2,5,5 }
				tint { point 0.501961,0.501961,0 }
				fade { point 0 }
				rotate { box -0.125,-0.25 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fast_in_slow_out }
				rotate { envelope linear }
			}

			end
			{
				size { line 35,35,25,25 }
				fade { line 0.15,0.3 }
			}
		}
	}
	emitter "source2"
	{
		duration	0.25,0.25
		count		8,8

		sprite
		{
			duration	1,2
			material	"gfx/effects/smoke/steam_alpha"
			gravity		0.005,0.005

			start
			{
				position { line 1,-1,-1,1,1,1 }
				velocity { box 25,-3,3,12,3,3 }
				size { line 12,12,10,10 }
				tint { line 0.501961,0.501961,0,0.486275,0.341176,0.00784314 }
				fade { point 0 }
				rotate { box -0.125,-0.25 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fast_in_slow_out }
				rotate { envelope linear }
			}

			end
			{
				size { line 85,85,50,50 }
				fade { line 0.15,0.25 }
			}
		}
	}
}


