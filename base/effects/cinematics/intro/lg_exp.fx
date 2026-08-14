effect effects/cinematics/intro/lg_exp
{
	size	8053

	shake "camerashake"
	{
		duration	0.7,0.7
		scale		1
		attenuateEmitter
		attenuation	200,600
	}
	spawner "column_fire2"
	{
		count		5,5

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/fire/fire4a"

			start
			{
				position { line 0,0,0,200,0,0 linearSpacing }
				velocity { box 1000,-5000,-5000,5000,5000,5000 }
				angle { box 0,0,0,1,1,1 }
				size { box 2000,2000,3000,3000 }
				offset { box -50,-50,-50,50,50,50 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 60,60,80,80 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.277778,0.277778 relative }
			}
		}
	}
	spawner "flash3"
	{
		count		1,1

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/weapons/flash"
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { line 3000,3000,5000,5000 }
				rotate { box 0,1 }
			}

			motion
			{
				tint { envelope linear }
				fade { envelope linear }
			}
		}
	}
	spawner "fragments"
	{
		count		9,12

		line
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/energy_sparks/spark_line3"
			generatedOriginNormal

			start
			{
				position { cylinder 0.025,-0.1,-0.1,0.025,0.1,0.1 }
				velocity { box 500,0,0,820,0,0 }
				size { box 8,30 }
				tint { line 1,0.937255,0.584314,1,0.709804,0.411765 }
				length { box 300,0,0,2000,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}
		}
	}
	spawner "unnamed10"
	{
		count		5,5

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/launch_flash4"
			entityDef	"debris_walker_upperleg"

			start
			{
				position { point 1,0,0 }
				size { point 2,2 }
				tint { point 1,0.501961,0.25098 }
				rotate { box 0,-0.222222,-1,0,-0.222222,1 }
			}

			motion
			{
				size { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 5000,5000 }
				rotate { point 0,-0.222222,0 }
			}
		}
	}
	spawner "column_fire3"
	{
		count		10,10

		sprite
		{
			duration	1,1
			material	"gfx/effects/fire/fire4a"
			entityDef	"debris_walker_upperleg"

			start
			{
				position { cylinder 0,-500,-500,0,500,500 surface linearSpacing }
				velocity { box 0,-1000,-1000,0,1000,1000 }
				size { point 300,300 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 3000,3000,4000,4000 }
				rotate { box -0.277778,0.277778 relative }
			}
		}
	}
	spawner "column_fire4"
	{
		count		5,5

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/fire/fire2a"
			entityDef	"debris_walker_upperleg"

			start
			{
				position { line 0,0,0,200,0,0 linearSpacing }
				velocity { box 50,-3000,-3000,1000,3000,3000 }
				size { box 3000,3000,5000,5000 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 200,200,300,300 }
				rotate { box -0.277778,0.277778 relative }
			}
		}
	}
	delay "unnamed8"
	{
		duration	5,5
	}
	spawner "column_fire5"
	{
		count		10,10

		sprite
		{
			duration	1,1
			material	"gfx/effects/fire/fire1a"
			entityDef	"debris_walker_upperleg"

			start
			{
				position { cylinder 0,-2000,-2000,0,2000,2000 surface linearSpacing }
				velocity { box 0,-1000,-1000,0,1000,1000 }
				size { point 500,500 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 2000,2000,4000,4000 }
				rotate { box -0.277778,0.277778 relative }
			}
		}
	}
	spawner "column_fire6"
	{
		count		10,10

		sprite
		{
			duration	1,1
			material	"gfx/effects/fire/fire2a"
			entityDef	"debris_walker_upperleg"

			start
			{
				position { cylinder 0,-1000,-1000,0,1000,1000 surface linearSpacing }
				velocity { box 0,-1000,-1000,0,1000,1000 }
				size { point 500,500 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 2000,2000,4000,4000 }
				rotate { box -0.277778,0.277778 relative }
			}
		}
	}
	sound "unnamed10"
	{
		start		0.3,0.3
		soundShader	"cine_intro_lg_ship_explode1"
		freqshift	0.5,0.5
	}
	sound "unnamed11"
	{
		soundShader	"cine_intro_lg_ship_explode2"
	}
}



