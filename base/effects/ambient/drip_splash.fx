effect effects/ambient/drip_splash
{
	size	31

	spawner "splash"
	{
		count		6,6

		line
		{
			duration	0.25,0.25
			material	"gfx/effects/fluids_drips/green_splash_line"
			generatedOriginNormal

			start
			{
				position { cylinder 0.05,-0.05,-0.05,0.05,0.05,0.05 }
				size { point 3 }
				length { box 1,-0.3,-0.3,1,0.3,0.3 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { point 6 }
				length { box 5,-0.5,-0.5,5,0.5,0.5 }
			}
		}
	}
	spawner "shockwave"
	{
		count		1,1

		oriented
		{
			duration	2,2.5
			blend	add
			material	"gfx/effects/particles_shapes/shockwave"

			start
			{
				position { point 0.05,0,0 }
				size { point 0.5,0.5 }
				tint { point 0.541176,0.733333,0.333333 }
				fade { point 0 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope pop_fade }
				rotate { envelope linear }
			}

			end
			{
				size { point 20,20 }
				fade { line 0.12,0.25 }
			}
		}
	}
	spawner "splash2"
	{
		count		2,3

		line
		{
			duration	0.12,0.12
			material	"gfx/effects/fluids_drips/green_splash_line"
			generatedOriginNormal

			start
			{
				position { cylinder 0.05,-0.05,-0.05,0.05,0.05,0.05 surface }
				size { point 4 }
				length { box 2,-1,-1,2,1,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { point 8 }
				length { box 8,-10,-10,8,10,10 }
			}
		}
	}
	sound "segment04"
	{
		soundShader	"effects_liquiddrip_small_quiet"
	}
	spawner "drops_motion"
	{
		count		5,6

		sprite
		{
			duration	0.25,1
			material	"gfx/effects/fluids_drips/bubble_green"
			gravity		0.1,0.5

			start
			{
				position { cylinder 2,-3,-3,2,3,3 }
				velocity { box 25,-25,-25,50,25,25 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 0.5,0.5 }
			}
		}
	}
	spawner "drops2"
	{
		count		5,6

		sprite
		{
			duration	0.5,1
			material	"gfx/effects/fluids_drips/bubble_green_half"

			start
			{
				position { cylinder 0,-1,-1,0,1,1 }
				velocity { box 0.25,-1,-1,0,1,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine offset 0.5 }
			}

			end
			{
				size { box 3,3,4,4 }
			}
		}
	}
}


