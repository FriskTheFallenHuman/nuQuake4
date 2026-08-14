effect effects/smoke/air_defense_smokecolumn
{
	size	7531

	emitter "smoke"
	{
		duration	1,1
		count		2,2

		sprite
		{
			duration	8,20
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.06,-0.06

			start
			{
				position { box -50,-50,-50,50,50,50 }
				velocity { box 10,0,0,90,70,70 }
				angle { box 0,0,0,1,1,1 }
				acceleration { box -5,4,-5,-15,15,-30 }
				size { line 250,250,512,512 }
				tint { line 0,0,0,0.176471,0.156863,0.133333 }
				fade { point 0 }
				offset { box 10,-10,-10,10,10,10 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope concavefade }
				fade { envelope fastinslowout }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 2000,2000,3500,3500 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -1.05556,1.05556 relative }
			}
		}
	}
	emitter "underlit"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	5,5
			material	"gfx/effects/smoke/underlit_alpha2"
			gravity		-0.06,-0.06

			start
			{
				position { box 100,-100,-100,200,100,100 }
				velocity { box 10,0,0,90,70,70 }
				acceleration { box -5,8,-40,-20,24,-70 }
				size { point 500,300 }
				tint { line 1,1,0,1,1,1 }
				fade { point 0 }
				offset { point 10,0,0 }
				rotate { box 0.333333,0.5 }
			}

			motion
			{
				size { envelope concavefade }
				tint { envelope guitable_random3 count 8,8,8 }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { box 800,200,800,500 }
				tint { line 0,0,0,0.74902,0.74902,0.74902 }
				fade { line 0.5,1 }
				rotate { box -0.0555556,0.0555556 relative }
			}
		}
	}
	emitter "smoke2"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	12,16
			material	"gfx/effects/smoke/underlit_alpha2"
			gravity		-0.06,-0.06

			start
			{
				position { box -50,-50,-50,50,50,50 }
				velocity { box 10,0,0,80,70,70 }
				angle { box 0,0,0,1,1,1 }
				acceleration { box -5,4,-7,-13,10,-20 }
				size { line 250,250,512,512 }
				tint { line 0,0,0,0.282353,0.258824,0.223529 }
				fade { point 0 }
				offset { box 10,-10,-10,10,10,10 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope concavefade }
				fade { envelope fastinslowout }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 1000,1000,2000,2000 }
				fade { line 0.45,0.7 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -1.11111,1.11111 relative }
			}
		}
	}
}



