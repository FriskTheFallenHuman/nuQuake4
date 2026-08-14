effect effects/steam/moistureclouds_256
{
	size	459

	emitter "steam1"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/steam_alpha"
			gravity		0.35,0.35

			start
			{
				position { box 100,-100,-100,100,100,100 }
				velocity { box 0,-5,-5,55,5,5 }
				size { box 100,100,150,150 }
				tint { line 0.509804,0.529412,0.388235,0.670588,0.654902,0.596078 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { box 150,150,250,250 }
				fade { line 0.2,0.3 }
				rotate { box -0.25,0.25 relative }
			}
		}
	}
	emitter "steam2"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		0.35,0.35

			start
			{
				position { box 100,-100,-100,100,100,100 }
				velocity { box 0,-5,-5,55,5,5 }
				size { box 100,100,150,150 }
				tint { line 0.509804,0.529412,0.388235,0.670588,0.654902,0.596078 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { box 150,150,250,250 }
				fade { line 0.2,0.3 }
				rotate { box -0.25,0.25 relative }
			}
		}
	}
}


