effect effects/monsters/makron/lightning_trail
{
	size	209

	spawner "bolt shell"
	{
		count		1,1
		locked

		line
		{
			duration	0.3,0.3
			blend	add
			material	"gfx/test/lgun"

			start
			{
				size { point 130 }
				tint { point 0.309804,0,0.309804 }
				fade { point 0 }
				length { line 0,0,0,0,0,0 useEndOrigin }
			}

			motion
			{
				size { envelope "random" count 0.2 }
				tint { envelope "flickerblink" count 8,8,8 }
				fade { envelope "pop_fade" }
			}

			end
			{
				size { point 210 }
				tint { point 0.109804,0,0.109804 }
				fade { point 1 }
			}
		}
	}
	spawner "elect2"
	{
		count		1,1

		electricity
		{
			duration	0.1,0.1
			fork	0
			jitterRate	0
			jitterSize	5,15,15
			jitterTable	"halfsintable"
			material	"gfx/effects/electricity/electric_blue_fade"
			generatedNormal

			start
			{
				position { line 0,0,0,0,0,0 useEndOrigin }
				size { box 3,5 }
				tint { line 0.313726,0.129412,0.619608,0.4,0.54902,0.839216 }
				length { box 10,0,0,50,0,0 }
			}
		}
	}
	spawner "bolt shell2"
	{
		count		1,1
		locked

		line
		{
			duration	0.3,0.3
			blend	add
			material	"gfx/test/lgun"

			start
			{
				size { point 60 }
				tint { point 0.113725,0.262745,0.545098 }
				fade { point 0 }
				length { line 0,0,0,0,0,0 useEndOrigin }
			}

			motion
			{
				size { envelope "random" count 0.2 }
				tint { envelope "flickerblink" count 8,8,8 }
				fade { envelope "pop_fade" }
			}

			end
			{
				size { point 120 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 1 }
			}
		}
	}
	emitter "residualline"
	{
		duration	0.2,0.2
		count		1,1
		locked

		line
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/particles_shapes/add_line"

			start
			{
				size { point 30 }
				tint { point 0.384314,0,0.384314 }
				length { line 0,0,0,0,0,0 useEndOrigin }
			}
		}
	}
	emitter "bolt core"
	{
		duration	0.2,0.2
		count		1,1
		locked

		line
		{
			duration	0.2,0.2
			material	"gfx/effects/electricity/black_lightning"
			tiling	256

			start
			{
				size { box 40,80 }
				length { line 0,0,0,0,0,0 useEndOrigin }
			}

			motion
			{
				tint { envelope "flickerblink" count 8,8,8 }
			}

			end
			{
				tint { point 0.247059,0.247059,0.247059 }
			}
		}
	}
	emitter "main2"
	{
		duration	0.2,0.2
		count		2,2
		locked

		line
		{
			duration	0.2,0.2
			persist
			material	"gfx/effects/energy_sparks/blue_beam"

			start
			{
				size { point 25 }
				tint { point 0.215686,0,0.215686 }
				length { line 0,0,0,0,0,0 useEndOrigin }
			}
		}
	}
	sound "unnamed6"
	{
		soundShader	"makron_lightning1"
	}
}





