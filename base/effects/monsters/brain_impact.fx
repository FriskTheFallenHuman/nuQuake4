effect effects/monsters/brain_impact
{
	size	232

	spawner "spew 2"
	{
		count		20,20

		sprite
		{
			duration	0.25,0.5
			persist
			material	"gfx/effects/gore_spray/bloodhit4"
			gravity		0.2,0.2

			start
			{
				velocity { box 200,-200,-200,300,200,200 }
				size { point 2,2 }
				tint { line 1,0.690196,0.690196,0.411765,0.0784314,0.0784314 }
				rotate { box -0.5,0.5 }
			}

			motion
			{
				size { envelope arch count 0.7,0.7 }
				fade { envelope linear }
			}

			end
			{
				size { line 80,80,100,100 }
			}
		}
	}
	spawner "unnamed13"
	{
		count		3,5

		debris
		{
			duration	1,1
			entityDef	"debris_gib_brain1"

			start
			{
				velocity { box 300,-150,-150,150,150,150 }
			}
		}
	}
	spawner "spew 3"
	{
		count		20,20

		sprite
		{
			duration	0.25,1
			persist
			material	"gfx/effects/gore_spray/bloodhit4"
			gravity		0.2,0.2

			start
			{
				velocity { box 50,-50,-50,100,50,50 }
				size { point 2,2 }
				tint { line 1,0.690196,0.690196,0.411765,0.0784314,0.0784314 }
				rotate { box -0.5,0.5 }
			}

			motion
			{
				size { envelope arch count 0.7,0.7 }
				fade { envelope linear }
			}

			end
			{
				size { line 40,40,50,50 }
			}
		}
	}
	spawner "unnamed14"
	{
		count		3,5

		debris
		{
			duration	1,1
			entityDef	"debris_gib_brain1"

			start
			{
				velocity { box 0,-50,-50,50,50,50 }
			}
		}
	}
}

