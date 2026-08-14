effect effects/weapons/dmg/impact_default
{
	size	1110

	decal "decal"
	{

		decal
		{
			duration	0.002,0.002
			material	"textures/decals/rocketburn"

			start
			{
				size { point 100,0 }
				rotate { line 0,1 }
			}
		}
	}
	spawner "x_boom or2"
	{
		count		1,1

		oriented
		{
			duration	0.35,0.35
			material	"gfx/effects/weapons/darkmatter"

			start
			{
				position { point 1,0,0 }
				size { point 2,2 }
			}

			motion
			{
				size { envelope "cosine" }
				fade { envelope "linear" }
			}

			end
			{
				size { line 500,500,600,600 }
			}
		}
	}
	spawner "x_boom2"
	{
		count		1,1

		sprite
		{
			duration	0.35,0.35
			material	"gfx/effects/weapons/darkmatter"

			start
			{
				size { point 2,2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "cosine" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 500,500,600,600 }
				rotate { box -0.5,0.5 relative }
			}
		}
	}
	spawner "x_inner glow2"
	{
		count		3,3

		sprite
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/energy_sparks/spark_blue"

			start
			{
				size { point 2,2 }
				tint { point 1,0.74902,1 }
				rotate { box -0.5,0.5 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 500,500 }
				rotate { box -1,1 relative }
			}
		}
	}
	spawner "x_innerglow base/2"
	{
		count		3,3

		oriented
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/energy_sparks/spark_blue"

			start
			{
				position { point 1,0,0 }
				size { point 2,2 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 500,500 }
			}
		}
	}
	spawner "x_fill2"
	{
		start		0.15,0.15
		count		15,15

		sprite
		{
			duration	0.25,0.5
			blend	add
			material	"gfx/effects/weapons/plasma1"
			generatedOriginNormal

			start
			{
				position { sphere 0,-200,-200,0,200,200 surface }
				velocity { box 0,0,0,1000,0,0 }
				size { point 100,100 }
				tint { line 0.886275,0.756863,0.941177,0.619608,0.243137,1 }
				fade { line 0.5,1 }
				offset { box 0,-100,-100,0,100,100 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				offset { envelope "linear" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 500,500 }
				offset { point 1,1,1 }
				angle { box -1,-1,-1,1,1,1 }
				rotate { box -0.166667,0.166667 relative }
			}
		}
	}
	spawner "x_fill3"
	{
		start		0.15,0.15
		count		10,10

		sprite
		{
			duration	0.25,0.5
			blend	add
			material	"gfx/effects/weapons/plasma1"

			start
			{
				position { sphere 0,-200,-200,0,200,200 surface }
				velocity { box 0,0,0,800,0,0 }
				size { point 100,100 }
				tint { line 0.886275,0.756863,0.941177,0.619608,0.243137,1 }
				fade { line 0.5,1 }
				offset { box 0,-100,-100,0,100,100 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				offset { envelope "linear" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 500,500 }
				offset { point 1,1,1 }
				angle { box -1,-1,-1,1,1,1 }
				rotate { box -0.166667,0.166667 relative }
			}
		}
	}
	sound "unnamed9"
	{
		soundShader	"weapon_darkmatter_energy_burst"
	}
}









