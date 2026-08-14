effect effects/weapons/blaster/impact_flesh_exp
{
	size	41

	emitter "delayed_smoke"
	{
		start		0.125,0.125
		duration	1,1
		count		5,10

		sprite
		{
			duration	0.5,0.5
			persist
			material	"gfx/effects/smoke/impact_smoke3"
			gravity		-0.015,-0.015

			start
			{
				velocity { box 5,-2,-2,10,2,2 }
				size { point 0,0 }
				tint { point 0.74902,0.74902,0.74902 }
				fade { point 0.5 }
				rotate { box 0,0.111111 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 2,2,10,10 }
				rotate { box 0.111111,0.222222 relative }
			}
		}
	}
	spawner "hit2"
	{
		count		1,1

		sprite
		{
			duration	0.125,0.25
			blend	add
			material	"gfx/effects/energy_sparks/spark_blue"
			gravity		0.05,0.05

			start
			{
				position { line 0,0,0,10,0,0 linearSpacing }
				tint { point 0.694118,0.945098,0.941177 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
			}

			end
			{
				size { line 20,20,25,25 }
				fade { point 1 }
			}
		}
	}
}
