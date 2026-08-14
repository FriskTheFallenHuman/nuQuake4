effect effects/moveables/barrel/ignite2
{
	size	152

	emitter "smoke"
	{
		duration	3,3
		count		5,5

		sprite
		{
			duration	1.5,2
			persist
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.05,-0.05

			start
			{
				position { cylinder 0,-10,-10,-40,10,10 }
				velocity { box -5,-5,-5,5,5,5 }
				size { line 20,20,30,30 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0 }
				rotate { box -0.111111,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { line 10,10,80,80 }
				fade { point 1 }
				rotate { box -0.222222,-0.111111 relative }
			}
		}
	}
	emitter "fire1"
	{
		duration	3,3
		count		10,10
		locked

		sprite
		{
			duration	0.75,1
			blend	add
			persist
			material	"gfx/effects/fire/fire1a"
			gravity		-0.07,-0.07

			start
			{
				position { cylinder 0,-10,-10,-40,10,10 surface }
				velocity { box -5,0,0,-15,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 20,20,30,30 }
				fade { point 0 }
				offset { box -2,-2,-2,2,2,2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 7,7,9,9 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "fire2"
	{
		duration	3,3
		count		15,15
		locked

		sprite
		{
			duration	0.75,1
			blend	add
			persist
			material	"gfx/effects/fire/fire2a"
			gravity		-0.09,-0.09

			start
			{
				position { cylinder 0,-10,-10,-40,10,10 surface }
				velocity { box -5,0,0,-15,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 20,20,30,30 }
				fade { point 0 }
				offset { box -2,-2,-2,2,2,2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 7,7,9,9 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "embers"
	{
		duration	3,3
		count		9,12

		sprite
		{
			duration	1,2
			blend	add
			persist
			material	"gfx/effects/energy_sparks/spark3"
			gravity		-0.1,0

			start
			{
				position { line 10,-12,-12,30,12,12 }
				velocity { box 0,-5,-5,15,5,5 }
				angle { box 0,0,0,1,1,1 }
				size { line 1,1,3,3 }
				fade { point 0 }
				offset { box 0,-20,-20,0,20,20 }
				rotate { box 0,1 }
			}

			motion
			{
				tint { envelope linear }
				fade { envelope fastinslowout }
				angle { envelope linear }
			}

			end
			{
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
			}
		}
	}
	sound "unnamed8"
	{
		soundShader	"effects_fire_deep2"
		volume	0.4,0.4
	}
	emitter "fire_trail"
	{
		duration	3,3
		count		10,10

		sprite
		{
			duration	0.75,1
			blend	add
			persist
			material	"gfx/effects/fire/fire1a"
			gravity		-0.07,-0.07

			start
			{
				position { cylinder 0,-10,-10,-40,10,10 surface }
				velocity { box -5,0,0,-15,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 20,20,30,30 }
				fade { point 0 }
				offset { box -2,-2,-2,2,2,2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 7,7,9,9 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	sound "unnamed6"
	{
		soundShader	"effects_fire_blast"
		freqshift	1.5,1.5
	}
	sound "unnamed7"
	{
		soundShader	"generic_small_metal_break"
		freqshift	1.5,1.5
	}
	sound "unnamed9"
	{
		start		0.1,0.1
		soundShader	"effects_steam_blast"
		volume	10,10
		freqshift	2,2
	}
	light "FIRE_light"
	{
		locked

		light
		{
			duration	15,15
			blend	add
			material	"lights/defaultPointLight"

			start
			{
				position { point 25,0,0 }
				size { point 50,50,50 }
				tint { point 0.968627,0.976471,0.709804 }
			}

			motion
			{
				size { envelope bathroomtable }
				tint { envelope random count 0.15,0.15,0.15 }
				fade { envelope fire_smokefade }
			}

			end
			{
				size { point 80,80,80 }
				tint { point 0.709804,0.529412,0.2 }
			}
		}
	}
}
