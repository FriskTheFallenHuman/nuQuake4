effect effects/vehicles/tramgun_fly
{
	size	250

	spawner "line"
	{
		count		1,1
		locked
		constant

		line
		{
			duration	2,2
			blend	add
			material	"gfx/effects/weapons/flash_half4"

			start
			{
				position { point -60,0,0 }
				size { point 10 }
				length { point 50,0,0 }
			}

			motion
			{
				size { envelope linear }
			}

			end
			{
				size { point 8 }
			}
		}
	}
	spawner "line2"
	{
		count		1,1
		locked
		constant

		line
		{
			duration	2,2
			blend	add
			material	"gfx/effects/weapons/flash_half4"

			start
			{
				position { point -60,0,0 }
				size { point 40 }
				offset { point 50,0,0 }
				length { point -50,0,0 }
			}

			motion
			{
				size { envelope random }
				length { envelope random }
			}

			end
			{
				size { point 25 }
				length { point -70,0,0 }
			}
		}
	}
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
				position { line -30,0,0,-60,0,0 linearSpacing }
				size { point 40,40 }
				tint { point 0.752941,0.752941,0.752941 }
			}

			motion
			{
				size { envelope random }
			}

			end
			{
				size { point 65,65 }
			}
		}
	}
	spawner "trail"
	{
		count		1,1
		locked
		constant

		line
		{
			duration	2,2
			blend	add
			persist
			material	"gfx/effects/weapons/flash_half4"

			start
			{
				position { point -60,0,0 }
				size { point 20 }
				tint { point 0.854902,0.611765,0.854902 }
				fade { point 0.3 }
				offset { point 50,0,0 }
				length { point -150,0,0 }
			}

			motion
			{
				length { envelope random }
			}

			end
			{
				length { point -300,0,0 }
			}
		}
	}
	emitter "spirals"
	{
		duration	15,15
		count		50,50

		sprite
		{
			duration	0.1,0.2
			blend	add
			persist
			material	"gfx/effects/weapons/railgun_ring_end"

			start
			{
				position { point -30,0,0 }
				size { line 10,10,20,20 }
				tint { point 0.286275,0.521569,0.713726 }
				fade { point 0.5 }
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
				size { line 60,60,90,90 }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
}
