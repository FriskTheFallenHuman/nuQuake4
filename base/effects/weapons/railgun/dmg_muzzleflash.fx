effect effects/weapons/railgun/dmg_muzzleflash
{
	size	15

	spawner "unnamed0"
	{
		count		10,10
		locked

		sprite
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/energy_sparks/launch_flash3"

			start
			{
				size { point 4,4 }
				tint { point 0.756863,0.756863,0.756863 }
				fade { point 0.4 }
			}

			motion
			{
				size { envelope cosine }
				fade { envelope linear }
			}

			end
			{
				size { point 10,10 }
			}
		}
	}
	spawner "unnamed1"
	{
		count		3,3
		locked

		sprite
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/energy_sparks/launch_flash"

			start
			{
				size { point 10,10 }
				tint { point 0.592157,0.592157,0.729412 }
				fade { point 0.7 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}
		}
	}
	sound "unnamed2"
	{
		soundShader	"weapon_railgun_fire"
	}
	spawner "unnamed3"
	{
		count		1,1
		locked

		sprite
		{
			duration	0.2,0.2
			material	"gfx/effects/energy_sparks/launch_flash3"

			start
			{
				velocity { point 10,0,0 }
			}

			motion
			{
				size { envelope cosine }
			}

			end
			{
				size { point 3,3 }
			}
		}
	}
}


