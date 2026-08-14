effect effects/weapons/railgun/dmg_trail
{
	size	203

	spawner "unnamed0"
	{
		count		2,2

		line
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/particles_shapes/generic_pill"

			start
			{
				position { point -100,0,0 }
				size { point 12 }
				tint { point 0.643137,0.819608,1 }
				length { line 0,0,0,0,0,0 useEndOrigin }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
	spawner "unnamed1"
	{
		count		100,100

		sprite
		{
			duration	1.5,1.5
			blend	add
			material	"gfx/effects/weapons/muzzleflash2"
			gravity		0.005,0.02

			start
			{
				position { box 0,-4,-4,400,4,4 useEndOrigin }
				size { box 0.5,0.5,1.5,1.5 }
				tint { line 0.643137,0.819608,1,0,0.501961,0.74902 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}
		}
	}
	spawner "unnamed2"
	{
		count		1,1

		line
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/particles_shapes/generic_pill"

			start
			{
				position { point -80,0,0 }
				size { point 5 }
				fade { point 0.8 }
				length { line 0,0,0,0,0,0 useEndOrigin }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
	spawner "unnamed3"
	{
		count		15,15

		oriented
		{
			duration	0.7,0.7
			blend	add
			material	"gfx/effects/energy_sparks/launch_flash3"

			start
			{
				position { box -25,-0.01,-0.01,-25,0.01,0.01 useEndOrigin }
				velocity { point 100,0,0 }
				size { point 20,20 }
				rotate { box 0,0.25,0,1,0.25,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				rotate { point 0.5,0,0 relative }
			}
		}
	}
	spawner "unnamed4"
	{
		count		15,15

		oriented
		{
			duration	0.7,0.7
			blend	add
			material	"gfx/effects/energy_sparks/launch_flash2"

			start
			{
				position { box -25,-0.01,-0.01,-25,0.01,0.01 useEndOrigin }
				velocity { point 100,0,0 }
				size { point 20,20 }
				rotate { box 0,0.25,0,1,0.25,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				rotate { point 0.5,0,0 relative }
			}
		}
	}
}



