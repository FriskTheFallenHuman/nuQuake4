effect effects/monsters/grunt/bullet_tracer
{
	size	1

	spawner "unnamed2"
	{
		count		1,1

		line
		{
			duration	0.12,0.12
			material	"gfx/effects/weapons/tracerflipped"

			start
			{
				size { point 0.75 }
				tint { point 0.27451,0.27451,0.27451 }
				length { line 0,0,0,0,0,0 useEndOrigin }
			}

			motion
			{
				fade { envelope "linear" }
				length { envelope "linear" }
			}
		}
	}
}







