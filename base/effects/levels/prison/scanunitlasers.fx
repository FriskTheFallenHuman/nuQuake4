effect effects/levels/prison/scanunitlasers
{
	size	303

	emitter "glow"
	{
		duration	0.1,0.1
		count		5,5
		locked

		line
		{
			duration	0.1,0.1
			material	"gfx/effects/electricity/electric"

			start
			{
				size { point 3 }
				tint { point 0,0,1 }
				length { point 300,0,0 }
			}

			motion
			{
				tint { envelope laserfenceon }
			}
		}
	}
	emitter "misc_glow"
	{
		duration	0.1,0.1
		count		5,5
		locked

		sprite
		{
			duration	0.1,0.1
			material	"gfx/effects/particles_shapes/add_sphere"

			start
			{
				position { point 1,0,0 }
				size { point 5,5 }
				tint { point 0,0,1 }
			}
		}
	}
	emitter "s_glow"
	{
		duration	0.1,0.1
		count		5,5
		locked

		sprite
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/particles_shapes/spike"

			start
			{
				position { point 1,0,0 }
				size { line 20,20,30,30 }
				tint { point 0.615686,0.760784,1 }
				fade { point 0.8 }
				rotate { box 0,0.0138889 }
			}
		}
	}
	emitter "s_core"
	{
		duration	0.1,0.1
		count		5,5
		locked

		sprite
		{
			duration	0.1,0.1
			material	"gfx/effects/particles_shapes/add_sphere"

			start
			{
				position { point 1,0,0 }
				size { line 1,1,2.5,2.5 }
			}
		}
	}
	emitter "core"
	{
		duration	0.1,0.1
		count		5,5
		locked

		line
		{
			duration	0.1,0.1
			material	"gfx/effects/electricity/electric"

			start
			{
				size { point 2 }
				tint { point 0.501961,0.501961,0.501961 }
				length { point 300,0,0 }
			}

			motion
			{
				tint { envelope laserfenceon count 0.1,0.1,0.1 offset 3,3,3 }
			}

			end
			{
				tint { point 1,1,1 }
			}
		}
	}
	emitter "glow2"
	{
		duration	0.1,0.1
		count		5,5

		line
		{
			duration	0.3,0.3
			material	"gfx/effects/electricity/electric"

			start
			{
				tint { point 0,0,1 }
				length { point 300,0,0 }
			}

			motion
			{
				tint { envelope laserfenceon }
			}
		}
	}
}

