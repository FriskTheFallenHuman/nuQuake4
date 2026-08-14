effect effects/levels/terminal/bridge_connect
{
	size	151

	emitter "segment00"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/particles_shapes/spike"

			start
			{
				size { point 15,15 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
			}

			end
			{
				size { point 75,75 }
			}
		}
	}
	spawner "segment01"
	{
		count		6,9

		sprite
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/spike"
			gravity		0.5,0.5
			generatedOriginNormal

			start
			{
				position { cylinder -0.05,-0.05,-0.05,0.05,0.05,0.05 }
				velocity { box 300,-100,-100,300,100,100 }
				size { point 3,4 }
				tint { line 0.501961,1,1,0,0.501961,1 }
				rotate { point 3 }
			}

			motion
			{
				rotate { envelope linear count -0.05 }
			}

			impact
			{
				remove	1
			}
		}
	}
	light "segment02"
	{
		locked

		light
		{
			duration	0.25,0.25
			material	"lights/defaultPointLight"

			start
			{
				size { point 50,50,50 }
				tint { line 0.501961,1,1,1,1,1 }
			}

			motion
			{
				tint { envelope linear }
			}
		}
	}
	spawner "segment03"
	{
		count		5,5
		locked

		line
		{
			duration	0.05,0.05
			material	"gfx/effects/particles_shapes/add_sphere"
			generatedNormal

			start
			{
				position { box 0.05,0.05,0.05,-0.05,-0.05,-0.05 }
				velocity { point 100,0,0 }
				size { box 0.5,0.25 }
				tint { line 0,0,1,0.501961,1,1 }
				length { point 20,0,0 }
			}
		}
	}
	sound "segment05"
	{
		soundShader	"network_bridge_connect"
	}
}


