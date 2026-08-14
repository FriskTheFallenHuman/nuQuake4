effect effects/monsters/iron_maiden/banshee
{
	size	173

	emitter "distortion"
	{
		detail		0.5
		duration	10,10
		count		5,5

		sprite
		{
			duration	1,1
			blend	add
			persist
			material	"gfx/effects/energy_sparks/explosion_deform3"

			start
			{
				velocity { box 150,-5,-5,150,5,5 }
				size { point 5,5 }
			}

			motion
			{
				size { envelope "cosine" count 0.5,0.5 }
				fade { envelope "cosine" count 0.5 }
			}

			end
			{
				size { point 70,70 }
			}
		}
	}
	emitter "main"
	{
		duration	10,10
		count		10,10

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/launch_flash3_grey"

			start
			{
				position { point 1,0,0 }
				velocity { box 200,-5,-5,200,5,5 }
				size { point 5,5 }
				tint { line 1,1,1,0.701961,0.705882,0.8 }
				fade { point 0.5 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" count 0.5 }
			}

			end
			{
				size { point 60,60 }
			}
		}
	}
	emitter "reg"
	{
		duration	10,10
		count		10,10

		sprite
		{
			duration	1,1
			blend	add
			persist
			material	"gfx/effects/energy_sparks/launch_flash3_grey"

			start
			{
				velocity { box 200,-5,-5,200,5,5 }
				size { point 5,5 }
				tint { line 1,1,1,0.721569,0.729412,0.780392 }
				fade { point 0.5 }
			}

			motion
			{
				size { envelope "linear" count 1.5,1.5 }
				fade { envelope "cosine" count 0.5 }
			}

			end
			{
				size { point 60,60 }
			}
		}
	}
	emitter "reg2"
	{
		detail		0.5
		duration	10,10
		count		10,10

		sprite
		{
			duration	1,1
			blend	add
			persist
			material	"gfx/effects/energy_sparks/launch_flash3_grey"

			start
			{
				velocity { box 200,-5,-5,200,5,5 }
				size { point 5,5 }
				tint { point 0.423529,0.435294,0.533333 }
			}

			motion
			{
				size { envelope "linear" count 1.5,1.5 }
				fade { envelope "cosine" count 0.5 }
			}

			end
			{
				size { point 30,30 }
			}
		}
	}
}






