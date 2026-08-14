effect effects/mapobjects/tube_goo
{
	size	92

	emitter "steam"
	{
		duration	1,1
		count		3,3
		locked

		sprite
		{
			duration	10,10
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				position { line 0,0,0,70,0,0 }
				size { point 40,40 }
				tint { line 0,0.909804,0.909804,0,0.909804,0.658824 }
				fade { line 0.25,0.5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope cosine offset 0.5,0.5 }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "steam2"
	{
		duration	1,1
		count		3,3
		locked

		sprite
		{
			duration	10,10
			material	"gfx/effects/gore_spray/bloodhit2"

			start
			{
				position { line 0,0,0,70,0,0 }
				size { point 20,20 }
				tint { line 0,0.909804,0.909804,0,0.909804,0.658824 }
				fade { line 0.25,0.5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope cosine offset 0.5,0.5 }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}



