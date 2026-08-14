effect effects/levels/dispersal/acid_vat
{
	size	161

	emitter "spray"
	{
		duration	2.35,2.35
		count		100,100
		locked

		sprite
		{
			duration	0.5,0.75
			material	"gfx/effects/fluids_drips/bubble_alpha"
			gravity		0.12,0.25

			start
			{
				position { point 1,0,0 }
				velocity { box 75,-25,-100,125,25,100 }
				size { line 1,1,3,3 }
				tint { line 0.403922,0.572549,0.054902,0.501961,0.501961,0 }
				fade { point 0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope pop_hold_fade }
			}

			end
			{
				size { line 0.25,0.25,0.5,0.5 }
				fade { point 1 }
			}
		}
	}
	sound "sound"
	{
		soundShader	"effects_acid_pump"
	}
	emitter "spout"
	{
		duration	2.85,2.85
		count		10,15
		locked

		line
		{
			duration	0.25,0.25
			material	"gfx/effects/smoke/steam_source"
			generatedNormal

			start
			{
				position { point -2,0,0 }
				tint { point 0.490196,0.701961,0.301961 }
				length { point 55,25,55 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { point 33 }
				tint { point 0.490196,0.384314,0.00784314 }
				length { point 55,100,55 }
			}
		}
	}
	emitter "source1"
	{
		duration	2,2
		count		12,12

		sprite
		{
			duration	0.5,1
			material	"gfx/effects/smoke/steam_alpha"
			gravity		0.05,0.1

			start
			{
				position { line 0,-1,-1,0,1,1 }
				velocity { box 25,-3,-3,75,3,3 }
				size { line 2,2,5,5 }
				tint { point 0.501961,0.501961,0 }
				fade { point 0 }
				rotate { box -0.125,-0.25 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fast_in_slow_out }
				rotate { envelope linear }
			}

			end
			{
				size { line 35,35,25,25 }
				fade { line 0.25,1 }
			}
		}
	}
	emitter "nozzle"
	{
		start		1.25,1.25
		duration	2,2
		count		12,12
		locked

		line
		{
			duration	0.85,0.85
			material	"gfx/effects/smoke/steam_alpha"
			generatedOriginNormal

			start
			{
				position { cylinder 0.05,0.05,0.05,0.05,-0.05,-0.05 }
				size { point 2 }
				tint { point 0.572549,0.701961,0.301961 }
				fade { line 0.5,0.25 }
				length { box 5,-0.5,-0.5,6,0.5,0.5 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { point 4 }
				length { box 12,-10,-10,15,10,10 }
			}
		}
	}
	emitter "source2"
	{
		start		2,2
		duration	2,2
		count		8,8

		sprite
		{
			duration	1,2
			material	"gfx/effects/smoke/steam_alpha"
			gravity		0.005,0.005

			start
			{
				position { line 1,-1,-1,1,1,1 }
				velocity { box 25,-3,3,12,3,3 }
				size { line 12,12,10,10 }
				tint { line 0.501961,0.501961,0,0.486275,0.345098,0.0117647 }
				fade { point 0 }
				rotate { box -0.125,-0.25 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fast_in_slow_out }
				rotate { envelope linear }
			}

			end
			{
				size { line 85,85,50,50 }
				fade { line 0.35,0.5 }
			}
		}
	}
	spawner "acid_release"
	{
		start		2,2
		count		18,25

		sprite
		{
			duration	0.5,1
			material	"gfx/effects/smoke/steam_alpha"
			generatedOriginNormal

			start
			{
				position { cylinder 0,-0.05,-0.05,0,0.05,0.05 }
				velocity { box 0,0,100,0,0,-150 }
				friction { point -150,-150,-150 }
				size { line 3,3,6,6 }
				tint { line 1,1,0,0.580392,0.721569,0.278431 }
				fade { point 0 }
				rotate { point 1 }
			}

			motion
			{
				size { envelope pop_hold_grow }
				fade { envelope pop_fade }
				rotate { envelope linear }
			}

			end
			{
				size { line 50,50,35,35 }
				fade { line 0.5,0.25 }
			}
		}
	}
	spawner "shockwave"
	{
		start		1.85,1.85
		count		1,1

		oriented
		{
			duration	0.4,0.4
			material	"gfx/effects/particles_shapes/shockwave_alpha"

			start
			{
				position { point -1,0,0 }
				size { point 10,10 }
				tint { point 0.501961,1,0 }
				fade { point 0 }
			}

			motion
			{
				size { envelope popover_hold_grow }
				fade { envelope popoverextreme_hold_fade }
				rotate { envelope linear }
			}

			end
			{
				size { point 85,85 }
				fade { point 0.75 }
			}
		}
	}
}


