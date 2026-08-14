effect effects/fire/spot_32_trail_nssm
{
	size	64

	emitter "fire2"
	{
		duration	10,10
		count		4,4
		locked

		sprite
		{
			duration	0.5,1
			blend	add
			persist
			material	"gfx/effects/fire/fire2a"
			gravity		-0.05,-0.05

			start
			{
				position { cylinder 0,-10,-10,0,10,10 }
				angle { box 0,0,0,1,1,1 }
				size { box 15,15,25,25 }
				fade { point 0 }
				rotate { box 0,1 }
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
				size { box 8,8,15,15 }
				fade { point 0.6 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "fire3"
	{
		duration	10,10
		count		3,3
		locked

		sprite
		{
			duration	0.75,1.25
			blend	add
			persist
			material	"gfx/effects/fire/fire3a"
			gravity		-0.05,-0.05

			start
			{
				position { cylinder 0,-10,-10,0,10,10 }
				velocity { box 0,-5,-5,0,5,5 }
				angle { box 0,0,0,1,1,1 }
				size { box 15,15,25,25 }
				fade { point 0 }
				offset { box -2,-2,-2,2,2,2 }
				rotate { box 0,1 }
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
				size { box 8,8,15,15 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "fire5"
	{
		duration	10,10
		count		3,3
		locked

		sprite
		{
			duration	0.75,1.25
			blend	add
			persist
			material	"gfx/effects/fire/fire5a"
			gravity		-0.05,-0.05

			start
			{
				position { cylinder 0,-10,-10,0,10,10 }
				angle { box 0,0,0,1,1,1 }
				size { box 15,15,25,25 }
				fade { point 0 }
				rotate { box 0,1 }
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
				size { box 8,8,15,15 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "fire1"
	{
		duration	10,10
		count		5,5
		locked

		sprite
		{
			duration	0.85,0.95
			blend	add
			persist
			material	"gfx/effects/fire/fire1a"

			start
			{
				position { cylinder 0,-1,-1,0,1,1 }
				velocity { box 0,0,0,10,0,0 }
				angle { box 0,0,0,0,0,1 }
				size { box 15,15,25,25 }
				fade { point 0 }
				offset { box 0,-2,-2,0,2,2 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				angle { envelope "linear" }
			}

			end
			{
				size { box 25,25,30,30 }
				fade { line 0.75,1 }
				angle { box 0,0,0,0,0,1 }
			}
		}
	}
}



