effect effects/weapons/blaster/fly
{
	size	53

	spawner "line"
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
				size { point 6 }
				offset { point 12,0,0 }
				length { point -40,0,0 }
			}

			motion
			{
				size { envelope random }
				length { envelope random }
			}

			end
			{
				size { point 4 }
				length { point -35,0,0 }
			}
		}
	}
	spawner "line2"
	{
		count		1,1
		locked
		constant

		line
		{
			duration	5,5
			material	"gfx/effects/weapons/blaster_fly"

			start
			{
				position { point -4,0,0 }
				size { point 4 }
				length { point 16,0,0 }
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
				size { box 4,6 }
				tint { point 0.470588,0.470588,0.470588 }
				fade { point 0.8 }
				offset { point 12,0,0 }
				length { box 25,0,0,30,0,0 }
			}

			motion
			{
				fade { envelope random }
			}

			end
			{
				fade { point 0.2 }
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
				size { point 13,13 }
				offset { point 8,0,0 }
				rotate { box 0,0.5 }
			}

			motion
			{
				rotate { envelope linear }
			}

			end
			{
				rotate { box 0.5,1 }
			}
		}
	}
	emitter "smoke"
	{
		duration	15,15
		count		300,300

		sprite
		{
			duration	0.04,0.04
			blend	add
			material	"gfx/effects/weapons/railgun_ring"

			start
			{
				position { point 10,0,0 }
				size { line 4,4,6,6 }
				tint { line 0.568627,0.784314,1,0.568627,0.890196,1 }
				fade { point 0.6 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 15,15,20,20 }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
	emitter "sparks2"
	{
		duration	1,1
		count		100,100

		sprite
		{
			duration	0.5,0.5
			persist
			material	"gfx/effects/smoke/cloud_alpha2"

			start
			{
				angle { box 0,0,0,0.444444,0.444444,0.444444 }
				size { line 6,6,8,8 }
				tint { point 0.733333,0.878431,1 }
				fade { point 0.24 }
				offset { box 0,-5,-2,0,5,2 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope linear }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				angle { box -0.444444,-0.444444,-0.444444,0.444444,0.444444,0.444444 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}






