effect effects/moveables/barrel/burn2
{
	size	152

	emitter "FIRE_smoke"
	{
		duration	2,2
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
		duration	2,2
		count		35,35

		sprite
		{
			duration	0.75,0.75
			blend	add
			persist
			material	"gfx/effects/fire/fire5a"

			start
			{
				velocity { box 15,-3,-3,20,3,3 }
				size { line 4,4,5,5 }
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
				size { point 8,8 }
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
	sound "FIRE_sound"
	{
		soundShader	"effects_fire"
	}
	emitter "FIRE_body2"
	{
		start		0.5,0.5
		duration	1,1
		count		35,35

		sprite
		{
			duration	0.75,0.75
			blend	add
			persist
			material	"gfx/effects/fire/fire5a"

			start
			{
				position { box -6,-6,-6,6,6,6 }
				velocity { box -5,-5,-5,5,5,5 }
				size { point 8,8 }
				fade { point 0 }
				offset { box 0,-3,-3,0,3,3 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope arch }
				fade { envelope fast_in_slow_out }
				offset { envelope cosine }
				rotate { envelope linear }
			}

			end
			{
				size { point 12,12 }
				fade { line 0.3,0.4 }
				offset { box 0,-2,-2,0,2,2 }
				rotate { box -0.3,0.3 relative }
			}
		}
	}
	emitter "FIRE_body3"
	{
		start		1,1
		duration	1,1
		count		35,35

		sprite
		{
			duration	0.75,0.75
			blend	add
			persist
			material	"gfx/effects/fire/fire5a"

			start
			{
				position { box -12,-12,-12,12,12,12 }
				velocity { box -5,-5,-5,5,5,5 }
				size { point 12,12 }
				fade { point 0 }
				offset { box 0,-3,-3,0,3,3 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope arch }
				fade { envelope fast_in_slow_out }
				offset { envelope cosine }
				rotate { envelope linear }
			}

			end
			{
				size { point 20,20 }
				fade { line 0.5,0.6 }
				offset { box 0,-2,-2,0,2,2 }
				rotate { box -0.3,0.3 relative }
			}
		}
	}
	emitter "FIRE_smoke2"
	{
		start		1.2,1.2
		duration	1,1
		count		8,8

		sprite
		{
			duration	3,3
			persist
			material	"gfx/effects/smoke/smoke_alpha"
			gravity		-0.035,-0.02

			start
			{
				position { box -6,-6,-6,6,6,6 }
				velocity { box -6,-6,-6,6,6,6 }
				size { line 12,12,20,20 }
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
				size { line 30,30,40,40 }
				fade { point 1 }
			}
		}
	}
	emitter "FIRE_smoke3"
	{
		duration	1,1
		count		4,4

		sprite
		{
			duration	3,3
			persist
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.02,-0.02

			start
			{
				position { cylinder 0,-6,-6,6,6,6 }
				velocity { box 0,-6,-6,0,6,6 }
				size { point 20,20 }
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
				fade { line 0.2,0.5 }
			}
		}
	}
}

