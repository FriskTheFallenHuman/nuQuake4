effect effects/ambient/dust_impact
{
	size	495

	spawner "particles"
	{
		count		8,14

		sprite
		{
			duration	0.75,0.75
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.025,-0.025
			generatedNormal

			start
			{
				position { cylinder 0,-20,-20,0,20,20 surface }
				velocity { point 50,0,0 }
				size { point 20,20 }
				tint { line 0.32549,0.301961,0.282353,0.129412,0.133333,0.101961 }
				fade { point 0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine }
			}

			end
			{
				size { box 100,100,150,150 }
				fade { line 0.5,0.25 }
			}
		}
	}
	spawner "particles2"
	{
		count		8,14

		sprite
		{
			duration	1,5
			material	"gfx/effects/smoke/cloud_alpha3"
			generatedNormal

			start
			{
				position { cylinder 0,-100,-100,0,100,100 }
				size { point 20,20 }
				tint { line 0.32549,0.301961,0.282353,0.129412,0.133333,0.101961 }
				fade { line 0.5,0.75 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { box 200,200,300,300 }
			}
		}
	}
}
