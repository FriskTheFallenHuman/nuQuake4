effect effects/wounds/blood
{
	size	263

	emitter "unnamed0"
	{
		duration	1,1
		count		50,50

		sprite
		{
			duration	1,1
			blend	add
			material	"textures/decals/splat2_fade"
			gravity		1,1
			trailType	burn
			trailTime	1,1
			trailCount	5,5

			start
			{
				velocity { box 300,-300,-300,325,300,300 }
				size { point 20,20 }
			}
			timeout
			{
				effect	"effects/wounds/bleeding"
			}
		}
	}
}
