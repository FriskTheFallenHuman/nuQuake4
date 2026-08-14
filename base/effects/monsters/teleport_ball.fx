effect effects/monsters/teleport_ball
{
	size	163

	emitter "fuzz"
	{
		duration	1,1
		count		15,20

		sprite
		{
			duration	3,3
			blend	add
			material	"gfx/effects/weapons/plasma1"
			generatedNormal

			start
			{
				position { sphere 0,-1,-1,0,1,1 }
				angle { box -0.5,-0.5,-0.5,0.5,0.5,0.5 }
				size { point 0,0 }
				tint { line 1,1,1,0.501961,1,0.501961 }
				fade { line 0.5,1 }
				offset { box -20,-20,-20,20,20,20 }
				rotate { box 0,0.5 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 70,70,90,90 }
			}
		}
	}
	emitter "electricity2"
	{
		detail		0.3
		duration	1,1
		count		10,20

		electricity
		{
			duration	0.25,0.25
			blend	add
			fork	0
			jitterRate	0
			jitterSize	3,7,7
			jitterTable	"halfsintable"
			material	"gfx/effects/energy_sparks/energy1"
			generatedOriginNormal

			start
			{
				position { cylinder 0.35,-1,-1,0.35,1,1 }
				size { box 0.25,2 }
				tint { line 1,1,1,0.4,0.54902,0.839216 }
				fade { line 0.5,0.75 }
				length { box 100,0,0,150,0,0 }
			}

			motion
			{
				length { envelope "linear" }
			}

			end
			{
				length { box 10,0,0,120,0,0 }
			}
		}
	}
	sound "unnamed2"
	{
		soundShader	"effects_arc_loop"
		volume	0.3,0.3
		freqshift	1.5,1.5
	}
	sound "unnamed3"
	{
		soundShader	"effects_teleport_ball"
		volume	0.5,0.5
	}
}





