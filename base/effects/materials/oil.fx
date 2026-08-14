effect effects/materials/oil
{
	size	90

	emitter "oil_line_down"
	{
		duration	5,5
		count		4,4

		line
		{
			duration	3,7
			material	"gfx/effects/fluids_drips/brown_drop"

			start
			{
				position { line 0,-1,0,0,1,0 }
				tint { line 1,1,1,0,0,0 }
				length { box 0,0,-1,0,0,-2 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine offset 0.5 }
				length { envelope linear }
			}

			end
			{
				size { box 5,6 }
				length { box 0,0,-10,0,0,-100 }
			}
		}
	}
	emitter "oil_line_out"
	{
		duration	5,5
		count		12,12

		line
		{
			duration	0.5,1
			generatedLine
			material	"gfx/effects/fluids_drips/brown_drop"
			gravity		0.25,0.5

			start
			{
				velocity { box 50,0,0,75,0,0 }
				size { box 2,3 }
				tint { line 0,0,0,1,1,1 }
				fade { point 0 }
				length { point 1,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fast_in_slow_out }
				length { envelope linear }
			}

			end
			{
				size { box 5,7 }
				fade { point 1 }
				length { box 75,0,0,50,0,0 }
			}
		}
	}
	emitter "drops_motion"
	{
		duration	5,5
		count		12,20

		sprite
		{
			duration	0.12,0.25
			material	"gfx/effects/fluids_drips/brown_bubble"
			gravity		0.02,0.25

			start
			{
				position { line 0.05,-0.05,-0.05,0.05,0.05,0.05 }
				velocity { box 50,-50,-50,100,50,50 }
				tint { line 1,1,1,0,0,0 }
				fade { point 0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fast_in_slow_out }
			}

			end
			{
				size { point 0.5,0.5 }
				fade { point 1 }
			}
		}
	}
	sound "unnamed3"
	{
		soundShader	"bullet_impact_water"
	}
}


