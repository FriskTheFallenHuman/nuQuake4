effect effects/monsters/harvester/grenade_fly
{
	size	52

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
