effect effects/weapons/rocketlauncher/detonate_mp
{
	size	227

	sound "sound4"
	{
		soundShader	"player_rocketlauncher_explode"
	}
	sound "sound3"
	{
		soundShader	"player_rocketlauncher_explode2"
	}
	spawner "sparks3"
	{
		detail		0.5
		start		0.2,0.2
		count		15,15

		sprite
		{
			duration	1,1.5
			blend	add
			material	"gfx/effects/energy_sparks/spark3"

			start
			{
				position { sphere -20,-20,-20,20,20,20 }
				velocity { box 0,-50,-50,50,50,50 }
				angle { box 0,0,0,0.277778,0.277778,0.277778 }
				size { line 0.5,0.5,3,3 }
				tint { line 1,0.721569,0.309804,1,1,1 }
				offset { box -6,-6,-6,6,6,6 }
			}

			motion
			{
				fade { envelope "linear_flicker" }
				angle { envelope "linear" }
			}

			end
			{
				angle { box 0.277778,0.277778,0.277778,0.555556,0.555556,0.555556 relative }
			}
		}
	}
	spawner "fire4"
	{
		count		4,4

		sprite
		{
			duration	1,1
			material	"gfx/effects/fire/fire3a"

			start
			{
				position { sphere -50,-50,-50,50,50,50 linearSpacing }
				velocity { box -10,-10,-10,10,10,10 }
				angle { box 0,0,0,1,1,1 }
				size { box 30,30,40,40 }
				tint { point 1,0.792157,0.792157 }
				offset { box -2,-2,-2,2,2,2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "halflinear" }
				tint { envelope "exp_x2" }
				fade { envelope "linear" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 90,90,120,120 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	spawner "flash4"
	{
		count		1,1

		sprite
		{
			duration	0.75,0.75
			material	"gfx/effects/weapons/flash"
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { line 140,140,160,160 }
				tint { point 1,0.72549,0.72549 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "exp_x2" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 40,40 }
			}
		}
	}
	spawner "firesphere3"
	{
		detail		0.5
		count		40,40
		locked

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/fire/fire4a"
			generatedNormal

			start
			{
				position { sphere -5,-5,-5,5,5,5 surface }
				velocity { box 80,0,0,100,0,0 }
				size { point 20,20 }
				tint { point 1,0.592157,0.592157 }
				fade { point 0 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				size { envelope "convexfade" }
				tint { envelope "exp_x2" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 70,70 }
				fade { point 0.6 }
				rotate { box 0,0,-0.0555556,0,0,0.0555556 relative }
			}
		}
	}
}





