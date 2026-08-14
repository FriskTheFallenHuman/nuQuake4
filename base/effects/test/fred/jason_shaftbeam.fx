effect effects/test/fred/jason_shaftbeam
{
	size	9243

	emitter "main"
	{
		duration	1,1
		count		1,1

		line
		{
			duration	1,1
			persist
			material	"gfx/effects/energy_sparks/blue_beam"

			start
			{
				size { point 45 }
				length { point 9200,0,0 }
			}

			motion
			{
				size { envelope flicker count 20 }
			}

			end
			{
				size { point 85 }
			}
		}
	}
	emitter "unnamed1"
	{
		duration	1,1
		count		100,200

		oriented
		{
			duration	3,3
			material	"gfx/effects/weapons/plasma1"
			generatedNormal

			start
			{
				position { cylinder 9200,-5,-5,100,5,5 surface }
				velocity { point 50,0,0 }
				size { box 500,100,300,50 }
				tint { point 0,0,0 }
			}

			motion
			{
				tint { envelope fastinslowout }
			}

			end
			{
				tint { point 0.0196078,0.196078,0.156863 }
			}
		}
	}
	emitter "main2"
	{
		duration	1,1
		count		1,1

		line
		{
			duration	1,1
			persist
			material	"gfx/effects/energy_sparks/blue_beam"

			start
			{
				size { point 20 }
				length { point 9200,0,0 }
			}
		}
	}
}
