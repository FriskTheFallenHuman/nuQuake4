effect effects/weapons/hyperblaster/bounce_default
{
	size	37

	sound "sound"
	{
		soundShader	"effects_blaster_hit01"
	}
	decal "wall_mark"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/blaster_wall_mark3"

			start
			{
				size { point 12,12 }
				rotate { box 0,1 }
			}
		}
	}
	spawner "impact_flash"
	{
		detail		0.5
		count		1,1

		sprite
		{
			duration	0.14,0.14
			blend	add
			material	"gfx/effects/energy_sparks/spark_blue"
			generatedNormal

			start
			{
				position { point 2,0,0 }
				size { point 20,20 }
			}

			motion
			{
				fade { envelope "linear" }
			}
		}
	}
	spawner "side_impact_streaks"
	{
		count		4,6
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
				size { point 2.5 }
				length { box 6,0,0,10,0,0 }
			}

			motion
			{
				fade { envelope "linear" }
			}
		}
	}
	spawner "smoke"
	{
		detail		0.5
		start		0.06,0.06
		count		4,6

		sprite
		{
			duration	0.5,1
			material	"gfx/effects/smoke/impact_smoke3"
			gravity		0.05,0.05

			start
			{
				velocity { box 30,-5,-5,50,5,5 }
				acceleration { box -20,0,0,-40,0,0 }
				size { line 5,5,10,10 }
				tint { point 0.901961,0.992157,1 }
				fade { point 0.2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { line 1,1,3,3 }
				tint { point 0.576471,1,0.839216 }
			}
		}
	}
}



