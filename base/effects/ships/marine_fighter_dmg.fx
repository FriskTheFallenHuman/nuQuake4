effect effects/ships/marine_fighter_dmg
{
	size	210

	sound "unnamed4"
	{
		soundShader	"convoy_large_ship_loop1"
	}
	emitter "smoke"
	{
		duration	10,10
		count		20,30
		attenuateEmitter

		sprite
		{
			duration	1,2
			persist
			material	"gfx/effects/smoke/underlit_alpha2"

			start
			{
				position { line 0,-2,-2,0,2,2 }
				velocity { box -10,-10,-10,10,10,10 }
				acceleration { box -10,-10,-10,10,10,10 }
				size { line 10,10,30,30 attenuate }
				tint { line 0.752941,0.752941,0.752941,0,0,0 }
				offset { point 10,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear count 1.5 offset -0.5 }
				rotate { envelope linear }
			}

			end
			{
				size { line 50,50,120,120 attenuate }
				tint { line 0,0,0,0.501961,0.501961,0.501961 }
				rotate { box -0.25,0.25 relative }
			}
		}
	}
	emitter "fire"
	{
		duration	10,10
		count		22,22
		attenuateEmitter

		sprite
		{
			duration	0.5,0.5
			persist
			material	"gfx/effects/fire/impact_fire"

			start
			{
				position { cylinder -4,-4,-4,4,4,4 }
				velocity { box -20,-20,-20,20,20,20 }
				size { line 20,20,30,30 attenuate }
				tint { line 1,1,1,0,0,0 }
				offset { point 20,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear count 1.5,1.5,1.5 offset -0.5,-0.5,-0.5 }
				rotate { envelope linear }
			}

			end
			{
				size { box 80,80,100,100 attenuate }
				rotate { box -0.25,0.25 relative }
			}
		}
	}
	emitter "um"
	{
		duration	10,10
		count		10,10

		sprite
		{
			duration	0.2,0.3
			blend	add
			persist
			material	"gfx/effects/weapons/flash"

			start
			{
				velocity { box -200,-200,-200,200,200,200 }
				acceleration { box -100,-100,-100,100,100,100 }
				size { point 2,2 }
				offset { box 10,0,-10,80,0,10 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear count 2 offset -1 }
			}

			end
			{
				size { point 10,10 }
			}
		}
	}
}








