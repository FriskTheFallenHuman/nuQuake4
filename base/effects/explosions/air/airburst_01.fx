effect effects/explosions/air/airburst_01
{
	size	1415

	spawner "dust"
	{
		start		0.2,0.2
		count		6,6

		sprite
		{
			duration	0.4,0.4
			material	"gfx/effects/smoke/cloud_alpha"
			generatedOriginNormal

			start
			{
				position { sphere -500,-500,-500,500,500,500 }
				velocity { box -120,-120,-120,120,120,120 }
				size { box 300,300,400,400 }
				tint { point 0.415686,0.407843,0.34902 }
				fade { point 0 }
				rotate { box 0,0.25 }
			}

			motion
			{
				size { envelope exp_1minusx/x2 }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { box 400,400,500,500 }
				fade { point 0.5 }
				rotate { point 0.125 }
			}
		}
	}
	sound "sound"
	{
		soundShader	"effects_explosion_nodebris"
	}
	spawner "flash2"
	{
		count		5,5

		sprite
		{
			duration	0.3,0.5
			blend	add
			material	"gfx/effects/fire/impact_fire"

			start
			{
				position { point 1,0,0 }
				velocity { box 200,-400,-400,600,400,400 }
				size { point 500,500 }
				tint { point 0.752941,0.752941,0.752941 }
				fade { point 0.5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 100,100 }
			}
		}
	}
	spawner "flash"
	{
		count		1,1

		sprite
		{
			duration	0.1,0.1
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				size { point 1000,1000 }
				tint { point 0.74902,0.74902,0.74902 }
			}

			motion
			{
				size { envelope linear }
			}

			end
			{
				size { point 110,110 }
			}
		}
	}
	spawner "sparks_lines"
	{
		count		30,40
		locked

		line
		{
			duration	0.1,0.2
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2"
			generatedOriginNormal
			flipNormal

			start
			{
				position { sphere -0.1,-0.1,-0.1,0.1,0.1,0.1 surface cone }
				velocity { box 200,0,0,400,0,0 }
				size { box 5,60 }
				tint { line 1,0.921569,0.701961,0.74902,0.521569,0.203922 }
				length { box 200,0,0,400,0,0 }
			}

			motion
			{
				tint { envelope linear }
				fade { envelope exp_x2 }
			}

			end
			{
				tint { line 0.956863,0.658824,0.529412,0.956863,0.639216,0.529412 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
	shake "unnamed5"
	{
		duration	1,1
		scale		1
		attenuateEmitter
		attenuation	100,500
	}
}





