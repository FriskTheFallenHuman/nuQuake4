effect effects/vehicles/gev/maingun/muzzleflash
{
	size	743

	spawner "smoke"
	{
		start		0.1,0.1
		count		10,10

		sprite
		{
			duration	1.5,1.5
			material	"gfx/effects/smoke/cloud_alpha2"
			gravity		-0.04,-0.04

			start
			{
				position { box 0,-5,-5,400,5,5 }
				velocity { box 250,-50,-50,500,50,50 }
				size { line 60,60,80,80 }
				tint { line 0.776471,0.756863,0.72549,0.52549,0.521569,0.47451 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope cosine offset -0.1,-0.1 }
				tint { envelope fire_smokefade count 2,2,2 }
				fade { envelope cosine }
				rotate { envelope linear }
			}

			end
			{
				size { line 120,120,150,150 }
				tint { line 0.321569,0.321569,0.286275,0.333333,0.32549,0.290196 }
				fade { point 0.3 }
				rotate { box -0.166667,0.166667 relative }
			}
		}
	}
	spawner "single"
	{
		count		1,1
		locked

		line
		{
			duration	0.18,0.18
			blend	add
			material	"gfx/effects/weapons/flash_half_blue3"

			start
			{
				position { point -5,0,0 }
				size { point 0 }
			}

			motion
			{
				size { envelope fastinslowout }
				tint { envelope linear }
				fade { envelope linear }
				length { envelope fastinslowout }
			}

			end
			{
				size { point 20 }
				length { box 300,0,0,450,0,0 }
			}
		}
	}
	spawner "flash_large"
	{
		count		3,3
		locked

		sprite
		{
			duration	0.12,0.12
			material	"gfx/effects/weapons/shotgun_mflash"

			start
			{
				position { line 5,0,0,7,0,0 }
				size { box 120,120,150,150 }
				tint { point 0.768628,0.792157,0.956863 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 30,30 }
			}
		}
	}
	spawner "fire"
	{
		count		10,10

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/fire/fire4a"
			gravity		-0.04,-0.04

			start
			{
				position { box 0,-5,-5,400,5,5 }
				velocity { box 0,-20,-20,250,20,20 }
				size { line 20,20,30,30 }
				tint { point 0,0,0 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope fast_in_slow_out }
				rotate { envelope linear }
			}

			end
			{
				size { line 90,90,120,120 }
				tint { point 0.266667,0.266667,0.266667 }
				rotate { box -0.166667,0.166667 relative }
			}
		}
	}
	spawner "side_streaks"
	{
		count		5,5
		locked

		line
		{
			duration	0.12,0.12
			blend	add
			generatedLine
			material	"gfx/effects/weapons/flash_half_blue3"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.3,-0.3,-0.2,0.3,0.3 surface }
				velocity { point 1,0,0 }
				size { box 20,25 }
				tint { line 1,0.921569,0.701961,0.74902,0.521569,0.203922 }
				length { point 5,0,0 }
			}

			motion
			{
				tint { envelope linear }
				fade { envelope exp_x2 }
				length { envelope linear }
			}

			end
			{
				tint { line 0.956863,0.658824,0.529412,0.956863,0.639216,0.529412 }
				length { box 120,0,0,130,0,0 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
	emitter "delayed_smoke"
	{
		start		0.2,0.2
		duration	0.6,0.6
		count		20,20

		sprite
		{
			duration	1.5,1.5
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.35,-0.35

			start
			{
				velocity { box 5,-10,-10,10,10,10 }
				size { line 20,20,30,30 }
				tint { point 0.32549,0.313726,0.282353 }
				fade { point 0.35 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 180,180,200,200 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "heat"
	{
		duration	0.2,0.2
		count		10,10
		locked

		sprite
		{
			duration	0.6,0.6
			blend	add
			material	"gfx/effects/weapons/railgun_ring"

			start
			{
				position { line 8,-0.4,-0.4,8,0.4,0.4 }
				velocity { point -200,0,0 }
				size { line 15,15,25,25 }
				tint { line 0.776471,1,1,0.639216,0.847059,0.858824 }
				fade { point 0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
			}

			end
			{
				size { line 40,40,50,50 }
				fade { point 0.15 }
			}
		}
	}
}








