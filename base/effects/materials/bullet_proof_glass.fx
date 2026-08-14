effect effects/materials/bullet_proof_glass
{
	size	40

	sound "sound"
	{
		soundShader	"bullet_ricochet"
	}
	spawner "dust"
	{
		start		0.12,0.12
		count		1,1

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/smoke_alpha"

			start
			{
				position { point 5,0,0 }
				velocity { box 3,-2,-2,5,2,2 }
				fade { point 0 }
				rotate { box 0.32,0.1 }
			}

			motion
			{
				size { envelope pop_hold_grow }
				fade { envelope pop_fade }
				rotate { envelope linear }
			}

			end
			{
				size { point 15,15 }
				fade { point 0.5 }
			}
		}
	}
	spawner "glass"
	{
		count		1,2

		sprite
		{
			duration	0.35,0.35
			material	"gfx/effects/particles_shapes/chunk_glass"

			start
			{
				position { line 0.05,-0.05,-0.05,0.05,0.05,0.05 }
				velocity { box 25,0,0,12,0,0 }
				fade { point 0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope pop_fade }
			}

			end
			{
				size { point 6,6 }
				fade { point 1 }
			}
		}
	}
	spawner "glass_bits"
	{
		count		3,8

		sprite
		{
			duration	0.25,1
			material	"gfx/effects/particles_shapes/chunk_glass"
			gravity		0.15,0.25

			start
			{
				position { line 0.05,-0.05,-0.05,0.05,0.05,0.05 }
				velocity { box 50,-50,-50,25,50,50 }
				size { box 2,2,1,1 }
				tint { line 1,1,1,0,0,0 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope pop_fade }
				rotate { envelope linear }
			}

			end
			{
				size { point 0.5,0.5 }
				fade { point 1 }
			}
		}
	}
}



