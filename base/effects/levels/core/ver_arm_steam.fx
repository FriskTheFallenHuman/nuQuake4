effect effects/levels/core/ver_arm_steam
{
	size	172

	emitter "pulse"
	{
		duration	1,1
		count		10,15
		locked

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/cloud_alpha_depth"

			start
			{
				velocity { point 200,0,0 }
				friction { point -700,0,0 }
				size { line 2,2,10,10 }
				tint { line 1,1,1,0.772549,0.752941,0.705882 }
				rotate { box 0,0.555556 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope exp_x2 }
				rotate { envelope exp_x2 }
			}

			end
			{
				size { line 50,50,70,70 }
				rotate { box 0.138889,0.277778 relative }
			}
		}
	}
	emitter "puff"
	{
		duration	1,1
		count		1,1
		locked

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/smoke/cloud_alpha_depth"

			start
			{
				size { point 20,20 }
				tint { line 1,1,1,0.501961,0.501961,0.501961 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 50,50 }
			}
		}
	}
	emitter "pulse2"
	{
		duration	1,1
		count		10,15
		locked

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/cloud_alpha_depth"

			start
			{
				velocity { point 90,0,0 }
				size { line 2,2,10,10 }
				tint { line 1,1,1,0.752941,0.752941,0.752941 }
				rotate { box 0,0.555556 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope exp_x2 }
				rotate { envelope exp_x2 }
			}

			end
			{
				size { line 30,30,50,50 }
				rotate { box 0.138889,0.277778 relative }
			}
		}
	}
	emitter "core"
	{
		duration	1,1
		count		5,10
		locked

		line
		{
			duration	1,1
			material	"gfx/effects/smoke/cloud_alpha"

			start
			{
				length { point 60,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 10 }
			}
		}
	}
	sound "unnamed4"
	{
		soundShader	"effects_steam_blast"
		volume	6,6
		freqshift	0,0
	}
}







