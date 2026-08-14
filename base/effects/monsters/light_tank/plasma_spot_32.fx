effect effects/monsters/light_tank/plasma_spot_32
{
	size	86

	sound "sound"
	{
		soundShader	"lt_tank_flame_loop"
	}
	emitter "smoke"
	{
		duration	6,6
		count		2,2

		sprite
		{
			duration	3,3.5
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.03,-0.01

			start
			{
				position { cylinder 0,-10,-10,30,10,10 }
				velocity { box -5,-5,-5,5,5,5 }
				size { line 20,20,40,40 }
				tint { point 0.321569,0.52549,0.678431 }
				fade { point 0 }
				rotate { box -0.111111,0 }
			}

			motion
			{
				tint { envelope linear }
				fade { envelope cosine }
				rotate { envelope linear }
			}

			end
			{
				fade { point 0.5 }
				rotate { box -0.222222,-0.111111 relative }
			}
		}
	}
	emitter "fire2"
	{
		duration	6,6
		count		6,6

		sprite
		{
			duration	0.5,1
			blend	add
			material	"gfx/effects/fire/p_fire2a"
			gravity		-0.05,-0.05

			start
			{
				position { cylinder 0,-10,-10,0,10,10 }
				angle { box 0,0,0,1,1,1 }
				size { box 15,15,25,25 }
				tint { line 1,1,1,1,1,0.501961 }
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
				fade { point 0.6 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "fire3"
	{
		duration	6,6
		count		5,5

		sprite
		{
			duration	0.75,1.25
			blend	add
			material	"gfx/effects/fire/p_fire3a"
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
		duration	6,6
		count		5,5

		sprite
		{
			duration	0.75,1.25
			blend	add
			material	"gfx/effects/fire/p_fire5a"
			gravity		-0.05,-0.05

			start
			{
				position { cylinder 0,-10,-10,0,10,10 }
				angle { box 0,0,0,1,1,1 }
				size { box 15,15,25,25 }
				tint { line 1,1,1,1,1,0.501961 }
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
	spawner "orient_glow"
	{
		count		1,1

		oriented
		{
			duration	7.2,7.2
			blend	add
			material	"gfx/effects/particles_shapes/p_warm_blend2"

			start
			{
				position { point 1,0,0 }
				size { point 36,36 }
				fade { point 0 }
			}

			motion
			{
				fade { envelope fire_flickerout }
			}

			end
			{
				fade { point 0.6 }
			}
		}
	}
	sound "unnamed6"
	{
		soundShader	"effects_fire_small"
	}
}




