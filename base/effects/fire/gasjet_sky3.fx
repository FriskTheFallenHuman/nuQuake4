effect effects/fire/gasjet_sky3
{
	size	282

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
				velocity { box 60,-5,-5,120,5,5 }
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
				size { box 100,100,150,150 }
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
				velocity { box 100,-2,-2,200,2,2 }
				size { line 10,10,20,20 }
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
				size { box 30,30,50,50 }
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
				velocity { box 100,-5,-5,200,5,5 }
				size { box 5,5,10,10 }
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
				size { box 40,40,50,50 }
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
				velocity { box 100,-8,-8,150,8,8 }
				size { box 5,5,10,10 }
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
				size { box 30,30,50,50 }
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
				size { point 30,30 }
				fade { point 0.5 }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
	delay "unnamed5"
	{
		start		0,5
		duration	10,10
	}
}
