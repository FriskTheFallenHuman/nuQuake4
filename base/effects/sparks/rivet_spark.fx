effect effects/sparks/rivet_spark
{
	size	159

	light "light"
	{
		locked

		light
		{
			duration	0.12,0.12
			material	"lights/defaultPointLight"

			start
			{
				position { point 10,0,0 }
				size { point 64,64,64 }
				tint { point 0,0,0 }
				fade { point 0.5 }
			}

			motion
			{
				tint { envelope pop_fade }
			}

			end
			{
				tint { point 0.890196,0.780392,0.607843 }
			}
		}
	}
	spawner "sparks_lines"
	{
		start		0,0.1
		count		10,20

		line
		{
			duration	0.3,0.8
			generatedLine
			persist
			material	"gfx/effects/energy_sparks/spark_line2"
			gravity		0.3,0.5

			start
			{
				position { box 2,-1,-1,0,1,1 cone }
				velocity { box 10,-200,-200,300,200,200 }
				size { box 4,3 }
				tint { line 0.917647,0.901961,0.709804,1,1,0.768628 }
				length { box 8,0,0,10,0,0 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
			}

			end
			{
				size { point 0.5 }
				tint { point 1,0.701961,0 }
			}
		}
	}
	spawner "glow"
	{
		count		2,2

		sprite
		{
			duration	0.1,0.1
			material	"gfx/effects/weapons/mgun_muzzleflash"

			start
			{
				rotate { box 0,0.125 }
			}

			motion
			{
				size { envelope arch }
			}

			end
			{
				size { point 40,40 }
			}
		}
	}
	emitter "delayed_smoke"
	{
		duration	1,1
		count		5,10

		sprite
		{
			duration	1,1
			persist
			material	"gfx/effects/smoke/impact_smoke3"
			gravity		-0.015,-0.015

			start
			{
				velocity { box 5,-2,-2,10,2,2 }
				size { point 3,3 }
				tint { point 0.74902,0.74902,0.74902 }
				rotate { box 0,0.111111 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 20,20,10,10 }
				rotate { box 0.111111,0.222222 relative }
			}
		}
	}
	sound "unnamed4"
	{
		soundShader	"effects_sparks02"
	}
}

