effect effects/weapons/machinegun/impact_rubber
{
	size	11

	sound "sound"
	{
		soundShader	"bullet_ricochet"
	}
	decal "mark"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/nailgun_mark"

			start
			{
				size { line 2,2,2.5,2.5 }
				fade { point 0.5 }
				rotate { box 0,1 }
			}
		}
	}
	spawner "smoke"
	{
		count		5,5

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/smoke/smoke_alpha"

			start
			{
				velocity { box 3,-20,-20,3,20,20 }
				tint { line 0.384314,0.34902,0.258824,0.501961,0.501961,0.501961 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 5,5 }
			}
		}
	}
	spawner "flash"
	{
		count		3,3

		sprite
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/weapons/flash"
			generatedNormal

			start
			{
				size { line 1,1,3,3 }
				fade { point 0.6 }
			}

			motion
			{
				tint { envelope linear }
			}
		}
	}
}

