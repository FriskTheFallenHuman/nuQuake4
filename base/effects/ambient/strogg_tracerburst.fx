effect effects/ambient/strogg_tracerburst
{
	size	63

	decal "decal"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/railgun_impact1"

			start
			{
				size { line 4,4,7,7 }
				rotate { box 0,1 }
			}
		}
	}
	spawner "impact_flash"
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
				tint { point 0.380392,0.392157,0.854902 }
			}

			motion
			{
				size { envelope "linear" }
			}
		}
	}
	spawner "side_impact_streaks"
	{
		count		6,8
		locked

		line
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/weapons/blaster_flyflipped"
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
	emitter "smoke"
	{
		duration	0.35,0.35
		count		15,15

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
				tint { line 0.443137,0.596078,1,1,1,1 }
				fade { point 0.6 }
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





