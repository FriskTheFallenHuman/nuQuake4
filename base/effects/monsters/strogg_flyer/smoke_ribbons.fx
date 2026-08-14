effect effects/monsters/strogg_flyer/smoke_ribbons
{
	size	139

	emitter "smoke"
	{
		duration	1,1
		count		6,6

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/cloud_alpha"

			start
			{
				position { cylinder 0.2,-0.1,-0.1,0.2,0.1,0.1 }
				size { point 30,30 }
				tint { point 0.756863,0.709804,0.517647 }
				fade { point 0 }
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
				size { point 80,80 }
				tint { point 0.290196,0.266667,0.223529 }
				fade { point 0.75 }
				rotate { box -0.5,0.5 relative }
			}
		}
	}
	emitter "fire"
	{
		duration	1,1
		count		10,10
		locked

		sprite
		{
			duration	0.3,0.3
			material	"gfx/effects/fire/fire1a"

			start
			{
				velocity { point 150,0,0 }
				size { point 10,10 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope exp_x2 }
				rotate { envelope linear }
			}

			end
			{
				size { box 40,40,70,70 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "fire2"
	{
		duration	1,1
		count		10,10
		locked

		sprite
		{
			duration	0.6,0.6
			material	"gfx/effects/fire/fire3a"

			start
			{
				velocity { point 150,0,0 }
				size { point 10,10 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope exp_x2 }
				rotate { envelope linear }
			}

			end
			{
				size { box 40,40,70,70 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	sound "unnamed3"
	{
		soundShader	"convoy_large_ship_loop2"
		freqshift	0.5,0.5
	}
	sound "unnamed4"
	{
		soundShader	"convoy_jetfire2"
	}
	sound "unnamed5"
	{
		soundShader	"cine_intro_ship_thruster_1"
		freqshift	2,2
	}
}







