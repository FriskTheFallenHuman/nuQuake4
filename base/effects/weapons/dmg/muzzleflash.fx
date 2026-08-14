effect effects/weapons/dmg/muzzleflash
{
	size	56

	emitter "delayed_smoke"
	{
		detail		0.5
		start		0.2,0.2
		duration	0.75,1.5
		count		15,15
		locked

		sprite
		{
			duration	1,1.5
			blend	add
			material	"gfx/effects/weapons/plasma1"
			gravity		-0.002,-0.002

			start
			{
				velocity { box 3,0,0,5,0,0 }
				angle { box -1,-1,-1,1,1,1 }
				size { line 1,1,2,2 }
				tint { point 0.568627,0.447059,0.619608 }
				fade { point 0 }
				offset { box 0,-1,-1,0,1,1 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 6,6,8,8 }
				fade { line 0.4,0.6 }
				angle { point 0,0,0 relative }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	spawner "single_streak"
	{
		detail		0.5
		count		2,2
		locked

		line
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/weapons/flash_half3"

			start
			{
				position { point -2,0,0 }
				size { point 5 }
				tint { point 0.568627,0.447059,0.619608 }
				length { box 30,0,0,50,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
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
			generatedOriginNormal

			start
			{
				position { cylinder 0,-1,-1,0,1,1 surface }
				velocity { point 20,0,0 }
				size { line 8,8,15,15 }
				tint { point 0.568627,0.447059,0.619608 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope "linear" }
				rotate { envelope "linear" }
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
				velocity { point 1,0,0 }
				size { point 10,10 }
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
				size { point 1.5,1.5 }
			}
		}
	}
}




