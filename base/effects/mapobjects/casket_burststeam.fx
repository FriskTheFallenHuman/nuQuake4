effect effects/mapobjects/casket_burststeam
{
	size	91

	emitter "unnamed0"
	{
		duration	1,1
		count		20,20

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/cloud_alpha2"
			gravity		0.025,0.125

			start
			{
				position { cylinder 0,-15,-15,0,15,15 }
				velocity { box 10,0,0,15,0,0 }
				angle { box 0,0,-1,0.277778,0.277778,1 }
				size { line 10,10,15,15 }
				fade { point 0.5 }
				offset { box 0,-5,-5,0,5,5 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				angle { envelope linear }
			}

			end
			{
				size { line 30,30,50,50 }
				angle { box -0.513889,-0.5,-0.5,0.513889,0.5,0.5 relative }
			}
		}
	}
}


