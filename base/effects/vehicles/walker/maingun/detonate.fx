effect effects/vehicles/walker/maingun/detonate
{
	size	525

	spawner "flash"
	{
		count		1,1

		sprite
		{
			duration	0.06,0.06
			blend	add
			material	"gfx/effects/weapons/muzzleflash2"

			start
			{
				velocity { box 300,-50,-50,400,50,50 }
				size { point 350,350 }
				tint { point 1,1,0.8 }
				fade { point 0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
			}

			end
			{
				size { point 50,50 }
				fade { point 0.8 }
			}
		}
	}
	sound "sound"
	{
		soundShader	"vehicle_walker_cannon_impact"
	}
	spawner "embers_out"
	{
		count		30,30

		sprite
		{
			duration	1,3
			blend	add
			material	"gfx/effects/weapons/flash"
			gravity		0.1,0.2

			start
			{
				position { sphere 50,-25,-25,0,25,25 }
				velocity { box -200,-200,-200,200,200,200 }
				angle { box 0,0,0,1,1,1 }
				size { line 2,2,4,4 }
				tint { line 0.996078,0.968628,0.905882,0.94902,0.603922,0.376471 }
				offset { box 0,-25,-25,0,25,25 }
				rotate { box 0.251,-0.25 }
			}

			motion
			{
				size { envelope exp_x2 }
				fade { envelope linear_flicker }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 0.5,0.5,1,1 }
				angle { box -0.5,-0.5,-0.5,0.5,0.5,0.5 relative }
			}
		}
	}
	spawner "smoke_ring"
	{
		count		30,30

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/impact_smoke"
			gravity		-0.03,-0.03
			generatedOriginNormal

			start
			{
				position { cylinder 0.1,-8,-8,0.1,8,8 surface }
				velocity { box 300,0,0,400,0,0 }
				acceleration { point -400,0,0 }
				size { point 6,6 }
				tint { point 0.376471,0.356863,0.309804 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 100,100 }
			}
		}
	}
	spawner "flash_streaks"
	{
		count		4,4
		locked

		line
		{
			duration	0.06,0.06
			blend	add
			material	"gfx/effects/weapons/flash_half3"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -1,-0.3,-0.3,-1,0.3,0.3 surface }
				velocity { box -25,-25,-25,25,25,25 }
				size { box 20,40 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0 }
				length { box -100,-100,-100,100,100,100 }
			}

			motion
			{
				fade { envelope decalfade }
			}

			end
			{
				fade { point 1 }
			}
		}
	}
	emitter "smoke3"
	{
		start		1,1
		duration	1,1
		count		2,3

		sprite
		{
			duration	2,3
			material	"gfx/effects/smoke/smoke_alpha"
			gravity		-0.02,-0.02

			start
			{
				velocity { box 0,-80,-80,80,80,80 }
				size { line 100,100,200,200 }
				tint { point 0.607843,0.572549,0.52549 }
				fade { point 0 }
				rotate { box -0.111111,0 }
			}

			motion
			{
				fade { envelope pop_hold_fadefast }
				rotate { envelope linear }
			}

			end
			{
				fade { point 0.4 }
				rotate { box -0.222222,-0.111111 relative }
			}
		}
	}
	spawner "smoke"
	{
		start		0.09,0.09
		count		7,9

		sprite
		{
			duration	2,3
			material	"gfx/effects/smoke/smoke_alpha"
			gravity		-0.02,-0.02

			start
			{
				velocity { box -25,-25,-25,25,25,25 }
				size { line 50,50,100,100 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0 }
				rotate { box 0,0.111111 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope exp_x2 }
				fade { envelope pop_hold_fadefast }
				rotate { envelope linear }
			}

			end
			{
				size { line 75,75,150,150 }
				tint { point 0.360784,0.360784,0.360784 }
				fade { point 0.5 }
				rotate { box 0.111111,0.222222 relative }
			}
		}
	}
	spawner "flash2"
	{
		count		1,1

		sprite
		{
			duration	0.06,0.06
			material	"gfx/effects/weapons/flash"
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { line 90,90,120,120 }
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
				size { line 50,50,70,70 }
			}
		}
	}
}


