effect effects/monsters/strogg_flyer/bomb_burst
{
	size	780

	sound "sound"
	{
		soundShader	"effects_explosion_wood"
	}
	decal "scorch"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/explosion_impact2"

			start
			{
				size { point 80,80 }
				rotate { box 0,1 }
			}
		}
	}
	light "light"
	{
		locked

		light
		{
			duration	0.2,0.2
			material	"lights/defaultPointLight"

			start
			{
				position { point 5,0,0 }
				size { point 300,300,300 }
				tint { point 1,0.823529,0.290196 }
			}
		}
	}
	spawner "dirt_up"
	{
		start		0.2,0.2
		count		2,2

		sprite
		{
			duration	0.6,1
			material	"gfx/effects/particles_shapes/dirt2"
			gravity		0.5,0.75

			start
			{
				position { cylinder 200,-0.5,-0.5,0,0.5,0.5 }
				velocity { box 100,-100,-100,600,100,100 }
				acceleration { point -600,0,0 }
				size { line 80,80,100,100 }
				tint { point 0.470588,0.47451,0.376471 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope pop_hold_fadefast }
				rotate { envelope linear }
			}

			end
			{
				size { line 200,200,300,300 }
				tint { point 0.2,0.176471,0.14902 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "dirt_up2"
	{
		start		0.2,0.2
		count		2,2

		sprite
		{
			duration	0.6,1
			material	"gfx/effects/particles_shapes/dirt3"
			gravity		0.5,0.75

			start
			{
				position { cylinder 200,-0.5,-0.5,0,0.5,0.5 }
				velocity { box 100,-100,-100,600,100,100 }
				acceleration { point -600,0,0 }
				size { line 80,80,100,100 }
				tint { point 0.462745,0.439216,0.360784 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope pop_hold_fadefast }
				rotate { envelope linear }
			}

			end
			{
				size { line 200,200,300,300 }
				tint { point 0.2,0.176471,0.14902 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "dust_up"
	{
		count		7,7

		sprite
		{
			duration	1.5,2
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		0.1,0.25

			start
			{
				position { cylinder 0,-0.5,-0.5,0,0.5,0.5 }
				velocity { box 150,-50,-50,400,50,50 }
				size { line 80,80,100,100 }
				tint { line 0.32549,0.294118,0.243137,0.352941,0.403922,0.329412 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope pop_hold_fadefast }
				rotate { envelope linear }
			}

			end
			{
				size { line 200,200,300,300 }
				tint { point 0.2,0.176471,0.14902 }
				fade { point 0.4 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "flash"
	{
		count		1,1

		line
		{
			duration	0.3,0.3
			material	"gfx/effects/weapons/flash_half"

			start
			{
				position { point -100,0,0 }
				size { point 150 }
				length { box 350,-30,-30,350,30,30 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { point 75 }
				length { point 250,0,0 }
			}
		}
	}
	spawner "fire"
	{
		count		5,5

		sprite
		{
			duration	0.5,0.8
			blend	add
			material	"gfx/effects/fire/impact_fire"

			start
			{
				position { point 1,0,0 }
				velocity { box 30,-60,-60,100,60,60 }
				size { line 80,80,120,120 }
				tint { point 0.74902,0.74902,0.74902 }
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
				size { line 60,60,80,80 }
			}
		}
	}
	spawner "sparks"
	{
		count		25,25

		sprite
		{
			duration	1,3
			blend	add
			material	"gfx/effects/energy_sparks/spark2"
			gravity		0.2,0.5

			start
			{
				position { sphere 50,-25,-25,0,25,25 }
				velocity { box 50,-100,-100,350,100,100 }
				size { line 1,1,3,3 }
				tint { point 0.992157,0.909804,0.729412 }
				rotate { box 0.251,-0.25 }
			}

			motion
			{
				fade { envelope linear_flicker }
				rotate { envelope linear }
			}
		}
	}
}



