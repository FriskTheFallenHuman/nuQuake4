effect effects/test/mvainio/firewallclimb
{
	size	95

	emitter "fire1"
	{
		duration	10,10
		count		3,3

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/fire/fire1a"
			gravity		-0.25,-0.25

			start
			{
				position { point 1,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 50,50,60,60 }
				fade { point 0 }
				offset { box -5,-5,-5,5,5,5 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				fade { envelope fastinslowout }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box 0,0,-0.222222,0,0,0.222222 relative }
			}
		}
	}
	emitter "fire2"
	{
		duration	10,10
		count		3,3

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/fire/fire2a"
			gravity		-0.25,-0.25

			start
			{
				position { point 1,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 50,50,60,60 }
				fade { point 0 }
				offset { box -5,-5,-5,5,5,5 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				fade { envelope fastinslowout }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box 0,0,-0.222222,0,0,0.222222 relative }
			}
		}
	}
	emitter "fire3"
	{
		duration	10,10
		count		2,2

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/fire/fire3a"
			gravity		-0.25,-0.25

			start
			{
				position { point 1,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 50,50,60,60 }
				fade { point 0 }
				offset { box -5,-5,-5,5,5,5 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				fade { envelope fastinslowout }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box 0,0,-0.222222,0,0,0.222222 relative }
			}
		}
	}
	emitter "fire4"
	{
		duration	10,10
		count		2,2

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/fire/fire4a"
			gravity		-0.25,-0.25

			start
			{
				position { point 1,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 50,50,60,60 }
				fade { point 0 }
				offset { box -5,-5,-5,5,5,5 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				fade { envelope fastinslowout }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box 0,0,-0.222222,0,0,0.222222 relative }
			}
		}
	}
	emitter "fire5"
	{
		duration	10,10
		count		2,2

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/fire/fire5a"
			gravity		-0.25,-0.25

			start
			{
				position { point 1,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 50,50,60,60 }
				fade { point 0 }
				offset { box -5,-5,-5,5,5,5 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				fade { envelope fastinslowout }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box 0,0,-0.222222,0,0,0.222222 relative }
			}
		}
	}
}
