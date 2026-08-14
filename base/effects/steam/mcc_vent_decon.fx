effect effects/steam/mcc_vent_decon
{
	size	296

	emitter "steam1"
	{
		duration	1,1
		count		20,20

		sprite
		{
			duration	0.75,1.5
			persist
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		0.125,0.125

			start
			{
				position { point 0,0,0 cone }
				velocity { box 20,-10,-10,150,10,10 }
				angle { box 0,0,0,1,0,1 }
				acceleration { box 0,-25,-25,50,25,25 }
				friction { box 0,-1000,-1000,0,1000,1000 }
				size { box 5,5,10,10 }
				tint { line 1,1,1,0.713726,0.733333,0.796079 }
				fade { point 0.35 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				angle { envelope exp_x2 }
				rotate { envelope linear }
			}

			end
			{
				size { line 30,30,90,90 }
				angle { box -0.5,0,-0.5,0.5,0,0.5 relative }
				rotate { point 0 relative }
			}
		}
	}
	sound "unnamed3"
	{
		soundShader	"ambient_ventilation04"
	}
}



