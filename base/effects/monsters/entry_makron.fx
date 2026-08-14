effect effects/monsters/entry_makron
{
	size	791

	emitter "fuzz2"
	{
		duration	1,1
		count		30,30

		sprite
		{
			duration	1,3
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.125,0
			generatedNormal

			start
			{
				position { sphere 0,-150,-150,0,150,150 surface }
				velocity { box 100,0,0,150,0,0 }
				angle { box 0,0,-1,0,0,1 }
				size { point 100,100 }
				tint { line 0.752941,0.752941,0.752941,0.545098,0.611765,0.694118 }
				fade { point 0 }
				offset { box 0,-10,-10,0,10,10 }
				rotate { box 0,0.5 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 150,150,300,300 }
				fade { point 0.5 }
			}
		}
	}
	emitter "fuzz3"
	{
		duration	1,1
		count		15,15

		sprite
		{
			duration	1,3
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.05,0

			start
			{
				position { sphere 0,-150,-150,0,150,150 surface }
				velocity { box 100,-50,-50,150,50,50 }
				angle { box 0,0,-1,0,0,1 }
				size { point 100,100 }
				tint { line 0.752941,0.752941,0.752941,0.552941,0.592157,0.686275 }
				fade { point 0 }
				offset { box 0,-10,-10,0,10,10 }
				rotate { box 0,0.5 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 150,150,300,300 }
				fade { line 0.5,0.75 }
			}
		}
	}
}
