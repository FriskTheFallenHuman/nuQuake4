effect effects/moveables/barrel/launch
{
	size	1002

	decal "scorch"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/explosion_impact2"

			start
			{
				size { point 75,75 }
				rotate { box 0,1 }
			}
		}
	}
	sound "sound"
	{
		soundShader	"effects_barrel_launch"
	}
	spawner "embers_out"
	{
		count		30,30

		sprite
		{
			duration	1,3
			blend	add
			material	"gfx/effects/weapons/flash"
			gravity		0.2,0.5

			start
			{
				position { sphere 50,-25,-25,0,25,25 }
				velocity { box 150,-200,-200,650,200,200 }
				angle { box 0,0,0,1,1,1 }
				size { line 2,2,4,4 }
				tint { line 1,1,1,0.952941,0.678431,0.372549 }
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
				velocity { box 500,0,0,600,0,0 }
				acceleration { point -600,0,0 }
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
				size { line 50,50,100,100 }
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
	spawner "flash2"
	{
		count		5,5

		sprite
		{
			duration	0.5,0.7
			blend	add
			material	"gfx/effects/fire/impact_fire"

			start
			{
				position { point 1,0,0 }
				velocity { box 30,-60,-60,100,60,60 }
				size { line 60,60,90,90 }
				tint { point 0.752941,0.752941,0.752941 }
				fade { point 0.5 }
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
				size { line 20,20,30,30 }
			}
		}
	}
	spawner "flash4"
	{
		count		1,1

		sprite
		{
			duration	0.5,0.5
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
				size { line 30,30,40,40 }
			}
		}
	}
}

