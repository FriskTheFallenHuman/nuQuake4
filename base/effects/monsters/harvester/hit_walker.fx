effect effects/monsters/harvester/hit_walker
{
	size	425

	spawner "impact"
	{
		count		1,1

		sprite
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/weapons/flash"

			start
			{
				size { point 50,50 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 300,300 }
			}
		}
	}
	spawner "sparks"
	{
		count		10,10

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/weapons/flash"
			gravity		1,1
			trailType	sparktrail

			start
			{
				velocity { box 600,-600,-600,800,600,600 }
				size { point 5,5 }
			}
		}
	}
	spawner "unnamed3"
	{
		count		10,30

		line
		{
			duration	0.25,0.25
			blend	add
			generatedLine
			material	"gfx/effects/weapons/flash"
			gravity		0.5,1

			start
			{
				velocity { box 300,-500,-500,500,500,500 }
				size { point 2 }
				length { point 100,0,0 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
}
