effect effects/weapons/hyperblaster/impact_flesh_exp
{
	size	22

	emitter "smoke"
	{
		duration	0.2,0.2
		count		35,35

		sprite
		{
			duration	0.8,1
			blend	add
			material	"gfx/effects/weapons/plasma1"
			gravity		-0.02,-0.02

			start
			{
				position { line 0,0,0,5,0,0 }
				velocity { box 0,-4,-4,20,4,4 }
				size { line 1,1,3,3 }
				tint { line 0.45098,0.8,0.572549,0.713726,0.803922,0.905882 }
				fade { point 0.5 }
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
				size { line 4,4,6,6 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	spawner "impact_flash"
	{
		count		1,1

		sprite
		{
			duration	0.14,0.14
			blend	add
			material	"gfx/effects/weapons/flash_green"
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { point 3,3 }
			}

			motion
			{
				fade { envelope "exp_x2" }
			}
		}
	}
	spawner "side_impact_streaks"
	{
		count		7,9
		locked

		line
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/weapons/blaster_flyflipped"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.3,-0.3,-0.2,0.3,0.3 surface }
				size { point 1.5 }
				length { box 4,0,0,6,0,0 }
			}

			motion
			{
				fade { envelope "linear" }
			}
		}
	}
}
