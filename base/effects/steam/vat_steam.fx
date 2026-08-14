effect effects/steam/vat_steam
{
	size	122

	emitter "unnamed0"
	{
		duration	1,1
		count		25,25

		sprite
		{
			duration	1,1
			persist
			material	"gfx/effects/smoke/cloud_alpha2"
			gravity		-0.025,0.0195

			start
			{
				velocity { point 20,0,0 }
				angle { box 0,0,-0.194444,0,0,0.194444 }
				size { line 10,10,20,20 }
				tint { line 0.501961,0.501961,0.501961,0.235294,0.282353,0.215686 }
				fade { line 0.25,0.5 }
				offset { box 0,-30,-30,0,30,30 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope pop_hold_fade }
				fade { envelope cosine offset 0.5 }
				angle { envelope linear }
			}

			end
			{
				size { line 30,30,50,50 }
				tint { point 0.439216,0.419608,0.313726 }
				angle { box 0,0,0,0,0,0.194444 relative }
			}
		}
	}
	emitter "bubbles"
	{
		duration	1,1
		count		30,30

		oriented
		{
			duration	1,1
			material	"gfx/effects/fluids_drips/bubble_green"

			start
			{
				position { sphere 1,-40,-40,1,40,40 }
				size { point 0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 2,2 }
			}
		}
	}
	emitter "bubbles2"
	{
		duration	1,1
		count		25,25

		oriented
		{
			duration	1,1
			material	"gfx/effects/fluids_drips/bubble_additive"

			start
			{
				position { sphere 1,-40,-40,1,40,40 }
				size { point 0,0 }
				tint { line 0.164706,0.337255,0.156863,0.305882,0.309804,0.14902 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { line 2,2,6,6 }
			}
		}
	}
}

