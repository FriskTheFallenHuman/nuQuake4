effect effects/monsters/gladiator/destroy_arm_trail
{
	size	132

	emitter "smoke"
	{
		duration	1,3
		count		10,10

		sprite
		{
			duration	1.5,2
			persist
			material	"gfx/effects/smoke/smoke_alpha"
			gravity		-0.05,-0.025

			start
			{
				position { box 0,-2,-2,30,2,2 }
				velocity { box -5,-5,-5,5,5,5 }
				size { line 20,20,25,25 }
				tint { line 0.239216,0.219608,0.176471,0.537255,0.521569,0.439216 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
			}

			end
			{
				size { line 45,45,60,60 }
				fade { point 1 }
			}
		}
	}
	spawner "sparks_lines"
	{
		detail		0.5
		start		0,0.1
		count		10,20

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
				velocity { box -20,-100,-20,20,100,20 }
				size { box 1,2 }
				tint { line 0.501961,1,1,0.4,0.54902,0.839216 }
				length { box 2,0,0,8,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
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
			jitterTable	"halfsintable"
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
				size { envelope "linear" }
				tint { envelope "popoverextreme_hold_fade" }
				length { envelope "exp_1minusx/x2" }
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
				size { envelope "arch" }
			}

			end
			{
				size { point 40,40 }
			}
		}
	}
	delay "unnamed6"
	{
		duration	0.5,0.5
	}
}



