effect effects/fire/gasjet_sky4
{
	size	25

	emitter "flamecore"
	{
		duration	1,1
		count		8,8
		locked

		line
		{
			duration	0.25,0.25
			material	"gfx/effects/smoke/steam_source"
			generatedNormal

			start
			{
				size { point 0.25 }
				tint { point 0.501961,0.858824,1 }
				length { point 1,1,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				length { point 8,8,8 }
			}
		}
	}
	emitter "smoke"
	{
		duration	1,1
		count		8,8

		sprite
		{
			duration	1,5
			material	"gfx/effects/smoke/smoke_dark"
			gravity		-0.001,0
			generatedOriginNormal

			start
			{
				position { point 2,0,0 }
				velocity { box 1,-2,-2,2,2,2 }
				size { box 1,1,2,2 }
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
				size { box 5,5,10,10 }
				fade { point 0.2 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	emitter "fire"
	{
		duration	1,1
		count		3,3

		sprite
		{
			duration	0.5,2
			blend	add
			material	"gfx/effects/fire/fire4a"
			gravity		-0.002,0

			start
			{
				position { line 2,-1,-1,2,1,1 }
				velocity { box 1,-0.5,-0.5,2,0.5,0.5 }
				size { line 1,1,2,2 }
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
				size { box 3,3,5,5 }
				fade { point 1 }
				rotate { box -0.166667,0.166667 relative }
			}
		}
	}
	emitter "fire2"
	{
		duration	1,1
		count		2,2

		sprite
		{
			duration	0.5,2
			blend	add
			material	"gfx/effects/fire/fire1a"
			gravity		-0.002,0

			start
			{
				position { line 1,-1,-1,1,1,1 }
				velocity { box 1,-0.5,-0.5,2,0.5,0.5 }
				size { box 0.5,0.5,1,1 }
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
				size { box 4,4,5,6 }
				fade { point 1 }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
	emitter "fire3"
	{
		duration	1,1
		count		4,4

		sprite
		{
			duration	0.5,2
			blend	add
			material	"gfx/effects/fire/fire3a"

			start
			{
				position { line 2,-1,-1,2,1,1 }
				velocity { box 1,-0.5,-0.5,2,0,0.5 }
				size { box 0.5,0.5,1,1 }
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
				size { box 3,3,5,5 }
				fade { point 1 }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
	emitter "fire4"
	{
		duration	1,1
		count		8,8

		sprite
		{
			duration	0.5,2
			blend	add
			material	"gfx/effects/fire/fire1a"

			start
			{
				position { line 0,-0.5,-0.5,0,0.5,0.5 }
				velocity { box -0.5,-0.5,-0.5,0.5,0.5,0.5 }
				size { point 0,0 }
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
				size { box 2,2,2.5,2.5 }
				fade { point 0.5 }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
	delay "unnamed6"
	{
		duration	3,10
	}
}
