effect effects/ships/marine_fighter
{
	size	417

	emitter "jet"
	{
		duration	10,10
		count		1,1
		locked

		line
		{
			duration	1,1
			material	"gfx/effects/ships/marine_fighter"

			start
			{
				position { point -100,0,0 }
				size { point 30 }
				tint { point 0.282353,0.376471,0.368627 }
				length { point 65,0,0 }
			}
		}
	}
	sound "unnamed2"
	{
		soundShader	"convoy_large_ship_loop1"
	}
	emitter "unnamed3"
	{
		duration	10,10
		count		30,30

		line
		{
			duration	3,4
			persist
			material	"gfx/effects/smoke/cloud_alpha2"
			flipNormal

			start
			{
				position { point -50,0,0 }
				acceleration { box 0,8,0,0,25,0 }
				size { box 10,20 }
				tint { point 0.745098,0.847059,0.862745 }
				fade { line 0.07,0.13 }
				length { point 120,0,0 }
			}

			motion
			{
				size { envelope arch offset 0.25 }
				fade { envelope linear count 1.5 offset -0.5 }
				length { envelope linear }
			}

			end
			{
				size { box 20,40 }
				length { point 300,0,0 }
			}
		}
	}
}









