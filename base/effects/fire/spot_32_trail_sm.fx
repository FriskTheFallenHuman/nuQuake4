effect effects/fire/spot_32_trail_sm
{
	size	183

	emitter "smoke"
	{
		duration	5,5
		count		20,40

		sprite
		{
			duration	2,2
			persist
			material	"gfx/effects/smoke/smoke_dark"
			gravity		-0.025,0

			start
			{
				position { cylinder 0,-5,-5,0,5,5 }
				size { line 15,15,25,25 }
				tint { line 1,1,1,0.74902,0.74902,0.74902 }
				fade { line 0.25,0.75 }
				rotate { box -0.111111,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 30,30,50,50 }
				rotate { box -0.222222,-0.111111 relative }
			}
		}
	}
	emitter "fire7"
	{
		duration	5,5
		count		1,1

		sprite
		{
			duration	1,2
			blend	add
			persist
			material	"gfx/effects/fire/fire2a"
			gravity		-0.019,0

			start
			{
				position { cylinder 0,-15,-15,0,15,15 }
				velocity { box 0,0,0,50,0,0 }
				angle { box 0,0,0,0,0,1 }
				size { line 5,5,10,10 }
				fade { point 0 }
				offset { box -10,-10,-10,10,10,10 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 15,15,20,20 }
				fade { point 1 }
				angle { box 0,0,-1,0,0,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "fire8"
	{
		duration	5,5
		count		2,2

		sprite
		{
			duration	1,1
			blend	add
			persist
			material	"gfx/effects/fire/fire3a"
			gravity		-0.22,0

			start
			{
				position { cylinder 0,-15,-15,0,15,15 }
				angle { box 0,0,0,1,1,1 }
				size { box 20,20,30,30 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 5,5,10,10 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,-0.333333 relative }
			}
		}
	}
	emitter "fire9"
	{
		duration	5,5
		count		1,1

		sprite
		{
			duration	1,1
			blend	add
			persist
			material	"gfx/effects/fire/fire4a"
			gravity		-0.2,-0.02

			start
			{
				position { cylinder 0,-15,-15,0,15,15 }
				size { box 25,25,35,35 }
				fade { point 0 }
				rotate { box -1,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { box 5,5,10,10 }
				fade { point 1 }
				rotate { box 0.333333,0.444444 relative }
			}
		}
	}
	emitter "fire10"
	{
		duration	5,5
		count		1,1

		sprite
		{
			duration	1,1.5
			blend	add
			persist
			material	"gfx/effects/fire/fire5a"
			gravity		-0.22,-0.22

			start
			{
				position { cylinder 0,-15,-15,0,15,15 }
				angle { box 0,0,0,1,1,1 }
				size { box 30,30,40,40 }
				tint { line 0.192157,0.192157,0.192157,0.501961,0.501961,0.501961 }
				fade { point 0 }
				offset { box -10,-10,-10,10,10,10 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope fadetable }
				fade { envelope fastinslowout }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 20,20,30,30 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.111111,-0.222222 relative }
			}
		}
	}
	emitter "fire trail"
	{
		duration	5,5
		count		10,20

		sprite
		{
			duration	0.5,1
			blend	add
			persist
			material	"gfx/effects/fire/fire2a"

			start
			{
				position { cylinder 0,-5,-5,0,5,5 }
				size { line 10,10,20,20 }
				tint { line 0.329412,0.329412,0.329412,0.752941,0.752941,0.752941 }
				rotate { box -0.111111,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 25,25,30,30 }
				rotate { box -0.222222,-0.111111 relative }
			}
		}
	}
	emitter "fire trail2"
	{
		duration	5,5
		count		10,10
		locked

		sprite
		{
			duration	0.5,1
			blend	add
			persist
			material	"gfx/effects/fire/fire2a"

			start
			{
				position { cylinder 0,-5,-5,0,5,5 }
				size { line 10,10,20,20 }
				tint { line 0.329412,0.329412,0.329412,0.752941,0.752941,0.752941 }
				rotate { box -0.111111,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 25,25,30,30 }
				rotate { box -0.222222,-0.111111 relative }
			}
		}
	}
}

