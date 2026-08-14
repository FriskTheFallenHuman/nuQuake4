effect effects/monsters/network_guardian/impact
{
	size	323

	decal "scorch"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/explosion_impact2"

			start
			{
				size { point 40,40 }
				rotate { box 0,1 }
			}
		}
	}
	sound "sound"
	{
		soundShader	"player_grenadelauncher_explode"
		volume	0.5,0.5
		freqshift	0.9,0.9
	}
	spawner "embers_out"
	{
		count		10,15

		sprite
		{
			duration	0.75,1.25
			blend	add
			material	"gfx/effects/energy_sparks/spark3"
			gravity		-0.02,-0.02

			start
			{
				position { sphere 1,-5,-5,0,5,5 }
				velocity { box 0,-50,-50,200,50,50 }
				angle { box 0,0,0,1,1,1 }
				size { point 8,8 }
				fade { point 0.3 }
				offset { box 0,-10,-10,0,10,10 }
				rotate { box 0.251,-0.25 }
			}

			motion
			{
				size { envelope "exp_x2" }
				fade { envelope "linear_flicker" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				angle { box 0,0,0,1,1,1 relative }
			}
		}
	}
	spawner "smoke_hang"
	{
		start		0.09,0.09
		count		2,2

		sprite
		{
			duration	2,3
			material	"gfx/effects/smoke/smoke_alpha"
			gravity		-0.02,-0.02

			start
			{
				velocity { box -25,-25,-25,25,25,25 }
				size { line 25,25,50,50 }
				tint { point 0.752941,0.752941,0.752941 }
				fade { point 0 }
				rotate { box 0,0.111111 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "exp_x2" }
				fade { envelope "pop_hold_fadefast" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 50,50,100,100 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0.8 }
				rotate { box 0.111111,0.222222 relative }
			}
		}
	}
	spawner "smoke_up"
	{
		start		0.09,0.09
		count		2,2

		sprite
		{
			duration	2,3
			material	"gfx/effects/smoke/smoke_alpha"
			gravity		-0.02,-0.02

			start
			{
				velocity { box 0,0,0,50,0,0 }
				size { line 100,100,150,150 }
				tint { point 0.752941,0.752941,0.752941 }
				fade { point 0 }
				rotate { box 0,0.111111 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "exp_x2" }
				fade { envelope "pop_hold_fadefast" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 125,125,175,175 }
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
			gravity		-0.02,-0.02

			start
			{
				velocity { box 0,0,0,50,0,0 }
				size { line 40,40,90,90 }
				tint { point 0.603922,0.584314,0.505882 }
				fade { point 0 }
				rotate { box -0.0833333,-0.166667 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "pop_hold_fadefast" }
			}

			end
			{
				size { line 100,100,150,150 }
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
				position { point 10,0,0 }
				velocity { box 0,0,0,200,0,0 }
				acceleration { point -200,0,0 }
				size { line 50,50,100,100 }
				tint { point 0.752941,0.752941,0.752941 }
				fade { point 0 }
				rotate { box -0.111111,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "pop_hold_fadefast" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 25,25,50,50 }
				fade { point 0.8 }
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
				position { point 1,0,0 }
				size { line 100,100,200,200 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { line 75,75,100,100 }
			}
		}
	}
	spawner "flash_streaks2"
	{
		count		4,4
		locked

		line
		{
			duration	0.06,0.06
			blend	add
			material	"gfx/effects/weapons/flash_half3"
			gravity		0.1,0.1
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -1,-0.3,-0.3,-1,0.3,0.3 surface }
				velocity { point 50,0,0 }
				size { box 20,40 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0 }
				length { box 30,0,0,180,0,0 }
			}

			motion
			{
				fade { envelope "decalfade" }
			}
		}
	}
	spawner "flash 3"
	{
		count		1,1

		oriented
		{
			duration	0.06,0.06
			material	"gfx/effects/weapons/flash"

			start
			{
				size { point 100,100 }
			}
		}
	}
}

