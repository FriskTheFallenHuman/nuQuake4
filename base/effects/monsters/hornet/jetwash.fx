effect effects/monsters/hornet/jetwash
{
	size	183

	emitter "deform2"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	1,1
			material	"gfx/effects/energy_sparks/warp_mask"

			start
			{
				position { point -30,0,0 }
				size { point 50,50 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 80,80 }
			}
		}
	}
	emitter "ENGINE"
	{
		duration	1,1
		count		5,5
		locked

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/plasma1"

			start
			{
				position { cylinder 15,-10,-10,-20,10,10 }
				size { box 40,40,60,60 }
				tint { point 0.803922,0.803922,1 }
				fade { point 0.65 }
				offset { box -10,-10,-10,10,10,10 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope "cosine" offset 0.5 }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				rotate { box -0.25,0.25 relative }
			}
		}
	}
	emitter "trail"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	2,2
			blend	add
			material	"gfx/effects/weapons/plasma1"

			start
			{
				position { cylinder 5,-40,-40,-60,40,40 }
				size { point 100,100 }
				tint { point 0.803922,0.803922,1 }
				fade { line 0.25,0.5 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope "cosine" offset 0.5 }
				rotate { envelope "linear" }
			}

			end
			{
				rotate { box -0.25,0.25 relative }
			}
		}
	}
	spawner "electricity2"
	{
		count		10,10
		locked
		constant

		electricity
		{
			duration	1,1
			blend	add
			fork	0
			jitterRate	0
			jitterSize	15,7,7
			jitterTable	"halfsintable"
			material	"gfx/effects/electricity/electric_blue_fade"

			start
			{
				position { cylinder -60,-20,-20,-60,20,20 }
				size { box 2,5 }
				tint { line 1,1,1,0.501961,0.501961,1 }
				fade { point 0.5 }
				length { box 40,0,0,60,0,0 }
			}
		}
	}
}








