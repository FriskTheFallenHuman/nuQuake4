effect effects/materials/gelatinous_fluid
{
	size	37

	sound "sound"
	{
		soundShader	"bullet_impact_water"
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
	spawner "splash222"
	{
		count		5,6

		line
		{
			duration	0.12,0.18
			material	"gfx/effects/fluids_drips/brown_splash_line"
			generatedOriginNormal

			start
			{
				position { cylinder 0.05,-0.05,-0.05,0.05,0.05,0.05 surface }
				size { point 7 }
				length { box 1,-1,-1,1,1,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { point 12 }
				length { box 13,-5,-5,13,5,5 }
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
			gravity		0.25,0.5

			start
			{
				position { cylinder 10,-1,-1,10,1,1 }
				velocity { box 25,-50,-50,10,50,50 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine offset 0.5 }
			}

			end
			{
				size { point 0.5,0.5 }
			}
		}
	}
	spawner "half_bubbles"
	{
		count		6,12

		sprite
		{
			duration	0.12,4
			material	"gfx/effects/fluids_drips/brown_bubble_half"

			start
			{
				position { cylinder 0,-12,-12,0,12,12 }
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
				size { box 6,6,8,8 }
			}
		}
	}
}


