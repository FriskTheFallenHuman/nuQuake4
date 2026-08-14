effect effects/levels/putra/acid_drip_impact
{
	size	35

	sound "sound"
	{
		soundShader	"effects_liquiddrip_large"
	}
	spawner "splash"
	{
		count		6,6

		line
		{
			duration	0.25,0.25
			material	"gfx/effects/fluids_drips/brown_splash_line"
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
				length { box 12,-2,-2,12,2,2 }
			}
		}
	}
	spawner "shockwave"
	{
		count		1,1

		oriented
		{
			duration	0.5,0.5
			material	"gfx/effects/particles_shapes/shockwave"

			start
			{
				position { point 0.05,0,0 }
				size { point 2,2 }
				tint { point 0.603922,0.466667,0.258824 }
				fade { point 0 }
			}

			motion
			{
				size { envelope sintable count 0.5,0.5 }
				tint { envelope linear }
				fade { envelope sintable count 0.5 }
				rotate { envelope linear }
			}

			end
			{
				size { point 5,5 }
				fade { point 0.25 }
			}
		}
	}
	spawner "drops_motion"
	{
		count		5,8

		sprite
		{
			duration	0.25,1
			material	"gfx/effects/fluids_drips/brown_bubble"
			gravity		0.2,0.2

			start
			{
				position { cylinder 0,-3,-3,0,3,3 }
				velocity { box 35,-30,-30,50,30,30 }
				size { point 3,3 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine offset 0.5 }
			}
		}
	}
	spawner "half_bubbles"
	{
		count		6,8

		sprite
		{
			duration	0.12,3
			material	"gfx/effects/fluids_drips/brown_bubble_half"

			start
			{
				position { cylinder 0,-10,-10,0,10,10 }
				velocity { box 0,-1,-1,0,1,1 }
				size { point 2,2 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine offset 0.5 }
			}

			end
			{
				size { box 5,5,6,6 }
			}
		}
	}
}
