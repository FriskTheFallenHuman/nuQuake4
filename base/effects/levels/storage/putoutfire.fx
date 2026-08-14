effect effects/levels/storage/putoutfire
{
	size	697

	emitter "fire6"
	{
		duration	4,4
		count		10,10

		sprite
		{
			duration	1,1.5
			blend	add
			persist
			material	"gfx/effects/fire/fire1a"
			gravity		-0.15,-0.15

			start
			{
				position { line 0,-90,0,0,90,0 }
				velocity { box 30,0,0,70,0,0 }
				size { point 60,60 }
				tint { line 1,1,1,0.501961,0.501961,0 }
				fade { point 0 }
				offset { box -10,-10,-10,10,10,10 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 70,70,90,250 }
				fade { point 0.6 }
				rotate { box -0.138889,0.138889 relative }
			}
		}
	}
	emitter "fire7"
	{
		duration	5,5
		count		10,10

		sprite
		{
			duration	1,1.5
			blend	add
			persist
			material	"gfx/effects/fire/fire1a"
			gravity		-0.15,-0.15

			start
			{
				position { line 0,-90,0,0,90,0 }
				velocity { box 30,0,0,70,0,0 }
				size { point 60,60 }
				tint { line 1,1,1,0.501961,0.501961,0 }
				fade { point 0 }
				offset { box -10,-10,-10,10,10,10 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 70,70,90,250 }
				fade { point 0.6 }
				rotate { box -0.138889,0.138889 relative }
			}
		}
	}
	emitter "fire8"
	{
		duration	3,3
		count		12,12

		sprite
		{
			duration	0.75,1.45
			blend	add
			persist
			material	"gfx/effects/fire/fire5a"
			gravity		-0.22,-0.22

			start
			{
				position { line 0,-70,0,0,70,0 }
				velocity { box 50,-10,-10,100,10,10 }
				size { box 75,75,90,90 }
				fade { point 0 }
				offset { box -10,-10,-10,10,10,10 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 80,80,90,90 }
				fade { point 1 }
				rotate { box -0.194444,0.194444 relative }
			}
		}
	}
	emitter "fire3"
	{
		duration	3,5
		count		2,2

		sprite
		{
			duration	0.75,1.25
			blend	add
			persist
			material	"gfx/effects/fire/fire3a"
			gravity		-0.2,-0.15

			start
			{
				position { line 10,-60,0,80,60,0 }
				velocity { box 50,-15,-15,120,15,15 }
				angle { box 0,0,0,1,1,1 }
				size { box 70,70,90,90 }
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
				size { box 40,40,60,60 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,-0.444444 relative }
			}
		}
	}
	emitter "finalSmoke"
	{
		start		4.5,4.5
		duration	4,4
		count		5,5

		sprite
		{
			duration	5,12
			persist
			material	"gfx/effects/smoke/cloud_alpha2"
			gravity		-0.01,0

			start
			{
				position { box 10,-80,-80,30,80,80 }
				velocity { box 0,-3,-3,3,3,3 }
				size { line 40,40,100,100 }
				tint { line 0.886275,0.886275,0.886275,0.501961,0.501961,0.501961 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 120,120 }
				fade { line 0.2,0.4 }
				rotate { box -0.611111,0.611111 relative }
			}
		}
	}
	emitter "unnamed11"
	{
		duration	5,5
		count		2,6

		oriented
		{
			duration	0.75,1
			blend	add
			material	"gfx/effects/fire/fire1a"

			start
			{
				position { point 1,0,0 }
				size { box 400,230,380,250 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fullflicker" }
			}

			end
			{
				size { box 1,1,30,30 }
			}
		}
	}
	spawner "heathaze"
	{
		count		1,1

		sprite
		{
			duration	3,3
			blend	add
			material	"gfx/effects/energy_sparks/warp_mask"

			start
			{
				velocity { box 80,0,0,100,0,0 }
				size { point 400,400 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				tint { point 0.501961,0.501961,1 }
			}
		}
	}
}





