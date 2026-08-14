effect effects/monsters/cannon/cannon_impact_small
{
	size	33

	decal "decal"
	{

		decal
		{
			duration	0.002,0.002
			material	"textures/decals/bullethole"

			start
			{
				size { point 15,0 }
				rotate { box 0,1 }
			}
		}
	}
	sound "sound"
	{
		soundShader	"bullet_ricochet"
	}
	spawner "flash"
	{
		detail		0.5
		count		1,1

		sprite
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/weapons/flash"

			start
			{
				velocity { box 0,0,0,50,0,0 }
				size { point 20,20 }
				fade { point 0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
			}

			end
			{
				size { point 0,0 }
				fade { point 1 }
			}
		}
	}
	spawner "side_streaks"
	{
		count		5,5
		locked

		line
		{
			duration	0.2,0.2
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.3,-0.3,-0.2,0.3,0.3 surface }
				velocity { point 1,0,0 }
				size { box 1,3 }
				tint { line 1,0.921569,0.701961,0.74902,0.521569,0.203922 }
				fade { point 0 }
				length { point 10,0,0 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
				length { envelope "linear" }
			}

			end
			{
				tint { line 0.956863,0.658824,0.529412,0.956863,0.639216,0.529412 }
				fade { point 1 }
				length { box 3,0,0,6,0,0 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
}


