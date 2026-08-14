effect effects/sparks/rail_sparks
{
	size	30

	spawner "smoke puf"
	{
		count		5,5

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.025,-0.025

			start
			{
				position { cylinder 0,-1,-1,0,1,1 surface }
				velocity { box 10,-10,-10,10,10,10 }
				size { point 2,2 }
				tint { point 0.501961,0.501961,0.501961 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 10,10 }
			}
		}
	}
	spawner "main"
	{
		count		10,10

		sprite
		{
			duration	0.125,0.125
			material	"gfx/effects/energy_sparks/spark3"

			start
			{
				position { cylinder 0,-5,-5,0,5,5 surface }
				velocity { box -100,-100,-100,100,100,100 }
				size { line 2,2,5,5 }
			}

			motion
			{
				size { envelope linear }
			}

			end
			{
				size { point 0,0 }
			}
		}
	}
	spawner "lines"
	{
		count		5,5

		line
		{
			duration	0.25,0.25
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line3"
			gravity		1,1

			start
			{
				velocity { box 50,-100,-100,100,100,100 }
				tint { line 1,1,1,0.878431,0.847059,0.211765 }
				length { point 10,0,0 }
			}

			motion
			{
				tint { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}
		}
	}
	emitter "core"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/energy_sparks/spark3"

			start
			{
				size { point 15,15 }
			}

			motion
			{
				size { envelope lightningflicker }
			}

			end
			{
				size { point 0,0 }
			}
		}
	}
	sound "unnamed4"
	{
		soundShader	"effects_sparks02_quiet"
	}
}

