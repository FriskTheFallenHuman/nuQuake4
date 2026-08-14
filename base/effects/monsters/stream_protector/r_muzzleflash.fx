effect effects/monsters/stream_protector/r_muzzleflash
{
	size	130

	spawner "smoke"
	{
		count		8,8

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/cloud_alpha"
			generatedNormal

			start
			{
				position { box -5,-5,-5,5,5,5 }
				velocity { box 20,-10,-10,30,10,10 }
				angle { box 0,0,0.0833333,0,0,0.166667 }
				size { line 10,10,15,15 }
				tint { line 0.54902,0.54902,0.54902,0.294118,0.294118,0.294118 }
				fade { point 0.5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "fire_smokefade" count 2,2,2 }
				fade { envelope "linear" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 30,30,50,50 }
				tint { line 0.164706,0.164706,0.164706,0.211765,0.211765,0.211765 }
				angle { point 0,0,0.222222 relative }
				rotate { box -0.333333,0.333333 relative }
			}
		}
	}
	spawner "flash_close"
	{
		count		1,1
		locked

		sprite
		{
			duration	0.18,0.18
			material	"gfx/effects/weapons/shotgun_mflash"

			start
			{
				position { point 1,0,0 }
				size { point 0,0 }
				tint { point 0,0,0 }
				rotate { box 1,2 }
			}

			motion
			{
				size { envelope "fastinslowout" }
				tint { envelope "fastinslowout" }
				rotate { envelope "random" }
			}

			end
			{
				size { point 30,30 }
				tint { point 1,1,1 }
			}
		}
	}
	spawner "flash2"
	{
		count		2,2
		locked

		sprite
		{
			duration	0.12,0.12
			blend	add
			material	"gfx/effects/weapons/mgun_muzzleflash"

			start
			{
				size { line 10,10,20,20 }
				fade { point 0.9 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { line 10,10,15,15 }
			}
		}
	}
	spawner "sparks_lines"
	{
		count		4,4

		line
		{
			duration	0.35,0.5
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2"
			gravity		0.05,0.19
			generatedOriginNormal

			start
			{
				position { cylinder -0.35,-0.1,-0.1,-0.35,0.1,0.1 surface }
				velocity { box 150,0,0,325,0,0 }
				size { box 2.5,3 }
				tint { line 1,0.941176,0.8,0.94902,0.941176,0.839216 }
				length { box 5,0,0,9,0,0 }
			}

			motion
			{
				size { envelope "linear" count 1.2 offset -0.2 }
				tint { envelope "linear" count 1.2,1.2,1.2 offset -0.2,-0.2,-0.2 }
				length { envelope "arch" }
			}

			end
			{
				size { point 0 }
				tint { line 0.858824,0.729412,0.309804,0.847059,0.564706,0.313726 }
				length { point 10,0,0 }
			}
		}
	}
	spawner "single_streak"
	{
		count		2,2
		locked

		line
		{
			duration	0.06,0.06
			blend	add
			material	"gfx/effects/weapons/flash_half3"

			start
			{
				position { point -2,0,0 }
				size { point 10 }
				length { box 50,0,0,60,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { point 10 }
				length { box 30,0,0,40,0,0 }
			}
		}
	}
	light "unnamed5"
	{

		light
		{
			duration	0.1,0.1
			blend	add
			material	"lights/ambientLight"

			start
			{
				size { point 75,75,75 }
				tint { point 0.490196,0.392157,0.0823529 }
				fade { point 0 }
			}

			motion
			{
				fade { envelope "fastinslowout" }
			}

			end
			{
				fade { point 1 }
			}
		}
	}
	spawner "sparks_lines2"
	{
		count		2,2

		line
		{
			duration	0.2,0.3
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2"
			gravity		0.1,0.3
			generatedNormal

			start
			{
				position { sphere -0.35,-0.1,-0.1,-0.35,0.1,0.1 }
				velocity { box 50,0,0,100,0,0 }
				size { box 1,2 }
				tint { line 1,0.941176,0.8,0.94902,0.941176,0.839216 }
				length { box 9,0,0,20,0,0 }
			}

			motion
			{
				size { envelope "linear" count 1.2 offset -0.2 }
				tint { envelope "linear" count 1.2,1.2,1.2 offset -0.2,-0.2,-0.2 }
			}

			end
			{
				size { point 0 }
				tint { line 0.858824,0.729412,0.309804,0.847059,0.564706,0.313726 }
			}
		}
	}
}
