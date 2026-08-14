effect effects/weapons/nailgun/impact_concrete
{
	size	1487

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
	spawner "dirt"
	{
		detail		0.5
		count		3,3

		line
		{
			duration	0.25,0.5
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		0.5,0.5

			start
			{
				size { box 4,6 }
				tint { line 0.317647,0.278431,0.184314,0.270588,0.262745,0.227451 }
				fade { point 0 }
				length { box 45,0,0,70,0,0 }
			}

			motion
			{
				fade { envelope "fastinslowout" }
				length { envelope "linear" }
			}

			end
			{
				fade { point 0.8 }
			}
		}
	}
	spawner "debris"
	{
		detail		0.5
		start		0.1,0.1
		count		1,1

		sprite
		{
			duration	0.35,0.7
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		0.3,0.3

			start
			{
				velocity { box 100,-30,-30,150,30,30 }
				size { line 10,10,15,15 }
				tint { line 0.509804,0.47451,0.286275,0.466667,0.439216,0.329412 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
			}

			end
			{
				size { point 75,75 }
				fade { point 0.6 }
			}
		}
	}
	spawner "smoke"
	{
		start		0.04,0.04
		count		6,8

		sprite
		{
			duration	1,1.5
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		0.02,0.02

			start
			{
				velocity { box 10,-5,-5,60,5,5 }
				acceleration { point -20,0,0 }
				size { box 0.5,3,1,4 }
				tint { point 0.411765,0.376471,0.313726 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { box 20,20,30,30 }
			}
		}
	}
	spawner "chunks_physics"
	{
		detail		0.75
		start		0.04,0.04
		count		1,1

		sprite
		{
			duration	3,3
			material	"gfx/effects/particles_shapes/concrete_chunks"
			gravity		0.75,0.75

			start
			{
				position { point 1,0,0 }
				velocity { box 80,-40,-40,300,40,40 }
				size { line 0.5,0.5,2,2 }
				tint { line 0.458824,0.411765,0.337255,0.235294,0.254902,0.172549 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope "linear" }
			}

			impact
			{
				bounce	0.4
			}
		}
	}
	spawner "chunks"
	{
		detail		0.75
		start		0.04,0.04
		count		7,12

		sprite
		{
			duration	0.5,0.75
			material	"gfx/effects/particles_shapes/concrete_chunks"
			gravity		0.75,0.75

			start
			{
				velocity { box 80,-40,-40,300,40,40 }
				size { line 0.25,0.25,2,2 }
				tint { line 0.458824,0.411765,0.337255,0.254902,0.254902,0.188235 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope "linear" }
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
				size { point 8,8 }
				fade { point 0.6 }
			}

			motion
			{
				tint { envelope "linear" }
			}

			end
			{
				tint { point 0.282353,0.14902,0.14902 }
			}
		}
	}
	spawner "side_streaks"
	{
		count		3,5
		locked

		line
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/weapons/flash_half3"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.3,-0.3,-0.2,0.3,0.3 surface }
				size { box 2,4 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0 }
				length { box 12,0,0,16,0,0 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "decalfade" }
			}

			end
			{
				tint { point 0.584314,0.443137,0.443137 }
				fade { point 1 }
			}
		}
	}
	spawner "fragments"
	{
		count		5,5

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






