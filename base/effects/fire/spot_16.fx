effect effects/fire/spot_16
{
	size	213

	emitter "smoke"
	{
		duration	1,1
		count		6,6

		sprite
		{
			duration	3,3.5
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.015,-0.015

			start
			{
				position { line 0,0,0,15,0,0 }
				velocity { box -5,-5,-5,5,5,5 }
				size { line 8,8,16,16 }
				tint { line 0.513726,0.470588,0.321569,0.47451,0.45098,0.356863 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "cosine" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 16,16,32,32 }
				fade { point 0.5 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "fire2"
	{
		duration	1,1
		count		4,4

		sprite
		{
			duration	0.75,1.25
			blend	add
			material	"gfx/effects/fire/fire2a"
			gravity		-0.05,-0.05

			start
			{
				position { cylinder 0,-5,-5,0,5,5 }
				angle { box 0,0,0,1,1,1 }
				size { box 5,5,10,10 }
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
				size { box 6,10,8,20 }
				fade { line 1,0.5 }
				angle { box -1,-1,-1,1,1,1 relative }
			}
		}
	}
	emitter "fire3"
	{
		duration	1,1
		count		4,4

		sprite
		{
			duration	0.75,1.25
			blend	add
			material	"gfx/effects/fire/fire3a"
			gravity		-0.05,-0.05

			start
			{
				position { cylinder 0,-5,-5,0,5,5 }
				angle { box 0,0,0,1,1,1 }
				size { box 8,8,12,12 }
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
				size { box 6,6,8,8 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "fire5"
	{
		duration	1,1
		count		4,4

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
				size { box 8,8,12,12 }
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
				size { box 6,6,8,8 }
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
		count		5,5

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
				size { line 0.5,0.5,2,2 }
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
	spawner "strip"
	{
		count		1,1
		constant

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/fire/flame3"

			start
			{
				size { point 20,20 }
				tint { point 0.501961,0.501961,0.501961 }
				offset { point 7,0,0 }
				rotate { point 0.375 }
			}
		}
	}
	emitter "unnamed11"
	{
		duration	1,1
		count		6,6

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/fire/fire1a"

			start
			{
				position { point 1,0,0 }
				size { point 30,30 }
				rotate { box 0,0,-1,0,0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fullflicker" }
			}
		}
	}
}







