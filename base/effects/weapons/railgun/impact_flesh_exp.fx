effect effects/weapons/railgun/impact_flesh_exp
{
	size	50

	sound "sound"
	{
		soundShader	"weapon_railgun_impact"
	}
	decal "wall mark"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/railgun_decal"

			start
			{
				size { point 12,12 }
				rotate { box 0,1 }
			}
		}
	}
	spawner "side_impact_streaks"
	{
		count		7,9
		locked

		line
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/weapons/blaster_impact3"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.3,-0.3,-0.2,0.3,0.3 surface }
				size { box 6,8 }
				length { box 15,0,0,25,0,0 }
			}

			motion
			{
				fade { envelope "linear" }
			}
		}
	}
	spawner "sparks_lines"
	{
		count		3,5
		locked

		line
		{
			duration	0.2,0.2
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.1,-0.1,-0.1,-0.1,0.1,0.1 surface }
				velocity { box 50,0,0,300,0,0 }
				size { box 1,3 }
				tint { point 0.658824,0.921569,0.627451 }
				length { box 15,0,0,20,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
			}

			end
			{
				size { point 0 }
				tint { point 0.247059,0.627451,0.294118 }
			}
		}
	}
}
