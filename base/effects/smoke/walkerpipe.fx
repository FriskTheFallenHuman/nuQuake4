effect effects/smoke/walkerpipe
{
	size	1318

	emitter "smoke3"
	{
		duration	1,1
		count		3,5
		attenuateEmitter

		sprite
		{
			duration	3,8
			material	"gfx/effects/smoke/smoke_dark"
			gravity		-0.045,0
			generatedOriginNormal

			start
			{
				position { point 40,0,0 }
				velocity { box 0,-25,-25,60,25,25 }
				size { line 100,100,150,150 attenuate }
				tint { line 1,1,1,0.501961,0.501961,0.501961 }
				fade { point 0 attenuate }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "cosine" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 300,300,450,450 attenuate }
				fade { line 0.25,0.5 attenuate }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
}
