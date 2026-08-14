effect effects/levels/hub/emp
{
	size	4950

	spawner "white flash"
	{
		count		1,1

		sprite
		{
			duration	0.15,0.15
			persist
			material	"gfx/effects/weapons/mflash2_machinegun"

			start
			{
				size { point 3000,3000 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope linear }
			}
		}
	}
	spawner "blue flash"
	{
		count		2,2

		sprite
		{
			duration	0.25,0.25
			persist
			material	"gfx/effects/weapons/flash_blue"

			start
			{
				size { point 3500,3500 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				rotate { envelope exp_x2 }
			}

			end
			{
				rotate { box -1,1 }
			}
		}
	}
	spawner "ground"
	{
		count		10,20

		electricity
		{
			duration	0.25,0.5
			blend	add
			fork	0
			jitterRate	0
			jitterSize	3,7,7
			persist
			material	"gfx/effects/electricity/electric_blue_fade"
			generatedOriginNormal

			start
			{
				position { cylinder 0,-1,-1,0,1,1 surface }
				size { point 2 }
				length { point 100,0,0 }
			}

			motion
			{
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				fade { line 0.5,0 }
				length { box 300,0,0,500,0,0 }
			}
		}
	}
	spawner "air"
	{
		count		10,20

		electricity
		{
			duration	0.25,0.5
			blend	add
			fork	0
			jitterRate	0
			jitterSize	3,7,7
			persist
			material	"gfx/effects/electricity/electric_blue_fade"

			start
			{
				position { cylinder 0.5,-1,-1,0.5,1,1 surface }
				size { point 2 }
				length { box 100,-100,-100,100,100,100 }
			}

			motion
			{
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				fade { line 0.5,0 }
				length { box 300,-300,-300,500,300,300 }
			}
		}
	}
	spawner "deform"
	{
		count		1,1

		sprite
		{
			duration	1,1
			blend	add
			persist
			material	"gfx/effects/energy_sparks/explosion_deform"

			start
			{
				size { point 0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 2000,2000 }
			}
		}
	}
	emitter "deform_oriented"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	1,1
			persist
			material	"gfx/effects/energy_sparks/explosion_deform"

			start
			{
				position { point 1,0,0 }
			}

			motion
			{
				size { envelope linear }
			}

			end
			{
				size { point 2000,2000 }
			}
		}
	}
	sound "unnamed6"
	{
		soundShader	"stream_hub_emp_blast2"
	}
	sound "unnamed7"
	{
		soundShader	"stream_hub_emp_blast1"
	}
	emitter "unnamed8"
	{
		duration	0.25,0.5
		count		5,5

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/launch_flash4"

			start
			{
				size { point 2,2 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 1500,1500 }
			}
		}
	}
	spawner "unnamed9"
	{
		count		5,5

		oriented
		{
			duration	1,1
			material	"gfx/effects/energy_sparks/launch_flash4"

			start
			{
				position { point 1,0,0 }
				size { point 2,2 }
				rotate { box 0,0,-1,0,0,1 }
			}

			motion
			{
				size { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 1500,1500 }
			}
		}
	}
	spawner "unnamed10"
	{
		count		5,5

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/launch_flash4"

			start
			{
				size { point 2,2 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 1500,1500 }
			}
		}
	}
}






