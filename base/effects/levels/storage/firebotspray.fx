effects/levels/storage/firebotspray
{
	size	282

	sound "sound"
	{
		soundShader	"effects_blowtorch"
	}
	emitter "spout"
	{
		duration	2,2
		count		10,15
		locked

		line
		{
			duration	0.25,0.25
			material	"gfx/effects/smoke/steam_source"
			generatedNormal

			start
			{
				size { box 5,10 }
				tint { line 1,1,1,0.870588,0.92549,0.952941 }
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
				size { box 33,40 }
				length { box 55,125,55,55,200,55 }
			}
		}
	}
	emitter "source"
	{
		duration	2,2
		count		5,6

		sprite
		{
			duration	0.2,0.5
			material	"gfx/effects/smoke/steam_alpha"

			start
			{
				velocity { box 10,0,0,20,0,0 }
				acceleration { box 100,0,0,200,0,0 }
				size { point 5,5 }
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
				size { point 20,20 }
				fade { point 0.5 }
				rotate { box -0.166667,0.166667 relative }
			}
		}
	}
	emitter "nozzle"
	{
		duration	2,2
		count		10,15
		locked

		line
		{
			duration	0.2,0.2
			material	"gfx/effects/smoke/steam_alpha"

			start
			{
				position { line -2,0,0,0,0,0 }
				size { point 2 }
				tint { line 1,1,1,0.788235,0.933333,0.945098 }
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
				size { box 4,10 }
				length { box 30,-8,-8,75,8,8 }
			}
		}
	}
	emitter "spout2"
	{
		duration	2,2
		count		5,5
		locked

		line
		{
			duration	0.25,0.25
			material	"gfx/effects/smoke/steam_source"
			generatedNormal

			start
			{
				size { point 2 }
				tint { line 1,1,1,0.870588,0.92549,0.952941 }
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
				size { box 5,20 }
				length { box 55,150,55,55,250,55 }
			}
		}
	}
	emitter "source2"
	{
		duration	2,2
		count		5,10

		sprite
		{
			duration	0.1,0.2
			material	"gfx/effects/smoke/steam_alpha"

			start
			{
				size { point 5,5 }
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
				size { point 5,5 }
				fade { point 1 }
				rotate { box -0.166667,0.166667 relative }
			}
		}
	}
	emitter "source3"
	{
		duration	2,2
		count		12,12

		sprite
		{
			duration	1,1.6
			material	"gfx/effects/smoke/steam_alpha"
			gravity		0.02,0.1

			start
			{
				position { line 0,-1,-1,0,1,1 }
				velocity { box 150,-10,-10,150,10,10 }
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
}



