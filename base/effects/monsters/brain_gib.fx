effect effects/monsters/brain_gib
{
	size	259

	spawner "blood"
	{
		count		3,3

		sprite
		{
			duration	0.7,1
			material	"gfx/effects/gore_spray/bloodhit3"
			gravity		0.05,0.05

			start
			{
				position { line 0,0,0,10,0,0 linearSpacing }
				velocity { box 20,0,0,80,0,80 }
				size { line 50,50,60,60 }
				tint { line 0.94902,0.54902,0.54902,0.466667,0,0 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 100,100,140,140 }
				fade { point 1 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	spawner "blood2"
	{
		count		3,3

		sprite
		{
			duration	0.7,1
			material	"gfx/effects/gore_spray/bloodhit4"
			gravity		0.05,0.05

			start
			{
				position { line 0,0,0,10,0,0 linearSpacing }
				velocity { box 10,0,0,40,0,80 }
				size { line 50,50,60,60 }
				tint { line 0.113725,0.0156863,0.0156863,0.156863,0,0 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 100,100,140,140 }
				fade { point 1 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	spawner "blood_streaks"
	{
		count		25,25
		locked

		line
		{
			duration	0.25,0.5
			generatedLine
			material	"gfx/effects/gore_spray/bloodline1"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.3,-0.3,0.2,0.3,0.3 surface }
				velocity { point 1,0,0 }
				size { box 15,20 }
				tint { point 0.309804,0.101961,0.0431373 }
				length { box 40,0,0,45,0,0 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				tint { point 0.14902,0.0509804,0.0156863 }
				length { box 150,0,0,200,0,0 }
			}
		}
	}
	decal "splat2"
	{

		decal
		{
			duration	0.002,0.002
			material	"textures/decals/splat2_fadelong"

			start
			{
				size { line 70,70,130,130 }
				rotate { box 0,1 }
			}
		}
	}
}

