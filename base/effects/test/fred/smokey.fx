effect effects/test/fred/smokey
{
	size	1068

	spawner "unnamed0"
	{
		count		300,300

		sprite
		{
			duration	1,3
			material	"gfx/effects/smoke/cloud_alpha2"

			start
			{
				velocity { box 20,-200,-200,400,200,200 }
				size { point 10,10 }
				tint { line 1,1,0.501961,1,0.501961,0.25098 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope cosine }
				fade { envelope linear offset 0.5 }
			}

			end
			{
				size { point 300,300 }
				tint { line 0,0,0,0.25098,0,0 }
			}
		}
	}
}
