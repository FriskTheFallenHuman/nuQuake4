effect effects/vehicles/mship/thrust
{
	size	849

	emitter "smoke"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	1,1
			blend	add
			persist
			material	"gfx/effects/weapons/plasma1"

			start
			{
				position { cylinder 0.2,-0.1,-0.1,0.2,0.1,0.1 }
				size { point 200,200 }
				tint { line 0.721569,0.803922,0.803922,0.294118,0.419608,0.419608 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 400,400,600,600 }
				tint { point 0.556863,0.588235,0.607843 }
				fade { point 0.25 }
				rotate { box -0.333333,0.333333 relative }
			}
		}
	}
	sound "unnamed1"
	{
		soundShader	"mcc_landing_thruster"
		freqshift	0.5,0.5
	}
	sound "unnamed2"
	{
		soundShader	"mcc_landing_thruster"
	}
}




