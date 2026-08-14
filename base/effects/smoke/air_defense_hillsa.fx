effect effects/smoke/air_defense_hillsa
{
	size	385

	emitter "smoke"
	{
		duration	1,1
		count		1.5,1.5

		sprite
		{
			duration	10,20
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.0001,-0.0001

			start
			{
				position { point -40,0,0 }
				velocity { box 15,0,0,20,-1,1 }
				angle { box 0,0,0,1,1,1 }
				acceleration { box 0,0,0,-1,-1,-1 }
				size { line 32,32,48,48 }
				tint { point 0.811765,0.639216,0.372549 }
				fade { point 0 }
				offset { box 10,-10,-10,10,10,10 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "concavefade" count 0.8,0.8 }
				fade { envelope "fastinslowout" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 100,100,150,150 }
				fade { line 0.15,0.25 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box 0,0.277778 relative }
			}
		}
	}
}

