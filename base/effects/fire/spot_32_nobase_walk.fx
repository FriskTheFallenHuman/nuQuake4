effect effects/fire/spot_32_nobase_walk
{
	size	212

	sound "sound"
	{
		soundShader	"effects_fire_small"
		volume	0.2,0.2
		freqshift	2,2
	}
	emitter "smoke"
	{
		duration	1,1
		count		4,4

		sprite
		{
			duration	3,3.5
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.03,-0.01

			start
			{
				position { cylinder 0,-10,-10,30,10,10 }
				velocity { box -5,-5,-5,5,5,5 }
				size { line 20,20,40,40 }
				tint { point 0.576471,0.513726,0.364706 }
				fade { point 0 }
				rotate { box -0.111111,0 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "cosine" }
				rotate { envelope "linear" }
			}

			end
			{
				fade { point 0.5 }
				rotate { box -0.222222,-0.111111 relative }
			}
		}
	}
	emitter "fire2"
	{
		duration	1,1
		count		4,4

		sprite
		{
			duration	0.5,1
			blend	add
			material	"gfx/effects/fire/fire2a"
			gravity		-0.05,-0.05

			start
			{
				position { cylinder 0,-10,-10,0,10,10 }
				angle { box 0,0,0,1,1,1 }
				size { box 15,15,25,25 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 8,8,15,15 }
				fade { point 0.6 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "fire3"
	{
		duration	1,1
		count		3,3

		sprite
		{
			duration	0.75,1.25
			blend	add
			material	"gfx/effects/fire/fire3a"
			gravity		-0.05,-0.05

			start
			{
				position { cylinder 0,-10,-10,0,10,10 }
				velocity { box 0,-5,-5,0,5,5 }
				angle { box 0,0,0,1,1,1 }
				size { box 15,15,25,25 }
				fade { point 0 }
				offset { box -2,-2,-2,2,2,2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 8,8,15,15 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "fire5"
	{
		duration	1,1
		count		3,3

		sprite
		{
			duration	0.75,1.25
			blend	add
			material	"gfx/effects/fire/fire5a"
			gravity		-0.05,-0.05

			start
			{
				position { cylinder 0,-10,-10,0,10,10 }
				angle { box 0,0,0,1,1,1 }
				size { box 15,15,25,25 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 8,8,15,15 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "embers"
	{
		detail		0.4
		duration	1,1
		count		10,10

		sprite
		{
			duration	1.5,3
			blend	add
			material	"gfx/effects/energy_sparks/spark3"
			gravity		-0.1,0

			start
			{
				position { cylinder 20,-10,-10,40,10,10 }
				velocity { box 0,-5,-5,15,5,5 }
				angle { box 0,0,0,1,1,1 }
				size { line 0.25,0.25,1.5,1.5 }
				tint { line 1,1,1,1,0.701961,0.501961 }
				fade { point 0 }
				offset { box 0,-10,-10,0,10,10 }
				rotate { box 0,1 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
				angle { envelope "linear" }
			}

			end
			{
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
			}
		}
	}
	emitter "fire1"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	0.85,0.95
			blend	add
			material	"gfx/effects/fire/fire1a"

			start
			{
				position { cylinder 0,-1,-1,0,1,1 }
				velocity { box 0,0,0,10,0,0 }
				angle { box 0,0,0,0,0,1 }
				size { box 15,15,25,25 }
				fade { point 0 }
				offset { box 0,-2,-2,0,2,2 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				angle { envelope "linear" }
			}

			end
			{
				size { box 25,60,30,70 }
				fade { line 0.75,1 }
				angle { box 0,0,0,0,0,1 }
			}
		}
	}
	spawner "heathaze"
	{
		detail		0.4
		count		1,1

		sprite
		{
			duration	3,3
			blend	add
			material	"gfx/effects/energy_sparks/warp_mask"

			start
			{
				velocity { box 20,0,0,60,0,0 }
				size { point 50,50 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				tint { point 0.501961,0.501961,1 }
			}
		}
	}
	spawner "strip2"
	{
		count		1,1

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/fire/flame3"

			start
			{
				size { point 35,35 }
				tint { point 0.501961,0.501961,0.501961 }
				offset { point 10,0,0 }
				rotate { point 0.375 }
			}
		}
	}
	emitter "fire4"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	0.5,1
			blend	add
			material	"gfx/effects/fire/fire1a"
			gravity		-0.05,-0.05

			start
			{
				position { cylinder 0,-10,-10,0,10,10 }
				velocity { box 5,0,0,10,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 15,15,25,25 }
				fade { point 0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
				angle { envelope "linear" }
			}

			end
			{
				size { box 15,30,15,50 }
				fade { point 0.6 }
				angle { box -1,-1,-1,1,1,1 relative }
			}
		}
	}
}



