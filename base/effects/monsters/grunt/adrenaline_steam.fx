effect effects/monsters/grunt/adrenaline_steam
{
	size	46

	emitter "elect2"
	{
		duration	0.2,0.2
		count		4,4
		locked

		electricity
		{
			duration	0.1,0.1
			fork	0
			jitterRate	0
			jitterSize	3,7,7
			material	"gfx/effects/electricity/electric_blue_fade"
			generatedNormal

			start
			{
				position { cylinder 0,-5,-5,0,5,5 }
				size { box 0.5,1 }
				tint { point 0.662745,0.847059,0.666667 }
				length { box 10,0,0,30,0,0 }
			}
		}
	}
	emitter "smoke"
	{
		duration	0.5,1
		count		2,2

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.15,-0.05

			start
			{
				position { cylinder 0,-4,-4,0,4,4 }
				size { point 5,5 }
				tint { line 0.505882,0.533333,0.341176,0.203922,0.403922,0.254902 }
				fade { line 0.5,1 }
				rotate { box 0,0.5 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope cosine offset 0.5 }
				rotate { envelope linear }
			}

			end
			{
				size { point 30,30 }
				tint { line 0,0.247059,0,0,0.247059,0.247059 }
				rotate { box 0,-0.5 relative }
			}
		}
	}
	emitter "unnamed9"
	{
		duration	0.2,0.2
		count		1,1
		locked

		electricity
		{
			duration	0.5,0.5
			fork	0
			jitterRate	0
			jitterSize	3,7,7
			material	"gfx/effects/electricity/electric_blue_fade"
			generatedOriginNormal

			start
			{
				position { cylinder 0,-1,-1,0,1,1 surface }
				size { point 2 }
				tint { point 0.65098,0.870588,0.403922 }
			}

			motion
			{
				length { envelope linear }
			}

			end
			{
				length { box 20,0,0,25,0,0 }
			}
		}
	}
	spawner "unnamed11"
	{
		count		1,1
		locked

		electricity
		{
			duration	1,1
			fork	0
			jitterRate	0
			jitterSize	3,7,7
			material	"gfx/effects/electricity/electric_blue_fade"
			generatedOriginNormal

			start
			{
				position { line 0,-4,-4,0,4,4 }
				tint { point 0.686275,0.882353,0.32549 }
			}

			motion
			{
				length { envelope linear }
			}

			end
			{
				length { box 5,0,0,7,0,0 }
			}
		}
	}
	emitter "glow"
	{
		duration	5,10
		count		8,8
		locked

		sprite
		{
			duration	0.5,1
			material	"gfx/effects/smoke/cloud_alpha2"

			start
			{
				position { cylinder 0,-4,-4,0,4,4 }
				velocity { box 10,-10,-10,10,10,10 }
				size { point 5,5 }
				tint { line 0.521569,0.815686,0.25098,0.376471,0.560784,0.203922 }
				fade { point 0.25 }
				rotate { box 0,0.5 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine offset 0.5 }
				rotate { envelope linear }
			}

			end
			{
				size { point 20,20 }
				rotate { box 0,-0.5 relative }
			}
		}
	}
}



