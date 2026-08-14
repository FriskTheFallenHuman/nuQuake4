effect effects/levels/convoy/ob_explosion
{
	size	4293

	shake "camera"
	{
		duration	2,2
		attenuateEmitter
		attenuation	200,1024
	}
	sound "sound"
	{
		soundShader	"effects_explosion_nodebris"
	}
	sound "sound2"
	{
		soundShader	"effects_explosion_fiery"
	}
	spawner "debris"
	{
		count		5,5

		sprite
		{
			duration	3,3
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		-0.02,-0.01

			start
			{
				position { sphere -200,-250,-250,1000,250,250 }
				velocity { box 10,-10,-10,10,10,10 }
				size { box 200,200,300,300 }
				tint { point 0.282353,0.27451,0.215686 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 600,600,700,700 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "shockwave"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/energy_sparks/energy2"

			start
			{
				position { point 100,0,0 }
				size { point 200,200 }
				fade { point 0.5 }
				rotate { point 0,0,1111 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "exp_x2" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 3000,3000 }
			}
		}
	}
	spawner "fire"
	{
		count		5,5

		sprite
		{
			duration	0.3,0.4
			blend	add
			material	"gfx/effects/fire/fire4a"
			gravity		-4,-4

			start
			{
				position { sphere 0,-200,-200,0,200,200 }
				velocity { box 0,-200,-200,50,200,200 }
				size { point 800,800 }
				tint { point 0.552941,0.65098,0.811765 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 400,400 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "flash2"
	{
		count		1,1

		sprite
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/weapons/flash"

			start
			{
				position { point 50,0,0 }
				size { point 0,0 }
				tint { point 0.537255,0.654902,0.921569 }
				fade { point 0 }
			}

			motion
			{
				size { envelope "exp_1minusx/x2" count 0.6,0.6 }
				fade { envelope "decalfade" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 1000,1000 }
				fade { point 1 }
				rotate { point 0.25 }
			}
		}
	}
	spawner "sparks_lines4"
	{
		count		9,12
		locked

		line
		{
			duration	0.3,0.3
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.02,-0.1,-0.1,-0.1,0.1,0.1 surface }
				velocity { point 1,0,0 }
				size { box 60,80 }
				tint { line 0.807843,0.890196,0.87451,0.384314,0.505882,0.568627 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "exp_x2" }
				length { envelope "linear" }
			}

			end
			{
				tint { line 0.752941,0.796079,0.686275,0.811765,0.772549,0.670588 }
				length { box 800,0,0,850,0,0 }
			}
		}
	}
	spawner "sparks"
	{
		start		0.2,0.2
		count		15,15

		sprite
		{
			duration	0.5,1
			blend	add
			material	"gfx/effects/energy_sparks/spark_blue"

			start
			{
				position { sphere 0,-500,-500,500,500,500 }
				velocity { box 0,-50,-50,50,50,50 }
				angle { box 0,0,0,0.277778,0.277778,0.277778 }
				size { line 10,10,20,20 }
				tint { line 1,0.721569,0.309804,1,1,1 }
				offset { box -6,-6,-6,6,6,6 }
			}

			motion
			{
				fade { envelope "linear_flicker" }
				angle { envelope "linear" }
			}

			end
			{
				angle { box 0.277778,0.277778,0.277778,0.555556,0.555556,0.555556 relative }
			}
		}
	}
}





