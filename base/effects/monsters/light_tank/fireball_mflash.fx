effect effects/monsters/light_tank/fireball_mflash
{
	size	152

	sound "sound"
	{
		soundShader	"lt_tank_fireball_burst"
		freqshift	1.5,1.5
	}
	spawner "smoke"
	{
		detail		0.5
		count		8,8

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/cloud_alpha3"
			generatedOriginNormal

			start
			{
				position { box 0,-5,-5,5,5,5 }
				velocity { box 20,-10,-10,30,10,10 }
				angle { box 0,0,0.0833333,0,0,0.166667 }
				size { line 10,10,15,15 }
				tint { line 0.466667,0.466667,0.466667,0.294118,0.294118,0.294118 }
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
				tint { point 0.690196,0.690196,0.690196 }
			}
		}
	}
	spawner "sparks_lines"
	{
		detail		0.5
		count		4,8

		line
		{
			duration	0.25,0.4
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2"
			gravity		0.01,0.05
			generatedOriginNormal

			start
			{
				position { cylinder 0.35,-0.1,-0.1,0.35,0.1,0.1 surface }
				velocity { box 100,0,0,400,0,0 }
				size { box 2,3 }
				tint { line 1,0.937255,0.8,0.94902,0.937255,0.839216 }
				length { box 2,0,0,5,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" offset 0.2,0.2,0.2 }
				fade { envelope "linear" }
			}

			end
			{
				size { point 0 }
				tint { line 0.858824,0.729412,0.309804,0.847059,0.564706,0.313726 }
			}
		}
	}
	spawner "single_streak"
	{
		count		1,1
		locked

		line
		{
			duration	0.06,0.06
			blend	add
			material	"gfx/effects/weapons/flash_half3"

			start
			{
				position { point -2,0,0 }
				size { point 15 }
				length { box 80,0,0,100,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { point 15 }
				length { box 30,0,0,40,0,0 }
			}
		}
	}
	spawner "flash3"
	{
		count		10,10
		locked

		sprite
		{
			duration	0.125,0.2
			blend	add
			material	"gfx/effects/fire/fire_plume_additive"

			start
			{
				velocity { box 100,-300,-300,100,300,300 }
				size { line 70,70,80,80 }
				fade { point 0.9 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 10,10,15,15 }
			}
		}
	}
}



