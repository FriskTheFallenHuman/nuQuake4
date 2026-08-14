effect effects/materials/rock
{
	size	660

	sound "sound"
	{
		soundShader	"effects_bulletimpact_concrete"
	}
	decal "mark"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/nailgun_mark"

			start
			{
				size { point 20,20 }
				rotate { point 0.180556 }
			}
		}
	}
	spawner "dust_brown"
	{
		count		10,12

		sprite
		{
			duration	1,2
			material	"gfx/effects/smoke/smoke_alpha"
			gravity		0.05,0.1

			start
			{
				position { cylinder 0,-0.5,-0.5,0,0.5,0.5 }
				velocity { box 50,-75,-75,100,75,75 }
				friction { box -200,0,0,-300,0,0 }
				size { point 25,25 }
				tint { line 0.921569,0.909804,0.819608,0.8,0.756863,0.521569 }
				fade { line 0.5,0.25 }
				rotate { box -0.3,0.3 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				rotate { envelope cosine count 0.5 }
			}

			end
			{
				size { point 100,100 }
				rotate { box 0,1 relative }
			}
		}
	}
	spawner "rock_models"
	{
		count		3,5

		model
		{
			duration	3,6
			material	"gfx/effects/rock"
			model		"models/misc/rock_chunk.ASE"
			gravity		1,1.25

			start
			{
				position { cylinder 20,-10,-10,30,10,10 }
				velocity { box 75,-25,-25,25,25,25 }
				size { box 0.5,0.5,0.5,0.25,0.25,0.25 }
				rotate { box 20,20,20,5,5,5 }
			}

			impact
			{
				bounce	0.15
			}
		}
	}
	spawner "dust_grey"
	{
		count		2,2

		sprite
		{
			duration	1,1.5
			material	"gfx/effects/smoke/smoke_alpha"
			gravity		0.05,0.05

			start
			{
				position { point 0.05,0,0 }
				velocity { box 50,-2,-2,65,2,2 }
				friction { box -100,0,0,-50,0,0 }
				size { point 10,10 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0 }
				rotate { box 0.32,0.1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope pop_fade }
				fade { envelope pop_fade }
				rotate { envelope linear }
			}

			end
			{
				size { point 50,50 }
				tint { point 1,1,1 }
				fade { point 0.5 }
			}
		}
	}
	spawner "rocks_sprites"
	{
		count		8,12

		sprite
		{
			duration	2,3
			material	"gfx/effects/rock_alpha"
			gravity		0.5,0.75

			start
			{
				position { cylinder 1,-0.5,-0.5,25,0.5,0.5 }
				velocity { box 200,-100,-100,150,100,100 }
				fade { point 0 }
				rotate { point 0.12 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope hold_drop }
				rotate { envelope random }
			}

			end
			{
				size { box 2,2,3,3 }
				fade { point 1 }
			}
		}
	}
	spawner "rock_models2"
	{
		count		3,5

		model
		{
			duration	3,6
			material	"gfx/effects/rock"
			model		"models/misc/rock_chunk.ASE"
			gravity		0.5,1

			start
			{
				position { cylinder 20,-10,-10,30,10,10 }
				velocity { box 150,-100,-100,200,100,100 }
				size { box 0.12,0.12,0.12,0.25,0.25,0.25 }
				rotate { box 20,20,20,5,5,5 }
			}

			impact
			{
				bounce	0.3
			}
		}
	}
}


