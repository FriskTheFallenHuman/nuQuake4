effect effects/monsters/teleport_dropper/telpod_explode
{
	size	198

	spawner "flash"
	{
		count		1,1

		sprite
		{
			duration	0.15,0.15
			blend	add
			material	"gfx/effects/energy_sparks/energy1"
			generatedOriginNormal

			start
			{
				size { point 140,140 }
				tint { point 0.705882,0.960784,0.890196 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope decalfade }
			}

			end
			{
				size { point 0,0 }
				fade { point 1 }
			}
		}
	}
	spawner "swirl"
	{
		count		20,20

		sprite
		{
			duration	0.5,0.7
			blend	add
			material	"gfx/effects/energy_sparks/energy1"
			gravity		-0.1,0
			trailType	motion
			trailTime	1,1
			trailCount	6,6

			start
			{
				position { cylinder 0,-2,-2,0,2,2 }
				velocity { box 0,-5,-5,15,5,5 }
				angle { box 0,0,0,1,1,1 }
				size { line 2,2,4,4 }
				tint { line 0.85098,0.909804,0.866667,0.854902,0.878431,0.705882 }
				fade { point 0 }
				offset { box 0,-20,-20,0,20,20 }
				rotate { box 0,1 }
			}

			motion
			{
				tint { envelope exp_x2 }
				fade { envelope fastinslowout }
				offset { envelope linear }
				angle { envelope linear }
			}

			end
			{
				fade { point 1 }
				offset { box 0,-1,-1,0,1,1 }
				angle { box -1,-1,-1,1,1,1 relative }
			}
		}
	}
	spawner "smoke"
	{
		count		5,5

		sprite
		{
			duration	0.6,0.8
			blend	add
			material	"gfx/effects/energy_sparks/energy1"
			gravity		-0.02,-0.02
			generatedOriginNormal

			start
			{
				position { sphere -15,-15,-15,15,15,15 }
				velocity { box 0,0,0,20,0,0 }
				size { line 20,20,25,25 }
				tint { line 0.447059,0.8,0.568627,0.713726,0.803922,0.901961 }
				fade { point 0.6 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 50,50,60,60 }
				tint { point 0.980392,0.886275,0.670588 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	spawner "sparks"
	{
		count		20,20

		sprite
		{
			duration	0.3,0.5
			material	"gfx/effects/particles_shapes/blank"
			gravity		0.5,0.5
			generatedOriginNormal
			trailType	motion
			trailTime	0.1,0.1
			trailCount	3,3

			start
			{
				position { sphere -1,-1,-1,1,1,1 }
				velocity { box 80,0,0,300,0,0 }
				size { box 3,3,5,5 }
				tint { point 0.619608,0.6,0.470588 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
			}

			end
			{
				tint { line 0.929412,0.796079,0.321569,0.909804,0.501961,0.364706 }
			}
		}
	}
}
