effect effects/materials/gravel
{
	size	534

	sound "sound"
	{
		soundShader	"effects_bulletimpact_dirt"
	}
	decal "mark"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/nailgun_mark"

			start
			{
				size { point 6,6 }
				rotate { point 0.180556 }
			}
		}
	}
	spawner "rock_models_physics"
	{
		count		12,15

		model
		{
			duration	3,6
			material	"gfx/effects/rock"
			model		"models/misc/rock_chunk.ASE"
			gravity		0.25,1

			start
			{
				position { cylinder 5,-0.05,-0.05,20,0.05,0.05 }
				velocity { box 75,-75,-75,150,75,75 }
				size { box 0.12,0.12,0.12,0.06,0.06,0.06 }
				rotate { box 20,20,20,5,5,5 }
			}

			impact
			{
				bounce	0.15
			}
		}
	}
	emitter "dust_grey"
	{
		duration	0.12,0.12
		count		8,8

		sprite
		{
			duration	1,1.5
			material	"gfx/effects/smoke/smoke_alpha"
			gravity		0.05,0.05

			start
			{
				position { line 0.05,0,0,1,0,0 }
				velocity { box 75,-2,-2,25,2,2 }
				friction { box -100,0,0,-50,0,0 }
				size { point 10,10 }
				fade { point 0 }
				rotate { box 0.32,0.1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope pop_fade }
				rotate { envelope linear }
			}

			end
			{
				size { point 50,50 }
				fade { line 0.5,1 }
			}
		}
	}
	spawner "rock_models2"
	{
		count		25,30

		model
		{
			duration	3,6
			material	"gfx/effects/rock"
			model		"models/misc/rock_chunk.ASE"
			gravity		0.25,0.5

			start
			{
				position { cylinder 1,-0.05,-0.05,12,0.05,0.05 }
				velocity { box 200,-12,-12,150,12,12 }
				size { box 0.12,0.12,0.12,0.06,0.06,0.06 }
				rotate { box 20,20,20,5,5,5 }
			}
		}
	}
	spawner "dust_grey_impact"
	{
		count		1,1

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/smoke/smoke_alpha"
			gravity		0.05,0.05

			start
			{
				position { line 0.05,0,0,1,0,0 }
				velocity { box 1,-2,-2,2,2,2 }
				friction { box -100,0,0,-50,0,0 }
				size { point 10,10 }
				fade { point 0 }
				rotate { box 0.32,0.1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope pop_fade }
				rotate { envelope linear }
			}

			end
			{
				size { point 25,25 }
				fade { point 1 }
			}
		}
	}
	spawner "ground_sprite"
	{
		count		3,3

		oriented
		{
			duration	0.75,0.75
			material	"gfx/effects/smoke/smoke_alpha"

			start
			{
				position { point 1,0,0 }
				fade { point 0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope pop_fade }
				rotate { envelope linear }
			}

			end
			{
				size { point 35,35 }
				fade { point 1 }
			}
		}
	}
}


