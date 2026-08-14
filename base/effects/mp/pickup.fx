effect effects/mp/pickup
{
	size	85

	spawner "unnamed0"
	{
		count		10,10

		sprite
		{
			duration	0.4,0.4
			blend	add
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				size { box 1,2,80,2 }
				fade { line 0.25,0.5 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				rotate { box -0.5,0.5 relative }
			}
		}
	}
	spawner "unnamed1"
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
	spawner "unnamed2"
	{
		count		1,1

		sprite
		{
			duration	0.2,0.4
			blend	add
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				size { point 60,60 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
	spawner "unnamed3"
	{
		count		50,50

		sprite
		{
			duration	0.4,0.4
			blend	add
			material	"gfx/effects/energy_sparks/spark2"
			gravity		0.025,0.025
			generatedOriginNormal

			start
			{
				position { sphere 0,-2,-2,0,2,2 }
				velocity { box -50,-50,-50,50,50,50 }
				fade { line 0.5,1 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
	sound "unnamed4"
	{
		soundShader	"mp_item_respawn"
	}
	delay "unnamed5"
	{
		duration	3,3
	}
}


