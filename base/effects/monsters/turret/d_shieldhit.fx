effect effects/monsters/turret/d_shieldhit
{
	size	440

	emitter "unnamed2"
	{
		duration	0.2,0.2
		count		100,100
		locked

		oriented
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/weapons/g_rail_flash"
			generatedNormal

			start
			{
				position { sphere 0,-130,-130,180,130,130 surface }
				size { line 100,100,120,120 }
				tint { line 1,1,1,0.866667,0.537255,0.419608 }
				fade { point 0 }
				rotate { point 0,0,-0.0416667 }
			}

			motion
			{
				size { envelope "convexfade" }
				tint { envelope "exp_x2" }
				fade { envelope "fastinslowout" }
			}

			end
			{
				size { line 180,180,220,220 }
				tint { point 0.752941,0.752941,0.752941 }
				fade { point 1 }
			}
		}
	}
}





