effect effects/monsters/gunner/grenade_fly
{
	size	104

	light "light3"
	{
		detail		0.5
		locked
		constant

		light
		{
			duration	1,1
			material	"lights/grenade_flicker"

			start
			{
				size { point 60,60,60 }
				tint { point 0.972549,0.286275,0.0862745 }
			}
		}
	}
	emitter "unnamed3"
	{
		duration	1,1
		count		50,50
		attenuateEmitter

		sprite
		{
			duration	0.5,0.5
			blend	add
			persist
			material	"gfx/effects/weapons/flash"

			start
			{
				position { line 0,-2,-2,0,2,2 }
				size { line 18,18,22,22 attenuate }
				tint { point 1,0,0 }
				fade { point 0.25 }
				offset { point -5,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 28,28,32,32 attenuate }
				rotate { box -0.25,0.25 relative }
			}
		}
	}
}





