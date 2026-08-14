effect effects/monsters/convoy_rolly/mflash
{
	size	76

	spawner "flash2"
	{
		count		1,1
		locked

		sprite
		{
			duration	0.1,0.1
			material	"gfx/effects/energy_sparks/energy1_red"

			start
			{
				position { point 10,0,0 }
				size { point 50,50 }
				tint { point 0.74902,0.74902,0.74902 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 15,15 }
			}
		}
	}
	emitter "heat"
	{
		duration	0.25,0.25
		count		5,5
		locked

		sprite
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/weapons/flash_hot"

			start
			{
				position { point 5,0,0 }
				size { line 3,3,6,6 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" count 2 offset -1 }
			}

			end
			{
				size { point 20,20 }
			}
		}
	}
}


