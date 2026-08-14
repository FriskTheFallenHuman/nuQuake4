effect effects/steam/fastblink_128
{
	size	318

	sound "sound"
	{
		soundShader	"effects_blowtorch"
	}
	emitter "end"
	{
		duration	25,25
		count		1,3

		sprite
		{
			duration	1,1.25
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.01,0.01
			generatedOriginNormal

			start
			{
				position { line 25,0,0,45,0,0 }
				velocity { box 100,-15,-15,150,15,15 }
				size { line 80,80,10,10 }
				tint { point 0.611765,0.584314,0.478431 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope flickerblink count 1.8 }
				rotate { envelope linear }
			}

			end
			{
				size { line 120,120,150,150 }
				fade { point 0.15 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	emitter "steam"
	{
		duration	25,25
		count		12,15

		sprite
		{
			duration	1,2
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		0.02,0.06

			start
			{
				position { line 10,-1,-1,10,1,1 }
				velocity { box 30,-10,-10,160,10,10 }
				size { box 30,30,40,40 }
				tint { point 0.611765,0.584314,0.478431 }
				fade { point 0.2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope randomflick count 2 }
				rotate { envelope linear }
			}

			end
			{
				size { box 50,50,70,70 }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
}


