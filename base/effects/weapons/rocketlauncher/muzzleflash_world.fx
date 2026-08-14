effect effects/weapons/rocketlauncher/muzzleflash_world
{
	size	44

	spawner "flash2"
	{
		count		1,1
		locked

		sprite
		{
			duration	0.16,0.16
			blend	add
			material	"gfx/effects/weapons/shotgun_mflash"

			start
			{
				size { line 8,8,20,20 }
				fade { point 0.7 }
				offset { point 2,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { line 2,2,3,3 }
			}
		}
	}
	spawner "flash"
	{
		detail		0.5
		count		2,2
		locked

		sprite
		{
			duration	0.06,0.06
			material	"gfx/effects/weapons/mgun_muzzleflash"

			start
			{
				size { line 8,8,20,20 }
				tint { point 0.701961,0.784314,0.803922 }
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
				size { line 2,2,3,3 }
			}
		}
	}
	spawner "smoke"
	{
		detail		0.5
		count		20,20
		locked

		sprite
		{
			duration	0.15,0.15
			material	"gfx/effects/smoke/cloud_alpha"
			generatedOriginNormal

			start
			{
				position { sphere 0.1,-5,-5,0.1,5,5 surface }
				velocity { point 1,0,0 }
				friction { point -300,0,0 }
				size { point 2,2 }
				tint { line 1,1,1,0.647059,0.858824,0.847059 }
				fade { point 0.1 }
				offset { point 2,0,0 }
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
				size { box 4,4,6,6 }
				rotate { point 0 relative }
			}
		}
	}
	spawner "smoke3"
	{
		detail		0.5
		count		15,15
		locked

		sprite
		{
			duration	0.15,0.15
			material	"gfx/effects/smoke/cloud_alpha"
			generatedOriginNormal

			start
			{
				position { sphere 0.1,-2,-2,0.1,2,2 surface }
				velocity { box 2,0,0,4,0,0 }
				size { line 0,0,2,2 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0.3 }
				offset { point 2,0,0 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 4,4,6,6 }
				rotate { point 0 relative }
			}
		}
	}
	spawner "single_streak"
	{
		count		1,1
		locked

		line
		{
			duration	0.12,0.12
			blend	add
			material	"gfx/effects/weapons/flash_half3"

			start
			{
				position { point -2,0,0 }
				size { point 5 }
				length { box 32,0,0,38,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { point 1.5 }
				length { box 14,0,0,20,0,0 }
			}
		}
	}
}

