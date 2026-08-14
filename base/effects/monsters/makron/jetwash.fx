effect effects/monsters/makron/jetwash
{
	size	186

	emitter "slow"
	{
		duration	2,2
		count		5,5
		locked
		attenuateEmitter
		attenuation	500,1000

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/fire/fire_plume_additive"

			start
			{
				position { cylinder 0,-0.5,-0.5,0,0.5,0.5 }
				velocity { box 5,-15,-15,10,15,15 }
				size { line 30,30,50,50 attenuate }
				tint { line 1,1,1,0,1,1 }
				fade { line 0.5,1 attenuate }
				offset { point 0,0,7 }
				rotate { box -1,1 }
			}

			motion
			{
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				fade { point 0 attenuate }
			}
		}
	}
	emitter "fast"
	{
		duration	2,2
		count		5,5
		locked
		attenuateEmitter
		attenuation	500,1000

		sprite
		{
			duration	1.5,1.5
			blend	add
			material	"gfx/effects/fire/fire_plume_additive"

			start
			{
				position { cylinder 0,-0.5,-0.5,0,0.5,0.5 }
				velocity { box 10,0,0,20,0,0 }
				size { point 40,40 attenuate }
				tint { line 1,1,1,0,1,1 }
				fade { line 0.5,1 attenuate }
				offset { point 0,0,7 }
				rotate { box -1,1 }
			}

			motion
			{
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				fade { point 0 attenuate }
			}
		}
	}
	emitter "static"
	{
		duration	2,2
		count		15,15
		locked
		attenuateEmitter
		attenuation	500,1000

		sprite
		{
			duration	0.5,1
			blend	add
			material	"gfx/effects/fire/fire_plume_additive"
			generatedOriginNormal

			start
			{
				position { cylinder 0,-10,-10,25,10,10 surface }
				angle { box 0,0,-1,0,0,1 }
				size { line 20,20,30,30 attenuate }
				tint { line 1,1,1,0,1,1 }
				fade { point 0.125 attenuate }
				offset { box 0,-20,-20,0,20,20 }
				rotate { box -1,1 }
			}

			motion
			{
				fade { envelope sintable offset 0.25 }
				offset { envelope linear }
				angle { envelope linear }
			}

			end
			{
				fade { point 0 attenuate }
				angle { box 0,0,-1,0,0,1 relative }
			}
		}
	}
	emitter "unnamed3"
	{
		duration	1,1
		count		1,10
		locked
		attenuateEmitter
		attenuation	500,1000

		electricity
		{
			duration	0.25,0.25
			blend	add
			fork	0
			jitterRate	0.4
			jitterSize	3,7,7
			material	"gfx/effects/electricity/electric_blue_fade"

			start
			{
				position { cylinder 0,-15,-15,0,15,15 surface }
				size { point 1 attenuate }
				tint { line 1,1,1,0,1,0 }
				fade { point 0.5 attenuate }
				length { line 100,0,0,100,0,0 useEndOrigin attenuate }
			}

			motion
			{
				fade { envelope linear }
			}

			end
			{
				fade { point 0 attenuate }
			}
		}
	}
	emitter "single_streak"
	{
		duration	2,2
		count		2,4
		locked

		line
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/weapons/flash_half3"

			start
			{
				position { point -2,0,0 }
				size { point 10 }
				tint { line 1,1,1,0.501961,1,0 }
				fade { line 0.75,1 }
				offset { point 0,0,7 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { box 10,30 }
				length { box 80,-10,-10,100,10,10 }
			}
		}
	}
	emitter "deform2"
	{
		duration	2,2
		count		5,5

		sprite
		{
			duration	1,1
			material	"gfx/effects/energy_sparks/warp1"

			start
			{
				velocity { point 100,0,0 }
				size { point 20,20 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope linear }
			}

			end
			{
				size { point 100,100 }
			}
		}
	}
}
