effect effects/levels/hub/emp_charge
{
	size	758

	emitter "unnamed0"
	{
		duration	7,7
		count		5,5

		electricity
		{
			duration	1,1
			blend	add
			fork	0
			jitterRate	0
			jitterSize	3,7,7
			material	"gfx/effects/electricity/electric_blue_fade"
			gravity		-0.18,-0.18
			generatedOriginNormal

			start
			{
				position { cylinder 0,-1,-1,0,1,1 }
				size { point 2 }
				offset { point -100,0,0 }
				length { point 150,0,0 }
			}

			motion
			{
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				length { box 80,0,0,50,0,0 }
			}
		}
	}
	emitter "unnamed2"
	{
		duration	7,7
		count		5,5

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/energy1"
			gravity		-0.25,-0.25

			start
			{
				size { box 100,100,150,150 }
				tint { line 0.501961,1,1,1,1,1 }
				offset { point -100,0,0 }
				rotate { box -0.5,0.5 }
			}

			motion
			{
				fade { envelope cosine offset 0.5 }
				rotate { envelope linear }
			}
		}
	}
	emitter "unnamed3"
	{
		duration	7,7
		count		20,20

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/spark_blue"
			gravity		-0.25,-0.25

			start
			{
				angle { box 0,0,-0.5,0,0,0.5 }
				size { line 50,50,80,80 }
				tint { line 0,1,1,1,1,1 }
				offset { box -100,-50,-50,-100,50,50 }
				rotate { box -0.5,0.5 }
			}

			motion
			{
				fade { envelope cosine offset 0.5 }
				angle { envelope linear }
				rotate { envelope linear }
			}
		}
	}
	emitter "unnamed4"
	{
		duration	7,7
		count		3,3
		locked

		sprite
		{
			duration	3,3
			blend	add
			material	"gfx/effects/energy_sparks/spark_blue"

			start
			{
				angle { box 0,0,-0.5,0,0,0.5 }
				tint { line 0,1,1,1,1,1 }
				offset { point -50,0,0 }
				rotate { box -0.5,0.5 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine offset 0.5 }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 500,500 }
			}
		}
	}
	sound "unnamed4"
	{
		soundShader	"airdefense_cannon_charge"
		freqshift	0.6,0.6
	}
	sound "unnamed5"
	{
		soundShader	"stream_hub_emp_blast1"
		freqshift	0.6,0.6
	}
}





