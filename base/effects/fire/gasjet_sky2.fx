effect effects/fire/gasjet_sky2
{
	size	32

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
				offset { point 0,1,0 }
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
	emitter "smoke2"
	{
		duration	1,1
		count		8,8

		sprite
		{
			duration	1,1.25
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.01,0.01
			generatedOriginNormal

			start
			{
				position { point 5,0,0 }
				velocity { box 6,-5,-5,12,5,5 }
				size { box 5,5,10,10 }
				tint { line 0.501961,0.501961,0.501961,0.227451,0.290196,0.388235 }
				fade { point 0 }
				offset { point 0,1,0 }
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
				size { box 10,10,15,15 }
				fade { point 0.2 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	emitter "fire5"
	{
		duration	1,1
		count		15,15

		sprite
		{
			duration	0.25,0.5
			blend	add
			material	"gfx/effects/fire/fire4a"
			gravity		-0.02,0

			start
			{
				position { line 2,-1,-1,2,1,1 }
				velocity { box 10,-2,-2,20,2,2 }
				size { line 1,1,2,2 }
				fade { point 0 }
				offset { point 0,1,0 }
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
	emitter "fire6"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	0.25,0.5
			blend	add
			material	"gfx/effects/fire/fire1a"
			gravity		-0.02,0

			start
			{
				position { line 1,-1,-1,1,1,1 }
				velocity { box 10,-5,-5,20,5,5 }
				size { box 0.5,0.5,1,1 }
				fade { point 0 }
				offset { point 0,1,0 }
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
	emitter "fire7"
	{
		duration	1,1
		count		15,15

		sprite
		{
			duration	0.25,0.5
			blend	add
			material	"gfx/effects/fire/fire3a"
			gravity		-0.02,0

			start
			{
				position { line 2,-1,-1,2,1,1 }
				velocity { box 10,-8,-8,25,8,8 }
				size { box 0.5,0.5,1,1 }
				fade { point 0 }
				offset { point 0,1,0 }
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
	emitter "fire8"
	{
		duration	1,1
		count		8,8

		sprite
		{
			duration	0.25,0.5
			blend	add
			material	"gfx/effects/fire/fire1a"

			start
			{
				position { line 0,-0.5,-0.5,0,0.5,0.5 }
				velocity { box -2,-3,-3,2,3,3 }
				size { point 0,0 }
				fade { point 0 }
				offset { point 0,1,0 }
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
	delay "unnamed12"
	{
		duration	5,5
	}
}
