effect effects/ambient/grinder
{
	size	299

	spawner "splat"
	{
		count		5,5

		sprite
		{
			duration	0.12,0.12
			material	"textures/decals/dsplat2"
			generatedOriginNormal

			start
			{
				position { cylinder -1,-1,-1,1,1,1 }
				velocity { point 5000,0,0 }
				size { point 25,25 }
				rotate { line 0,1 }
			}

			impact
			{
				bounce	0
				effect	"effects/monsters/gib_splat"
			}
		}
	}
	emitter "blood_rear"
	{
		duration	1,1
		count		15,15

		sprite
		{
			duration	0.7,1
			persist
			material	"gfx/effects/gore_spray/bloodhit3"

			start
			{
				position { point 0,0,0 linearSpacing }
				velocity { box 0,-80,-80,0,80,80 }
				size { line 50,50,60,60 }
				tint { line 0.4,0,0,0.156863,0,0 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { line 100,100,140,140 }
				fade { point 1 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	emitter "blood2"
	{
		duration	1,1
		count		15,15

		sprite
		{
			duration	0.5,1
			persist
			material	"gfx/effects/gore_spray/bloodhit4"
			gravity		0.05,0.05

			start
			{
				position { point 0,0,0 linearSpacing }
				velocity { box 0,0,0,200,0,0 }
				size { line 20,20,30,30 }
				tint { line 0.470588,0.0627451,0.0627451,0.156863,0,0 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { line 100,100,140,140 }
				fade { point 1 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	emitter "blood"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	0.5,1
			persist
			material	"gfx/effects/gore_spray/bloodhit4"
			gravity		0.05,0.05

			start
			{
				position { point 0,0,0 linearSpacing }
				velocity { box 0,-10,-10,80,10,10 }
				size { line 50,50,60,60 }
				tint { line 0.462745,0.054902,0.054902,0.156863,0,0 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { line 100,100,140,140 }
				fade { point 1 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	sound "unnamed4"
	{
		soundShader	"effects_gib_grinder"
	}
}

