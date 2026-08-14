effect effects/weapons/railgun/impact_default_mp
{
	size	277

	sound "sound"
	{
		soundShader	"weapon_railgun_impact"
	}
	decal "wall mark"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/railgun_impact_mp"

			start
			{
				size { point 12,0 }
				rotate { box 0,1 }
			}
		}
	}
	spawner "embers"
	{
		detail		0.5
		count		10,10

		sprite
		{
			duration	0.5,1
			material	"gfx/effects/energy_sparks/spark3"
			gravity		0.5,0.75
			generatedOriginNormal

			start
			{
				position { sphere 1,-10,-10,1,10,10 }
				velocity { box 250,-200,-200,200,200,200 }
				size { point 6,6 }
				rotate { box 0.251,-0.25 }
			}

			motion
			{
				size { envelope "random" }
				tint { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 10,10 }
			}
		}
	}
	spawner "side_impact_streaks"
	{
		count		7,7
		locked

		line
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/weapons/blaster_impact3"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.3,-0.3,-0.2,0.3,0.3 surface }
				size { box 6,8 }
				length { box 30,0,0,35,0,0 }
			}

			motion
			{
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				length { point 15,0,0 }
			}
		}
	}
	spawner "sparks_lines"
	{
		count		5,5
		locked

		line
		{
			duration	0.4,0.4
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.1,-0.1,-0.1,-0.1,0.1,0.1 surface }
				velocity { box 25,0,0,200,0,0 }
				size { box 3,5 }
				length { box 15,0,0,20,0,0 }
			}

			motion
			{
				size { envelope "linear" }
			}

			end
			{
				size { point 0 }
			}
		}
	}
	spawner "heat_mark"
	{
		detail		0.5
		count		1,1

		oriented
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/energy_sparks/launch_flash3_grey"

			start
			{
				position { point 0.1,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "exp_x2" }
			}

			end
			{
				size { point 100,100 }
			}
		}
	}
	emitter "smoke"
	{
		detail		0.5
		duration	0.2,0.2
		count		6,6

		sprite
		{
			duration	1,1.5
			blend	add
			material	"gfx/effects/energy_sparks/energy1_grey"
			gravity		-0.02,-0.02

			start
			{
				position { point 5,0,0 }
				velocity { box 0,-1,-1,5,1,1 }
				size { line 2,2,5,5 }
				fade { point 0.4 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "exp_x2" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 40,40,60,60 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
}





