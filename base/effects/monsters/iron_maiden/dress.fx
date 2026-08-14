effect effects/monsters/iron_maiden/dress
{
	size	122

	emitter "energy for dress"
	{
		duration	1,1
		count		10,10
		locked

		sprite
		{
			duration	3,3
			blend	add
			persist
			material	"gfx/effects/energy_sparks/IM_energy"

			start
			{
				velocity { box -30,-10,-10,-30,10,10 }
				angle { box 0,0,0,0,0,1 }
				size { line 2,2,10,10 }
				tint { line 1,1,1,0.74902,0.74902,0.74902 }
				fade { line 0.5,1 }
				offset { box 0,-6,-5,0,5,5 }
				rotate { box -1,1 }
			}

			motion
			{
				fade { envelope "linear" }
				angle { envelope "linear" }
				rotate { envelope "edgealpha" }
			}

			end
			{
				angle { box 0,0,-0.5,0,0,0.5 }
				rotate { point 0 relative }
			}
		}
	}
	emitter "energy for dress3"
	{
		detail		0.5
		duration	1,1
		count		15,15
		locked

		sprite
		{
			duration	1,3
			blend	add
			persist
			material	"gfx/effects/fire/fire_plume_additive"

			start
			{
				velocity { box -30,-10,-10,-30,10,10 }
				angle { box 0,0,0,0,0,1 }
				size { point 10,10 }
				tint { line 0.501961,0,0.25098,0.501961,0.501961,0.501961 }
				fade { line 0.25,0.5 }
				offset { box 0,-5,-5,0,5,5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 50,50 }
				angle { box 0,0,-0.5,0,0,0.5 }
				rotate { point 0 relative }
			}
		}
	}
	emitter "reg"
	{
		duration	1,1
		count		3,3
		locked

		sprite
		{
			duration	0.75,0.75
			blend	add
			persist
			material	"gfx/effects/energy_sparks/launch_flash3_GREY"

			start
			{
				velocity { point -50,0,0 }
				size { point 30,30 }
				tint { line 0.25098,0.501961,0.501961,0.313726,0.113725,0.388235 }
				fade { point 0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
			}

			end
			{
				size { point 25,25 }
				fade { point 1 }
			}
		}
	}
}


