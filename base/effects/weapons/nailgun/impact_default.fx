effect effects/weapons/nailgun/impact_default
{
	size	115

	sound "sound"
	{
		soundShader	"bullet_impact_metal"
	}
	decal "mark"
	{

		decal
		{
			duration	0.002,0.002
			material	"textures/decals/bullethole"

			start
			{
				size { box 7,7,10,10 }
				fade { point 0.5 }
				rotate { box 0,1 }
			}
		}
	}
	spawner "smoke"
	{
		detail		0.5
		start		0.1,0.1
		count		9,12

		sprite
		{
			duration	1,1.5
			material	"gfx/effects/smoke/cloud_alpha2"
			gravity		0.05,0.05

			start
			{
				position { line 0,0,0,20,0,0 }
				velocity { box 0,-5,-5,50,5,5 }
				acceleration { point -20,0,0 }
				size { line 1,3,2,4 }
				tint { line 0.403922,0.411765,0.384314,0.443137,0.439216,0.356863 }
				fade { point 0.5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { line 15,15,25,25 }
				tint { line 0.176471,0.176471,0.164706,0.180392,0.184314,0.156863 }
			}
		}
	}
	spawner "flash"
	{
		detail		0.5
		count		1,1

		sprite
		{
			duration	0.14,0.14
			blend	add
			material	"gfx/effects/weapons/flash"
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { point 12,12 }
			}

			motion
			{
				tint { envelope "linear" }
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
			material	"gfx/effects/energy_sparks/spark_line2"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.3,-0.3,-0.2,0.3,0.3 surface }
				velocity { point 1,0,0 }
				size { box 2,4 }
				tint { line 1,0.921569,0.701961,0.74902,0.521569,0.203922 }
				length { point 5,0,0 }
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
				length { box 10,0,0,20,0,0 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
	spawner "single_line"
	{
		detail		0.5
		count		1,1

		line
		{
			duration	0.1,0.1
			material	"gfx/effects/weapons/flash_half3"

			start
			{
				size { box 3,5 }
				length { box 15,0,0,22,0,0 }
			}

			motion
			{
				length { envelope "linear" }
			}
		}
	}
	spawner "fragments"
	{
		count		15,15

		line
		{
			duration	0.2,0.3
			generatedLine
			material	"gfx/effects/particles_shapes/blank"
			gravity		1,1
			generatedOriginNormal
			trailType	motion
			trailTime	0.1,0.1
			trailCount	2,2
			trailMaterial	"gfx/effects/particles_shapes/motionblur_nail"

			start
			{
				position { cylinder 0.025,-0.1,-0.1,0.025,0.1,0.1 }
				velocity { box 200,0,0,600,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { point 10 }
				tint { point 1,0.501961,0 }
				offset { box 0,8,8,0,-8,-8 }
				length { box 6,0,0,12,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "exp_1minusx/x2" }
				fade { envelope "linear" }
			}

			end
			{
				tint { point 0.501961,0.501961,0.501961 }
			}
		}
	}
}











