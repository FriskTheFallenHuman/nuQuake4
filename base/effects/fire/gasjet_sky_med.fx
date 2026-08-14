effect effects/fire/gasjet_sky_med
{
	size	16

	emitter "flamecore"
	{
		start		0.5,0.5
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
				offset { point -5,1,0 }
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
				length { point 5,5,5 }
			}
		}
	}
	emitter "smoke"
	{
		start		0.5,0.5
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
				position { point 1,0,0 }
				velocity { box 1,-0.5,-0.5,2,0.5,0.5 }
				size { box 1,1,2,2 }
				fade { point 0 }
				offset { point -5,1,0 }
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
				size { box 2,2,3,3 }
				fade { point 0.1 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	emitter "fire"
	{
		start		0.5,0.5
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
				position { point 1,0,0 }
				velocity { box 1,-0.5,-0.5,2,0.5,0.5 }
				size { line 1,1,2,2 }
				fade { point 0 }
				offset { point -5,1,0 }
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
				size { box 2,2,3,3 }
				fade { line 0.3,0.5 }
				rotate { box -0.166667,0.166667 relative }
			}
		}
	}
	emitter "fire2"
	{
		start		0.5,0.5
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
				velocity { box 1,-0.5,-0.5,2,0.5,0.5 }
				size { box 0.5,0.5,1,1 }
				fade { point 0 }
				offset { point -5,1,0 }
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
				size { box 1,1,2,2 }
				fade { line 0.3,0.5 }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
	emitter "fire3"
	{
		start		0.5,0.5
		duration	1,1
		count		4,4

		sprite
		{
			duration	0.5,2
			blend	add
			material	"gfx/effects/fire/fire3a"

			start
			{
				position { point 1,0,0 }
				velocity { box 1,-0.5,-0.5,2,0.5,0.5 }
				size { box 0.5,0.5,1,1 }
				fade { point 0 }
				offset { point -5,1,0 }
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
				size { box 1,1,2,2 }
				fade { line 0.3,0.5 }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
	emitter "fire4"
	{
		start		0.5,0.5
		duration	1,1
		count		8,8

		sprite
		{
			duration	0.5,2
			blend	add
			material	"gfx/effects/fire/fire1a"

			start
			{
				velocity { box -0.5,-0.2,-0.2,0.5,0.2,0.2 }
				size { point 0,0 }
				fade { point 0 }
				offset { point -5.25,1,0 }
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
				size { box 1,1,1.5,1.5 }
				fade { line 0.3,0.5 }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
	emitter "flamecore2"
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
				offset { point -5,-0.8,0 }
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
				length { point 5,5,5 }
			}
		}
	}
	emitter "smoke2"
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
				position { point 1,0,0 }
				velocity { box 1,-0.5,-0.5,2,0.5,0.5 }
				size { box 1,1,2,2 }
				fade { point 0 }
				offset { point -5,-0.8,0 }
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
				size { box 2,2,3,3 }
				fade { point 0.1 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	emitter "fire5"
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
				position { point 1,0,0 }
				velocity { box 1,-0.5,-0.5,2,0.5,0.5 }
				size { line 1,1,2,2 }
				fade { point 0 }
				offset { point -5,-0.8,0 }
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
				size { box 2,2,3,3 }
				fade { line 0.3,0.5 }
				rotate { box -0.166667,0.166667 relative }
			}
		}
	}
	emitter "fire6"
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
				velocity { box 1,-0.5,-0.5,2,0.5,0.5 }
				size { box 0.5,0.5,1,1 }
				fade { point 0 }
				offset { point -5,-0.8,0 }
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
				size { box 1,1,2,2 }
				fade { line 0.3,0.5 }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
	emitter "fire7"
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
				position { point 1,0,0 }
				velocity { box 1,-0.5,-0.5,2,0.5,0.5 }
				size { box 0.5,0.5,1,1 }
				fade { point 0 }
				offset { point -5,-0.8,0 }
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
				size { box 1,1,2,2 }
				fade { line 0.3,0.5 }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
	emitter "fire8"
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
				velocity { box -0.5,-0.2,-0.2,0.5,0.2,0.2 }
				size { point 0,0 }
				fade { point 0 }
				offset { point -5,-0.8,0 }
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
				size { box 1,1,1.5,1.5 }
				fade { line 0.3,0.5 }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
	delay "unnamed12"
	{
		duration	6,6
	}
}

