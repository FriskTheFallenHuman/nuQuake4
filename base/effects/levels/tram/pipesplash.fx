effect effects/levels/tram/pipesplash
{
	size	174

	emitter "steam"
	{
		duration	1,1
		count		8,8

		sprite
		{
			duration	9,9
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.01,-0.002

			start
			{
				position { line 0,-20,-20,0,20,20 }
				velocity { box 12,-6,-6,0,6,6 }
				size { point 30,30 }
				tint { point 0.301961,0.533333,0.384314 }
				fade { point 0 }
				rotate { box -100,100 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope exp_xoverx2 }
				fade { envelope cosine }
				rotate { envelope cosine count 0.5 }
			}

			end
			{
				size { point 75,75 }
				tint { point 0.27451,0.643137,0.329412 }
				fade { point 0.4 }
				rotate { box 0,0.5 relative }
			}
		}
	}
	emitter "splash"
	{
		duration	1,1
		count		30,30

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/fluids_drips/bubble_green"
			gravity		0.35,0.35

			start
			{
				position { line 0,-10,-10,0,10,10 }
				velocity { box 120,-100,-100,150,100,100 }
				size { box 20,20,25,25 }
				tint { point 0.894118,0.937255,0.913726 }
				fade { point 0.5 }
				rotate { box -100,100 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope exp_xoverx2 }
				rotate { envelope cosine count 0.5 }
			}

			end
			{
				size { box 5,5,10,10 }
				tint { point 0.67451,0.858824,0.705882 }
				rotate { box 0,0.5 relative }
			}
		}
	}
	spawner "shockwave_inner"
	{
		count		1,1

		oriented
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/shockwave_alpha"

			start
			{
				position { point 5,0,0 }
				size { point 50,50 }
				tint { line 0.501961,0.501961,0,0.682353,0.682353,0.364706 }
				rotate { box 0,0,-0.25,0,0,0.25 }
			}

			motion
			{
				size { envelope random count 0.1,0.1 }
				rotate { envelope linear }
			}

			end
			{
				size { point 80,80 }
			}
		}
	}
}


