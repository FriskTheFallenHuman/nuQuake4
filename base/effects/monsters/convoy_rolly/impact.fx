effect effects/monsters/convoy_rolly/impact
{
	size	63

	sound "unnamed0"
	{
		soundShader	"bullet_impact_metal"
	}
	decal "decal2"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/railgun_impact1"

			start
			{
				size { line 4,0,7,0 }
				rotate { box 0,1 }
			}
		}
	}
	spawner "impact_flash2"
	{
		count		2,2

		sprite
		{
			duration	0.16,0.16
			blend	add
			material	"gfx/effects/weapons/flash_green"
			generatedNormal

			start
			{
				size { box 20,20,30,30 }
				tint { point 0.890196,0.341176,0.341176 }
			}

			motion
			{
				size { envelope "linear" }
			}
		}
	}
	spawner "side_impact_streaks2"
	{
		count		6,8
		locked

		line
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/weapons/blaster_fly_redflipped"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.3,-0.3,-0.2,0.3,0.3 surface }
				size { box 2,3 }
				tint { line 1,1,1,0.4,0.411765,0.866667 }
				length { box 10,0,0,20,0,0 }
			}

			motion
			{
				fade { envelope "linear" }
			}
		}
	}
	emitter "smoke2"
	{
		duration	0.35,0.35
		count		10,10

		sprite
		{
			duration	0.5,0.7
			blend	add
			material	"gfx/effects/weapons/plasma1"
			gravity		-0.05,-0.05

			start
			{
				position { line 0,0,0,10,0,0 }
				velocity { box 0,-5,-5,20,5,5 }
				size { line 4,4,10,10 }
				tint { line 1,0.356863,0.2,1,0.717647,0.333333 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 20,20,35,35 }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
}


