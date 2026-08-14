effect effects/smoke/slowsmoke_256_sky2
{
	size	1620

	emitter "smoke"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	8,8
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.0001,-0.0001

			start
			{
				position { line 20,-1,-1,20,1,1 }
				velocity { box 150,0,0,200,-1,-1 }
				acceleration { box 0,0,0,-1,-1,-1 }
				size { box 350,350,380,380 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0 }
				offset { box -200,-10,-10,-200,10,10 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 400,400,600,600 }
				fade { point 1 }
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
			duration	4,6
			material	"gfx/effects/smoke/underlit_alpha"
			gravity		-0.0001,-0.0001

			start
			{
				position { line 20,-1,-1,20,1,1 }
				velocity { box 50,0,0,100,-1,-1 }
				angle { box 0,0,0,1,1,1 }
				acceleration { box 0,0,0,-1,-1,-1 }
				size { box 180,180,220,220 }
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
				size { box 300,300,350,350 }
				fade { point 1 }
				angle { box -0.333333,-0.333333,-0.333333,0.333333,0.333333,0.333333 relative }
			}
		}
	}
}

