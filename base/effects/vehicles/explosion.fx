effect effects/vehicles/explosion
{
	size	1818

	sound "sound"
	{
		soundShader	"vehicle_walker_death"
	}
	spawner "chunks"
	{
		start		0.12,0.12
		count		15,15

		sprite
		{
			duration	3,4
			material	"gfx/effects/rock_alpha"
			gravity		1,1
			generatedNormal

			start
			{
				position { sphere -50,-50,-50,50,50,50 }
				velocity { box 450,0,0,750,0,0 }
				size { line 6,6,30,30 }
				rotate { box 0,1 }
			}

			motion
			{
				rotate { envelope linear }
			}

			end
			{
				rotate { box -0.25,0.25 relative }
			}

			impact
			{
				bounce	0.3
			}
		}
	}
	spawner "flash"
	{
		start		0.06,0.06
		count		1,1

		sprite
		{
			duration	0.09,0.09
			material	"gfx/effects/fire/impact_fire"

			start
			{
				position { point 2,0,0 }
				velocity { box 300,-50,-50,400,50,50 }
				size { point 300,300 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
			}

			end
			{
				size { point 550,550 }
			}
		}
	}
	spawner "large streaks"
	{
		start		0.05,0.05
		count		20,20
		locked

		line
		{
			duration	0.12,0.12
			blend	add
			material	"gfx/effects/weapons/flash_half3"

			start
			{
				position { cylinder -30,-5,-5,-30,5,5 }
				size { point 10 }
				length { box 100,-100,-100,150,100,100 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 100 }
			}
		}
	}
	spawner "streaks"
	{
		start		0.06,0.06
		count		2,2

		line
		{
			duration	0.18,0.18
			material	"gfx/effects/weapons/flash_half3"

			start
			{
				position { point -100,0,0 }
				size { point 10 }
				length { box 100,-30,-30,100,30,30 }
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
				size { point 200 }
				length { point 400,0,0 }
			}
		}
	}
	spawner "streaks222"
	{
		start		0.06,0.06
		count		2,2

		line
		{
			duration	0.18,0.18
			material	"gfx/effects/weapons/flash_half3"

			start
			{
				position { point -100,0,0 }
				size { point 10 }
				length { box 200,-30,-30,200,30,30 }
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
				size { point 150 }
				length { point 400,0,0 }
			}
		}
	}
	spawner "flash22"
	{
		count		1,1

		sprite
		{
			duration	0.08,0.08
			material	"gfx/effects/fire/impact_fire"

			start
			{
				size { point 100,100 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 400,400 }
				rotate { box -0.444444,0.444444 relative }
			}
		}
	}
	spawner "shockwave2"
	{
		start		0.06,0.06
		count		1,1

		oriented
		{
			duration	0.12,0.12
			material	"gfx/effects/particles_shapes/shockwave"

			start
			{
				position { point 0.02,0,0 }
				tint { point 0.231373,0.231373,0.231373 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 700,700 }
			}
		}
	}
	light "light"
	{
		locked

		light
		{
			duration	0.2,0.2
			material	"lights/defaultPointLight"

			start
			{
				position { point 5,0,0 }
				size { point 400,400,400 }
			}
		}
	}
	spawner "shockwave_vert"
	{
		count		1,1

		sprite
		{
			duration	0.12,0.12
			material	"gfx/effects/particles_shapes/shockwave"

			start
			{
				size { point 25,25 }
				tint { point 0.231373,0.231373,0.231373 }
				rotate { box 0.1,-0.1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 900,900 }
			}
		}
	}
	spawner "ground_sprite"
	{
		count		2,2

		oriented
		{
			duration	0.18,0.18
			material	"gfx/effects/weapons/shotgun_mflash"

			start
			{
				position { point 0.02,0,0 }
				size { point 100,100 }
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
				size { point 350,350 }
			}
		}
	}
}



