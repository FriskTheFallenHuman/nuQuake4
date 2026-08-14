effect effects/materials/dirt
{
	size	186

	decal "scorch"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/nailgun_mark"

			start
			{
				size { point 12,12 }
				rotate { box 0,1 }
			}
		}
	}
	spawner "dust"
	{
		count		10,12

		sprite
		{
			duration	1,2
			material	"gfx/effects/smoke/smoke_alpha"

			start
			{
				position { cylinder 0,-0.05,-0.05,0,0.05,0.05 }
				velocity { box 5,-25,-25,10,25,25 }
				friction { box -200,0,0,-300,0,0 }
				size { point 5,5 }
				tint { line 0.784314,0.74902,0.501961,0.494118,0.392157,0.196078 }
				rotate { box 0,0.25 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope exp_1minusx/x2 count 0.7,0.7,0.7 }
				fade { envelope exp_1minusx/x2 }
				rotate { envelope linear }
			}

			end
			{
				size { point 100,100 }
				rotate { box 0.125,0 }
			}
		}
	}
	spawner "impact_mist"
	{
		count		12,15
		locked

		line
		{
			duration	0.25,0.25
			material	"gfx/effects/particles_shapes/jk_dirt"
			generatedOriginNormal

			start
			{
				position { cylinder 0,-0.5,-0.5,0,0.5,0.5 }
				size { point 5 }
				fade { point 0 }
				length { box 1,5,5,1,-5,-5 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope pop_fade }
				length { envelope linear }
			}

			end
			{
				size { point 12 }
				fade { point 1 }
				length { box 12,-35,-35,12,35,35 }
			}
		}
	}
	sound "unnamed5"
	{
		soundShader	"effects_bulletimpact_dirt"
	}
}



