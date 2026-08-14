effect effects/monsters/scientist/concussion_fly
{
	size	128

	emitter "segment082"
	{
		start		1,1
		duration	0.85,1
		count		2,3
		locked

		electricity
		{
			duration	0.85,0.85
			fork	1
			jitterRate	0
			jitterSize	3,7,7
			material	"gfx/effects/electricity/electric_orange"

			start
			{
				position { sphere 0,-0.05,-0.05,0,0.05,0.05 }
				size { box 0.5,0.25 }
				tint { line 1,1,1,0.501961,0,0 }
				length { box 15,-15,-15,5,15,15 }
			}

			motion
			{
				size { envelope random }
				length { envelope linear }
			}

			end
			{
				length { point 0.5,0.5,0.5 }
			}
		}
	}
	spawner "burst"
	{
		start		3.95,3.95
		count		1,1
		locked

		sprite
		{
			duration	0.12,0.12
			blend	add
			material	"gfx/effects/weapons/flash"

			start
			{
				size { point 2,2 }
				rotate { box 0,7 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 90,90 }
				rotate { box -0.1,0.1 relative }
			}
		}
	}
	emitter "pulse"
	{
		duration	4,4
		count		1,1
		locked

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/muzzleflash2"

			start
			{
				size { point 15,15 }
				tint { point 0.984314,0.94902,0.603922 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 30,30 }
			}
		}
	}
	light "segment4"
	{
		locked

		light
		{
			duration	4,4
			material	"lights/rav_turretfire"

			start
			{
				size { point 40,40,40 }
				tint { point 0.839216,0.266667,0.0196078 }
			}

			motion
			{
				size { envelope flicker }
				tint { envelope hardflicker count 100,100,100 }
			}
		}
	}
	emitter "powerup"
	{
		duration	1,1
		count		25,25

		sprite
		{
			duration	0.5,1
			blend	add
			material	"gfx/effects/fire/embers"

			start
			{
				size { box 20,20,10,10 }
				rotate { point 0.1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 0,0 }
			}
		}
	}
	emitter "segment7"
	{
		duration	1,1
		count		1,1
		locked

		model
		{
			duration	3.95,3.95
			blend	add
			material	"models/monsters/gunner/grenade"
			model		"gfx/effects/monsters/gunner/grenade.lwo"

			start
			{
				size { point 0.75,0.75,0.75 }
			}

			motion
			{
				tint { envelope linear }
				fade { envelope linear }
			}

			end
			{
				tint { point 1,1,0 }
			}
		}
	}
}



