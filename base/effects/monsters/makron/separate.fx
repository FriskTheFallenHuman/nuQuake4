effect effects/monsters/makron/separate
{
	size	344

	spawner "dust_back"
	{
		count		30,30
		attenuateEmitter

		sprite
		{
			duration	0.5,0.5
			persist
			material	"gfx/effects/smoke/smoke_alpha"
			gravity		-0.03,-0.02
			generatedNormal

			start
			{
				position { cylinder 0,-1,-1,0,1,1 surface }
				velocity { box 400,0,0,600,0,0 }
				size { box 10,10,20,20 }
				tint { point 0.752941,0.752941,0.752941 }
				fade { line 0.1,0.5 }
				rotate { box -0.5,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 100,100,150,150 }
				rotate { box -1,-0.5 relative }
			}
		}
	}
	spawner "unnamed3"
	{
		count		50,50
		locked
		attenuateEmitter

		line
		{
			duration	0.25,0.25
			persist
			material	"gfx/effects/smoke/smoke_alpha_depth"
			generatedOriginNormal

			start
			{
				position { cylinder 0,-0.1,-0.1,0,0.1,0.1 surface }
				velocity { box 150,0,0,200,0,0 }
				size { box 1,2 }
				tint { point 0.752941,0.752941,0.752941 }
				fade { point 0.5 }
				length { box 30,0,0,40,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { box 4,8 }
				length { box 100,0,0,150,0,0 }
			}
		}
	}
}
