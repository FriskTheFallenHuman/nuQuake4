effect effects/levels/terminal/brain_laser_impact_bad
{
	size	91

	emitter "steam"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	1,1
			persist
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.04,-0.01

			start
			{
				position { line 0,-2,-2,0,2,2 }
				velocity { box 10,-10,-10,30,10,10 }
				size { point 15,15 }
				tint { line 0.67451,0.654902,0.576471,0.67451,0.647059,0.564706 }
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
				size { point 50,50 }
				fade { point 0.5 }
				rotate { box -0.166667,0.166667 relative }
			}
		}
	}
	emitter "o_sparks"
	{
		duration	1,1
		count		7,7

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/spark2_red"

			start
			{
				position { point 1,0,0 }
				size { line 50,50,60,60 }
				fade { point 0 }
				offset { box 0,0,0,5,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
			}

			end
			{
				size { box 5,5,1,1 }
				fade { point 0.5 }
			}
		}
	}
	emitter "sparks2"
	{
		duration	1,1
		count		20,50

		sprite
		{
			duration	0.75,0.75
			blend	add
			persist
			material	"gfx/effects/energy_sparks/spark2_red"
			gravity		0.25,0.25

			start
			{
				position { sphere 0,-5,-5,0,5,5 }
				velocity { box 20,-10,-10,50,10,10 }
				size { line 1,1,2,2 }
				rotate { box -1,1 }
			}

			motion
			{
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				rotate { point 0 relative }
			}
		}
	}
	emitter "sparks3"
	{
		duration	1,1
		count		3,3

		sprite
		{
			duration	0.75,0.75
			blend	add
			persist
			material	"gfx/effects/energy_sparks/spark2_red"

			start
			{
				velocity { point 30,0,0 }
				size { line 10,10,20,20 }
				rotate { box -1,1 }
			}

			motion
			{
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				rotate { point 0 relative }
			}
		}
	}
}



