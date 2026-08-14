effect effects/moveables/barrel/burn
{
	size	143

	emitter "FIRE_smoke"
	{
		duration	30,30
		count		4,4

		sprite
		{
			duration	3,3
			persist
			material	"gfx/effects/smoke/smoke_alpha"
			gravity		-0.02,-0.02

			start
			{
				position { cylinder 0,-6,-6,6,6,6 }
				velocity { box 0,-6,-6,0,6,6 }
				size { line 5,5,12,12 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope fast_in_slow_out }
			}

			end
			{
				size { line 20,20,30,30 }
				fade { line 1,0.75 }
			}
		}
	}
	emitter "FIRE_body"
	{
		duration	15,15
		count		35,35

		sprite
		{
			duration	0.75,0.75
			blend	add
			persist
			material	"gfx/effects/fire/fire1a"

			start
			{
				velocity { box 15,-3,-3,20,3,3 }
				size { line 2,2,5,5 }
				fade { point 0 }
				offset { box 0,-3,-3,0,3,3 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope fire_smokefade }
				fade { envelope fast_in_slow_out }
				offset { envelope cosine }
				rotate { envelope linear }
			}

			end
			{
				size { point 2,2 }
				fade { line 0.3,0.2 }
				offset { box 0,-2,-2,0,2,2 }
				rotate { box -0.3,0.3 relative }
			}
		}
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
				size { envelope flickerblink }
				tint { envelope random count 0.15,0.15,0.15 }
				fade { envelope fire_smokefade }
			}

			end
			{
				size { point 75,75,75 }
				tint { point 0.709804,0.529412,0.2 }
			}
		}
	}
	sound "FIRE_sound"
	{
		soundShader	"effects_fire"
	}
	emitter "FIRE_embers"
	{
		duration	30,30
		count		10,10
		attenuation	0,500

		sprite
		{
			duration	2,4
			blend	add
			persist
			material	"gfx/effects/weapons/flash"
			gravity		-0.06,0

			start
			{
				velocity { box 5,-5,-5,10,5,5 }
				angle { box 0,0,0,1,1,1 }
				size { line 0.25,0.25,0.5,0.5 }
				fade { point 0 }
				offset { box 0,-5,-5,0,5,5 }
				rotate { box 0,1 }
			}

			motion
			{
				tint { envelope linear }
				fade { envelope arch }
				angle { envelope linear }
			}

			end
			{
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
			}
		}
	}
}




