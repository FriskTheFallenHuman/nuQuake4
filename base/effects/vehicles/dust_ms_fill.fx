effect effects/vehicles/dust_ms_fill
{
	size	4259

	emitter "dust_back"
	{
		duration	5,5
		count		500,500
		attenuateEmitter

		sprite
		{
			duration	2,3
			persist
			material	"gfx/effects/smoke/smoke_alpha"
			gravity		-0.02,-0.01

			start
			{
				position { cylinder 0,-3000,-5000,0,3000,5000 }
				velocity { box 100,0,0,400,0,0 }
				size { box 300,300,500,500 }
				tint { line 0.8,0.713726,0.611765,0.584314,0.447059,0.301961 }
				fade { point 0 }
				rotate { box -0.5,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope pop_hold_fadefast }
				rotate { envelope linear }
			}

			end
			{
				size { box 300,300,1000,1000 }
				fade { line 0.1,0.5 }
				rotate { box -1,-0.5 relative }
			}
		}
	}
	emitter "unnamed3"
	{
		duration	5,5
		count		500,500

		oriented
		{
			duration	5,5
			material	"gfx/effects/smoke/smoke_alpha"
			gravity		-0.03,-0.02

			start
			{
				position { cylinder 0,-3000,-5000,0,3000,5000 }
				velocity { box 50,-50,-50,50,50,50 }
				size { point 600,600 }
				tint { line 0.8,0.713726,0.611765,0.584314,0.447059,0.301961 }
				fade { line 0.1,0.5 }
				rotate { box 0,0,-0.0833333,0,0,0.0833333 }
			}

			motion
			{
				fade { envelope cosine offset 0.5 }
				rotate { envelope linear }
			}
		}
	}
}
