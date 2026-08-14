effect effects/monsters/scientist/obscuring_cloud
{
	size	517

	emitter "white_round"
	{
		duration	8,8
		count		1,1

		sprite
		{
			duration	1.5,2
			material	"gfx/effects/smoke/white_alpha"
			gravity		-0.05,-0.01

			start
			{
				position { sphere 1,-1,-1,1,1,1 }
				velocity { box 10,-10,-10,10,10,10 }
				size { point 0,0 }
				tint { point 0.403922,0.886275,0.427451 }
				rotate { point -0.08 }
			}

			motion
			{
				size { envelope "exp_1minusx/x2" }
				fade { envelope "cosine" offset 0.5 }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 300,300 }
			}
		}
	}
	emitter "segment01222"
	{
		detail		0.5
		duration	8,8
		count		12,12

		sprite
		{
			duration	1,2
			material	"gfx/effects/smoke/steam_alpha"

			start
			{
				position { sphere -99,-99,-99,99,99,99 }
				velocity { box -4,-4,-4,4,4,4 }
				size { point 100,100 }
				tint { line 0.403922,0.886275,0.427451,0.207843,0.0666667,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "exp_x2" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 300,300 }
				rotate { box -0.0833333,0.0833333 relative }
			}
		}
	}
	emitter "white_round_alpha1"
	{
		duration	8,8
		count		1,1

		sprite
		{
			duration	1,1.5
			material	"gfx/effects/smoke/white_alpha"
			gravity		-0.05,-0.01

			start
			{
				position { sphere 10,-50,-50,10,50,50 }
				velocity { box -10,-10,-10,10,10,10 }
				size { point 100,100 }
				tint { point 0.670588,0.937255,0.682353 }
				rotate { point -0.08 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" offset 0.5 }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 300,300 }
			}
		}
	}
	emitter "steam2"
	{
		detail		0.5
		duration	8,8
		count		50,50

		sprite
		{
			duration	1.5,3
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.08,-0.08
			generatedNormal

			start
			{
				position { cylinder 0,-10,-10,0,10,10 surface }
				velocity { box 0,0,-50,0,0,50 }
				size { point 30,30 }
				tint { line 0.576471,0.921569,0.584314,0.784314,0.768628,0.447059 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 100,100 }
			}
		}
	}
	emitter "white_round_alpha3"
	{
		duration	8,8
		count		1,1

		sprite
		{
			duration	1.5,2
			material	"gfx/effects/smoke/white_alpha"
			gravity		-0.05,-0.01

			start
			{
				position { sphere 10,-50,-50,10,50,50 }
				velocity { box -10,-10,-10,10,10,10 }
				size { point 100,100 }
				tint { line 0.854902,0.92549,0.615686,1,1,0.501961 }
				rotate { point 0.08 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" offset 0.5 }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 250,250 }
			}
		}
	}
	emitter "warm_round_add"
	{
		detail		0.5
		start		0.55,0.55
		duration	8,8
		count		1,1

		sprite
		{
			duration	1.5,2
			material	"gfx/effects/smoke/cloud_alpha"

			start
			{
				velocity { box -20,-10,-10,20,10,10 }
				size { point 100,100 }
				tint { point 0.411765,0.329412,0.239216 }
				rotate { box 1,-1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "cosine" offset 0.5,0.5,0.5 }
			}

			end
			{
				size { point 250,250 }
			}
		}
	}
}



