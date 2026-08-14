effect effects/mp/armor_shard
{
	size	29

	emitter "unnamed1"
	{
		duration	1,1
		count		1,1
		locked

		sprite
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/energy_sparks/spark3"

			start
			{
				position { point -2,0,11 }
				velocity { point -15,0,0 }
				size { point 15,15 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 5,5 }
			}
		}
	}
	emitter "unnamed2"
	{
		duration	1,1
		count		1,1
		locked

		sprite
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/energy_sparks/spark3"

			start
			{
				position { point 2,0,11 }
				velocity { point 15,0,0 }
				size { point 15,15 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 5,5 }
			}
		}
	}
}

