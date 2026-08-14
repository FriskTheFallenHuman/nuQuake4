effect effects/weapons/machinegun/impact_fabric
{
	size	56

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
	spawner "dust2"
	{
		count		3,3

		sprite
		{
			duration	0.5,1
			material	"gfx/effects/smoke/smoke_alpha"

			start
			{
				velocity { box 5,-20,-20,10,20,20 }
				friction { box -200,0,0,-50,0,0 }
				size { point 0,0 }
				tint { point 0.901961,0.207843,0.207843 }
				fade { point 0 }
				rotate { box 0.32,0.1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope exp_1minusx/x2 }
				fade { envelope pop_fade }
				rotate { envelope linear }
			}

			end
			{
				size { point 30,30 }
				tint { point 1,1,1 }
				fade { point 0.5 }
			}
		}
	}
}

