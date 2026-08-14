effect effects/weapons/nailgun/impact_default_mp
{
	size	120

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
				size { box 4,4,6,6 }
				rotate { box 0,1 }
			}
		}
	}
	spawner "smoke"
	{
		detail		0.5
		start		0.1,0.1
		count		1,1

		sprite
		{
			duration	1,1.5
			material	"gfx/effects/smoke/cloud_alpha2"
			gravity		-0.02,-0.02

			start
			{
				position { line 0,0,0,10,0,0 }
				velocity { box 3,0,0,5,0,0 }
				size { line 3,3,4,4 }
				tint { line 0.403922,0.411765,0.384314,0.443137,0.439216,0.356863 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
			}

			end
			{
				size { line 12,12,15,15 }
				tint { line 0.176471,0.176471,0.164706,0.180392,0.184314,0.156863 }
				fade { point 0.75 }
			}
		}
	}
	spawner "side_streaks"
	{
		count		5,7
		locked

		line
		{
			duration	0.6,0.6
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2_flipped"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.3,-0.3,-0.2,0.3,0.3 surface }
				velocity { point 1,0,0 }
				size { box 2,4 }
				tint { line 1,0.65098,0.501961,0.74902,0.521569,0.203922 }
				length { box 10,0,0,20,0,0 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "exp_x2" }
				length { envelope "linear" }
			}

			end
			{
				tint { line 0.921569,0.654902,0.388235,0.956863,0.639216,0.529412 }
				length { box 10,0,0,15,0,0 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
	spawner "flash"
	{
		count		1,1

		sprite
		{
			duration	0.6,0.6
			blend	add
			material	"gfx/effects/weapons/flash"
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { point 16,16 }
				tint { point 1,0.792157,0.666667 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
			}

			end
			{
				size { point 12,12 }
			}
		}
	}
	spawner "fragments2"
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
			trailCount	3,3
			trailMaterial	"gfx/effects/particles_shapes/motionblur_nail"

			start
			{
				position { cylinder 0.025,-0.1,-0.1,0.025,0.1,0.1 }
				velocity { box 200,0,0,600,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { point 15 }
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


