effect effects/explosions/surface/pipe_exp
{
	size	920

	sound "sound"
	{
		soundShader	"effects_blowtorch"
	}
	spawner "steam"
	{
		count		6,10

		sprite
		{
			duration	0.75,1
			material	"gfx/effects/smoke/cloud_alpha2"
			gravity		0.06,0.16

			start
			{
				position { line 10,-1,-1,10,1,1 }
				velocity { box 120,-80,-80,150,80,80 }
				size { box 10,10,20,20 }
				tint { line 0.752941,0.752941,0.752941,0.501961,0.501961,0.501961 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { box 50,50,100,100 }
				fade { line 0.5,1 }
				rotate { box -0.166667,0.166667 }
			}
		}
	}
	spawner "steam2"
	{
		count		4,6

		sprite
		{
			duration	0.75,1
			material	"gfx/effects/smoke/cloud_alpha2"
			gravity		0.06,0.16

			start
			{
				position { line 10,-1,-1,10,1,1 }
				velocity { box 200,-150,-150,300,150,150 }
				size { line 10,10,20,20 }
				tint { line 0.752941,0.752941,0.752941,0.501961,0.501961,0.501961 }
				fade { point 0 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { line 100,100,200,200 }
				fade { line 1,0.75 }
				rotate { box -0.166667,0.166667 }
			}
		}
	}
	spawner "steam3"
	{
		start		0.25,0.25
		count		20,20

		sprite
		{
			duration	1,3
			material	"gfx/effects/smoke/cloud_alpha2"

			start
			{
				position { cylinder 10,-100,-100,10,100,100 }
				velocity { box -100,-100,-100,-100,100,100 }
				size { line 100,100,0,0 }
				tint { line 0.752941,0.752941,0.752941,0.501961,0.501961,0.501961 }
				fade { point 0 }
				offset { point 210,0,0 }
				rotate { box 0,0.5 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine }
				rotate { envelope linear }
			}

			end
			{
				size { line 200,200,300,300 }
				fade { line 0.25,0.5 }
				rotate { box -0.166667,0.166667 relative }
			}
		}
	}
	spawner "flash"
	{
		count		2,5
		locked

		sprite
		{
			duration	0.125,0.125
			material	"gfx/effects/weapons/mgun_muzzleflash"

			start
			{
				size { line 4,4,5,5 }
				tint { point 0.705882,0.788235,0.803922 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 200,200 }
			}
		}
	}
}

