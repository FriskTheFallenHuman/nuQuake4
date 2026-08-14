effect effects/levels/storage/roofcoreconnection
{
	size	20120

	emitter "beamCore"
	{
		duration	1,1
		count		14,14

		line
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/energy_sparks/red_beam"

			start
			{
				size { point 20 }
				length { point 20000,0,0 }
			}

			motion
			{
				size { envelope "arch" }
				fade { envelope "linear" }
			}

			end
			{
				size { box 25,35 }
			}
		}
	}
	emitter "beamMotion"
	{
		duration	1,1
		count		40,40

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/spark2_red"

			start
			{
				position { point 20,0,0 }
				velocity { box 1800,0,0,2000,0,0 }
				size { point 80,80 }
				tint { line 1,0.301961,0,1,0.847059,0 }
				fade { point 0.15 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "cosine" count 0.4,0.4 }
			}

			end
			{
				size { point 10,10 }
			}
		}
	}
	emitter "subtleGlow"
	{
		duration	1,1
		count		4,4

		line
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/energy_sparks/red_beam"

			start
			{
				size { point 70 }
				tint { point 1,0.219608,0 }
				fade { point 0.2 }
				length { point 20000,0,0 }
			}

			motion
			{
				size { envelope "arch" }
			}

			end
			{
				size { box 100,120 }
			}
		}
	}
	emitter "spikeGlow"
	{
		duration	1,1
		count		8,8

		sprite
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/particles_shapes/spike"

			start
			{
				position { point 15,0,0 }
				velocity { box 400,0,0,800,0,0 }
				size { line 20,20,40,40 }
				tint { line 1,0.501961,0.247059,1,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "cosine" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 225,225,300,300 }
				rotate { box -0.0277778,0.0277778 relative }
			}
		}
	}
	emitter "glowCover"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	0.5,0.5
			material	"gfx/effects/energy_sparks/spark2_red"

			start
			{
				position { point 1,0,0 }
				size { point 20,20 }
			}

			motion
			{
				size { envelope "flickerblink" }
			}

			end
			{
				size { point 50,50 }
			}
		}
	}
	emitter "beamMotion2"
	{
		duration	1,1
		count		40,40

		sprite
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/energy_sparks/spark2_red"

			start
			{
				velocity { point 1500,0,0 }
				size { point 40,40 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}
		}
	}
	emitter "THELIGHT"
	{
		duration	1,1
		count		2,2

		line
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/teleport_light"

			start
			{
				size { box 30,80 }
				tint { point 1,0.501961,0 }
				length { box 250,0,0,370,0,0 }
			}

			motion
			{
				size { envelope "flickerblink" }
				fade { envelope "fadeouttable" }
			}
		}
	}
	emitter "teleportringmove2"
	{
		duration	1,1
		count		11,11

		oriented
		{
			duration	4,4
			blend	add
			material	"gfx/effects/energy_sparks/teleport_base"

			start
			{
				position { point 1,0,0 }
				velocity { point 600,0,0 }
				size { point 50,50 }
				tint { point 1,0.501961,0 }
				fade { point 0 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "pop_hold_fade" offset 0.4 }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 6,6 }
				fade { line 0.6,1 }
				rotate { box 0,0,-0.222222,0,0,0.222222 relative }
			}
		}
	}
	emitter "elect5"
	{
		duration	1,1
		count		10,20

		electricity
		{
			duration	0.5,1
			fork	1
			jitterRate	0.2
			jitterSize	2,15,15
			jitterTable	"halfsintable"
			material	"gfx/effects/electricity/electric_blue_fade"
			generatedOriginNormal

			start
			{
				position { sphere 0.1,-1,-1,0.5,1,1 }
				velocity { box 0,0,0,20,0,0 }
				size { box 1.5,3 }
				tint { line 1,0,0,1,0.501961,0 }
				length { box 10,0,0,20,0,0 }
			}

			motion
			{
				tint { envelope "linear" count 2,2,2 offset -1,-1,-1 }
				length { envelope "linear" }
			}

			end
			{
				length { box 100,0,0,300,0,0 }
			}
		}
	}
	emitter "Gas "
	{
		duration	1,1
		count		5,5
		locked

		oriented
		{
			duration	2,2
			material	"gfx/effects/weapons/plasma1"

			start
			{
				position { line -50,0,0,100,0,0 }
				size { box 50,100,200,200 }
				tint { point 0.176471,0.0392157,0 }
				fade { point 0.3 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
			}

			end
			{
				size { box 600,600,700,700 }
			}
		}
	}
	sound "unnamed10"
	{
		soundShader	"ambient_roof_core"
		freqshift	1.5,1.5
	}
	sound "unnamed11"
	{
		soundShader	"ambient_roof_core2"
		volume	0.5,0.5
		freqshift	1.9,1.9
	}
}








