effect effects/levels/dispersal/harvester_steam
{
	size	557

	emitter "spout"
	{
		duration	25,25
		count		10,15
		locked

		line
		{
			duration	0.25,0.25
			material	"gfx/effects/smoke/steam_source"
			generatedNormal

			start
			{
				length { point 55,25,55 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { point 50 }
				length { point 55,500,55 }
			}
		}
	}
	sound "sound"
	{
		soundShader	"harvester_steam_blast"
	}
}


