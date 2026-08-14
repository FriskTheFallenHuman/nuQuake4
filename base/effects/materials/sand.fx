effect effects/materials/sand
{
	size	174

	spawner "sand_up"
	{
		count		5,8

		sprite
		{
			duration	0.5,0.75
			material	"gfx/effects/particles_shapes/sand"
			gravity		0.25,0.5

			start
			{
				position { cylinder 25,-0.5,-0.5,0,0.5,0.5 }
				velocity { box 150,-10,-10,200,10,10 }
				size { point 1,20 }
				tint { line 0,0,0,1,1,1 }
				fade { point 0 }
			}

			motion
			{
				size { envelope popoverextreme_hold_grow }
				fade { envelope pop_fade }
				rotate { envelope random }
			}

			end
			{
				size { point 5,25 }
				fade { point 1 }
			}
		}
	}
	spawner "sand_out"
	{
		start		0.12,0.12
		count		5,5

		sprite
		{
			duration	0.5,1
			material	"gfx/effects/particles_shapes/sand"
			gravity		0.5,0.65

			start
			{
				position { cylinder 55,-0.05,-0.05,35,0.05,0.05 }
				velocity { box 150,-25,-25,100,25,25 }
				size { point 1,25 }
				tint { point 0.776471,0.678431,0.392157 }
				fade { line 0.5,1 }
			}

			motion
			{
				size { envelope popoverextreme_hold_grow }
				fade { envelope exp_x2 }
				rotate { envelope random }
			}

			end
			{
				size { point 15,15 }
			}
		}
	}
	decal "scorch"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/nailgun_mark"

			start
			{
				size { point 12,12 }
				rotate { box 0,1 }
			}
		}
	}
	spawner "dust"
	{
		count		1,2

		sprite
		{
			duration	1,2
			material	"gfx/effects/smoke/smoke_alpha"

			start
			{
				position { cylinder 0,-0.05,-0.05,0,0.05,0.05 }
				velocity { box 5,-5,-5,10,5,5 }
				friction { box -200,0,0,-300,0,0 }
				size { point 5,5 }
				tint { point 0.466667,0.356863,0.156863 }
				fade { point 0 }
				rotate { box 0,0.25 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope pop_fade }
				fade { envelope fast_in_slow_out }
				rotate { envelope linear }
			}

			end
			{
				size { point 100,100 }
				tint { line 0.768628,0.756863,0.658824,0.792157,0.784314,0.639216 }
				fade { point 1 }
				rotate { box 0.125,0 }
			}
		}
	}
	spawner "impact_mist"
	{
		count		12,15
		locked

		line
		{
			duration	0.25,0.25
			material	"gfx/effects/particles_shapes/sand"
			generatedOriginNormal

			start
			{
				position { cylinder 0,-0.5,-0.5,0,0.5,0.5 }
				size { point 5 }
				fade { point 0 }
				length { box 1,5,5,1,-5,-5 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope pop_fade }
				length { envelope linear }
			}

			end
			{
				size { point 12 }
				fade { line 0.5,1 }
				length { box 12,-55,-55,12,55,55 }
			}
		}
	}
	sound "unnamed5"
	{
		soundShader	"effects_bulletimpact_dirt"
	}
}


