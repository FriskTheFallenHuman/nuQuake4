effect effects/monsters/heavy_tank/jetwash
{
	size	186

	emitter "fast"
	{
		duration	2,2
		count		10,10
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
				velocity { box 10,0,0,20,0,0 }
				size { point 10,10 attenuate }
				tint { line 0.74902,0.909804,0.741176,0,1,1 }
				fade { line 0.5,1 attenuate }
				offset { point 0,0,7 }
				rotate { box -1,1 }
			}

			motion
			{
				fade { envelope "linear" }
				rotate { envelope "linear" }
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
				fade { envelope "sintable" offset 0.25 }
				offset { envelope "linear" }
				angle { envelope "linear" }
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
		detail		0.5
		duration	1.5,1.5
		count		1,8
		locked
		attenuateEmitter
		attenuation	250,1500

		electricity
		{
			duration	0.3,0.3
			blend	add
			fork	0
			jitterRate	0.1
			jitterSize	4,16,16
			jitterTable	"halfsintable"
			material	"gfx/effects/electricity/electric_blue_fade"

			start
			{
				position { cylinder 0,-15,-15,0,15,15 surface }
				size { point 6 attenuate }
				tint { line 0.74902,0.909804,0.741176,0.27451,0.866667,0.258824 }
				fade { point 0.7 attenuate }
				offset { box -10,0,0,-20,0,20 }
				length { box 50,-20,-20,100,20,20 attenuate }
			}

			motion
			{
				size { envelope "exp_1minusx/x2" }
				length { envelope "linear" }
			}

			end
			{
				size { point 0.2 attenuate }
				length { box 50,-20,-20,50,20,20 attenuate }
			}
		}
	}
	emitter "fast2"
	{
		duration	2,2
		count		10,10
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
				velocity { box 10,0,0,20,0,0 }
				size { point 10,10 attenuate }
				tint { line 0.74902,0.909804,0.741176,0,1,1 }
				fade { line 0.5,1 attenuate }
				offset { point 0,-6,-4 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope "arch" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 20,20 attenuate }
				fade { point 0 attenuate }
				rotate { point 1 relative }
			}
		}
	}
	emitter "fast3"
	{
		duration	2,2
		count		10,10
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
				velocity { box 20,0,0,30,0,0 }
				size { point 10,10 attenuate }
				tint { line 0.74902,0.909804,0.741176,0,1,1 }
				fade { line 0.5,1 attenuate }
				offset { point 0,7,-4 }
				rotate { box -1,1 }
			}

			motion
			{
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				fade { point 0 attenuate }
			}
		}
	}
	emitter "single_streak"
	{
		detail		0.5
		duration	2,2
		count		10,10
		locked

		line
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/weapons/flash_half3"

			start
			{
				position { point -2,0,0 }
				size { point 4 }
				tint { line 0.74902,0.909804,0.741176,0.501961,1,0 }
				fade { line 0.75,1 }
				offset { point 0,0,7 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { box 10,15 }
				length { box 45,-5,-5,60,5,5 }
			}
		}
	}
	emitter "single_streak2"
	{
		detail		0.5
		duration	2,2
		count		10,10
		locked

		line
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/weapons/flash_half3"

			start
			{
				position { point -2,0,0 }
				size { point 4 }
				tint { line 0.74902,0.909804,0.741176,0.501961,1,0 }
				fade { line 0.75,1 }
				offset { point 0,-6,-4 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { box 10,15 }
				length { box 45,-5,-5,60,5,5 }
			}
		}
	}
	emitter "single_streak3"
	{
		detail		0.5
		duration	2,2
		count		10,10
		locked

		line
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/weapons/flash_half3"

			start
			{
				position { point -2,0,0 }
				size { point 4 }
				tint { line 0.74902,0.909804,0.741176,0.501961,1,0 }
				fade { line 0.75,1 }
				offset { point 0,7,-4 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { box 10,15 }
				length { box 45,-5,-5,60,5,5 }
			}
		}
	}
	emitter "deform2"
	{
		detail		0.5
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
				size { envelope "linear" }
			}

			end
			{
				size { point 100,100 }
			}
		}
	}
	spawner "static2"
	{
		count		5,5
		locked

		sprite
		{
			duration	4,4
			blend	add
			material	"gfx/effects/weapons/flash"
			gravity		0.003,0.003
			generatedOriginNormal

			start
			{
				position { box 0,-10,-10,0,10,15 }
				size { point 20,20 }
				tint { point 0.596078,0.92549,0.54902 }
				fade { point 0.3 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "sintable" offset 0.25 }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 5,5 }
				rotate { point 2 relative }
			}
		}
	}
}








