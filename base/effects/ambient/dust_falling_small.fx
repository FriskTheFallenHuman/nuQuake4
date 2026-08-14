effect effects/ambient/dust_falling_small
{
	size	163

	spawner "trails"
	{
		start		0.2,0.5
		count		3,4

		line
		{
			duration	5,7
			material	"gfx/effects/particles_shapes/duststreak_alpha"
			gravity		0,0.001

			start
			{
				position { cylinder -10,-10,0,10,10,0 surface }
				size { box 1,3 }
				tint { line 0.4,0.34902,0.243137,0.384314,0.407843,0.235294 }
				fade { point 0.4 }
			}

			motion
			{
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				length { box 70,0,0,100,0,0 }
			}
		}
	}
	spawner "particles"
	{
		start		0.5,0.5
		count		10,10
		attenuateEmitter
		attenuation	0,256

		sprite
		{
			duration	6,10
			material	"gfx/effects/smoke/smoke_alpha"
			gravity		0.001,0.001

			start
			{
				position { cylinder 0,-10,-10,0,10,10 }
				velocity { box 10,-2,-2,20,2,2 }
				acceleration { box -1,-1,-1,1,1,1 }
				size { line 0.25,0.25,1,1 }
				tint { line 0.992157,0.854902,0.6,0.866667,0.984314,0.603922 }
			}
		}
	}
	spawner "particles_big"
	{
		count		6,6

		sprite
		{
			duration	6,10
			material	"gfx/effects/smoke/smoke_alpha"
			gravity		0.001,0.001

			start
			{
				position { cylinder 0,-20,-20,0,20,20 }
				velocity { box 4,-1,-1,15,1,1 }
				acceleration { box -1,-1,0,1,1,0 }
				size { point 10,10 }
				tint { line 0.886275,0.839216,0.682353,0.772549,0.792157,0.717647 }
				fade { point 0 }
				rotate { box 0,0.333333 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { line 40,40,50,50 }
				fade { point 0.2 }
				rotate { box 0.333333,0.666667 relative }
			}
		}
	}
	sound "unnamed3"
	{
		soundShader	"effects_debris_light"
	}
	sound "unnamed4"
	{
		soundShader	"effects_debris"
		volume	1,1
		freqshift	1.3,1.3
	}
	emitter "dust_fill"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	5,5
			material	"gfx/effects/smoke/smoke_alpha"
			gravity		0.0005,0.0005

			start
			{
				position { point 1,0,0 }
				size { point 50,50 }
				fade { point 0 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
			}

			end
			{
				size { point 100,100 }
				fade { point 0.4 }
			}
		}
	}
}







