effect effects/smoke/slowsmoke_256
{
	size	1031

	emitter "smoke"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	10,20
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.0001,-0.0001

			start
			{
				position { line 20,-1,-1,20,1,1 }
				velocity { box 25,0,0,50,-1,-1 }
				angle { box 0,0,0,1,1,1 }
				acceleration { box 0,0,0,-1,-1,-1 }
				size { box 150,150,180,180 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0 }
				offset { box -10,-10,-10,10,10,10 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 200,200,400,400 }
				fade { point 1 }
				angle { box -0.333333,-0.333333,-0.333333,0.333333,0.333333,0.333333 relative }
				rotate { box -0.166667,0.166667 relative }
			}
		}
	}
	emitter "smoke2"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	10,15
			material	"gfx/effects/smoke/underlit_alpha"
			gravity		-0.0001,-0.0001

			start
			{
				position { line 20,-1,-1,20,1,1 }
				velocity { box 15,0,0,30,-1,-1 }
				angle { box 0,0,0,1,1,1 }
				acceleration { box 0,0,0,-1,-1,-1 }
				size { box 80,80,120,120 }
				fade { point 0 }
				offset { box -10,-10,-10,10,10,10 }
				rotate { box 0.305556,0.416667 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				angle { envelope "linear" }
			}

			end
			{
				size { box 200,200,250,250 }
				fade { point 1 }
				angle { box -0.333333,-0.333333,-0.333333,0.333333,0.333333,0.333333 relative }
			}
		}
	}
}

