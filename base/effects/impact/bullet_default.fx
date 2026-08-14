effect effects/impact/bullet_default
{
	size	143

	sound "segment00"
	{
		soundShader	"bullet_impact_metal"
	}
	decal "segment01"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/bullet_glowcenter"

			start
			{
				size { point 2,2 }
				fade { point 0.5 }
			}
		}
	}
	spawner "segment032"
	{
		start		0.12,0.12
		count		1,1
		locked

		sprite
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/particles_shapes/shockwave"

			start
			{
				velocity { point 10,0,0 }
				size { point 10,10 }
				fade { point 0.4 }
				rotate { point -0.05 }
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
				size { point 100,100 }
			}
		}
	}
	spawner "segment042"
	{
		count		1,1
		locked

		sprite
		{
			duration	0.12,0.12
			material	"gfx/effects/particles_shapes/spike"
			generatedOriginNormal

			start
			{
				position { point 3,0,0 }
				velocity { point 0,1,0 }
				size { point 30,30 }
				tint { point 0.984314,0.952941,0.607843 }
				rotate { point -0.03 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear count 0 }
				rotate { envelope linear }
			}

			end
			{
				size { point 0,0 }
			}
		}
	}
	spawner "segment052"
	{
		count		20,20
		locked

		line
		{
			duration	0.12,0.12
			material	"gfx/effects/weapons/flash"
			gravity		0.1,0.1
			generatedOriginNormal

			start
			{
				position { sphere -0.5,-0.5,-0.5,0.5,0.5,0.5 }
				velocity { point 50,0,0 }
				size { point 0.5 }
				length { point 1,0,0 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				length { envelope linear }
			}

			end
			{
				length { box 15,0,0,20,0,0 }
			}
		}
	}
}


