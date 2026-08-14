effect effects/weapons/blaster/impact_flesh_charged_exp
{
	size	76

	emitter "delayed_smoke"
	{
		start		0.125,0.125
		duration	0.75,0.75
		count		5,10

		sprite
		{
			duration	1,1
			persist
			material	"gfx/effects/smoke/impact_smoke3"
			gravity		-0.015,-0.015

			start
			{
				velocity { box 5,-2,-2,10,2,2 }
				size { point 5,5 }
				tint { point 0.501961,0.501961,0.501961 }
				rotate { box 0,0.111111 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 10,10,20,20 }
				rotate { box 0.111111,0.222222 relative }
			}
		}
	}
	spawner "hit3"
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
				size { line 40,40,50,50 }
				fade { point 1 }
			}
		}
	}
}
