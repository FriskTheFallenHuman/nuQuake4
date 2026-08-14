effect effects/monsters/grunt/gundone
{
	size	23

	emitter "smoke"
	{
		duration	1.5,1.5
		count		30,30

		sprite
		{
			duration	0.75,1
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.1,-0.06

			start
			{
				position { point 0,0,5 }
				velocity { box 0,-3,-3,10,3,3 }
				size { line 1,1,2,2 }
				tint { line 0.47451,0.458824,0.419608,0.203922,0.192157,0.176471 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine }
			}

			end
			{
				size { line 8,8,12,12 }
				fade { point 1 }
			}
		}
	}
}






