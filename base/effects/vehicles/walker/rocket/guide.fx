effect effects/vehicles/walker/rocket/guide
{
	size	142

	spawner "unnamed1"
	{
		count		1,1
		locked
		constant

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/guis/hud/reticles/nailgun_scope_lock"

			start
			{
				size { point 100,100 }
				tint { point 1,0,0 }
				fade { point 0.8 }
			}

			motion
			{
				rotate { envelope "linear" count 0.003 }
			}

			end
			{
				rotate { point 100 relative }
			}
		}
	}
}



