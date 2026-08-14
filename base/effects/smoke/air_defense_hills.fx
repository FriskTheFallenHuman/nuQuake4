effect effects/smoke/air_defense_hills
{
	size	429

	emitter "smoke"
	{
		duration	1,1
		count		1.5,1.5

		sprite
		{
			duration	16,25
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.0001,-0.0001

			start
			{
				position { point -40,0,0 }
				velocity { box 15,0,0,20,-1,1 }
				angle { box 0,0,0,1,1,1 }
				acceleration { box 0,0,0,-1,-1,-1 }
				size { line 32,32,48,48 }
				tint { line 0.109804,0.129412,0.247059,0.192157,0.258824,0.258824 }
				fade { point 0 }
				offset { box 10,-10,-10,10,10,10 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope concavefade count 0.8,0.8 }
				tint { envelope linear count 1.7,1.7,1.7 }
				fade { envelope fastinslowout }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 100,100,150,150 }
				tint { line 0.0784314,0.219608,0.266667,0.239216,0.203922,0.141176 }
				fade { line 0.7,0.9 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box 0,0.277778 relative }
			}
		}
	}
}



