effect effects/explosions/air/airburst_01_small
{
	size	425

	spawner "dust"
	{
		start		0.1,0.1
		count		6,6

		sprite
		{
			duration	0.4,0.4
			material	"gfx/effects/smoke/cloud_alpha"
			generatedOriginNormal

			start
			{
				position { sphere -50,-50,-50,50,50,50 }
				velocity { box -120,-120,-120,120,120,120 }
				size { line 50,50,60,60 }
				tint { point 0.309804,0.305882,0.258824 }
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
				size { line 80,80,100,100 }
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
				velocity { box 100,-200,-200,200,200,200 }
				size { point 100,100 }
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
				size { point 10,10 }
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
				size { point 300,300 }
				tint { point 0.74902,0.74902,0.74902 }
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
	spawner "sparks_lines"
	{
		count		10,15
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
				size { box 5,10 }
				tint { line 1,0.921569,0.701961,0.74902,0.521569,0.203922 }
				length { box 50,0,0,60,0,0 }
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
	spawner "flash3"
	{
		count		1,1

		sprite
		{
			duration	0.1,0.1
			material	"gfx/effects/weapons/mgun_muzzleflash"

			start
			{
				size { point 200,200 }
				tint { point 0.74902,0.74902,0.74902 }
				rotate { box -1,1 }
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
}

