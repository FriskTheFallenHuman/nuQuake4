effect effects/smoke/ceilingsmoke_big
{
	size	601

	emitter "smoke"
	{
		duration	10,10
		count		3,3

		sprite
		{
			duration	5,8
			material	"gfx/effects/smoke/smoke_dark"
			gravity		-0.001,-0.001

			start
			{
				position { cylinder 0,-200,-200,0,200,200 }
				velocity { box -5,-5,-5,5,5,5 }
				size { line 90,90,120,120 }
				tint { line 0.447059,0.447059,0.447059,0.47451,0.447059,0.368627 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 200,200,300,300 }
				fade { line 0.5,1 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
}
