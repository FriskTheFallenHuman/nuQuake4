effect effects/monsters/turret/d_flash
{
	size	232

	sound "sound"
	{
		soundShader	"turret_convoy_fire"
	}
	emitter "smoke"
	{
		detail		0.5
		duration	1,1
		count		1,1

		sprite
		{
			duration	2,3
			material	"gfx/effects/smoke/smoke_dark"
			gravity		-0.06,-0.06
			generatedNormal

			start
			{
				velocity { box 0,-5,-5,15,5,5 }
				angle { box 0,0,0.0833333,0,0,0.166667 }
				size { line 2,2,4,4 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 60,60,80,80 }
				fade { point 0.6 }
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
				rotate { box 1,2 }
			}

			motion
			{
				size { envelope "fastinslowout" }
				rotate { envelope "random" }
			}

			end
			{
				size { point 80,80 }
			}
		}
	}
	spawner "side_streaks2"
	{
		detail		0.5
		count		5,5
		locked

		line
		{
			duration	0.16,0.16
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.3,-0.3,-0.2,0.3,0.3 surface }
				velocity { point 1,0,0 }
				size { box 10,15 }
				tint { line 1,0.921569,0.701961,0.74902,0.521569,0.203922 }
				length { box 60,0,0,70,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				length { envelope "linear" }
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
	sound "unnamed7"
	{
		soundShader	"turret_generic_fire"
	}
}









