effect effects/monsters/network_guardian/fireball_fly
{
	size	118

	emitter "trail"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	2,2
			persist
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				position { line 0,-2,-2,0,2,2 }
				size { line 30,30,50,50 }
				tint { line 0.584314,0.54902,0.482353,0.376471,0.376471,0.337255 }
				fade { point 0.5 }
				offset { point 3,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope concavefade }
				tint { envelope concavefade }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 20,20,80,80 }
				rotate { box -0.222222,0.222222 relative }
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
			duration	5,5
			material	"gfx/effects/weapons/blaster_fly_redflipped"

			start
			{
				size { point 18 }
				offset { point 12,0,0 }
				length { point -80,0,0 }
			}

			motion
			{
				size { envelope random }
				length { envelope random }
			}

			end
			{
				size { point 10 }
				length { point -60,0,0 }
			}
		}
	}
	emitter "flash"
	{
		duration	1,1
		count		3,3
		locked

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/energy1_red"

			start
			{
				size { point 40,40 }
				rotate { box 0,0.5 }
			}

			motion
			{
				fade { envelope cosine offset 0.5 }
				rotate { envelope linear }
			}

			end
			{
				rotate { box 0.5,1 }
			}
		}
	}
	spawner "flash2"
	{
		count		1,1
		locked
		constant

		sprite
		{
			duration	1,1
			material	"gfx/effects/weapons/flash"

			start
			{
				size { point 16,16 }
				offset { point 8,0,0 }
				rotate { box 0,0.5 }
			}

			motion
			{
				rotate { envelope linear }
			}

			end
			{
				rotate { box 0.5,1 }
			}
		}
	}
	emitter "flash3"
	{
		duration	1,1
		count		15,15
		locked

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/fire/fire_plume_additive"

			start
			{
				velocity { box -30,-30,-30,30,30,30 }
				size { line 45,45,50,50 }
				fade { point 0.9 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 10,10,15,15 }
			}
		}
	}
	emitter "spots"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	0.8,0.8
			blend	add
			material	"gfx/effects/energy_sparks/spark3"

			start
			{
				position { line -5,0,0,5,0,0 }
				velocity { box 0,-80,-80,0,80,80 }
				size { box 0.5,0.5,1,1 }
				tint { line 1,0.501961,0,1,1,1 }
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
				size { box 8,8,12,12 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}
