effect effects/levels/storage/drop_pod_trail_2
{
	size	807

	emitter "unnamed2"
	{
		duration	1,1
		count		15,18

		line
		{
			duration	0.6,0.8
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				position { point -100,0,0 }
				velocity { box 850,0,0,950,0,0 }
				size { box 20,10 }
				fade { point 0.4 }
				length { point 200,0,0 }
			}

			motion
			{
				size { envelope "fastinslowout" }
				fade { envelope "cosine" count 0.8 offset 0.7 }
			}

			end
			{
				size { box 45,60 }
			}
		}
	}
	emitter "unnamed3"
	{
		duration	1,1
		count		12,15

		line
		{
			duration	0.5,1
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				position { point -400,0,0 }
				velocity { point 1500,0,0 }
				size { box 20,30 }
				fade { point 0.2 }
				length { point 200,0,0 }
			}

			motion
			{
				size { envelope "fastinslowout" }
				fade { envelope "cosine" count 0.8 offset 0.7 }
			}

			end
			{
				size { box 80,150 }
			}
		}
	}
	emitter "unnamed2"
	{
		duration	1,1
		count		15,15

		sprite
		{
			duration	0.5,0.8
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				position { point -300,0,0 }
				velocity { box 750,-50,-50,1100,50,50 }
				size { line 60,60,90,90 }
				fade { point 0.4 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope "cosine" count 0.8 offset 0.7 }
			}
		}
	}
}
