effect effects/materials/concrete
{
	size	434

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
				size { point 14,14 }
				rotate { point 0.180556 }
			}
		}
	}
	spawner "rock_models"
	{
		count		7,10

		model
		{
			duration	3,6
			material	"gfx/effects/rock"
			model		"models/misc/rock_chunk.ASE"
			gravity		0.25,1

			start
			{
				position { cylinder 11,-0.05,-0.05,11,0.05,0.05 }
				velocity { box 75,-45,-45,150,45,45 }
				size { box 0.12,0.12,0.12,0.25,0.25,0.25 }
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
				fade { line 0.5,1 }
			}
		}
	}
	spawner "streaks_flat"
	{
		count		5,5
		locked

		line
		{
			duration	0.06,0.06
			material	"gfx/effects/weapons/flash_half"
			gravity		0.1,0.1
			generatedOriginNormal

			start
			{
				position { cylinder 2,-0.5,-0.5,2,0.5,0.5 surface }
				velocity { point 50,0,0 }
				size { box 0.5,1 }
				tint { point 0.501961,0.501961,0.501961 }
				length { box 1,-10,-10,1,10,10 }
			}

			motion
			{
				length { envelope linear }
			}

			end
			{
				length { box 1,-25,-25,1,25,25 }
			}
		}
	}
}


