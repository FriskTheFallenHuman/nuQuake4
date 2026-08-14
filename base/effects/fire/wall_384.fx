effect effects/fire/wall_384
{
	size	839

	emitter "smoke"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	3,4
			material	"gfx/effects/smoke/smoke_dark"
			gravity		-0.05,-0.05

			start
			{
				position { line 50,-150,-30,180,150,30 }
				velocity { box -5,-5,-5,5,5,5 }
				size { line 80,80,100,100 }
				tint { line 0.501961,0.501961,0.501961,0.752941,0.752941,0.752941 }
				fade { point 0 }
				rotate { box -0.5,0.5 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "cosine" count 0.75 offset 0.25 }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 200,200,210,210 }
				fade { point 1 }
			}
		}
	}
	emitter "fire1"
	{
		duration	1,1
		count		12,12

		sprite
		{
			duration	1,1.5
			blend	add
			material	"gfx/effects/fire/fire1a"

			start
			{
				position { line 0,-150,0,0,150,0 }
				velocity { box 0,0,0,50,0,0 }
				angle { box 0,0,0,0,0,1 }
				size { box 70,70,90,90 }
				fade { point 0 }
				offset { box -10,-10,-10,10,10,10 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
			}

			end
			{
				size { box 90,200,100,300 }
				fade { point 1 }
			}
		}
	}
	emitter "fire2"
	{
		duration	1,1
		count		8,8

		sprite
		{
			duration	1,1.5
			blend	add
			material	"gfx/effects/fire/fire2a"
			gravity		-0.019,-0.019

			start
			{
				position { line 5,-150,0,5,150,0 }
				velocity { box 0,0,0,20,0,0 }
				angle { box 0,0,0,0,0,1 }
				size { box 70,70,90,90 }
				fade { point 0 }
				offset { box -10,-10,-10,10,10,10 }
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
				size { box 110,110,120,120 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "fire3"
	{
		duration	1,1
		count		6,6

		sprite
		{
			duration	1,1.25
			blend	add
			material	"gfx/effects/fire/fire3a"
			gravity		-0.25,-0.022

			start
			{
				position { line 10,-150,0,10,150,0 }
				velocity { box 0,-15,-15,0,15,15 }
				size { box 70,70,90,90 }
				fade { point 0 }
				offset { box -10,-10,-10,10,10,10 }
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
				rotate { box -0.222222,-0.333333 relative }
			}
		}
	}
	emitter "fire4"
	{
		duration	1,1
		count		6,6

		sprite
		{
			duration	1.5,2
			blend	add
			material	"gfx/effects/fire/fire4a"
			gravity		-0.09,-0.09

			start
			{
				position { line 20,-150,0,20,150,0 }
				velocity { box 0,-15,-15,0,15,15 }
				angle { box 0,0,0,1,1,1 }
				size { box 80,80,100,100 }
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
				size { box 50,50,70,70 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box 0.333333,0.444444 relative }
			}
		}
	}
	emitter "fire5"
	{
		duration	1,1
		count		6,6

		sprite
		{
			duration	1.5,2
			blend	add
			material	"gfx/effects/fire/fire5a"
			gravity		-0.092,-0.092

			start
			{
				position { line 10,-150,0,10,150,0 }
				velocity { box 0,-10,-10,20,10,10 }
				angle { box 0,0,0,1,1,1 }
				size { box 60,60,80,80 }
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
				size { box 40,40,60,60 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.111111,-0.222222 relative }
			}
		}
	}
	emitter "embers"
	{
		detail		0.4
		duration	1,1
		count		9,12

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/spark3"
			gravity		-0.2,-0.2

			start
			{
				position { line 80,-160,-40,120,160,40 }
				velocity { box 0,-5,-5,15,5,5 }
				angle { box 0,0,0,1,1,1 }
				size { line 2,2,9,9 }
				fade { point 0 }
				offset { box 0,-40,-40,0,40,40 }
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
	sound "unnamed9"
	{
		soundShader	"effects_fire_gas"
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
				size { point 500,500 }
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
	emitter "unnamed11"
	{
		duration	1,1
		count		3,5

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/fire/fire1a"

			start
			{
				position { point 1,0,0 }
				size { point 220,150 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fullflicker" }
			}
		}
	}
	spawner "strip"
	{
		count		3,3
		constant

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/fire/flame1"

			start
			{
				position { line 0,-100,0,0,100,0 }
				size { point 180,180 }
				offset { point 10,0,0 }
				rotate { point 0.375 }
			}
		}
	}
}


















