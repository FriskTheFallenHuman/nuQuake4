effect effects/fire/lineshort_96
{
	size	237

	sound "sound"
	{
		soundShader	"effects_fire_small"
		freqshift	1.3,1.3
	}
	emitter "smoke"
	{
		duration	1,1
		count		4,4

		sprite
		{
			duration	3,3.5
			material	"gfx/effects/smoke/cloud_alpha2"
			gravity		-0.03,-0.01

			start
			{
				position { cylinder 20,-60,-10,60,60,10 }
				velocity { box -5,-5,-5,5,5,5 }
				size { line 60,60,100,100 }
				tint { point 0.505882,0.482353,0.439216 }
				fade { point 0 }
				rotate { box -0.111111,0 }
			}

			motion
			{
				fade { envelope "cosine" }
				rotate { envelope "linear" }
			}

			end
			{
				fade { point 0.68 }
				rotate { box -0.222222,-0.111111 relative }
			}
		}
	}
	emitter "fire2"
	{
		duration	1,1
		count		14,14

		sprite
		{
			duration	0.5,1
			blend	add
			material	"gfx/effects/fire/fire2a"
			gravity		-0.05,-0.05

			start
			{
				position { cylinder 0,-50,-10,0,50,10 }
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
	emitter "fire3"
	{
		duration	1,1
		count		14,14

		sprite
		{
			duration	0.75,1.25
			blend	add
			material	"gfx/effects/fire/fire3a"
			gravity		-0.05,-0.05

			start
			{
				position { cylinder 0,-50,-10,0,50,10 }
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
		duration	1,1
		count		14,14

		sprite
		{
			duration	0.75,1.25
			blend	add
			material	"gfx/effects/fire/fire5a"
			gravity		-0.05,-0.05

			start
			{
				position { cylinder 0,-50,-10,0,50,10 }
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
	spawner "orient_glow"
	{
		count		1,1
		constant

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/particles_shapes/warm_blend2"

			start
			{
				position { point 1,0,0 }
				size { point 110,50 }
			}

			motion
			{
				fade { envelope "randomflick" }
			}

			end
			{
				fade { point 0.6 }
			}
		}
	}
	emitter "embers"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	1.5,3
			blend	add
			material	"gfx/effects/energy_sparks/spark3"
			gravity		-0.1,0

			start
			{
				position { cylinder 20,-60,-10,40,60,10 }
				velocity { box 0,-5,-5,15,5,5 }
				angle { box 0,0,0,1,1,1 }
				size { line 0.25,0.25,1.5,1.5 }
				fade { point 0 }
				offset { box 0,-10,-10,0,10,10 }
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
	emitter "fire1"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	0.85,0.95
			blend	add
			material	"gfx/effects/fire/fire1a"

			start
			{
				position { cylinder 0,-45,-10,0,45,10 }
				angle { box 0,0,0,0,0,1 }
				size { line 20,20,30,30 }
				fade { point 0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				angle { envelope "linear" }
			}

			end
			{
				size { box 30,40,30,100 }
				fade { line 0.75,1 }
				angle { box 0,0,0,0,0,1 }
			}
		}
	}
	emitter "unnamed11"
	{
		duration	1,1
		count		1,3

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/fire/fire1a"

			start
			{
				position { point 1,0,0 }
				size { point 180,100 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fullflicker" }
			}
		}
	}
}






