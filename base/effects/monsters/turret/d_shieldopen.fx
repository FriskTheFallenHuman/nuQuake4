effect effects/monsters/turret/d_shieldopen
{
	size	417

	spawner "unnamed2"
	{
		count		50,50
		locked

		oriented
		{
			duration	0.4,0.4
			blend	add
			material	"gfx/effects/weapons/g_rail_flash"
			generatedNormal

			start
			{
				position { sphere 0,-140,-140,160,140,140 surface }
				velocity { box 0,-500,0,0,500,0 }
				size { line 80,80,160,160 }
				tint { line 1,1,1,0.866667,0.537255,0.419608 }
				fade { point 0.75 }
				rotate { point 0,0,-0.0416667 }
			}

			motion
			{
				tint { envelope "exp_x2" }
				fade { envelope "exp_xoverx2" }
			}
		}
	}
}





