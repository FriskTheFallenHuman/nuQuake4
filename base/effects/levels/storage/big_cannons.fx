effect effects/levels/storage/big_cannons
{
	size	3072

	trail "trail5"
	{
		count		40,40

		sprite
		{
			duration	2,2
			blend	add
			material	"gfx/effects/weapons/plasma1"

			start
			{
				size { point 35,35 }
				tint { line 1,1,1,0.4,0.54902,0.839216 }
				fade { point 0.2 }
				rotate { box -0.5,0.5 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope cosine offset 0.5 }
			}

			end
			{
				size { line 20,20,5,5 }
			}
		}
	}
	emitter "unnamed3"
	{
		duration	5,5
		count		0.5,0.5

		sprite
		{
			duration	15,15
			material	"gfx/effects/weapons/blaster_fly2"
			trailType	trail5

			start
			{
				position { box 0,-200,-100,0,200,100 }
				velocity { box 450,-25,-25,600,25,25 }
				size { point 50,50 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope exp_x2 count 1.2,1.2 offset -0.2,-0.2 }
				rotate { envelope linear }
			}

			end
			{
				size { point 70,70 }
				rotate { box -9.16667,-13.3333 relative }
			}
		}
	}
}
