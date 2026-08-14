effect effects/levels/convoy/doorcharge
{
	size	1419

	sound "sound"
	{
		soundShader	"effects_explosion_metal"
	}
	shake "camerashake"
	{
		duration	0.7,0.7
		scale		1
		attenuateEmitter
		attenuation	200,600
	}
	emitter "smoke"
	{
		duration	0.1,0.1
		count		200,200

		sprite
		{
			duration	3,4
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.02,-0.02

			start
			{
				position { box 0,-128,-64,600,128,64 linearSpacing }
				velocity { box 50,0,0,100,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { point 150,150 }
				tint { line 0.258824,0.254902,0.207843,0.180392,0.180392,0.180392 }
				offset { box -2,-2,-2,2,2,2 }
				rotate { box 0,1 }
			}

			motion
			{
				tint { envelope linear }
				fade { envelope linear }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.277778,0.277778 relative }
			}
		}
	}
	emitter "dirt"
	{
		duration	0.1,0.1
		count		200,200

		sprite
		{
			duration	0.4,0.6
			material	"gfx/effects/particles_shapes/dirt3"
			gravity		0.5,0.5

			start
			{
				position { box 0,-128,-64,500,128,64 linearSpacing }
				velocity { box 1000,0,0,2000,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { point 100,100 }
				tint { line 0.364706,0.32549,0.27451,0,0,0 }
				offset { box -2,-2,-2,2,2,2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope exp_x2 }
				fade { envelope exp_x2 }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 450,450 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.277778,0.277778 relative }
			}
		}
	}
	emitter "sparks_lines"
	{
		duration	0.1,0.1
		count		200,200
		locked

		line
		{
			duration	0.2,0.2
			blend	add
			generatedLine
			material	"gfx/effects/weapons/flash_half3"

			start
			{
				position { box 0,-128,-64,0,128,64 }
				velocity { box 500,-50,-50,500,50,50 }
				size { point 100 }
				length { point 500,0,0 }
			}

			motion
			{
				fade { envelope exp_x2 }
				length { envelope linear }
			}

			end
			{
				length { box 800,0,0,1000,0,0 }
			}
		}
	}
	emitter "column_fire"
	{
		duration	0.1,0.1
		count		200,200

		sprite
		{
			duration	0.3,0.4
			material	"gfx/effects/fire/fire4a"

			start
			{
				position { box 0,-128,-64,500,128,64 linearSpacing }
				velocity { box 50,0,0,1000,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { point 100,100 }
				offset { box -2,-2,-2,2,2,2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope exp_x2 }
				tint { envelope exp_x2 }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 250,250 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.277778,0.277778 relative }
			}
		}
	}
}
