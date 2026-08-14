effect effects/levels/core/doors
{
	size	4119

	emitter "dust_back"
	{
		duration	1,1
		count		5,5
		attenuateEmitter

		sprite
		{
			duration	30,30
			persist
			material	"gfx/effects/smoke/CLOUD_alpha3"

			start
			{
				position { box 0,-100,-800,0,100,800 }
				velocity { box 0,20,-50,0,200,-50 }
				size { line 300,300,500,500 }
				tint { line 0.407843,0.254902,0.2,0.207843,0.12549,0.109804 }
				rotate { box -0.5,0 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 300,300,1000,1000 }
				tint { line 0.815686,0.721569,0.592157,0.6,0.360784,0.282353 }
				rotate { box -1,-0.5 relative }
			}
		}
	}
	shake "unnamed1"
	{
		duration	1,1
		scale		1
		attenuateEmitter
	}
	emitter "chunks"
	{
		duration	1,1
		count		100,100
		attenuateEmitter

		sprite
		{
			duration	1,1
			persist
			material	"gfx/effects/particles_shapes/concrete_chunks"
			gravity		1,1
			generatedNormal

			start
			{
				position { cylinder 1,-100,-800,1,100,800 }
				velocity { box 1000,0,0,5000,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { line 10,10,50,50 }
				tint { line 0.356863,0.27451,0.184314,0.678431,0.541176,0.372549 }
				fade { point 0 }
				offset { box 0,-20,-20,0,20,20 }
				rotate { box 0,0.5 }
			}

			motion
			{
				fade { envelope pop_hold_fadefast }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				fade { point 0.4 }
				angle { box -0.333333,-0.333333,-0.333333,0.333333,0.333333,0.333333 relative }
				rotate { box 0.5,1 relative }
			}
		}
	}
}
