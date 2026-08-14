effect effects/levels/convoy/tracer
{
	size	5355

	emitter "tracer"
	{
		duration	10,10
		count		5,5

		line
		{
			duration	2,2
			persist
			material	"gfx/effects/weapons/tracerlarge"

			start
			{
				position { line 0,-50,0,500,-50,0 }
				velocity { point 8000,0,0 }
				size { box 20,30 }
				length { box 600,0,0,700,0,0 }
			}

			motion
			{
				fade { envelope exp_xoverx2 }
				length { envelope linear }
			}
		}
	}
	sound "sound"
	{
		soundShader	"weapon_tracer_fire"
	}
}





