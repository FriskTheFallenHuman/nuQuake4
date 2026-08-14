effect effects/fire/spot_32_trail_roller
{
	size	482

	emitter "smoke"
	{
		duration	10,10
		count		20,50

		sprite
		{
			duration	2,3
			persist
			material	"gfx/effects/smoke/smoke_dark"

			start
			{
				position { cylinder 0,-10,-10,30,10,10 }
				size { line 80,80,100,100 }
				tint { line 0.329412,0.329412,0.329412,0.752941,0.752941,0.752941 }
				fade { line 0.25,0.75 }
				rotate { box -0.111111,0 }
			}

			motion
			{
				size { envelope cosine }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 150,150,300,300 }
				rotate { box -0.222222,-0.111111 relative }
			}
		}
	}
	emitter "fire6"
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
			gravity		-0.15,-0.125

			start
			{
				position { cylinder 0,-25,-25,0,25,25 }
				velocity { box 0,0,0,50,0,0 }
				angle { box 0,0,0,0,0,1 }
				size { box 50,50,80,80 }
				fade { point 0 }
				offset { box 0,-10,-10,0,10,10 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				angle { envelope linear }
			}

			end
			{
				size { box 150,150,300,300 }
				fade { line 0.75,1 }
				angle { box 0,0,0,0,0,1 }
			}
		}
	}
	emitter "fire7"
	{
		duration	10,10
		count		1,1
		locked

		sprite
		{
			duration	1,2
			blend	add
			persist
			material	"gfx/effects/fire/fire2a"
			gravity		-0.019,0

			start
			{
				position { cylinder 5,-15,-15,5,15,15 }
				velocity { box 0,0,0,50,0,0 }
				angle { box 0,0,0,0,0,1 }
				size { line 30,30,40,40 }
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
				size { box 110,110,120,120 }
				fade { point 1 }
				angle { box 0,0,-1,0,0,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "fire8"
	{
		duration	10,10
		count		2,2
		locked

		sprite
		{
			duration	1,1
			blend	add
			persist
			material	"gfx/effects/fire/fire3a"
			gravity		-0.22,0

			start
			{
				position { cylinder 10,-15,-15,10,15,15 }
				velocity { box 0,-15,-15,50,15,15 }
				angle { box 0,0,0,1,1,1 }
				size { box 80,80,100,100 }
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
				size { box 40,40,60,60 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,-0.333333 relative }
			}
		}
	}
	emitter "fire9"
	{
		duration	10,10
		count		1,1
		locked

		sprite
		{
			duration	1,1
			blend	add
			persist
			material	"gfx/effects/fire/fire4a"
			gravity		-0.2,-0.02

			start
			{
				position { cylinder 20,-15,-15,20,15,15 }
				velocity { box 0,-15,-15,50,15,15 }
				size { box 50,50,70,70 }
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
				size { box 10,10,20,20 }
				fade { point 1 }
				rotate { box 0.333333,0.444444 relative }
			}
		}
	}
	emitter "fire10"
	{
		duration	10,10
		count		1,1
		locked

		sprite
		{
			duration	1,1.5
			blend	add
			persist
			material	"gfx/effects/fire/fire5a"
			gravity		-0.22,-0.22

			start
			{
				position { cylinder 10,-15,-15,10,15,15 }
				velocity { box 0,-10,-10,50,10,10 }
				angle { box 0,0,0,1,1,1 }
				size { box 100,100,120,120 }
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
				size { box 40,40,60,60 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.111111,-0.222222 relative }
			}
		}
	}
	emitter "fire trail"
	{
		duration	10,10
		count		5,10

		sprite
		{
			duration	0.5,1
			blend	add
			persist
			material	"gfx/effects/fire/fire2a"

			start
			{
				position { cylinder 0,-10,-10,30,10,10 }
				size { line 80,80,100,100 }
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
				size { box 150,150,300,300 }
				rotate { box -0.222222,-0.111111 relative }
			}
		}
	}
}






