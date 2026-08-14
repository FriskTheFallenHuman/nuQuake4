effect effects/explosions/surface/item_exp
{
	size	283

	spawner "flash"
	{
		count		2,5
		locked

		sprite
		{
			duration	0.125,0.125
			material	"gfx/effects/weapons/mgun_muzzleflash"

			start
			{
				size { line 4,4,5,5 }
				tint { point 0.705882,0.788235,0.803922 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 200,200 }
			}
		}
	}
	spawner "chunks3"
	{
		start		0.12,0.12
		count		8,8

		sprite
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/debris3"
			entityDef	"debris_walker_upperleg"
			gravity		0.5,1
			generatedNormal

			start
			{
				position { sphere -50,-50,-50,50,50,50 }
				velocity { box 45,45,45,200,200,200 }
				size { line 6,6,8,8 }
				rotate { box -1,1 }
			}

			motion
			{
				rotate { envelope linear }
			}

			end
			{
				rotate { box -0.25,0.25 }
			}

			impact
			{
				bounce	0.4
			}
		}
	}
	sound "segment00"
	{
		soundShader	"bullet_impact_metal"
	}
	emitter "smoke"
	{
		duration	1,1
		count		2,2

		sprite
		{
			duration	4,6
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.02,-0.01

			start
			{
				position { line 10,-1,-1,10,1,1 }
				velocity { box 5,-2,-2,10,2,2 }
				angle { box 0,0,0,1,1,1 }
				size { box 30,30,40,40 }
				tint { line 0.117647,0.109804,0.101961,0.188235,0.160784,0.129412 }
				fade { point 0 }
				offset { box -10,-10,-10,10,10,10 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope fastinslowout }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 120,120,150,150 }
				tint { point 0.192157,0.184314,0.164706 }
				fade { point 1 }
				angle { box -0.333333,-0.333333,-0.333333,0.333333,0.333333,0.333333 relative }
				rotate { box -0.166667,0.166667 relative }
			}
		}
	}
	emitter "smoke2"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	4,6
			material	"gfx/effects/smoke/underlit_alpha"
			gravity		-0.02,-0.01

			start
			{
				position { line 10,-1,-1,10,1,1 }
				velocity { box 5,-2,-2,10,2,2 }
				angle { box 0,0,0,1,1,1 }
				size { box 30,30,40,40 }
				tint { line 0.505882,0.470588,0.447059,0.584314,0.509804,0.4 }
				fade { point 0 }
				offset { box -10,-10,-10,10,10,10 }
				rotate { box 0.333333,0.388889 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope fastinslowout }
				angle { envelope linear }
			}

			end
			{
				size { box 80,80,110,110 }
				tint { point 0.192157,0.184314,0.164706 }
				fade { point 1 }
				angle { box -0.333333,-0.333333,-0.333333,0.333333,0.333333,0.333333 relative }
			}
		}
	}
}
