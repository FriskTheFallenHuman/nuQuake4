effect effects/weapons/rocketlauncher/dmg_projectile
{
	size	174

	emitter "unnamed0"
	{
		duration	1,1
		count		3,3
		locked

		sprite
		{
			duration	1,1
			material	"gfx/effects/energy_sparks/launch_flash"

			start
			{
				size { line 20,20,25,25 }
				rotate { box 0,1 }
			}

			motion
			{
				rotate { envelope linear }
			}

			end
			{
				rotate { box -1,1 relative }
			}
		}
	}
	spawner "unnamed1"
	{
		count		10,10
		locked

		line
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/generic_pill"
			generatedNormal

			start
			{
				position { sphere -0.1,-0.1,-0.1,0.1,0.1,0.1 }
				length { box 5,0,0,15,0,0 }
			}

			motion
			{
				tint { envelope linear }
				length { envelope linear }
			}

			end
			{
				tint { point 0.396078,0.854902,0.878431 }
			}
		}
	}
	emitter "unnamed2"
	{
		duration	1,1
		count		2,2
		locked

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/muzzleflash2"

			start
			{
				size { point 15,15 }
				tint { point 0.729412,0.913726,0.929412 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}
		}
	}
	light "unnamed3"
	{
		locked

		light
		{
			duration	10,10
			material	"lights/defaultPointLight"

			start
			{
				size { point 100,100,100 }
			}

			motion
			{
				tint { envelope linear }
			}

			end
			{
				tint { point 0.666667,0.843137,0.85098 }
			}
		}
	}
	emitter "unnamed4"
	{
		duration	1,1
		count		1,1
		locked

		line
		{
			duration	1,1
			blend	add
			material	"gfx/effects/particles_shapes/generic_pill"

			start
			{
				size { point 10 }
				length { point -110,0,0 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
}


