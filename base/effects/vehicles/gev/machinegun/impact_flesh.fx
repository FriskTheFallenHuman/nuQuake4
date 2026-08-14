effect effects/vehicles/gev/machinegun/impact_flesh
{
	size	67

	sound "sound"
	{
		soundShader	"bullet_impact_flesh"
	}
	decal "mark"
	{

		decal
		{
			duration	0.002,0.002
			material	"textures/decals/hurt03"

			start
			{
				size { point 3,3 }
				rotate { point 0.180556 }
			}
		}
	}
	spawner "bloodspray"
	{
		count		6,8

		sprite
		{
			duration	1,1
			material	"gfx/effects/gore_spray/bloodspray2"
			gravity		-0.01,-0.01

			start
			{
				velocity { box 1,-6,-6,20,6,6 }
				size { box 1,1,2,2 }
				rotate { box 0,0.138889 }
			}

			motion
			{
				size { envelope linear count 3,3 }
				tint { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { box 20,20,40,40 }
				tint { point 0.501961,0.501961,0.501961 }
			}
		}
	}
}


