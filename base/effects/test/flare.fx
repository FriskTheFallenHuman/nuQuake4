effect effects/test/flare
{
	size	28

	emitter "unnamed0"
	{
		duration	1,1
		count		3,3

		sprite
		{
			duration	1,1
			material	"models/mapobjects/terminal/doorflare"

			start
			{
				velocity { box 50,-20,-20,50,20,20 }
				size { point 2,2 }
			}
		}
	}
}
