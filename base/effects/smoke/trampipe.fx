effect effects/smoke/trampipe
{
	size	1200

	emitter "smoke"
	{
		duration	1,1
		count		15,30
		attenuateEmitter

		sprite
		{
			duration	1,3
			material	"gfx/effects/smoke/smoke_dark"
			gravity		-0.45,-0.25
			generatedOriginNormal

			start
			{
				position { point 40,0,0 }
				velocity { box 0,-15,-15,0,15,15 }
				size { line 5,5,10,10 attenuate }
				tint { line 1,1,1,0.501961,0.501961,0.501961 }
				fade { point 0 attenuate }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope cosine }
				rotate { envelope linear }
			}

			end
			{
				size { line 200,200,250,250 attenuate }
				fade { line 0.25,0.5 attenuate }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
}


