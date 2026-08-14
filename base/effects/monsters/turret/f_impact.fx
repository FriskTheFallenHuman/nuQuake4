effect effects/monsters/turret/f_impact
{
	size	77

	sound "unnamed0"
	{
		soundShader	"bullet_impact_metal"
	}
	spawner "unnamed1"
	{
		detail		0.5
		count		1,1

		sprite
		{
			duration	0.5,1.5
			material	"gfx/effects/smoke/blacksmokepuff"
			gravity		-0.02,-0.02

			start
			{
				velocity { box 0,-5,-5,0,5,5 }
				size { point 2,2 }
				rotate { box 0,2 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
			}

			end
			{
				size { point 40,40 }
			}
		}
	}
	decal "unnamed2"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/nailgun_burn"

			start
			{
				size { line 8,8,12,12 }
				rotate { box 0,1 }
			}
		}
	}
	spawner "unnamed3"
	{
		count		6,6
		locked

		line
		{
			duration	0.1,0.2
			material	"gfx/effects/weapons/nailgun_flash2"
			generatedOriginNormal

			start
			{
				position { cylinder 0.5,-0.5,-0.5,0.5,0.5,1 surface }
				velocity { box 50,0,0,160,0,0 }
				size { box 1,2 }
				tint { line 0.501961,0.501961,0.501961,1,1,1 }
				length { box 10,0,0,15,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { point 0 }
				length { box 35,0,0,60,0,0 }
			}
		}
	}
}




