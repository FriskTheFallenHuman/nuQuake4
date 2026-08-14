effect effects/monsters/iron_maiden/casket_break
{
	size	115

	spawner "sparks_lines"
	{
		start		0,0.1
		count		20,50

		line
		{
			duration	0.3,0.8
			generatedLine
			persist
			material	"gfx/effects/energy_sparks/spark_line2"
			gravity		0.3,0.5
			generatedOriginNormal

			start
			{
				position { cylinder 2,-1,-1,0,1,1 surface }
				velocity { box -20,-100,-100,20,100,100 }
				size { box 1,2 }
				tint { line 0.501961,1,1,0.4,0.54902,0.839216 }
				length { box 2,0,0,8,0,0 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
			}

			end
			{
				size { point 0.5 }
				tint { point 0.501961,0.501961,1 }
			}
		}
	}
	emitter "electricty"
	{
		duration	1,1
		count		2,2

		electricity
		{
			duration	0.3,0.5
			fork	0
			jitterRate	0.1
			jitterSize	1,9,9
			persist
			material	"gfx/effects/electricity/electric"

			start
			{
				size { box 5,10 }
				tint { point 0,0,0 }
				length { box 1,-1,-1,2,1,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope popoverextreme_hold_fade }
				length { envelope exp_1minusx/x2 }
			}

			end
			{
				size { point 0.25 }
				tint { point 1,1,1 }
				length { box 5,-25,-25,10,25,25 }
			}
		}
	}
	sound "sound"
	{
		soundShader	"effects_sparks02"
	}
	spawner "glow"
	{
		count		2,2

		sprite
		{
			duration	0.1,0.1
			persist
			material	"gfx/effects/energy_sparks/spark_blue"

			start
			{
				position { point 3,0,0 }
				tint { point 0.929412,0.643137,1 }
				rotate { box 0,0.125 }
			}

			motion
			{
				size { envelope arch }
			}

			end
			{
				size { point 80,80 }
			}
		}
	}
	delay "unnamed6"
	{
		duration	0.5,0.5
	}
	spawner "electricty2"
	{
		count		5,5

		electricity
		{
			duration	0.3,0.5
			fork	0
			jitterRate	0.1
			jitterSize	1,9,9
			persist
			material	"gfx/effects/electricity/electric"

			start
			{
				size { box 5,10 }
				tint { point 0,0,0 }
				length { box 1,-1,-1,2,1,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope popoverextreme_hold_fade }
				length { envelope exp_1minusx/x2 }
			}

			end
			{
				size { point 0.25 }
				tint { point 1,1,1 }
				length { box 5,-25,-25,10,25,25 }
			}
		}
	}
}
