effect effects/levels/storage/medfire_xtra_smoke
{
	size	379

	sound "sound"
	{
		soundShader	"effects_fire_deep2"
	}
	emitter "smoke"
	{
		duration	5,5
		count		20,20

		sprite
		{
			duration	1,3
			persist
			material	"gfx/effects/smoke/cloud_alpha2"
			gravity		-0.05,0

			start
			{
				position { line 0,-90,-90,90,90,90 }
				velocity { box 0,-30,-30,60,30,30 }
				size { line 50,50,100,100 }
				tint { line 0.886275,0.886275,0.886275,0.501961,0.501961,0.501961 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { line 150,150,150,50 }
				fade { point 1 }
				rotate { box -0.611111,0.611111 relative }
			}
		}
	}
	emitter "fire1"
	{
		duration	5,5
		count		2,2

		sprite
		{
			duration	1,1.5
			blend	add
			persist
			material	"gfx/effects/fire/fire1a"
			gravity		-0.15,-0.15

			start
			{
				position { line 0,-40,0,0,40,0 }
				velocity { box 30,0,0,70,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 120,120,140,140 }
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
				size { box 70,70,90,90 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "fire2"
	{
		duration	5,5
		count		2,2

		sprite
		{
			duration	1,1.5
			blend	add
			persist
			material	"gfx/effects/fire/fire2a"
			gravity		-0.19,-0.19

			start
			{
				position { line 5,-60,0,5,60,0 }
				velocity { box 30,0,0,70,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 110,110,130,130 }
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
				size { box 70,70,90,90 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "fire3"
	{
		duration	5,5
		count		2,2

		sprite
		{
			duration	0.75,1.25
			blend	add
			persist
			material	"gfx/effects/fire/fire3a"
			gravity		-0.2,-0.15

			start
			{
				position { line 10,-60,0,80,60,0 }
				velocity { box 50,-15,-15,120,15,15 }
				angle { box 0,0,0,1,1,1 }
				size { box 70,70,90,90 }
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
				size { box 40,40,60,60 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,-0.444444 relative }
			}
		}
	}
	emitter "fire4"
	{
		duration	5,5
		count		2,2

		sprite
		{
			duration	0.75,1.25
			blend	add
			persist
			material	"gfx/effects/fire/fire4a"
			gravity		-0.2,-0.15

			start
			{
				position { line 20,-60,0,20,60,0 }
				velocity { box 50,-15,-15,100,15,15 }
				angle { box 0,0,0,1,1,1 }
				size { box 80,80,100,100 }
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
				size { box 50,50,70,70 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box 0.333333,0.444444 relative }
			}
		}
	}
	emitter "fire5"
	{
		duration	5,5
		count		8,8

		sprite
		{
			duration	0.75,1.25
			blend	add
			persist
			material	"gfx/effects/fire/fire5a"
			gravity		-0.22,-0.22

			start
			{
				position { line 10,-50,0,60,50,0 }
				velocity { box 50,-10,-10,100,10,10 }
				angle { box 0,0,0,1,1,1 }
				size { box 60,60,80,80 }
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
				size { box 40,40,60,60 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.111111,-0.25 relative }
			}
		}
	}
	emitter "embers"
	{
		duration	5,5
		count		9,12

		sprite
		{
			duration	2,3
			blend	add
			persist
			material	"gfx/effects/energy_sparks/spark3"
			gravity		-0.2,-0.2

			start
			{
				position { line 80,-120,-40,120,120,40 }
				velocity { box 0,-5,-5,15,5,5 }
				angle { box 0,0,0,1,1,1 }
				size { line 2,2,9,9 }
				fade { point 0 }
				offset { box 0,-40,-40,0,40,40 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope fastinslowout }
				angle { envelope linear }
			}

			end
			{
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
			}
		}
	}
	spawner "orient_glow"
	{
		count		1,1

		oriented
		{
			duration	5,5
			material	"gfx/effects/particles_shapes/warm_blend2"

			start
			{
				position { point 1,0,0 }
				size { point 200,225 }
			}

			motion
			{
				size { envelope linear }
			}

			end
			{
				size { point 125,150 }
			}
		}
	}
	spawner "orient_glow2"
	{
		count		1,1

		oriented
		{
			duration	5,5
			material	"gfx/effects/particles_shapes/warm_blend2"

			start
			{
				position { point 1,0,0 }
				size { point 100,100 }
			}

			motion
			{
				size { envelope linear }
			}

			end
			{
				size { point 50,50 }
			}
		}
	}
}
