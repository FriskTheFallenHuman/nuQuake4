effect effects/monsters/harvester/rocket_trail
{
	size	495

	emitter "smoke"
	{
		duration	1,1
		count		5,5

		line
		{
			duration	1.5,2
			persist
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				position { point -40,0,0 }
				size { box 60,75 }
				tint { point 0.490196,0.494118,0.403922 }
				fade { point 0 }
				length { point -400,0,0 }
			}

			motion
			{
				fade { envelope "cosine" }
			}

			end
			{
				fade { point 0.5 }
			}
		}
	}
	emitter "line_inner"
	{
		duration	1,1
		count		10,10

		line
		{
			duration	0.5,0.6
			blend	add
			material	"gfx/effects/fire/fireline1"

			start
			{
				position { point 20,0,0 }
				size { box 40,80 }
				fade { point 0.6 }
				length { box -300,0,0,-200,0,0 }
			}

			motion
			{
				size { envelope "linear" }
			}

			end
			{
				size { box 10,20 }
			}
		}
	}
	emitter "side_streaks"
	{
		duration	1,1
		count		20,20
		locked

		line
		{
			duration	0.6,0.6
			blend	add
			material	"gfx/effects/weapons/flash_half"
			generatedOriginNormal

			start
			{
				position { cylinder -0.1,-0.1,-0.1,-0.1,0.1,0.1 surface }
				size { box 30,40 }
				tint { point 0.486275,0.682353,1 }
				fade { point 0 }
				offset { point -3,0,0 }
				length { box 100,0,0,150,0,0 }
			}

			motion
			{
				fade { envelope "fast_in_slow_out" }
				length { envelope "linear" }
			}

			end
			{
				fade { point 0.75 }
				length { box 60,0,0,80,0,0 }
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
			material	"gfx/effects/energy_sparks/spark3"

			start
			{
				position { point -10,0,0 }
				size { point 300,300 }
			}

			motion
			{
				size { envelope "random" }
			}

			end
			{
				size { point 200,200 }
			}
		}
	}
}


