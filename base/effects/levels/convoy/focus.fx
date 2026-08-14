effect effects/levels/convoy/focus
{
	size	1003

	spawner "dirt"
	{
		start		0.12,0.12
		count		5,5

		sprite
		{
			duration	1,2
			material	"gfx/effects/particles_shapes/dirt"
			gravity		-0.5,-0.23

			start
			{
				position { cylinder -100,-100,-100,0,100,100 }
				size { point 200,200 }
				tint { point 0,0,0 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope cosine offset 0.5 }
				rotate { envelope random }
			}

			end
			{
				size { point 51,500 }
			}
		}
	}
	spawner "beam"
	{
		count		1,1
		locked

		line
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/bombard_focus"

			start
			{
				size { point 150 }
				tint { point 0.501961,0.501961,1 }
				fade { point 0 }
				length { line 0,0,0,0,0,0 useEndOrigin }
			}

			motion
			{
				size { envelope exp_x2 }
				fade { envelope exp_x2 }
			}

			end
			{
				size { point 60 }
				fade { point 1 }
			}
		}
	}
	spawner "beamCore"
	{
		start		0.95,1.1
		count		2,2
		locked

		line
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/energy_sparks/bombard_focus"

			start
			{
				size { point 60 }
				tint { point 0,0,0 }
				fade { point 0 }
				length { line 0,0,0,0,0,0 useEndOrigin }
			}

			motion
			{
				size { envelope exp_1minusx/x2 count 0.5 }
				tint { envelope cosine }
				fade { envelope exp_1minusx/x2 }
			}

			end
			{
				size { point 50 }
				tint { line 0.866667,0.894118,1,0.615686,0.772549,1 }
				fade { point 0.5 }
			}
		}
	}
	sound "sound"
	{
		soundShader	"mcc_landing_bombardment"
		freqshift	1.2,1.2
	}
	emitter "reverse_light"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	0.85,0.85
			material	"gfx/effects/weapons/muzzleflash2"

			start
			{
				position { point 15,0,0 }
				size { point 400,400 }
				tint { point 0.74902,0.74902,0.74902 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope cosine offset 0.5,0.5,0.5 }
				rotate { envelope linear }
			}
		}
	}
}



