effect effects/monsters/heavy_tank/muzzleflash
{
	size	284

	sound "sound"
	{
		soundShader	"vehicle_walker_rockets"
	}
	spawner "flash_close"
	{
		detail		0.5
		count		1,1
		locked

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/fire/fire_plume_additive"

			start
			{
				position { point 1,0,0 }
				size { point 200,200 }
				tint { point 0.176471,0.235294,0.635294 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 0,0 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "flash2"
	{
		detail		0.5
		count		2,2
		locked

		sprite
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/weapons/mgun_muzzleflash"

			start
			{
				size { point 40,40 }
				fade { point 0.9 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope "linear" }
			}
		}
	}
	spawner "sparks_lines2"
	{
		detail		0.5
		count		5,7
		locked

		line
		{
			duration	0.1,0.2
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2"
			generatedNormal

			start
			{
				position { sphere -0.1,-0.1,-0.1,-0.1,0.1,0.1 surface }
				velocity { box 100,0,0,200,0,0 }
				size { box 30,50 }
				tint { line 0.733333,0.796079,0.968628,0.647059,0.85098,0.960784 }
				fade { point 0.3 }
				length { point 1,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { point 0 }
				tint { point 0.803922,0.87451,1 }
				length { point 80,0,0 }
			}
		}
	}
	spawner "single_streak2"
	{
		count		1,1
		locked

		line
		{
			duration	0.16,0.16
			blend	add
			material	"gfx/effects/energy_sparks/spark_line2"

			start
			{
				position { point -2,0,0 }
				size { point 30 }
				tint { point 0.854902,0.486275,0.356863 }
				length { box 160,0,0,180,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { point 3 }
				length { box 4,0,0,8,0,0 }
			}
		}
	}
	spawner "round flash2"
	{
		count		1,1
		locked

		sprite
		{
			duration	0.4,0.4
			blend	add
			material	"gfx/effects/energy_sparks/launch_flash3"

			start
			{
				position { box 0,-3,-3,0,3,3 }
				size { point 20,20 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "exp_x2" }
			}

			end
			{
				size { point 160,160 }
			}
		}
	}
	spawner "flash4"
	{
		count		1,1
		locked

		sprite
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/weapons/flash"

			start
			{
				size { point 200,200 }
				tint { point 0.596078,0.654902,0.811765 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "exp_x2" }
			}

			end
			{
				size { point 80,80 }
			}
		}
	}
}




