effect effects/impact/impact_flesh
{
	size	272

	sound "sound"
	{
		soundShader	"bullet_impact_flesh"
	}
	spawner "bloodspray_enter"
	{
		count		3,4

		sprite
		{
			duration	1,1
			material	"gfx/effects/gore_spray/bloodspray2"
			gravity		-0.01,-0.01

			start
			{
				velocity { box 1,-6,-6,20,6,6 }
				size { box 0.05,0.05,0.2,0.2 }
				tint { point 0.364706,0.32549,0.27451 }
				rotate { box 0,0.138889 }
			}

			motion
			{
				size { envelope linear count 3,3 }
				tint { envelope exp_x2 }
				fade { envelope exp_x2 }
			}

			end
			{
				size { box 4,4,8,8 }
			}
		}
	}
	spawner "bloodspray_exit"
	{
		count		3,5

		sprite
		{
			duration	1,1
			material	"gfx/effects/gore_spray/bloodspray2"
			flipNormal

			start
			{
				position { point -10,0,0 }
				velocity { box 5,-6,-6,60,6,6 }
				size { point 10,10 }
				tint { point 0.603922,0.584314,0.505882 }
				rotate { box 0,0.138889 }
			}

			motion
			{
				size { envelope linear count 0.65,0.65 }
				tint { envelope exp_x2 }
				fade { envelope exp_x2 }
			}

			end
			{
				size { point 40,40 }
			}
		}
	}
	spawner "side_streaks"
	{
		count		7,9
		locked

		line
		{
			duration	0.24,0.24
			generatedLine
			material	"gfx/effects/gore_spray/bloodspray4"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.3,-0.3,-0.2,0.3,0.3 surface }
				velocity { point 1,0,0 }
				size { box 1,2 }
				tint { point 0.501961,0.501961,0.501961 }
			}

			motion
			{
				tint { envelope exp_x2 }
				fade { envelope exp_x2 }
				length { envelope linear }
			}

			end
			{
				tint { point 0.364706,0.321569,0.27451 }
				length { box 15,0,0,25,0,0 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
	spawner "chunks"
	{
		count		4,6

		sprite
		{
			duration	0.5,1
			material	"gfx/effects/particles_shapes/blank"
			gravity		0.1,0.1
			trailType	chunks_trail

			start
			{
				position { point 1,0,0 }
				velocity { box 300,-25,25,600,25,-100 }
				size { line 3,3,6,6 }
				tint { point 0.282353,0,0 }
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
	trail "chunks_trail"
	{
		count		50,50

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/smoke/impact_smoke3"

			start
			{
				size { box 1.5,1.5,3,3 }
				tint { line 0.12549,0,0,0.243137,0,0 }
				fade { point 0.75 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { box 6,6,9,9 }
			}
		}
	}
}
