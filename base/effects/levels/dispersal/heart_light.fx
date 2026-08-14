effect effects/levels/dispersal/heart_light
{
	size	71

	light "unnamed0"
	{

		light
		{
			duration	2,2
			material	"lights/rav_slowfalloff"

			start
			{
				position { point 0,0,-2 }
				size { point 0,0,0 }
				tint { point 0.247059,0.454902,0.803922 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear offset -0.5,-0.5,-0.5 }
			}

			end
			{
				size { point 40,40,40 }
				tint { point 1,1,1 }
			}
		}
	}
}


