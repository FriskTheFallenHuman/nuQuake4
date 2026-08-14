effect effects/monsters/heavy_tank/impact
{
	size	259

	sound "sound"
	{
		soundShader	"effects_barrel_explode"
		volume	10,10
	}
	decal "scorch3"
	{

		decal
		{
			duration	0.002,0.002
			material	"textures/decals/rocketburn"

			start
			{
				size { point 50,50 }
				rotate { box 0,1 }
			}
		}
	}
	spawner "lightsmoke2"
	{
		detail		0.5
		start		0.2,0.2
		count		4,4

		sprite
		{
			duration	0.8,1.2
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.02,-0.02

			start
			{
				position { sphere 0,-50,-50,80,50,50 linearSpacing }
				velocity { box 0,50,50,0,-50,-50 }
				size { box 50,50,90,90 }
				tint { point 0.380392,0.509804,0.521569 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "cosine" }
				rotate { envelope "linear" }
			}

			end
			{
				tint { point 0.133333,0.160784,0.168627 }
				fade { point 0.6 }
				rotate { box -0.277778,0.277778 relative }
			}
		}
	}
	spawner "sparks_lines2"
	{
		detail		0.5
		count		9,12
		locked

		line
		{
			duration	0.15,0.15
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.1,-0.1,-0.1,-0.1,0.1,0.1 surface }
				velocity { point 1,0,0 }
				size { box 6,16 }
				tint { line 0.701961,0.92549,1,0.211765,0.47451,0.737255 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "exp_x2" }
				length { envelope "linear" }
			}

			end
			{
				tint { line 0.533333,0.678431,0.94902,0.54902,0.666667,0.933333 }
				length { box 120,0,0,140,0,0 }
			}
		}
	}
	spawner "fire2"
	{
		detail		0.5
		count		4,4

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/fire/fire2b"
			generatedOriginNormal

			start
			{
				position { cylinder 0.1,-0.1,-0.1,0.1,0.1,0.1 surface linearSpacing }
				velocity { box 80,0,0,120,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 40,40,50,50 }
				tint { point 0.67451,0.745098,0.603922 }
				offset { box -2,-2,-2,2,2,2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "exp_x2" }
				fade { envelope "linear" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 120,120,150,150 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	spawner "fire3"
	{
		count		4,4

		sprite
		{
			duration	0.35,0.35
			material	"gfx/effects/fire/fire5b"

			start
			{
				position { line 0,0,0,50,0,0 linearSpacing }
				velocity { box 80,0,0,120,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 40,40,50,50 }
				tint { point 0.67451,0.772549,0.627451 }
				offset { box -2,-2,-2,2,2,2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "exp_x2" }
				fade { envelope "linear" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 120,120,150,150 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	spawner "flash3"
	{
		count		1,1

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/weapons/flash_blue"
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { line 140,140,160,160 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 40,40 }
			}
		}
	}
}




