effect effects/ambient/road_flare
{
	size	52

	emitter "flare"
	{
		duration	1,1
		count		4,4
		locked
		attenuateEmitter
		attenuation	0,2048

		line
		{
			duration	1,1.12
			blend	add
			material	"gfx/effects/fire/fireline1"

			start
			{
				position { point -0.4,0,0 }
				size { point 0.5 }
				tint { point 1,0.439216,0.25098 }
				length { point 6,0,0 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope ember1 offset 0.5,0.5,0.5 }
				fade { envelope ember1 offset 0.5 }
				length { envelope ember1 }
			}

			end
			{
				size { point 4 }
				tint { point 0.882353,0.65098,0.623529 }
				fade { point 0.5 }
				length { point 15,0,0 }
			}
		}
	}
	emitter "sparks_lines"
	{
		duration	1,1
		count		15,20
		attenuateEmitter
		attenuation	0,2048

		line
		{
			duration	0.2,0.2
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2"
			gravity		0.25,0.5
			generatedOriginNormal

			start
			{
				position { cylinder 0.4,-0.1,-0.1,0.4,0.1,0.1 }
				velocity { box 50,0,0,200,0,0 }
				size { box 0.5,1 }
				tint { line 1,0.984314,0.831373,1,0.701961,0.364706 }
				length { box 2,0,0,4,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope exp_x2 }
			}

			end
			{
				size { point 0 }
			}
		}
	}
	emitter "unnamed2"
	{
		duration	1,1
		count		10,10
		attenuateEmitter
		attenuation	0,2048

		sprite
		{
			duration	0.2,0.2
			material	"gfx/effects/energy_sparks/spark3"

			start
			{
				velocity { box 0,-2,-2,50,2,2 }
				size { point 5,5 }
				tint { point 0.996078,0.356863,0.145098 }
			}

			motion
			{
				size { envelope linear }
			}

			end
			{
				size { point 10,10 }
			}
		}
	}
	emitter "steam1"
	{
		duration	1,1
		count		5,5
		attenuateEmitter
		attenuation	0,2048

		sprite
		{
			duration	2.5,3.5
			material	"gfx/effects/smoke/cloud_alpha_depth"
			gravity		-0.03,-0.03

			start
			{
				position { point 5,0,0 }
				velocity { box 0,-1.5,-1.5,0,1.5,1.5 }
				angle { box 0,0,0,0.222222,0.222222,0.222222 }
				size { box 10,10,15,15 }
				tint { line 0.984314,0.337255,0.176471,0.870588,0.027451,0.027451 }
				fade { point 0 }
				offset { box -3,-3,-3,3,3,3 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope fastinslowout }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 25,25,30,30 }
				fade { point 0.35 }
				angle { box -0.222222,-0.222222,-0.222222,0.222222,0.222222,0.222222 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	sound "unnamed4"
	{
		soundShader	"effects_flare"
	}
}






