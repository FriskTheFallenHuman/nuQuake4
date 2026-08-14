effect effects/levels/dispersal/heart_shock2
{
	size	498

	spawner "electricity"
	{
		count		1,1
		locked

		line
		{
			duration	2.5,2.5
			blend	add
			material	"gfx/test/lgun"

			start
			{
				size { point 20 }
				fade { point 0 }
				length { point 60,0,0 }
			}

			motion
			{
				size { envelope "random" count 0.2 }
				tint { envelope "flickerblink" count 8,8,8 }
				fade { envelope "decalfade" }
			}

			end
			{
				size { point 60 }
				tint { point 0.247059,0.247059,0.247059 }
				fade { point 1 }
			}
		}
	}
	emitter "center"
	{
		duration	2.4,2.4
		count		10,10
		locked

		sprite
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				velocity { box 0,-20,-20,50,20,20 }
				size { box 6,6,10,10 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "cosine" }
				fade { envelope "pop_hold_fade" }
			}

			end
			{
				size { box 15,15,25,25 }
				fade { point 1 }
			}
		}
	}
	emitter "sparks_lines"
	{
		start		0.5,0.5
		duration	1.5,1.5
		count		20,20

		line
		{
			duration	1.5,2
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2"
			gravity		0.1,0.6
			generatedOriginNormal

			start
			{
				position { cylinder 0.5,-0.5,-0.5,0,0.5,0.5 }
				velocity { box 10,0,0,50,0,0 }
				size { box 1.5,2 }
				tint { line 1,0.941177,0.8,1,1,1 }
				length { box 4,0,0,6,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" offset 0.2,0.2,0.2 }
			}

			end
			{
				size { point 0 }
				tint { line 0.941177,0.639216,0.219608,0.74902,0.447059,0.164706 }
			}
		}
	}
	emitter "forks"
	{
		duration	2,2
		count		6,6
		locked

		electricity
		{
			duration	0.5,0.5
			blend	add
			fork	2
			jitterRate	0
			jitterSize	3,7,7
			jitterTable	"halfsintable"
			material	"gfx/effects/weapons/rail_spiral"
			generatedOriginNormal

			start
			{
				position { cylinder 0.1,-0.1,-0.1,0.1,0.1,0.1 }
				size { box 1,1.5 }
				tint { line 0.823529,0.913726,1,0.807843,0.960784,0.992157 }
				fade { point 0.5 }
				length { box 80,0,0,100,0,0 }
			}
		}
	}
	emitter "flash"
	{
		duration	0.2,0.2
		count		15,15
		locked

		sprite
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				size { point 80,80 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "pop_hold_fade" }
			}

			end
			{
				fade { point 1 }
			}
		}
	}
	light "unnamed0"
	{
		locked

		light
		{
			duration	2.4,2.4
			material	"lights/rav_slowfalloff"

			start
			{
				size { point 128,128,128 }
			}
		}
	}
	emitter "forks2"
	{
		duration	2,2
		count		6,6
		locked

		electricity
		{
			duration	0.5,0.5
			blend	add
			fork	2
			jitterRate	0
			jitterSize	3,7,7
			jitterTable	"halfsintable"
			material	"gfx/effects/weapons/rail_spiral"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder 0.1,-0.1,-0.1,0.1,0.1,0.1 }
				size { box 0.5,2 }
				tint { line 0.823529,0.913726,1,0.807843,0.960784,0.992157 }
				fade { point 0.5 }
				length { box 80,0,0,300,0,0 }
			}
		}
	}
}
