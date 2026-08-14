effect effects/smoke/air_defense_crash
{
	size	817

	emitter "closeSmoke"
	{
		duration	2,2
		count		4,4
		attenuateEmitter
		attenuation	500,1200

		sprite
		{
			duration	2,6
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.02,-0.01

			start
			{
				position { box 1200,-50,0,0,50,0 }
				velocity { box 0,0,5,0,0,20 }
				acceleration { box 0,-20,-20,0,0,0 }
				size { line 50,50,70,70 }
				tint { line 0.403922,0.403922,0.403922,0.0980392,0.0980392,0.0980392 }
				fade { line 0.15,0.25 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope costable }
				rotate { envelope linear }
			}

			end
			{
				size { point 150,150 }
				rotate { box -0.25,0.25 relative }
			}
		}
	}
	emitter "longSmoke"
	{
		duration	2,2
		count		4,4
		attenuateEmitter
		attenuation	500,1200

		sprite
		{
			duration	2,4
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.02,-0.01

			start
			{
				position { box 1200,-60,10,-900,60,30 }
				velocity { box 0,0,10,0,0,30 }
				acceleration { box 0,-30,-20,0,0,0 }
				size { line 50,50,75,75 }
				tint { line 0.403922,0.403922,0.403922,0.0980392,0.0980392,0.0980392 }
				fade { line 0.15,0.25 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope costable }
				rotate { envelope linear }
			}

			end
			{
				size { point 150,150 }
				rotate { box -0.25,0.25 relative }
			}
		}
	}
	emitter "shipSmoke"
	{
		duration	2,2
		count		2,2
		attenuateEmitter
		attenuation	500,1200

		sprite
		{
			duration	3,4
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.02,-0.01

			start
			{
				position { box 1250,-20,50,650,20,100 }
				velocity { box 0,0,5,0,0,20 }
				acceleration { box 0,-20,-20,0,0,0 }
				size { line 40,40,60,60 }
				tint { line 0.403922,0.403922,0.403922,0.0980392,0.0980392,0.0980392 }
				fade { line 0.2,0.3 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope costable }
				rotate { envelope linear }
			}

			end
			{
				size { point 100,100 }
				rotate { box -0.25,0.25 relative }
			}
		}
	}
}
