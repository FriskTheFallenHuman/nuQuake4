effect effects/vehicles/walker/machinegun/impact_concrete
{
	size	421

	sound "sound"
	{
		soundShader	"effects_bulletimpact_concrete"
	}
	spawner "dirt"
	{
		count		3,3

		line
		{
			duration	0.25,0.7
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		0.5,0.5

			start
			{
				size { box 8,12 }
				tint { line 0.317647,0.278431,0.184314,0.270588,0.262745,0.227451 }
				fade { point 0 }
				length { box 80,0,0,150,0,0 }
			}

			motion
			{
				fade { envelope fastinslowout }
				length { envelope linear }
			}

			end
			{
				fade { point 0.8 }
			}
		}
	}
	decal "mark"
	{

		decal
		{
			duration	0.002,0.002
			material	"textures/decals/bullethole"

			start
			{
				size { box 15,15,25,25 }
				rotate { box 0,1 }
			}
		}
	}
	spawner "chunks"
	{
		start		0.04,0.04
		count		2,2

		sprite
		{
			duration	1,1.5
			material	"gfx/effects/particles_shapes/concrete_chunks"
			gravity		0.75,0.75

			start
			{
				position { sphere -20,-20,-20,20,20,20 }
				velocity { box 200,-80,-80,600,80,80 }
				size { line 2,2,5,5 }
				tint { line 0.470588,0.419608,0.329412,0.258824,0.243137,0.184314 }
				rotate { box 0,0.333333 }
			}

			motion
			{
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				rotate { box 0.333333,0.666667 relative }
			}
		}
	}
	spawner "smoke"
	{
		start		0.1,0.1
		count		2,2

		sprite
		{
			duration	1,1.5
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		0.05,0.05

			start
			{
				velocity { box 30,-5,-5,120,5,5 }
				acceleration { point -20,0,0 }
				size { line 10,10,15,15 }
				tint { line 0.509804,0.47451,0.286275,0.466667,0.439216,0.329412 }
				fade { point 0.6 }
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
				size { line 40,40,60,60 }
				tint { line 0.172549,0.137255,0.0705882,0.105882,0.0941177,0.0705882 }
			}
		}
	}
	spawner "debris"
	{
		start		0.1,0.1
		count		1,1

		sprite
		{
			duration	0.5,1
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		0.35,0.35

			start
			{
				velocity { box 150,-50,-50,350,50,50 }
				size { line 10,10,15,15 }
				tint { line 0.509804,0.47451,0.286275,0.466667,0.439216,0.329412 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
			}

			end
			{
				size { line 100,100,150,150 }
				fade { point 0.6 }
			}
		}
	}
	spawner "side_streaks"
	{
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
				size { box 4,8 }
				tint { line 1,0.921569,0.701961,0.74902,0.521569,0.203922 }
				length { point 5,0,0 }
			}

			motion
			{
				tint { envelope linear }
				fade { envelope exp_x2 }
				length { envelope linear }
			}

			end
			{
				tint { line 0.956863,0.658824,0.529412,0.956863,0.639216,0.529412 }
				length { box 40,0,0,60,0,0 }
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
			duration	0.16,0.16
			blend	add
			material	"gfx/effects/weapons/flash"
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { box 20,20,30,30 }
			}

			motion
			{
				tint { envelope linear }
			}
		}
	}
}









