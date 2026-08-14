effect effects/levels/storage/drop_pod_trail_sm
{
	size	245

	emitter "unnamed2"
	{
		duration	1,1
		count		20,20

		line
		{
			duration	1,2
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				size { box 10,5 }
				fade { point 0.2 }
				length { point 200,0,0 }
			}

			motion
			{
				size { envelope fastinslowout }
				fade { envelope linear }
			}

			end
			{
				size { box 30,45 }
			}
		}
	}
}
