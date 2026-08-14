effect effects/weapons/dmg/impact_default_mp
{
	size	734

	sound "sound"
	{
		soundShader	"weapon_darkmatter_energy_burst"
	}
	decal "decal"
	{

		decal
		{
			duration	0.002,0.002
			material	"textures/decals/rocketburn"

			start
			{
				size { point 150,0 }
				rotate { line 0,1 }
			}
		}
	}
	spawner "sparks"
	{
		detail		0.5
		start		0.2,0.2
		count		50,50

		sprite
		{
			duration	4,6
			blend	add
			material	"gfx/effects/energy_sparks/spark_blue"

			start
			{
				position { sphere -400,-400,-400,400,400,400 }
				velocity { box -50,-50,-50,50,50,50 }
				angle { box 0,0,0,0.277778,0.277778,0.277778 }
				size { line 3,3,10,10 }
				tint { line 1,0.490196,0.709804,1,0.501961,1 }
				fade { point 0 }
				offset { box -6,-6,-6,6,6,6 }
			}

			motion
			{
				fade { envelope "cosine" }
				angle { envelope "linear" }
			}

			end
			{
				fade { point 1 }
				angle { box 0.277778,0.277778,0.277778,0.555556,0.555556,0.555556 relative }
			}
		}
	}
	spawner "fire"
	{
		count		6,6

		sprite
		{
			duration	2,3
			material	"gfx/effects/fire/fire5b"
			gravity		-0.025,-0.025

			start
			{
				position { line 0,0,0,50,0,0 linearSpacing }
				velocity { box 20,0,0,50,0,0 }
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
				size { box 190,190,220,220 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	spawner "inner_darksphere"
	{
		detail		0.5
		count		70,70
		locked

		oriented
		{
			duration	1.5,2
			material	"gfx/effects/weapons/darkmatter_exp1"
			generatedNormal

			start
			{
				position { sphere -25,-25,-25,25,25,25 surface }
				velocity { box 250,0,0,400,0,0 }
				acceleration { point -400,0,0 }
				size { point 20,20 }
				tint { point 0,0,0 }
				fade { point 0 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				size { envelope "convexfade" }
				fade { envelope "fast_in_slow_out" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 150,150 }
				fade { point 0.8 }
				rotate { box 0,0,-0.0555556,0,0,0.0555556 relative }
			}
		}
	}
	spawner "addsphere"
	{
		count		70,70
		locked

		oriented
		{
			duration	1.25,1.75
			blend	add
			material	"gfx/effects/weapons/darkmatter_exp2"
			generatedNormal

			start
			{
				position { sphere -25,-25,-25,25,25,25 surface }
				velocity { box 420,0,0,600,0,0 }
				acceleration { point -400,0,0 }
				size { point 20,20 }
				tint { point 0.737255,0.494118,0.721569 }
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
				size { point 350,350 }
				fade { point 0.4 }
				rotate { box 0,0,-0.0555556,0,0,0.0555556 relative }
			}
		}
	}
	spawner "darksphere"
	{
		count		70,70
		locked

		oriented
		{
			duration	1.25,1.75
			material	"gfx/effects/weapons/darkmatter_exp1"
			generatedNormal

			start
			{
				position { sphere -25,-25,-25,25,25,25 surface }
				velocity { box 420,0,0,600,0,0 }
				acceleration { point -400,0,0 }
				size { point 20,20 }
				tint { point 0,0,0 }
				fade { point 0 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				size { envelope "convexfade" }
				fade { envelope "fast_in_slow_out" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 350,350 }
				fade { point 0.8 }
				rotate { box 0,0,-0.0555556,0,0,0.0555556 relative }
			}
		}
	}
}


