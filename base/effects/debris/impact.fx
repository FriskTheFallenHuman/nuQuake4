effect effects/debris/impact
{
	size	293

	spawner "dust2"
	{
		count		2,2

		sprite
		{
			duration	1,1
			persist
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.125,-0.025

			start
			{
				position { sphere 0,-10,-10,0,10,10 surface }
				velocity { box 1,-50,-50,50,50,50 }
				friction { point -500,0,0 }
				size { line 20,20,30,30 }
				tint { line 0.494118,0.494118,0.494118,0.313726,0.337255,0.301961 }
				fade { point 0 }
				offset { point 0,-8,8 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { line 30,30,40,40 }
				tint { point 0.345098,0.345098,0.345098 }
				fade { point 0.25 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "debris2"
	{
		count		5,5

		sprite
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/debris2"
			gravity		1,1

			start
			{
				velocity { box 200,-200,-200,300,200,200 }
				angle { box 0,0,-1,0,0,1 }
				size { line 2,2,10,10 }
				fade { point 0.5 }
				offset { box 0,-5,-5,0,5,5 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope linear offset -0.5 }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				angle { box 0,0,-0.5,0,0,0.5 relative }
				rotate { box -0.5,0.5 relative }
			}
		}
	}
	spawner "debris4"
	{
		count		5,5

		sprite
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/debris4"
			gravity		1,1

			start
			{
				position { box 0,-30,-30,0,30,30 }
				velocity { box 300,-300,-300,400,300,300 }
				angle { box 0,0,-1,0,0,1 }
				size { line 2,2,10,10 }
				fade { point 0.5 }
				offset { box 0,-5,-5,0,5,5 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope linear offset -0.5 }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				angle { box 0,0,-0.5,0,0,0.5 relative }
				rotate { box -0.5,0.5 relative }
			}
		}
	}
}
