effect effects/ambient/hydrolic_spray
{
	size	565

	spawner "end"
	{
		count		5,10

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/steam_alpha"
			gravity		0.125,0.125
			generatedOriginNormal

			start
			{
				position { line 25,0,0,45,0,0 }
				velocity { box 200,-150,-150,100,150,150 }
				size { box 70,70,90,90 }
				tint { line 0.25098,0,0,0,0,0 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { box 100,100,150,150 }
				fade { line 0.5,1 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	emitter "steam"
	{
		duration	1,1
		count		7,9

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/smoke/steam_alpha"
			gravity		0.002,0.002

			start
			{
				position { line 10,-1,-1,10,1,1 }
				velocity { box 5,-10,-10,30,10,10 }
				size { box 2,2,10,10 }
				tint { line 0.368627,0.258824,0.258824,0.643137,0.317647,0.309804 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { box 100,100,150,150 }
				fade { point 0.5 }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
	spawner "unnamed5"
	{
		count		5,5

		line
		{
			duration	1,1
			blend	add
			generatedLine
			material	"gfx/effects/fluids_drips/drop_red"
			gravity		1,1

			start
			{
				velocity { box 20,-200,-200,1000,200,200 }
				size { point 10 }
				length { point 10,0,0 }
			}

			motion
			{
				fade { envelope lightning }
				length { envelope linear }
			}

			end
			{
				length { point 100,0,0 }
			}
		}
	}
	sound "unnamed3"
	{
		soundShader	"effects_steam_blast3"
		volume	0.5,0.5
		freqshift	1.5,1.5
	}
	sound "unnamed4"
	{
		soundShader	"generic_large_metal_break"
		freqshift	2,2
	}
	sound "unnamed5"
	{
		soundShader	"effects_hydraulic_burst"
		volume	2,2
	}
}



