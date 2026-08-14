effect effects/monsters/fatty/ambient_acid
{
	size	567

	emitter "steam"
	{
		duration	4,4
		count		7,9

		sprite
		{
			duration	5,8
			persist
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.035,-0.0125
			generatedOriginNormal

			start
			{
				position { cylinder -50,0,-50,50,0,50 surface }
				velocity { box -10,-10,-10,10,10,10 }
				size { line 2,2,10,10 }
				tint { line 0.803922,0.8,0.756863,0.67451,0.596078,0.356863 }
				fade { point 0 }
				offset { point 0,0,-50 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { line 150,150,300,300 }
				fade { point 0.3 }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
}
