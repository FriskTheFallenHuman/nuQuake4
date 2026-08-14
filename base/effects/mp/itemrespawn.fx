effect effects/mp/itemrespawn
{
	size	80

	sound "sound"
	{
		soundShader	"mp_item_respawn"
	}
	emitter "motes"
	{
		duration	1,1
		count		50,50

		sprite
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/weapons/blue_spark"
			gravity		0.01,0.05
			generatedNormal

			start
			{
				position { sphere 0,-32,-32,0,32,32 }
				velocity { box 0,-5,-5,0,5,5 }
				size { line 2,2,10,10 }
				tint { line 0.639216,0.639216,0.858824,0.74902,0.74902,0.74902 }
				fade { line 0.5,0.9 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
	spawner "star2"
	{
		count		10,10

		sprite
		{
			duration	0.4,0.4
			blend	add
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				size { box 1,2,40,2 }
				tint { line 0.501961,0.501961,0.501961,0.603922,0.580392,0.921569 }
				rotate { box -1,1 }
			}

			motion
			{
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				rotate { box -1,1 relative }
			}
		}
	}
	spawner "burst"
	{
		count		1,1

		sprite
		{
			duration	0.2,0.4
			blend	add
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				size { point 50,50 }
				tint { line 0.603922,0.576471,0.921569,0.74902,0.74902,0.74902 }
				rotate { box 0,0.5 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}
		}
	}
	spawner "moresprites"
	{
		count		50,50

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/spark2"
			gravity		0.025,0.025

			start
			{
				position { sphere 0,-20,-20,0,20,20 }
				velocity { box -50,0,0,50,0,0 }
				angle { box 0,0,-0.5,0,0,0.5 }
				size { line 1,1,2,2 }
				tint { line 0.752941,0.752941,0.752941,0,0,1 }
				fade { line 0.5,1 }
				offset { box 0,-10,-10,0,10,10 }
			}

			motion
			{
				fade { envelope linear }
				angle { envelope linear }
			}

			end
			{
				angle { box 0,0,-1,0,0,1 }
			}
		}
	}
	spawner "ring2"
	{
		count		2,2

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/smoke/cloud_alpha2"

			start
			{
				velocity { box -5,-5,-5,5,5,5 }
				angle { box 0,0,0,0,0,0.5 }
				size { line 5,5,30,30 }
				tint { point 0.74902,0.74902,0.74902 }
				fade { point 0.5 }
				offset { box 0,-5,-5,0,5,5 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 50,50 }
				rotate { point -0.5 relative }
			}
		}
	}
}





