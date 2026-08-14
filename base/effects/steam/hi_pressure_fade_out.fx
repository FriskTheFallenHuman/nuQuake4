effect effects/steam/hi_pressure_fade_out
{
	size	353

	sound "sound"
	{
		soundShader	"effects_blowtorch"
	}
	emitter "spout"
	{
		duration	4,4
		count		10,15
		locked

		line
		{
			duration	0.25,0.25
			material	"gfx/effects/smoke/steam_source"
			generatedNormal

			start
			{
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
		duration	4,4
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
	emitter "source"
	{
		duration	5,5
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
		duration	9,9
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
		duration	10,10
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
				fade { point 1 }
			}
		}
	}
	emitter "spout2"
	{
		start		4,4
		duration	0.5,0.5
		count		10,15
		locked

		line
		{
			duration	0.25,0.25
			material	"gfx/effects/smoke/steam_source"
			generatedNormal

			start
			{
				length { point 55,12,55 }
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
				length { point 55,50,55 }
			}
		}
	}
	emitter "spout3"
	{
		start		5,5
		duration	2,2
		count		3,3
		locked

		line
		{
			duration	0.25,0.25
			material	"gfx/effects/smoke/steam_source"
			generatedNormal

			start
			{
				length { point 55,12,55 }
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
				length { point 55,50,55 }
			}
		}
	}
	emitter "spout4"
	{
		start		9,9
		duration	0.25,0.25
		count		3,3
		locked

		line
		{
			duration	0.25,0.25
			material	"gfx/effects/smoke/steam_source"
			generatedNormal

			start
			{
				length { point 55,12,55 }
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
				length { point 55,50,55 }
			}
		}
	}
	emitter "spout5"
	{
		start		1,1
		duration	1,1
		count		4,4
		locked

		line
		{
			duration	6,6
			material	"gfx/effects/smoke/steam_source"
			generatedNormal

			start
			{
				fade { point 0.5 }
				length { point 1,35,1 }
			}

			motion
			{
				size { envelope fast_in_slow_out }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { point 3 }
				length { point 1,1,1 }
			}
		}
	}
	emitter "spout6"
	{
		start		9,9
		duration	0.5,0.5
		count		8,8
		locked

		line
		{
			duration	0.25,0.25
			material	"gfx/effects/smoke/steam_source"
			generatedNormal

			start
			{
				length { point 55,12,55 }
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
				length { box 55,50,55,55,100,55 }
			}
		}
	}
}





