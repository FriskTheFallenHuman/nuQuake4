effect effects/monsters/gladiator/blaster_fly
{
	size	135

	spawner "filler"
	{
		count		3,3
		locked
		constant

		sprite
		{
			duration	2,2
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				position { line 5,0,0,35,0,0 linearSpacing }
				size { point 10,10 }
				tint { point 0.752941,0.752941,0.752941 }
			}
		}
	}
	spawner "blasterfly"
	{
		count		2,2
		locked
		constant

		line
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/blaster_fly_red"

			start
			{
				position { point -50,0,0 }
				size { point 10 }
				tint { point 0.752941,0.752941,0.752941 }
				length { point 100,0,0 }
			}
		}
	}
	spawner "side_streaks"
	{
		detail		0.5
		count		7,7
		locked
		constant

		line
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/weapons/blaster_fly_red"
			generatedOriginNormal

			start
			{
				position { cylinder -0.08,-0.05,-0.05,-0.08,0.05,0.05 surface }
				size { box 8,10 }
				tint { line 0.501961,0.501961,0.501961,0.611765,0.254902,0.745098 }
				offset { point 30,0,0 }
				length { box 30,0,0,35,0,0 }
			}

			motion
			{
				fade { envelope "random" }
				length { envelope "random" }
			}

			end
			{
				fade { point 0.4 }
				length { box 10,0,0,20,0,0 }
			}
		}
	}
	emitter "smoke"
	{
		detail		0.5
		duration	15,15
		count		50,50

		sprite
		{
			duration	0.1,0.2
			blend	add
			material	"gfx/effects/fire/fire_plume_additive"

			start
			{
				position { point 10,0,0 }
				size { line 6,6,20,20 }
				tint { point 0.411765,0.360784,0.639216 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 30,30,40,40 }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
}








