effect effects/monsters/iron_maiden/phase
{
	size	425

	emitter "center fill"
	{
		duration	1,1
		count		25,25

		sprite
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/energy_sparks/teleport_base3"
			gravity		-0.25,-0.25

			start
			{
				position { cylinder -50,-5,-5,50,5,5 surface }
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
	spawner "line core"
	{
		count		10,10

		line
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/teleport_base3"

			start
			{
				position { point -100,0,0 }
				size { box 20,60 }
				tint { point 0.501961,0.501961,0.501961 }
				length { point 200,0,0 }
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
				offset { box -50,-50,0,50,50,0 }
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
	spawner "teleportringmove"
	{
		count		4,4

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/teleport_base"

			start
			{
				position { point 1,0,0 }
				velocity { box 0,0,0,80,0,0 }
				size { point 50,50 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope exp_x2 }
				rotate { envelope linear }
			}

			end
			{
				size { line 80,80,200,200 }
				rotate { box 0,0,-0.222222,0,0,0.222222 relative }
			}
		}
	}
	emitter "misting"
	{
		duration	1,1
		count		30,30

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/steam_alpha"
			generatedOriginNormal

			start
			{
				position { cylinder -35,-35,-35,35,35,35 surface }
				velocity { box -50,0,0,50,0,0 }
				size { point 30,30 }
				tint { point 0.690196,0.737255,0.686275 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope fast_in_slow_out }
			}

			end
			{
				fade { point 0.15 }
			}
		}
	}
	sound "unnamed0"
	{
		soundShader	"effects_teleport"
		volume	20,20
	}
	spawner "unnamed8"
	{
		count		2,2

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/energy_sparks/teleport_base2"

			start
			{
				size { point 250,250 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				rotate { box 0,1 relative }
			}
		}
	}
	spawner "teleportringmove3"
	{
		count		4,4

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/teleport_base"

			start
			{
				position { point 1,0,0 }
				velocity { box 0,0,0,-80,0,0 }
				size { point 50,50 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope exp_x2 }
				rotate { envelope linear }
			}

			end
			{
				size { line 80,80,200,200 }
				rotate { box 0,0,-0.222222,0,0,0.222222 relative }
			}
		}
	}
	emitter "unnamed8"
	{
		duration	0.65,0.65
		count		2,2

		sprite
		{
			duration	1,1
			material	"gfx/effects/energy_sparks/explosion_deform_grenade"

			start
			{
				size { line 2,2,20,20 }
			}

			motion
			{
				size { envelope cosine }
			}

			end
			{
				size { line 100,100,300,300 }
			}
		}
	}
}


