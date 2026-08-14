effect effects/monsters/teleport_dropper/runsmoke
{
	size	100

	spawner "steam1"
	{
		count		8,8

		sprite
		{
			duration	0.5,0.5
			persist
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				position { sphere 0,-10,-10,0,10,10 surface }
				velocity { box -100,-100,0,100,100,0 }
				size { line 5,5,10,10 }
				tint { line 0.752941,0.752941,0.752941,0.611765,0.603922,0.529412 }
				fade { point 0 }
				offset { point 0,0,8 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { line 30,30,40,40 }
				tint { point 0.160784,0.160784,0.160784 }
				fade { line 0.5,0.75 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}





