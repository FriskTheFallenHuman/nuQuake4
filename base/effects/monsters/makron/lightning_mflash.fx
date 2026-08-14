effect effects/monsters/makron/lightning_mflash
{
	size	355

	emitter "center2"
	{
		duration	1,1
		count		7,7
		locked

		sprite
		{
			duration	1,1
			material	"gfx/effects/weapons/darkmatter_haze"

			start
			{
				size { point 60,60 }
				rotate { box 1,-1 }
			}

			motion
			{
				size { envelope "cosine" }
				fade { envelope "linear" }
			}

			end
			{
				size { box 150,150,200,200 }
			}
		}
	}
	emitter "unnamed5"
	{
		duration	1,1
		count		7,7
		locked

		oriented
		{
			duration	1,1
			material	"gfx/effects/weapons/darkmatter_haze"

			start
			{
				position { point 1,0,0 }
				size { point 60,60 }
				rotate { box 0,0,-1,0,0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { line 200,200,250,250 }
			}
		}
	}
	emitter "electricity"
	{
		duration	1,1
		count		5,5
		locked

		electricity
		{
			duration	1,1
			fork	0
			jitterRate	0
			jitterSize	6,14,14
			jitterTable	"halfsintable"
			material	"gfx/effects/weapons/darkmatterbolt"
			generatedNormal

			start
			{
				position { sphere 0,-10,-10,0,10,10 surface }
				size { point 4 }
				tint { line 0.866667,0.615686,1,1,1,1 }
				length { box 60,0,0,100,0,0 }
			}

			motion
			{
				length { envelope "linear" }
			}
		}
	}
	spawner "center"
	{
		count		1,1
		locked
		constant

		sprite
		{
			duration	1,1
			material	"gfx/effects/weapons/darkmatter"

			start
			{
				size { point 40,40 }
			}

			motion
			{
				size { envelope "randomflick" }
			}

			end
			{
				size { point 60,60 }
			}
		}
	}
	emitter "center3"
	{
		duration	1,1
		count		20,20
		locked

		sprite
		{
			duration	1,2
			blend	add
			persist
			material	"gfx/effects/weapons/plasma1"

			start
			{
				velocity { point 10,0,0 }
				size { line 40,40,45,44 }
				tint { point 0.572549,0.447059,0.619608 }
				fade { line 0.25,0.75 }
				offset { box 0,-30,-30,0,30,30 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" offset 0.5 }
				offset { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 10,10,20,20 }
				offset { point 1,1,1 }
				rotate { box -0.25,0.25 relative }
			}
		}
	}
	emitter "electricity2"
	{
		duration	1,1
		count		5,5
		locked

		electricity
		{
			duration	1,1
			fork	0
			jitterRate	0
			jitterSize	3,8,5
			jitterTable	"halfsintable"
			material	"gfx/effects/weapons/darkmatterbolt"

			start
			{
				position { point 0,0,0 }
				velocity { box 0,-10,-10,0,10,10 }
				size { point 4 }
				tint { point 0.639216,0.568627,0.741176 }
				length { box 50,0,0,200,0,0 }
			}
		}
	}
	sound "unnamed6"
	{
		soundShader	"effects_fire_whoosh"
		freqshift	1.7,1.7
	}
	sound "unnamed7"
	{
		soundShader	"makron_grenade_fly"
	}
}



