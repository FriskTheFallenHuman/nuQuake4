effect effects/monsters/makron/black_absorb
{
	size	496

	emitter "center2"
	{
		duration	1,1
		count		7,7
		locked

		sprite
		{
			duration	1,1
			material	"gfx/effects/weapons/darkmatter_haze"

			start
			{
				size { box 300,300,350,350 }
				fade { point 0 }
				rotate { box 1,-1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 0,0 }
				fade { point 1 }
			}
		}
	}
	emitter "unnamed5"
	{
		duration	1,1
		count		7,7
		locked

		oriented
		{
			duration	1,1
			material	"gfx/effects/weapons/darkmatter_haze"

			start
			{
				position { point 1,0,0 }
				size { box 300,300,350,350 }
				fade { point 0 }
				rotate { box 0,0,-1,0,0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 0,0 }
				fade { point 1 }
			}
		}
	}
	emitter "electricity"
	{
		duration	1,1
		count		5,5
		locked

		electricity
		{
			duration	1,1
			blend	add
			fork	0
			jitterRate	0
			jitterSize	6,14,14
			jitterTable	"halfsintable"
			material	"gfx/effects/weapons/darkmatterbolt"
			generatedNormal

			start
			{
				position { sphere 0,-80,-80,0,80,80 surface }
				size { point 4 }
				tint { line 0.866667,0.615686,1,1,1,1 }
				fade { point 0.5 }
				length { box 60,0,0,100,0,0 }
			}

			motion
			{
				fade { envelope "linear" }
				length { envelope "linear" }
			}
		}
	}
	emitter "center3"
	{
		duration	1,1
		count		20,20
		locked

		sprite
		{
			duration	1,2
			persist
			material	"gfx/effects/weapons/darkmatter_haze"

			start
			{
				velocity { point 10,0,0 }
				size { line 40,40,45,44 }
				fade { point 0.75 }
				offset { box -100,-100,-100,100,100,100 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" offset 0.5 }
				offset { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 10,10,20,20 }
				offset { point 1,1,1 }
				rotate { box -0.25,0.25 relative }
			}
		}
	}
}

