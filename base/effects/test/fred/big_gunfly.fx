effect effects/test/fred/big_gunfly
{
	size	959

	spawner "line2"
	{
		count		1,1
		locked
		constant

		line
		{
			duration	5,5
			blend	add
			material	"gfx/effects/weapons/blaster_flyflipped"

			start
			{
				position { point -4,0,0 }
				size { point 40 }
				fade { point 0.5 }
				length { point -360,0,0 }
			}
		}
	}
	spawner "side_streaks"
	{
		count		7,7
		locked
		constant

		line
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/weapons/blaster_flyflipped"
			generatedOriginNormal

			start
			{
				position { cylinder -0.12,-0.05,-0.05,-0.12,0.05,0.05 surface }
				size { box 50,70 }
				tint { line 0.466667,0.466667,0.466667,0,0.501961,0.25098 }
				length { box 200,0,0,300,0,0 }
			}

			motion
			{
				fade { envelope "random" }
			}

			end
			{
				fade { point 0.2 }
			}
		}
	}
	spawner "line3"
	{
		count		1,1
		locked
		constant

		line
		{
			duration	5,5
			material	"gfx/effects/weapons/blaster_flyflipped"

			start
			{
				position { point -4,0,0 }
				size { point 80 }
				length { point -370,0,0 }
			}

			motion
			{
				size { envelope "random" }
				length { envelope "random" }
			}

			end
			{
				size { point 30 }
				length { point -340,0,0 }
			}
		}
	}
	emitter "orbit"
	{
		duration	30,30
		count		15,15
		locked

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/plasma1"

			start
			{
				velocity { box -300,-200,-200,-300,200,200 }
				angle { box 0,0,-1,0,0,1 }
				size { line 20,20,200,200 }
				fade { point 0.25 }
				offset { box 0,-50,-50,0,50,50 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 500,500 }
			}
		}
	}
	spawner "flash"
	{
		count		1,1
		locked
		constant

		sprite
		{
			duration	1,1
			material	"gfx/effects/weapons/blaster_fly2"

			start
			{
				position { point -4,0,0 }
				size { point 150,150 }
				rotate { box 0,0.5 }
			}

			motion
			{
				rotate { envelope "linear" }
			}

			end
			{
				rotate { box 0.5,1 }
			}
		}
	}
}
