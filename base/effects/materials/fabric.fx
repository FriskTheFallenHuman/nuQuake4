effect effects/materials/fabric
{
	size	94

	sound "sound"
	{
		soundShader	"effects_bulletimpact_dirt"
	}
	decal "mark"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/fabric"

			start
			{
				size { point 2,2 }
				rotate { point 0.180556 }
			}
		}
	}
	spawner "dust"
	{
		start		0.12,0.12
		count		1,1

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/smoke_alpha"

			start
			{
				position { point 5,0,0 }
				velocity { box 3,-2,-2,5,2,2 }
				fade { point 0 }
				rotate { box 0.32,0.1 }
			}

			motion
			{
				size { envelope pop_hold_grow }
				fade { envelope pop_fade }
				rotate { envelope linear }
			}

			end
			{
				size { point 15,15 }
				fade { point 1 }
			}
		}
	}
	spawner "dust2"
	{
		start		0.12,0.12
		count		1,1

		sprite
		{
			duration	1,1.5
			material	"gfx/effects/smoke/smoke_alpha"

			start
			{
				position { point 5,0,0 }
				velocity { box 10,-20,-20,20,20,20 }
				friction { box -200,0,0,-50,0,0 }
				size { point 10,10 }
				fade { point 0 }
				rotate { box 0.32,0.1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope pop_fade }
				rotate { envelope linear }
			}

			end
			{
				size { point 50,50 }
				fade { point 0.5 }
			}
		}
	}
}


