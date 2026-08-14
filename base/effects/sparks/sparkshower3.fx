effect effects/sparks/sparkshower3
{
	size	169

	light "light"
	{
		locked

		light
		{
			duration	0.12,0.12
			material	"lights/defaultPointLight"

			start
			{
				position { point 10,0,0 }
				size { point 64,64,64 }
				tint { point 0,0,0 }
				fade { point 0.5 }
			}

			motion
			{
				tint { envelope pop_fade }
			}

			end
			{
				tint { point 0.890196,0.780392,0.607843 }
			}
		}
	}
	spawner "sparks_lines"
	{
		start		0,0.1
		count		10,20

		line
		{
			duration	0.3,0.8
			generatedLine
			persist
			material	"gfx/effects/energy_sparks/spark_line2"
			gravity		0.3,0.5

			start
			{
				position { box 2,-1,-1,0,1,1 cone }
				velocity { box 80,-100,-80,195,100,160 }
				size { box 4,3 }
				tint { line 0.917647,0.901961,0.709804,1,1,0.768628 }
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
				tint { point 1,0.701961,0 }
			}
		}
	}
	emitter "electricty"
	{
		duration	1,1
		count		1,1

		electricity
		{
			duration	0.3,0.5
			fork	2
			jitterRate	0.1
			jitterSize	1,9,9
			material	"gfx/effects/electricity/electric_multicolor"

			start
			{
				size { box 24,16 }
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
				length { box 100,-25,-25,160,25,25 }
			}
		}
	}
	sound "sound"
	{
		soundShader	"effects_sparks02"
	}
	delay "delay"
	{
		duration	1,3
	}
	emitter "glow"
	{
		duration	1,1
		count		2,2

		sprite
		{
			duration	0.1,0.1
			material	"gfx/effects/energy_sparks/spark_line2"

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
				size { point 40,40 }
			}
		}
	}
}


