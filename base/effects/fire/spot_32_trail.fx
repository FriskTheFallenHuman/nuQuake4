effect effects/fire/spot_32_trail
{
	size	74

	emitter "smoke"
	{
		duration	5,5
		count		50,100

		sprite
		{
			duration	2,3
			persist
			material	"gfx/effects/smoke/smoke_dark"

			start
			{
				position { cylinder 0,-10,-10,30,10,10 }
				size { line 20,20,40,40 }
				tint { line 0.701961,0.654902,0.533333,0.313726,0.282353,0.2 }
				fade { point 0 }
				rotate { box -0.111111,0 }
			}

			motion
			{
				fade { envelope cosine }
				rotate { envelope linear }
			}

			end
			{
				fade { line 0.25,0.75 }
				rotate { box -0.222222,-0.111111 relative }
			}
		}
	}
	emitter "fire2"
	{
		duration	10,10
		count		4,4

		sprite
		{
			duration	0.5,1
			blend	add
			material	"gfx/effects/fire/fire2a"
			gravity		-0.05,-0.05

			start
			{
				position { cylinder 0,-10,-10,0,10,10 }
				angle { box 0,0,0,1,1,1 }
				size { box 8,8,10,10 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 20,20,25,25 }
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

		sprite
		{
			duration	0.75,1.25
			blend	add
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
				size { envelope linear }
				fade { envelope cosine }
				angle { envelope linear }
				rotate { envelope linear }
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

		sprite
		{
			duration	0.75,1.25
			blend	add
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
				size { envelope linear }
				fade { envelope cosine }
				angle { envelope linear }
				rotate { envelope linear }
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
}





