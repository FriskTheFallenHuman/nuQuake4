effect effects/levels/storage/drop_pod_trail
{
	size	832

	emitter "unnamed2"
	{
		duration	1,1
		count		20,20

		line
		{
			duration	0.5,1
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				position { point -100,0,0 }
				velocity { point 850,0,0 }
				size { box 20,10 }
				fade { point 0.5 }
				length { point 200,0,0 }
			}

			motion
			{
				size { envelope fastinslowout }
				fade { envelope linear }
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
		count		20,20

		line
		{
			duration	0.5,1
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				position { point -350,-20,-80 }
				velocity { point 1500,0,0 }
				size { box 20,30 }
				fade { point 0.5 }
				length { point 200,0,0 }
			}

			motion
			{
				size { envelope fastinslowout }
				fade { envelope linear }
			}

			end
			{
				size { box 80,150 }
			}
		}
	}
}
