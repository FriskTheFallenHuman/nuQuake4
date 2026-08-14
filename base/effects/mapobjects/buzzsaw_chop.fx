effect effects/mapobjects/buzzsaw_chop
{
	size	251

	emitter "blood2"
	{
		duration	1,1
		count		4,8

		sprite
		{
			duration	0.6,0.8
			material	"gfx/effects/gore_spray/bloodhit2"

			start
			{
				position { sphere 0,-1,-1,0,1,1 surface linearSpacing }
				velocity { box 100,-20,-20,150,20,20 }
				size { line 1,3,2,4 }
				tint { line 0.768628,0.109804,0.109804,0.541176,0.0352941,0.0352941 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
			}

			end
			{
				size { line 30,30,50,50 }
				fade { point 1 }
			}
		}
	}
	emitter "blood_streaks"
	{
		duration	1,1
		count		5,6
		locked

		line
		{
			duration	1,1
			generatedLine
			material	"gfx/effects/gore_spray/bloodline1"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.3,-0.3,-0.2,0.3,0.3 }
				velocity { point 1,0,0 }
				size { box 20,50 }
				tint { line 0.490196,0,0,0.94902,0,0 }
				length { box 10,0,0,15,0,0 }
			}

			motion
			{
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				length { box 100,0,0,120,0,0 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
	emitter "mflash2"
	{
		duration	1,1
		count		10,10
		locked

		line
		{
			duration	0.75,0.75
			material	"gfx/effects/fluids_drips/blood_spit_alpha"
			generatedNormal

			start
			{
				position { cylinder -0.2,-0.3,-0.3,-0.2,0.3,0.3 }
				size { box 1,5 }
				tint { line 1,1,1,0.501961,0,0 }
				length { point 3,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { point 30 }
				length { box 80,0,0,100,0,0 }
			}
		}
	}
	emitter "blood_streaks2"
	{
		duration	1,1
		count		5,6
		locked

		line
		{
			duration	1,1
			generatedLine
			material	"gfx/effects/gore_spray/bloodline1"
			generatedNormal

			start
			{
				position { cylinder -0.2,-0.3,-0.3,-0.2,0.3,0.3 }
				size { box 30,50 }
				tint { line 0.490196,0,0,0.94902,0,0 }
				length { box 10,0,0,15,0,0 }
			}

			motion
			{
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				length { box 100,0,0,200,0,0 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
	emitter "steam1"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	1.5,1.5
			persist
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.0125,-0.0125

			start
			{
				position { point 0,0,0 cone }
				velocity { box 5,-5,-5,5,5,5 }
				angle { box 0,0,0,1,0,1 }
				size { box 20,20,30,30 }
				tint { line 1,1,1,0.501961,0,0 }
				fade { point 0.35 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				angle { envelope exp_x2 }
				rotate { envelope linear }
			}

			end
			{
				size { line 50,50,80,80 }
				angle { box -0.5,0,-0.5,0.5,0,0.5 relative }
				rotate { point 0 relative }
			}
		}
	}
	shake "unnamed5"
	{
		duration	3,3
		scale		0.2
		attenuateEmitter
		attenuation	1,1
	}
	emitter "unnamed6"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	1,1
			gravity		0.5,0.5

			start
			{
				velocity { box 100,-100,-100,200,100,100 }
				size { point 0,0 }
			}

			impact
			{
				remove	1
				effect	"effects/wounds/blood_splat"
			}
		}
	}
	doubleVision "unnamed7"
	{
		duration	3,3
		scale		0.01
		attenuateEmitter
		attenuation	1,1
	}
}







