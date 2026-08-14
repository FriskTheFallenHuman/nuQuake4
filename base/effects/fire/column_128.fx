effect effects/fire/column_128
{
	size	449

	sound "sound"
	{
		soundShader	"effects_fire"
		freqshift	2,2
	}
	emitter "smoke"
	{
		duration	1,1
		count		4,4

		sprite
		{
			duration	2.5,3.5
			material	"gfx/effects/smoke/smoke_dark"
			gravity		-0.05,-0.05

			start
			{
				position { cylinder 20,-25,-25,140,25,25 }
				velocity { box -5,-5,-5,5,5,5 }
				size { line 50,50,100,100 }
				tint { line 0.501961,0.501961,0.501961,0.74902,0.74902,0.74902 }
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
				size { line 100,100,200,200 }
				fade { point 1 }
				rotate { box -0.333333,0.333333 relative }
			}
		}
	}
	emitter "fire6"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	0.85,0.95
			blend	add
			material	"gfx/effects/fire/fire1a"
			gravity		-0.15,-0.125

			start
			{
				position { cylinder 0,-25,-25,0,25,25 }
				velocity { box 0,0,0,50,0,0 }
				angle { box 0,0,0,0,0,1 }
				size { box 50,50,80,80 }
				fade { point 0 }
				offset { box 0,-10,-10,0,10,10 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				angle { envelope "linear" }
			}

			end
			{
				size { box 80,150,100,300 }
				fade { line 0.75,1 }
				angle { box 0,0,0,0,0,1 }
			}
		}
	}
	emitter "fire7"
	{
		detail		0.7
		duration	1,1
		count		1,1

		sprite
		{
			duration	1,1.5
			blend	add
			material	"gfx/effects/fire/fire2a"
			gravity		-0.019,0

			start
			{
				position { cylinder 5,-15,-15,5,15,15 }
				velocity { box 0,0,0,50,0,0 }
				angle { box 0,0,0,0,0,1 }
				size { line 30,30,40,40 }
				fade { point 0 }
				offset { box -10,-10,-10,10,10,10 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 110,110,120,120 }
				fade { point 1 }
				angle { box 0,0,-1,0,0,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "fire8"
	{
		duration	1,1
		count		2,2

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/fire/fire3a"
			gravity		-0.22,0

			start
			{
				position { cylinder 10,-15,-15,10,15,15 }
				velocity { box 0,-15,-15,50,15,15 }
				angle { box 0,0,0,1,1,1 }
				size { box 80,80,100,100 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 40,40,60,60 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,-0.333333 relative }
			}
		}
	}
	emitter "fire9"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/fire/fire4a"
			gravity		-0.2,-0.02

			start
			{
				position { cylinder 20,-15,-15,20,15,15 }
				velocity { box 0,-15,-15,50,15,15 }
				size { box 50,50,70,70 }
				fade { point 0 }
				rotate { box -1,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 10,10,20,20 }
				fade { point 1 }
				rotate { box 0.333333,0.444444 relative }
			}
		}
	}
	emitter "fire10"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	1,1.5
			blend	add
			material	"gfx/effects/fire/fire5a"
			gravity		-0.22,-0.22

			start
			{
				position { cylinder 10,-15,-15,10,15,15 }
				velocity { box 0,-10,-10,50,10,10 }
				angle { box 0,0,0,1,1,1 }
				size { box 100,100,120,120 }
				tint { line 0.192157,0.192157,0.192157,0.501961,0.501961,0.501961 }
				fade { point 0 }
				offset { box -10,-10,-10,10,10,10 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "fadetable" }
				fade { envelope "fastinslowout" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 40,40,60,60 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.111111,-0.222222 relative }
			}
		}
	}
	emitter "embers2"
	{
		detail		0.4
		duration	1,1
		count		7,9

		sprite
		{
			duration	1.5,3
			blend	add
			material	"gfx/effects/energy_sparks/spark3"
			gravity		-0.2,0

			start
			{
				position { cylinder 80,-40,-40,120,40,40 }
				velocity { box 0,-5,-5,15,5,5 }
				angle { box 0,0,0,1,1,1 }
				size { line 1,1,5,5 }
				tint { line 1,1,1,1,0.501961,0 }
				fade { point 0 }
				offset { box 0,-20,-20,0,20,20 }
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
			material	"gfx/effects/fire/flame1"

			start
			{
				size { point 110,100 }
				tint { point 0.501961,0.501961,0.501961 }
				offset { point 60,0,0 }
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
				size { point 220,220 }
				rotate { box 0,0,-1,0,0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fullflicker" }
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
				velocity { box 80,0,0,100,0,0 }
				size { point 200,200 }
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
}











