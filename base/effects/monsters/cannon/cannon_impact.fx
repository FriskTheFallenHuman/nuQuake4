effect effects/monsters/cannon/cannon_impact
{
	size	134

	decal "scorch"
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
	spawner "dust"
	{
		detail		0.5
		start		0.12,0.12
		count		3,4

		sprite
		{
			duration	0.5,1
			material	"gfx/effects/smoke/smoke_alpha"
			gravity		0.02,0.05

			start
			{
				position { cylinder 0,-100,-100,0,100,100 }
				velocity { box 20,-20,-20,50,20,20 }
				size { point 2,2 }
				tint { line 0.721569,0.686275,0.556863,0.419608,0.364706,0.258824 }
				fade { point 0 }
				rotate { box 0,0.25 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 30,30 }
				fade { point 1 }
				rotate { box 0.125,0 }
			}
		}
	}
	sound "sound"
	{
		soundShader	"bullet_ricochet"
	}
	spawner "flash"
	{
		count		1,1

		sprite
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/weapons/flash"

			start
			{
				velocity { box 0,-50,-50,100,50,50 }
				size { point 40,40 }
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
				size { box 3,5 }
				tint { line 1,0.921569,0.701961,0.74902,0.521569,0.203922 }
				fade { point 0 }
				length { point 20,0,0 }
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
				length { box 5,0,0,10,0,0 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
}











