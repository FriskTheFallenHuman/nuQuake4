effect effects/monsters/bossbuddy/dmg_muzzleflash
{
	size	96

	emitter "delayed_smoke"
	{
		start		0.4,0.4
		duration	1.2,1.2
		count		30,30

		sprite
		{
			duration	1,1.5
			blend	add
			material	"gfx/effects/weapons/plasma1"
			gravity		-0.03,-0.0125

			start
			{
				velocity { box 5,-2,-2,10,2,2 }
				angle { box -1,-1,-1,1,1,1 }
				size { point 10,5 }
				tint { point 0.568627,0.447059,0.619608 }
				fade { point 0 }
				offset { box 0,-2,-2,0,2,2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 20,20,30,30 }
				fade { point 0.3 }
				angle { point 0,0,0 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "single_streak"
	{
		count		1,1
		locked

		line
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/weapons/flash_half3"

			start
			{
				position { point -2,0,0 }
				size { point 10 }
				tint { point 0.564706,0.447059,0.619608 }
				offset { point 5,0,0 }
				length { box 50,0,0,80,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { point 0.5 }
				length { box 6,0,0,10,0,0 }
			}
		}
	}
	spawner "main"
	{
		count		6,10

		sprite
		{
			duration	0.25,0.25
			blend	add
			persist
			material	"gfx/effects/weapons/plasma1"

			start
			{
				position { cylinder 0,-1,-1,0,1,1 surface }
				velocity { box 0,0,0,80,0,0 }
				size { line 20,20,50,50 }
				tint { point 0.568627,0.447059,0.619608 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				rotate { box -0.25,0.25 relative }
			}
		}
	}
	spawner "flash2"
	{
		count		2,2
		locked

		sprite
		{
			duration	0.16,0.16
			material	"gfx/effects/weapons/mgun_muzzleflash"

			start
			{
				position { point 10,0,0 }
				velocity { point 1,0,0 }
				size { point 30,30 }
				tint { point 0.568627,0.447059,0.619608 }
				offset { point 5,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				tint { envelope linear }
				fade { envelope linear }
			}
		}
	}
	spawner "single_streak2"
	{
		count		1,1
		locked

		line
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/weapons/flash_half3"

			start
			{
				position { point -2,0,0 }
				size { point 10 }
				offset { point 5,0,0 }
				length { point 50,0,0 }
			}

			motion
			{
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				length { point 20,0,0 }
			}
		}
	}
}


