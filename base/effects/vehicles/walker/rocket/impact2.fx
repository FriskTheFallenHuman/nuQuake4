effect effects/vehicles/walker/rocket/impact2
{
	size	445

	decal "scorch"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/explosion_impact2"

			start
			{
				size { line 45,45,60,60 }
				rotate { box 0,1 }
			}
		}
	}
	sound "sound"
	{
		soundShader	"vehicle_walker_cannon_impact"
	}
	spawner "embers_out"
	{
		count		10,15

		sprite
		{
			duration	0.75,1.25
			blend	add
			material	"gfx/effects/energy_sparks/spark3"
			gravity		0.3,0.5

			start
			{
				position { sphere 1,-5,-5,0,5,5 }
				velocity { box 100,-100,-100,425,100,100 }
				size { point 8,8 }
				fade { line 0.5,1 }
				offset { box 0,-10,-10,0,10,10 }
				rotate { box 0.251,-0.25 }
			}

			motion
			{
				size { envelope exp_x2 }
				fade { envelope linear_flicker }
				rotate { envelope linear }
			}
		}
	}
	spawner "smoke_hang"
	{
		start		0.09,0.09
		count		2,2

		sprite
		{
			duration	2.5,4
			material	"gfx/effects/smoke/smoke_alpha"
			gravity		-0.01,-0.01

			start
			{
				position { box 5,-10,-10,15,10,10 }
				velocity { box 3,-25,-25,6,25,25 }
				size { line 25,25,40,40 }
				tint { point 0.752941,0.752941,0.752941 }
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
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0.8 }
				rotate { box 0.111111,0.222222 relative }
			}
		}
	}
	spawner "smoke_up_underlit"
	{
		count		2,2

		sprite
		{
			duration	2,3
			blend	add
			material	"gfx/effects/smoke/smoke_underlit"
			gravity		-0.01,-0.01

			start
			{
				position { box 5,-10,-10,15,10,10 }
				velocity { box 10,-5,-5,25,5,5 }
				size { line 25,25,35,35 }
				tint { point 0.603922,0.584314,0.505882 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope pop_hold_fadefast }
			}

			end
			{
				size { line 60,60,90,90 }
				fade { point 0.5 }
			}
		}
	}
	spawner "smoke_fill"
	{
		start		0.4,0.4
		count		2,2

		sprite
		{
			duration	1,2
			material	"gfx/effects/smoke/smoke_alpha"

			start
			{
				position { point 30,0,0 }
				velocity { box 10,0,0,20,0,0 }
				size { point 50,50 }
				tint { point 0.752941,0.752941,0.752941 }
				fade { point 0 }
				rotate { box -0.111111,0 }
			}

			motion
			{
				size { envelope arch }
				fade { envelope pop_hold_fadefast }
				rotate { envelope linear }
			}

			end
			{
				size { line 75,75,100,100 }
				fade { point 0.2 }
				rotate { box -0.222222,-0.111111 relative }
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
				position { point 10,0,0 }
				size { line 150,150,250,250 }
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
				size { line 75,75,150,150 }
			}
		}
	}
	emitter "flash_streaks2"
	{
		duration	0.25,0.25
		count		25,25

		line
		{
			duration	0.2,0.2
			material	"gfx/effects/weapons/flash_half3"

			start
			{
				position { point -25,0,0 }
				velocity { point 50,0,0 }
				size { point 90 }
				tint { line 0.752941,0.752941,0.752941,1,1,1 }
				fade { point 0 }
				length { box 30,0,0,40,0,0 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				length { envelope arch }
			}

			end
			{
				size { box 10,30 }
				length { box 130,0,0,180,0,0 }
			}
		}
	}
	spawner "flash 3"
	{
		count		1,1

		oriented
		{
			duration	0.5,0.5
			material	"gfx/effects/weapons/flash"

			start
			{
				size { point 25,25 }
				tint { point 0.752941,0.752941,0.752941 }
			}

			motion
			{
				size { envelope cosine }
			}

			end
			{
				size { point 150,150 }
			}
		}
	}
	spawner "flash3"
	{
		count		1,1

		sprite
		{
			duration	0.06,0.06
			blend	add
			material	"gfx/effects/weapons/flash"
			generatedNormal

			start
			{
				position { point 40,0,0 }
				size { point 300,300 }
				fade { point 0.2 }
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
				size { point 50,50 }
			}
		}
	}
}
