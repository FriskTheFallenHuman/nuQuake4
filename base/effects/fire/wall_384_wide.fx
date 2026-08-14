effect effects/fire/wall_384_wide
{
	size	511

	emitter "smoke"
	{
		duration	10,10
		count		8,8

		sprite
		{
			duration	3,4
			material	"gfx/effects/smoke/smoke_dark"
			gravity		-0.05,-0.05

			start
			{
				position { line 50,-150,-30,180,150,30 }
				velocity { box -5,-5,-5,5,5,5 }
				size { line 100,100,200,200 }
				tint { point 0.752941,0.752941,0.752941 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 10,10,200,200 }
				fade { point 1 }
				rotate { box -0.444444,0.444444 relative }
			}
		}
	}
	emitter "fire1"
	{
		duration	10,10
		count		5,5

		sprite
		{
			duration	1,1.5
			blend	add
			material	"gfx/effects/fire/fire1a"
			gravity		-0.15,-0.15

			start
			{
				position { line 0,-150,-100,0,150,100 }
				velocity { box 0,0,0,50,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 120,120,140,140 }
				fade { point 0 }
				offset { box -10,-10,-10,10,10,10 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 70,70,90,90 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "fire2"
	{
		duration	10,10
		count		8,8

		sprite
		{
			duration	1,1.5
			blend	add
			material	"gfx/effects/fire/fire2a"
			gravity		-0.19,-0.19

			start
			{
				position { line 5,-150,-100,5,150,100 }
				velocity { box 0,0,0,50,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 110,110,130,130 }
				fade { point 0 }
				offset { box -10,-10,-10,10,10,10 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 70,70,90,90 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "fire3"
	{
		duration	10,10
		count		6,6

		sprite
		{
			duration	1.5,2
			blend	add
			material	"gfx/effects/fire/fire3a"
			gravity		-0.22,-0.22

			start
			{
				position { line 10,-150,-100,10,150,100 }
				velocity { box 0,-15,-15,50,15,15 }
				angle { box 0,0,0,1,1,1 }
				size { box 70,70,90,90 }
				fade { point 0 }
				offset { box -10,-10,-10,10,10,10 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
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
	emitter "fire4"
	{
		duration	10,10
		count		6,6

		sprite
		{
			duration	1.5,2
			blend	add
			material	"gfx/effects/fire/fire4a"
			gravity		-0.2,-0.2

			start
			{
				position { line 20,-150,-100,20,150,100 }
				velocity { box 0,-15,-15,50,15,15 }
				angle { box 0,0,0,1,1,1 }
				size { box 80,80,100,100 }
				fade { point 0 }
				offset { box -10,-10,-10,10,10,10 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 50,50,70,70 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box 0.333333,0.444444 relative }
			}
		}
	}
	emitter "fire5"
	{
		duration	10,10
		count		6,6

		sprite
		{
			duration	1.5,2
			blend	add
			material	"gfx/effects/fire/fire5a"
			gravity		-0.22,-0.22

			start
			{
				position { line 10,-150,-100,10,150,100 }
				velocity { box 0,-10,-10,50,10,10 }
				angle { box 0,0,0,1,1,1 }
				size { box 60,60,80,80 }
				fade { point 0 }
				offset { box -10,-10,-10,10,10,10 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
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
	emitter "embers"
	{
		detail		0.3
		duration	10,10
		count		9,12

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/spark3"
			gravity		-0.2,-0.2

			start
			{
				position { line 80,-160,-40,120,160,40 }
				velocity { box 0,-5,-5,15,5,5 }
				angle { box 0,0,0,1,1,1 }
				size { line 2,2,9,9 }
				fade { point 0 }
				offset { box 0,-40,-40,0,40,40 }
				rotate { box 0,1 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
				angle { envelope "linear" }
			}

			end
			{
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
			}
		}
	}
	sound "unnamed9"
	{
		soundShader	"effects_fire_gas"
	}
	emitter "ground plane"
	{
		duration	10,10
		count		30,30

		sprite
		{
			duration	0.5,1
			blend	add
			material	"gfx/effects/fire/fire3a"

			start
			{
				position { line 0,-100,0,0,100,0 }
				size { box 20,20,50,50 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { box 150,150,250,250 }
			}
		}
	}
}



