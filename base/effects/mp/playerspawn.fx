effect effects/mp/playerspawn
{
	size	260

	spawner "unnamed2"
	{
		count		50,50

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/teleport_base3"
			gravity		0.01,0.05

			start
			{
				position { cylinder 10,-40,-40,100,40,40 }
				velocity { box 0,-10,-10,0,10,10 }
				size { line 3,3,5,5 }
				tint { line 1,1,1,0.901961,1,0.803922 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
	emitter "unnamed4"
	{
		duration	1,1
		count		20,20

		line
		{
			duration	1,1
			material	"gfx/effects/energy_sparks/teleport_light"

			start
			{
				position { point -20,0,0 }
				angle { box 0,0,-0.5,0,0,0.5 }
				size { box 5,10 }
				offset { box 0,30,0,0,40,0 }
				length { box 140,0,0,200,0,0 }
			}

			motion
			{
				size { envelope linear }
				angle { envelope linear }
			}

			end
			{
				size { point 0 }
				angle { box 0,0,-0.5,0,0,0.5 relative }
			}
		}
	}
	spawner "teleportring"
	{
		count		2,2

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/teleport_base"

			start
			{
				position { point 1,0,0 }
				size { point 90,90 }
				fade { point 0 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				fade { envelope cosine }
				rotate { envelope linear }
			}

			end
			{
				fade { point 1 }
				rotate { box 0,0,-0.222222,0,0,0.222222 relative }
			}
		}
	}
	emitter "teleportglow"
	{
		duration	1,1
		count		4,4

		oriented
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/energy_sparks/teleport_base2"

			start
			{
				position { point 1,0,0 }
				size { line 75,75,100,100 }
				tint { point 0.807843,1,0.862745 }
				fade { point 0 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine }
			}

			end
			{
				size { line 100,100,150,150 }
				fade { point 1 }
			}
		}
	}
	emitter "orbit4"
	{
		duration	1,1
		count		30,30

		sprite
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/energy_sparks/teleport_base3"
			generatedOriginNormal
			trailType	burn
			trailTime	0.25,0.25
			trailCount	10,10

			start
			{
				angle { box 0,0,0,0,0,1 }
				size { line 2,2,3,3 }
				offset { box 2,-50,0,80,50,0 }
				rotate { box 0,0.0333333 }
			}

			motion
			{
				tint { envelope linear }
				fade { envelope linear }
				angle { envelope linear }
			}

			end
			{
				tint { point 0,0.501961,0 }
				angle { box 0,0,-0.555556,0,0,0.555556 relative }
			}
		}
	}
	emitter "orbit_cheap2"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/teleport_orbit1"

			start
			{
				position { point 1,0,0 }
				size { point 90,90 }
			}

			motion
			{
				tint { envelope cosine offset 0.5,0.5,0.5 }
			}

			end
			{
				tint { point 0.501961,0.501961,0.501961 }
			}
		}
	}
	emitter "orbit_cheap4"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/teleport_orbit3"

			start
			{
				position { point 1,0,0 }
				size { point 100,100 }
				fade { point 0.75 }
				offset { point 2,0,0 }
			}

			motion
			{
				rotate { envelope linear }
			}

			end
			{
				rotate { point 0,0,0 relative }
			}
		}
	}
	emitter "orbit_cheap5"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/teleport_orbit2"

			start
			{
				position { point 1,0,0 }
				size { point 80,80 }
				fade { point 0.75 }
				offset { point 2,0,0 }
			}

			motion
			{
				rotate { envelope linear }
			}

			end
			{
				rotate { point 0,0,0 relative }
			}
		}
	}
	sound "unnamed1"
	{
		soundShader	"mp_player_sounds_spawn"
	}
}




