effect effects/fire/gasjet_long
{
	size	312

	sound "sound"
	{
		soundShader	"effects_blowtorch"
	}
	emitter "flamecore"
	{
		duration	1,1
		count		8,8
		locked

		line
		{
			duration	0.25,0.25
			material	"gfx/effects/smoke/steam_source"
			generatedNormal

			start
			{
				tint { point 0.501961,0.862745,1 }
				length { point 55,25,55 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { point 22 }
				length { point 55,100,55 }
			}
		}
	}
	emitter "smoke"
	{
		duration	1,1
		count		8,8

		sprite
		{
			duration	1,1.25
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.01,0.01
			generatedOriginNormal

			start
			{
				position { point 40,0,0 }
				velocity { box 120,-15,-15,300,15,15 }
				size { box 15,15,30,30 }
				tint { point 0.815686,0.803922,0.74902 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 60,60,90,90 }
				fade { point 0.2 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	emitter "fire"
	{
		duration	1,1
		count		25,25

		sprite
		{
			duration	0.25,0.5
			blend	add
			material	"gfx/effects/fire/fire4a"
			gravity		-0.02,0

			start
			{
				position { line 10,-1,-1,10,1,1 }
				velocity { box 500,-20,-20,500,20,20 }
				size { box 5,5,10,10 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 40,40,60,60 }
				fade { point 1 }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
	emitter "fire2"
	{
		duration	1,1
		count		30,30

		sprite
		{
			duration	0.25,0.5
			blend	add
			material	"gfx/effects/fire/fire1a"
			gravity		-0.02,0

			start
			{
				position { line 15,-1,-1,15,1,1 }
				velocity { box 500,-10,-10,650,10,10 }
				size { box 5,5,10,10 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 45,45,60,60 }
				fade { point 1 }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
	emitter "fire3"
	{
		duration	1,1
		count		30,30

		sprite
		{
			duration	0.25,0.5
			blend	add
			material	"gfx/effects/fire/fire3a"
			gravity		-0.02,0

			start
			{
				position { line 6,-1,-1,6,1,1 }
				velocity { box 300,-10,-10,500,10,10 }
				size { box 5,5,10,10 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 30,30,50,50 }
				fade { point 1 }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
	emitter "blue_fire"
	{
		duration	1,1
		count		25,25

		sprite
		{
			duration	0.3,0.4
			blend	add
			material	"gfx/effects/fire/fire2b"
			gravity		-0.02,0

			start
			{
				position { line 0,-1,-1,0,1,1 }
				velocity { box 100,-10,-10,250,10,10 }
				size { box 2,2,4,4 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fast_in_slow_out" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 25,25,50,50 }
				fade { point 1 }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
	emitter "blue_fire2"
	{
		duration	1,1
		count		25,25

		sprite
		{
			duration	0.25,0.35
			blend	add
			material	"gfx/effects/fire/fire5b"
			gravity		-0.02,0

			start
			{
				position { line 0,-1,-1,0,1,1 }
				velocity { box 100,-30,-30,250,30,30 }
				size { box 1,1,2,2 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fast_in_slow_out" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 15,15,30,30 }
				fade { point 1 }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
	sound "unnamed8"
	{
		soundShader	"effects_fire_gas"
	}
	emitter "heathaze"
	{
		detail		0.3
		duration	1,1
		count		5,5

		sprite
		{
			duration	3,3
			blend	add
			material	"gfx/effects/energy_sparks/warp_mask"

			start
			{
				velocity { box 100,0,0,150,0,0 }
				size { point 60,60 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				tint { point 0.501961,0.501961,1 }
			}
		}
	}
}



