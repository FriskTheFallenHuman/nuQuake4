effect effects/monsters/spiderhead/acid_spit
{
	size	17

	spawner "unnamed0"
	{
		count		1,1
		locked

		sprite
		{
			duration	5,5
			material	"gfx/effects/fluids_drips/bubble_glob"

			start
			{
				position { point 1,0,0 }
				size { point 7,7 }
				tint { point 0.501961,0.501961,0 }
				rotate { box -3,4 }
			}

			motion
			{
				tint { envelope linear }
				rotate { envelope linear }
			}
		}
	}
	spawner "unnamed1"
	{
		count		1,1
		locked

		line
		{
			duration	2,2
			blend	add
			material	"gfx/effects/fluids_drips/bubble_glob"

			start
			{
				position { point 1,0,0 }
				size { point 3 }
				tint { point 0.317647,0.317647,0.156863 }
				length { point -20,0,0 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { point 3 }
				length { point 10,1,1 }
			}
		}
	}
	spawner "unnamed2"
	{
		count		1,1
		locked

		sprite
		{
			duration	5,5
			material	"gfx/effects/fluids_drips/bubble_glob"

			start
			{
				size { point 4,4 }
				tint { point 0.501961,0.501961,0 }
				rotate { box -1,0 }
			}

			motion
			{
				tint { envelope linear }
				rotate { envelope linear }
			}
		}
	}
	spawner "unnamed3"
	{
		count		1,1
		locked

		line
		{
			duration	2,2
			blend	add
			material	"gfx/effects/fluids_drips/bubble_glob"

			start
			{
				position { point 5,0,0 }
				size { point 4 }
				tint { point 0.313726,0.313726,0.156863 }
				length { point -30,0,0 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { point 4 }
				length { point 10,1,1 }
			}
		}
	}
	spawner "unnamed4"
	{
		count		1,1
		locked

		sprite
		{
			duration	5,5
			material	"gfx/effects/fluids_drips/bubble_glob"

			start
			{
				position { point -1,0,0 }
				size { point 4,4 }
				tint { point 0.501961,0.501961,0 }
				rotate { box -1,0 }
			}

			motion
			{
				tint { envelope linear }
				rotate { envelope linear }
			}
		}
	}
	spawner "unnamed5"
	{
		count		2,2
		locked

		sprite
		{
			duration	5,5
			material	"gfx/effects/fluids_drips/bubble_glob"

			start
			{
				position { box -2,0,0,-3,0,0 }
				size { point 3,3 }
				tint { point 0.501961,0.501961,0 }
				rotate { box -1,0 }
			}

			motion
			{
				tint { envelope linear }
				rotate { envelope linear }
			}
		}
	}
	spawner "unnamed6"
	{
		count		2,2
		locked

		sprite
		{
			duration	5,5
			material	"gfx/effects/fluids_drips/bubble_glob"

			start
			{
				position { box -4,0,0,-5,0,0 }
				size { point 2.5,2.5 }
				tint { point 0.501961,0.501961,0 }
				rotate { box -1,0 }
			}

			motion
			{
				tint { envelope linear }
				rotate { envelope linear }
			}
		}
	}
}


