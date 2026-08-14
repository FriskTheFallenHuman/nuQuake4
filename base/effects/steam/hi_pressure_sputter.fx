effect effects/steam/hi_pressure_sputter
{
	size	353

	sound "sound"
	{
		soundShader	"effects_blowtorch"
	}
	emitter "kickers"
	{
		start		1,1
		duration	25,25
		count		2,5
		locked

		sprite
		{
			duration	1,2
			material	"gfx/effects/fluids_drips/bubble_alpha"
			gravity		0.25,0.5

			start
			{
				position { line 3,0,2,3,0,1 }
				velocity { box 100,-50,-50,200,50,50 }
				size { point 0.75,0.75 }
				fade { line 0.5,0.75 }
			}

			motion
			{
				size { envelope linear }
			}

			end
			{
				size { point 0.25,0.25 }
			}
		}
	}
	emitter "spout"
	{
		duration	25,25
		count		1,5
		locked

		line
		{
			duration	0.25,0.5
			material	"gfx/effects/smoke/steam_source"
			generatedNormal

			start
			{
				fade { line 0.5,0.85 }
				length { point 55,25,55 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { point 33 }
				length { point 55,100,55 }
			}
		}
	}
	emitter "end"
	{
		start		3,3
		duration	25,25
		count		1,3

		sprite
		{
			duration	1,1.25
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.01,0.01
			generatedOriginNormal

			start
			{
				position { line 25,0,0,45,0,0 }
				velocity { box 100,-15,-15,150,15,15 }
				size { box 2,2,5,5 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fast_in_slow_out }
				rotate { envelope linear }
			}

			end
			{
				size { box 150,150,175,175 }
				fade { point 0.25 }
				rotate { box -0.166667,0.166667 relative }
			}
		}
	}
	emitter "drops"
	{
		duration	25,25
		count		1,2.5

		line
		{
			duration	2,2
			generatedLine
			material	"gfx/effects/fluids_drips/bubble_alpha"
			gravity		0.25,0.5

			start
			{
				position { line 2,-1,-1,1,1,1 }
				size { point 0.5 }
				fade { point 0 }
				length { box 0,0,-35,0,0,-18 }
			}

			motion
			{
				fade { envelope fast_in_slow_out }
				length { envelope fast_in_slow_out }
			}

			end
			{
				fade { line 0.5,0.25 }
				length { box 0,0,3,0,0,8 }
			}
		}
	}
	emitter "source"
	{
		start		2,2
		duration	25,25
		count		12,12

		sprite
		{
			duration	1,2
			material	"gfx/effects/smoke/steam_alpha"
			gravity		0.02,0.1

			start
			{
				position { line 0,-1,-1,0,1,1 }
				velocity { box 5,-10,-10,150,10,10 }
				size { box 2,2,5,5 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fast_in_slow_out }
				rotate { envelope linear }
			}

			end
			{
				size { box 85,85,100,100 }
				fade { point 0.25 }
				rotate { box -0.166667,0.166667 relative }
			}
		}
	}
	emitter "nozzle"
	{
		start		0,2
		duration	0.2,0.2
		count		12,12
		locked

		line
		{
			duration	1,1
			material	"gfx/effects/smoke/steam_alpha"
			generatedOriginNormal

			start
			{
				position { cylinder 0.05,0.05,0.05,0.05,-0.05,-0.05 }
				size { point 2 }
				length { box 5,-0.5,-0.5,6,0.5,0.5 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { point 4 }
				length { box 12,-10,-10,15,10,10 }
			}
		}
	}
	emitter "mask"
	{
		duration	25,25
		count		3,3

		oriented
		{
			duration	2,2
			material	"gfx/effects/smoke/steam_alpha"

			start
			{
				position { line 0.05,0,0,1,0,0 }
				size { point 12,12 }
				fade { point 0 }
				rotate { box 0,0,0.5,0,0,-0.5 }
			}

			motion
			{
				size { envelope popoverextreme_hold_fade }
				fade { envelope fast_in_slow_out }
				rotate { envelope linear }
			}

			end
			{
				fade { point 0.25 }
			}
		}
	}
}



