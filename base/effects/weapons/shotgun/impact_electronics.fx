effect effects/weapons/shotgun/impact_electronics
{
	size	81

	sound "sound"
	{
		soundShader	"bullet_impact_metal_shotgun"
	}
	decal "mark"
	{

		decal
		{
			duration	0.002,0.002
			material	"textures/decals/bullethole"

			start
			{
				size { box 2,2,3,3 }
				rotate { box 0,1 }
			}
		}
	}
	spawner "electricity"
	{
		start		0.2,0.2
		count		2,2

		electricity
		{
			duration	0.15,0.75
			blend	add
			fork	0
			jitterRate	0
			jitterSize	3,7,7
			jitterTable	"halfsintable"
			material	"gfx/effects/electricity/electricity"
			generatedNormal

			start
			{
				position { cylinder 0,-0.1,-0.1,0,0.1,0.1 }
				size { box 0.3,0.8 }
				length { box 2,0,0,8,0,0 }
			}

			motion
			{
				fade { envelope "linear_flicker" }
			}
		}
	}
	spawner "sparks_trails"
	{
		count		3,4

		sprite
		{
			duration	0.5,1
			material	"gfx/effects/particles_shapes/blank"
			gravity		0.15,0.15
			trailType	motion
			trailTime	0.08,0.08
			trailCount	2,2

			start
			{
				velocity { box 20,-25,-25,150,25,25 }
				size { box 0.5,0.5,1.5,1.5 }
				tint { point 0.941177,0.921569,0.819608 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" count 2,2,2 }
				fade { envelope "linear_flicker" }
			}

			end
			{
				size { point 0.5,0.5 }
				tint { point 0.882353,0.956863,0.992157 }
			}
		}
	}
	spawner "impact_smoke"
	{
		detail		0.5
		start		0.06,0.06
		count		4,4

		sprite
		{
			duration	0.2,0.4
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				position { line 0,0,0,5,0,0 }
				velocity { box 0,-10,-10,30,10,10 }
				size { line 0.5,1,1,2 }
				rotate { box 0,0.111111 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 4,4,6,6 }
				rotate { box 0.111111,0.222222 relative }
			}
		}
	}
	emitter "delayed_smoke"
	{
		detail		0.5
		start		0.6,0.6
		duration	1.5,1.5
		count		8,12

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.05,-0.05

			start
			{
				velocity { box 5,-2,-2,10,2,2 }
				size { line 0.4,0.4,0.8,0.8 }
				tint { point 0.67451,0.639216,0.556863 }
				rotate { box 0,0.111111 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 7,7,9,9 }
				tint { point 0.356863,0.34902,0.266667 }
				rotate { box 0.111111,0.222222 relative }
			}
		}
	}
	spawner "side_streaks"
	{
		count		7,9
		locked

		line
		{
			duration	0.1,0.1
			blend	add
			generatedLine
			material	"gfx/effects/weapons/flash_half_blue3"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.3,-0.3,-0.2,0.3,0.3 surface }
				velocity { point 1,0,0 }
				size { point 2 }
				tint { line 1,0.921569,0.701961,0.74902,0.521569,0.203922 }
				length { point 4,0,0 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "exp_x2" }
				length { envelope "linear" }
			}

			end
			{
				tint { line 0.956863,0.658824,0.529412,0.956863,0.639216,0.529412 }
				length { box 8,0,0,10,0,0 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
	spawner "flash"
	{
		detail		0.5
		count		3,3

		sprite
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/weapons/flash"
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { point 6,6 }
				tint { point 0.945098,0.839216,0.737255 }
				fade { point 0.6 }
			}

			motion
			{
				tint { envelope "linear" }
			}
		}
	}
}




