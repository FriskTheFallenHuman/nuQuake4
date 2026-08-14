effect effects/monsters/scientist/gas_grenade_fly
{
	size	78

	emitter "smoke"
	{
		detail		0.5
		duration	1,1
		count		40,40

		sprite
		{
			duration	0.4,1
			persist
			material	"gfx/effects/smoke/steam_alpha"

			start
			{
				position { sphere -5,-5,-5,5,5,5 }
				velocity { box 0,-5,-5,0,5,5 }
				tint { line 0.403922,0.886275,0.427451,0.784314,0.768627,0.447059 }
				fade { point 0.6 }
				rotate { point 0.2 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 30,30,50,50 }
			}
		}
	}
	emitter "smoke2"
	{
		duration	1,1
		count		40,40

		sprite
		{
			duration	0.4,1
			persist
			material	"gfx/effects/smoke/cloud_alpha"

			start
			{
				position { sphere -5,-5,-5,5,5,5 }
				velocity { box 0,-5,-5,0,5,5 }
				tint { line 0.576471,0.921569,0.584314,0.784314,0.768627,0.447059 }
				fade { point 0.6 }
				rotate { point 0.2 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 30,30,50,50 }
			}
		}
	}
}







