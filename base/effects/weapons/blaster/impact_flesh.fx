effect effects/weapons/blaster/impact_flesh
{
	size	39

	spawner "bloodspray_enter"
	{
		detail		0.5
		count		3,4

		sprite
		{
			duration	1,1
			material	"gfx/effects/gore_spray/bloodspray2"
			gravity		-0.01,-0.01

			start
			{
				velocity { box 1,-6,-6,20,6,6 }
				size { box 0.05,0.05,0.2,0.2 }
				tint { point 0.364706,0.321569,0.27451 }
				rotate { box 0,0.138889 }
			}

			motion
			{
				size { envelope "linear" count 3,3 }
				tint { envelope "exp_x2" }
				fade { envelope "exp_x2" }
			}

			end
			{
				size { box 4,4,8,8 }
			}
		}
	}
	spawner "side_streaks"
	{
		detail		0.5
		count		7,9
		locked

		line
		{
			duration	0.24,0.24
			generatedLine
			material	"gfx/effects/gore_spray/bloodspray4"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.3,-0.3,-0.2,0.3,0.3 surface }
				velocity { point 1,0,0 }
				size { box 1,2 }
				tint { point 0.501961,0.501961,0.501961 }
			}

			motion
			{
				tint { envelope "exp_x2" }
				fade { envelope "exp_x2" }
				length { envelope "linear" }
			}

			end
			{
				tint { point 0.364706,0.321569,0.27451 }
				length { box 15,0,0,25,0,0 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
	spawner "bloodspray_exit2"
	{
		count		3,5

		sprite
		{
			duration	0.45,0.45
			material	"gfx/effects/gore_spray/bloodspray2"

			start
			{
				velocity { box 5,-15,-15,40,15,15 }
				size { point 0,0 }
				offset { box 0,-1,-1,0,1,1 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" count 0.65,0.65 }
				tint { envelope "exp_x2" }
				fade { envelope "exp_x2" }
				offset { envelope "linear" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 20,20 }
				tint { point 0.313726,0,0 }
				offset { point 1,1,1 }
				rotate { box 0,0.00277778 relative }
			}
		}
	}
	emitter "delayed_smoke"
	{
		detail		0.5
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
	sound "sound2"
	{
		soundShader	"bullet_impact_flesh"
	}
}




