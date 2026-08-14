effect effects/smoke/ground_impact
{
	size	279

	spawner "dust"
	{
		count		30,30

		sprite
		{
			duration	1,1
			persist
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.125,-0.025

			start
			{
				position { sphere 0,-10,-10,0,10,10 surface }
				velocity { box 0,-250,-250,0,250,250 }
				friction { point -2200,0,0 }
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
				size { line 60,60,70,70 }
				tint { point 0.235294,0.235294,0.235294 }
				fade { point 0.8 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "wave"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/particles_shapes/shockwave"

			start
			{
				position { point 1,0,0 }
				size { point 10,10 }
				tint { point 0.501961,0.501961,0.501961 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 150,150 }
			}
		}
	}
	spawner "dust2"
	{
		count		30,30

		sprite
		{
			duration	1.5,1.5
			persist
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.125,-0.025

			start
			{
				position { sphere 0,-10,-10,0,10,10 surface }
				velocity { box 1,-100,-100,80,100,100 }
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
				size { line 60,60,70,70 }
				tint { point 0.345098,0.345098,0.345098 }
				fade { point 0.8 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	sound "unnamed3"
	{
		soundShader	"generic_rock_impact_large"
	}
}


