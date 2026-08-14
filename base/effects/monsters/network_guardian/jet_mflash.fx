effect effects/monsters/network_guardian/jet_mflash
{
	size	166

	emitter "flamecore"
	{
		duration	4,4
		count		8,8
		locked

		line
		{
			duration	0.25,0.25
			material	"gfx/effects/smoke/steam_source"
			generatedNormal

			start
			{
				tint { point 0.501961,0.862745,1 }
				length { point 55,25,55 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { point 22 }
				length { point 55,100,55 }
			}
		}
	}
	emitter "blue_fire"
	{
		duration	4,4
		count		25,25

		sprite
		{
			duration	0.3,0.4
			blend	add
			material	"gfx/effects/fire/fire2b"
			gravity		-0.02,0

			start
			{
				position { line 30,-1,-1,30,1,1 }
				velocity { box 100,-10,-10,250,10,10 }
				size { box 2,2,4,4 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fast_in_slow_out }
				rotate { envelope linear }
			}

			end
			{
				size { box 25,25,50,50 }
				fade { point 1 }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
	emitter "blue_fire2"
	{
		duration	4,4
		count		25,25

		sprite
		{
			duration	0.25,0.35
			blend	add
			material	"gfx/effects/fire/fire5b"
			gravity		-0.02,0

			start
			{
				position { line 30,-1,-1,30,1,1 }
				velocity { box 100,-30,-30,250,30,30 }
				size { box 1,1,2,2 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fast_in_slow_out }
				rotate { envelope linear }
			}

			end
			{
				size { box 15,15,30,30 }
				fade { point 1 }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
	emitter "fire1"
	{
		duration	4,4
		count		5,5

		sprite
		{
			duration	1,1
			blend	add
			persist
			material	"gfx/effects/fire/fire1a"

			start
			{
				position { point 60,0,0 }
				velocity { point 150,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { line 10,10,20,20 }
				fade { point 0.5 }
				offset { box -2,-2,-2,2,2,2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope exp_1minusx/x2 }
				fade { envelope linear }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 30,30,50,50 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -1.38889,1.38889 relative }
			}
		}
	}
	emitter "fire4"
	{
		duration	4,4
		count		8,8

		sprite
		{
			duration	1,1
			blend	add
			persist
			material	"gfx/effects/fire/fire2b"

			start
			{
				position { point 60,0,0 }
				velocity { point 150,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { line 10,10,25,25 }
				fade { point 0.4 }
				offset { box -2,-2,-2,2,2,2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope exp_1minusx/x2 }
				fade { envelope linear }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 30,30,50,50 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -1.38889,1.38889 relative }
			}
		}
	}
	emitter "fire5"
	{
		duration	4,4
		count		10,10

		sprite
		{
			duration	1,1
			blend	add
			persist
			material	"gfx/effects/fire/fire5a"

			start
			{
				position { point 60,0,0 }
				velocity { point 150,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { line 10,10,25,25 }
				fade { point 0.4 }
				offset { box -2,-2,-2,2,2,2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope exp_1minusx/x2 }
				fade { envelope linear }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 30,30,50,50 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -1.38889,1.38889 relative }
			}
		}
	}
}


