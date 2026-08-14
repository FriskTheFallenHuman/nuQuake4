effect effects/levels/dispersal/supportbreak
{
	size	428

	spawner "dust2"
	{
		count		15,15

		sprite
		{
			duration	1.5,3
			persist
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		0.001,0.01

			start
			{
				position { line 0,-90,0,0,90,0 linearSpacing }
				velocity { box -10,-50,10,60,50,-150 }
				size { line 20,20,30,30 }
				tint { line 0.494118,0.494118,0.494118,0.294118,0.345098,0.305882 }
				fade { point 0 }
				offset { point 0,-8,8 }
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
				size { line 50,50,80,80 }
				tint { point 0.341176,0.341176,0.341176 }
				fade { line 0.5,0.8 }
				rotate { box -0.305556,0.305556 relative }
			}
		}
	}
	spawner "dust3"
	{
		count		15,15

		sprite
		{
			duration	0.5,1.2
			persist
			material	"gfx/effects/smoke/cloud_alpha"

			start
			{
				position { line 0,-90,0,0,90,0 linearSpacing }
				velocity { box -10,-90,-10,60,90,-260 }
				size { line 20,20,30,30 }
				tint { line 0.494118,0.494118,0.494118,0.294118,0.345098,0.305882 }
				fade { point 0 }
				offset { point 0,-8,8 }
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
				size { line 50,50,70,70 }
				tint { point 0.341176,0.341176,0.341176 }
				fade { point 1 }
				rotate { box -0.305556,0.305556 relative }
			}
		}
	}
	spawner "dust4"
	{
		count		4,4

		sprite
		{
			duration	5,10
			persist
			material	"gfx/effects/smoke/cloud_alpha"

			start
			{
				position { line 0,-90,-90,0,90,-90 linearSpacing }
				velocity { box -10,-10,0,10,10,-10 }
				size { point 100,100 }
				tint { line 0.494118,0.494118,0.494118,0.294118,0.345098,0.305882 }
				fade { point 0 }
				offset { point 0,-8,8 }
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
				size { point 200,200 }
				tint { point 0.341176,0.341176,0.341176 }
				fade { line 0.3,0.4 }
				rotate { box -0.305556,0.305556 relative }
			}
		}
	}
}

