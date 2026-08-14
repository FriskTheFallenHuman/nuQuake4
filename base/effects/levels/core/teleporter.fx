effect effects/levels/core/teleporter
{
	size	265

	emitter "unnamed4"
	{
		duration	1,1
		count		20,20

		line
		{
			duration	3,3
			blend	add
			material	"gfx/effects/energy_sparks/teleport_light"

			start
			{
				position { point -20,0,0 }
				angle { box 0,0,-0.5,0,0,0.5 }
				size { box 5,10 }
				fade { line 0.25,0.5 }
				offset { point 0,40,0 }
				length { box 140,0,0,200,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				angle { envelope linear }
			}

			end
			{
				size { point 0 }
				angle { box 0,0,-0.5,0,0,0.5 relative }
			}
		}
	}
	emitter "teleportring"
	{
		duration	1,1
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
				fade { envelope guitable_5_3 }
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
	emitter "center fill"
	{
		duration	1,1
		count		25,25

		sprite
		{
			duration	1.75,1.75
			blend	add
			material	"gfx/effects/energy_sparks/teleport_base3"
			gravity		-0.125,-0.125

			start
			{
				position { cylinder 0,-5,-5,0,5,5 surface }
				angle { box 0,0,0,0,0,0.5 }
				size { line 3,3,5,5 }
				tint { line 1,1,1,0.882353,1,0.882353 }
				fade { line 1,0.5 }
				offset { box -50,-10,-10,50,10,10 }
			}

			motion
			{
				fade { envelope linear }
				angle { envelope linear }
			}

			end
			{
				angle { box 0,0,-0.5,0,0,0.5 relative }
			}
		}
	}
	emitter "line core"
	{
		duration	1,1
		count		15,15

		line
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/energy_sparks/teleport_base3"

			start
			{
				size { box 2,15 }
				tint { point 0.501961,0.501961,0.501961 }
				offset { point -50,0,0 }
				length { box 100,0,0,200,0,0 }
			}

			motion
			{
				fade { envelope linear }
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
	spawner "moving thing2"
	{
		count		15,15

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/teleport_warp"

			start
			{
				position { cylinder 0,-40,-40,0,40,40 surface }
				velocity { point 50,0,0 }
				angle { box 0,0,-1,0,0,1 }
				size { point 10,10 }
				offset { box 0,-1,-1,0,1,1 }
			}

			motion
			{
				fade { envelope exp_x2 offset 0.25 }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				angle { box 0,0,-0.5,0,0,0.5 }
				rotate { point 0.00277778 relative }
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
}




