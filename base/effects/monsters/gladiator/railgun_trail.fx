effect effects/monsters/gladiator/railgun_trail
{
	size	113

	spawner "beam core"
	{
		count		1,1

		line
		{
			duration	0.8,0.8
			blend	add
			material	"gfx/effects/weapons/rail_trail2"

			start
			{
				size { point 10 }
				fade { point 0 }
				length { line 0,0,0,0,0,0 useEndOrigin }
			}

			motion
			{
				size { envelope "exp_x2" }
				fade { envelope "decalfade" }
			}

			end
			{
				fade { point 1 }
			}
		}
	}
	spawner "spiral"
	{
		density		60,60
		particleCap		512

		linked
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/rail_spiral"
			tiling	250
			generatedNormal

			start
			{
				position { spiral -15,2,0,-15,2,0,25 useEndOrigin linearSpacing }
				velocity { point 5,0,0 }
				size { point 2 }
				tint { point 0.709804,0.458824,0.290196 }
				fade { point 0.5 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "exp_x2" }
			}

			end
			{
				size { point 4 }
			}
		}
	}
	spawner "spark drops"
	{
		detail		0.5
		density		5,5
		particleCap		20

		sprite
		{
			duration	0.8,0.8
			blend	add
			persist
			material	"gfx/effects/energy_sparks/spark3"
			gravity		0.001,0.002

			start
			{
				position { line 0,-1.5,-1.5,0,1.5,1.5 useEndOrigin linearSpacing }
				velocity { box 0,-0.5,-0.5,0,0.5,0.5 }
				angle { box 0,0,0,1,1,1 }
				size { line 30,30,45,45 }
				tint { point 0.929412,0.388235,0.152941 }
				fade { point 0 }
				offset { box -25,-25,-25,25,25,25 }
			}

			motion
			{
				fade { envelope "cosine" }
				offset { envelope "linear" }
				angle { envelope "linear" }
			}

			end
			{
				fade { point 0.5 }
				offset { box -1,-1,-1,1,1,1 }
				angle { box -1,-1,-1,1,1,1 }
			}
		}
	}
	spawner "spiral_parts"
	{
		detail		0.5
		density		5,5
		particleCap		20

		sprite
		{
			duration	0.8,0.8
			blend	add
			persist
			material	"gfx/effects/weapons/railgun_ring_end"
			gravity		0.001,0.002

			start
			{
				position { line 0,-1.5,-1.5,0,1.5,1.5 useEndOrigin linearSpacing }
				velocity { box 0,-0.5,-0.5,0,0.5,0.5 }
				angle { box 0,0,0,1,1,1 }
				size { line 20,20,25,25 }
				tint { point 0.933333,0.333333,0.301961 }
				fade { point 0 }
				offset { box -15,-15,-15,15,15,15 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope "cosine" }
				offset { envelope "linear" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				fade { point 0.2 }
				offset { box -1,-1,-1,1,1,1 }
				angle { box -1,-1,-1,1,1,1 }
				rotate { point 5.55556 relative }
			}
		}
	}
	spawner "trail"
	{
		detail		0.5
		density		80,80
		particleCap		20

		sprite
		{
			duration	0.85,0.85
			persist
			material	"gfx/effects/energy_sparks/explosion_deform3"

			start
			{
				position { line 0,-2,-2,0,2,2 useEndOrigin }
				velocity { point 100,0,0 }
				size { line 5,5,10,10 }
				fade { point 0.2 }
				offset { point -5,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "sintable" count 0.5,0.5 }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 20,20,50,50 }
				rotate { box -0.25,0.25 relative }
			}
		}
	}
}








