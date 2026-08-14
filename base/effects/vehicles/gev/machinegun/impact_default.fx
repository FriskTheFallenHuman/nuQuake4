effect effects/vehicles/gev/machinegun/impact_default
{
	size	208

	sound "sound"
	{
		soundShader	"bullet_impact_metal"
	}
	decal "mark"
	{

		decal
		{
			duration	0.002,0.002
			material	"textures/decals/bullethole"

			start
			{
				size { line 12,12,15,15 }
				rotate { point 0.180556 }
			}
		}
	}
	spawner "sparks_trails"
	{
		count		7,9

		sprite
		{
			duration	0.25,0.4
			material	"gfx/effects/particles_shapes/blank"
			gravity		0.5,1
			trailType	motion
			trailTime	0.1,0.1
			trailCount	3,3

			start
			{
				velocity { box 200,-250,-250,400,250,250 }
				size { box 2,2,3.5,3.5 }
				tint { point 0.917647,0.858824,0.733333 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
			}

			end
			{
				tint { line 0.933333,0.796079,0.32549,0.909804,0.517647,0.384314 }
			}
		}
	}
	spawner "single_streak"
	{
		count		1,1

		line
		{
			duration	0.06,0.06
			blend	add
			generatedLine
			material	"gfx/effects/weapons/flash_half3"

			start
			{
				position { point 2,0,0 }
				velocity { point 1,0,0 }
				size { point 10 }
				length { box 40,0,0,50,0,0 }
			}

			motion
			{
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				length { box 15,0,0,25,0,0 }
			}
		}
	}
	spawner "sparks"
	{
		count		3,5

		sprite
		{
			duration	0.5,0.75
			blend	add
			material	"gfx/effects/energy_sparks/spark2"
			gravity		0.15,0.35

			start
			{
				velocity { box 50,-50,-50,100,50,50 }
				size { line 1,1,2,2 }
			}

			motion
			{
				fade { envelope linear_flicker }
			}
		}
	}
	spawner "smoke"
	{
		start		0.06,0.06
		count		4,6

		sprite
		{
			duration	1,1.5
			material	"gfx/effects/smoke/impact_smoke3"
			gravity		0.05,0.05

			start
			{
				velocity { box 10,-5,-5,100,5,5 }
				size { line 4,4,8,8 }
				tint { line 0.505882,0.478431,0.447059,0.52549,0.529412,0.470588 }
				fade { point 0.8 }
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
				size { line 60,60,100,100 }
				tint { line 0.2,0.176471,0.14902,0.196078,0.2,0.14902 }
			}
		}
	}
	spawner "flash2"
	{
		count		3,3

		sprite
		{
			duration	0.06,0.06
			blend	add
			material	"gfx/effects/weapons/flash"
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { point 35,35 }
				fade { point 0.6 }
			}

			motion
			{
				tint { envelope linear }
			}
		}
	}
	spawner "side_streaks2"
	{
		count		3,5
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
				position { cylinder -0.2,-0.3,-0.3,-0.2,0.3,0.3 surface }
				velocity { point 50,0,0 }
				size { box 8,12 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0 }
				length { box 30,0,0,40,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope decalfade }
			}

			end
			{
				size { point 0 }
				fade { point 1 }
			}
		}
	}
}



