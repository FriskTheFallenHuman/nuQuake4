effect effects/levels/convoy/weld_sparks
{
	size	520

	sound "sound"
	{
		soundShader	"effects_weld"
	}
	spawner "smoke"
	{
		start		0.06,0.06
		count		1,1

		sprite
		{
			duration	1,1.5
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.06,-0.04
			generatedOriginNormal

			start
			{
				size { line 2,2,4,4 }
				tint { line 0.560784,0.533333,0.439216,0.509804,0.541176,0.458824 }
				fade { point 0.6 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 15,15,30,30 }
				rotate { box -0.138889,0.138889 relative }
			}
		}
	}
	spawner "sparks_trails"
	{
		count		7,9

		sprite
		{
			duration	0.35,0.5
			material	"gfx/effects/particles_shapes/blank"
			gravity		0.5,1
			trailType	motion
			trailTime	0.1,0.1
			trailCount	3,3

			start
			{
				velocity { box 50,-150,-150,300,150,150 }
				size { box 1,1,2,2 }
				tint { point 0.913726,0.858824,0.729412 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
			}

			end
			{
				size { point 0.5,0.5 }
				tint { line 0.929412,0.796079,0.321569,0.909804,0.501961,0.364706 }
			}
		}
	}
	spawner "side_streaks"
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
				size { box 4,6 }
				fade { point 0 }
				length { box 10,0,0,15,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope pop_flicker_fade }
			}

			end
			{
				size { point 0 }
				fade { point 1 }
			}
		}
	}
	spawner "sparks_physics"
	{
		count		1,1

		sprite
		{
			duration	1,2
			blend	add
			material	"gfx/effects/particles_shapes/blank"
			gravity		1,3

			start
			{
				position { point 22,0,0 }
				velocity { box 100,-25,100,200,25,550 }
				size { line 0.5,0.5,0.25,0.25 }
			}

			motion
			{
				size { envelope random }
				fade { envelope linear_flicker }
			}

			end
			{
				size { line 0.75,0.75,2,2 }
			}

			impact
			{
				remove	1
				effect	"effects/levels/convoy/weld_sparks_impact"
			}
		}
	}
	spawner "center"
	{
		count		1,1
		locked

		sprite
		{
			duration	0.06,0.06
			material	"gfx/effects/weapons/flash"

			start
			{
				position { point 2,0,0 }
				size { point 5,5 }
			}

			motion
			{
				size { envelope random }
			}

			end
			{
				size { point 10,10 }
			}
		}
	}
}




