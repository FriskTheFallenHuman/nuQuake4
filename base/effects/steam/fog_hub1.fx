effect effects/steam/fog_hub1
{
	size	677

	emitter "oriented fog"
	{
		duration	30,30
		count		45,45

		oriented
		{
			duration	4,6
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.003,-0.003

			start
			{
				position { cylinder 0,-300,-850,0,300,850 }
				size { line 120,120,160,160 }
				tint { point 0.4,0.552941,0.843137 }
				fade { point 0 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				fade { envelope cosine }
				rotate { envelope linear }
			}

			end
			{
				fade { line 0.2,0.5 }
				rotate { box 0,0,-0.111111,0,0,0.111111 relative }
			}
		}
	}
}
