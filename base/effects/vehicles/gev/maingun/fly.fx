effect effects/vehicles/gev/maingun/fly
{
	size	350

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
	emitter "smoketrail"
	{
		duration	1,1
		count		250,250

		line
		{
			duration	1.5,2.5
			persist
			material	"gfx/effects/smoke/cloud_alpha2"
			flipNormal

			start
			{
				position { point 50,0,0 }
				acceleration { box 0,-8,0,0,-25,0 }
				size { point 10 }
				tint { point 0.847059,0.921569,0.917647 }
				fade { line 0.06,0.13 }
				length { point 130,0,0 }
			}

			motion
			{
				size { envelope arch offset 0.25 }
				fade { envelope linear count 1.5 offset -0.5 }
				length { envelope linear }
			}

			end
			{
				size { box 10,20 }
				length { point 300,0,0 }
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
				size { point 20 }
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
				size { point 15 }
				length { point -70,0,0 }
			}
		}
	}
	spawner "line"
	{
		count		1,1
		locked
		constant

		line
		{
			duration	2,2
			blend	add
			material	"gfx/effects/weapons/flash_half_flipped"

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
	spawner "filler"
	{
		count		3,3
		locked
		constant

		sprite
		{
			duration	2,2
			material	"gfx/effects/energy_sparks/spark3"

			start
			{
				position { line -30,0,0,-60,0,0 linearSpacing }
				size { point 20,20 }
				tint { point 0.752941,0.752941,0.752941 }
			}

			motion
			{
				size { envelope random }
			}

			end
			{
				size { point 35,35 }
			}
		}
	}
}






