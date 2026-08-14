effect effects/ambient/dust_swirl
{
	size	550

	emitter "unnamed0"
	{
		duration	1,1.5
		count		10,10

		sprite
		{
			duration	1,1.5
			material	"gfx/test/debris"
			gravity		-0.1,-0.1

			start
			{
				position { cylinder 0,-10,-10,0,10,10 surface }
				velocity { point 30,0,0 }
				size { point 150,150 }
				tint { point 0.639216,0.584314,0.462745 }
				fade { line 0.125,0.25 }
				offset { box 0,-50,-50,0,50,50 }
				rotate { box -0.5,0.5 }
			}

			motion
			{
				fade { envelope "cosine" offset 0.5 }
				offset { envelope "linear" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				offset { box 0,-200,-200,0,200,200 }
				angle { box 0,0,-1.11111,0,0,1.11111 }
			}
		}
	}
	emitter "chunks"
	{
		duration	1,1
		count		10,10
		attenuateEmitter

		sprite
		{
			duration	1,2
			persist
			material	"gfx/effects/particles_shapes/concrete_chunks"
			gravity		-0.1,-0.1

			start
			{
				position { cylinder 1,-1,-1,1,1,1 }
				angle { box 0,0,0,0,0,1 }
				size { line 2,2,4,4 }
				tint { point 0.752941,0.752941,0.752941 }
				fade { point 0 }
				offset { box 0,-100,-100,0,100,100 }
				rotate { box 0,0.5 }
			}

			motion
			{
				fade { envelope "pop_hold_fadefast" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				fade { point 0.4 }
				angle { box -0.5,-0.5,-0.333333,0.5,0.5,0.333333 relative }
				rotate { box 0.5,1 relative }
			}
		}
	}
	emitter "unnamed2"
	{
		duration	1,1.5
		count		5,5

		sprite
		{
			duration	2,2.5
			material	"gfx/test/debris"
			gravity		-0.1,-0.1

			start
			{
				position { cylinder 0,-10,-10,0,10,10 surface }
				velocity { point 80,0,0 }
				size { point 100,100 }
				tint { point 0.639216,0.584314,0.462745 }
				fade { line 0.125,0.25 }
				offset { box 0,-50,-50,0,50,50 }
				rotate { box -0.5,0.5 }
			}

			motion
			{
				fade { envelope "cosine" offset 0.5 }
				offset { envelope "linear" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				offset { box 0,-1,-1,0,1,1 }
				angle { box 0,0,-1.11111,0,0,1.11111 }
			}
		}
	}
}

