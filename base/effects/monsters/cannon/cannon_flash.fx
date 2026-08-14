effect effects/monsters/cannon/cannon_flash
{
	size	114

	spawner "flash_close2"
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
	spawner "side_streaks3"
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
}









