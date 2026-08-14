effect effects/steam/mcc_vent_decon_hold
{
	size	299

	emitter "steam1"
	{
		duration	1,1
		count		20,20

		sprite
		{
			duration	1.5,3
			persist
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.0125,0

			start
			{
				position { cylinder -100,-100,-100,100,100,100 }
				angle { box 0,0,0,1,0,1 }
				size { box 30,30,90,90 }
				tint { line 1,1,1,0.713726,0.729412,0.796079 }
				fade { line 0.015,0.2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine offset 0.5 }
				angle { envelope exp_x2 }
				rotate { envelope linear }
			}

			end
			{
				size { line 100,100,150,150 }
				angle { box -0.5,0,-0.5,0.5,0,0.5 relative }
				rotate { point 0 relative }
			}
		}
	}
	sound "unnamed1"
	{
		soundShader	"effects_blowtorch"
	}
}

