effect effects/weapons/nailgun/guide_start
{
	size	43

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
				size { point 30,30 }
				tint { point 1,1,0 }
				fade { point 0.8 }
			}

			motion
			{
				tint { envelope cosine count 5,5,5 }
				rotate { envelope linear count 0.002 }
			}

			end
			{
				tint { point 1,0,0 }
				rotate { point 100 relative }
			}
		}
	}
}


