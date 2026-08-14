effect effects/levels/terminal/bridge_disconnect
{
	size	287

	emitter "segment00"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	2,2
			material	"gfx/effects/particles_shapes/spike"

			start
			{
				size { point 20,20 }
				tint { point 1,0.501961,0 }
				rotate { point 3 }
			}

			motion
			{
				size { envelope cosine count 2,2 }
				tint { envelope linear }
				rotate { envelope linear count -0.05 }
			}

			end
			{
				size { point 15,15 }
			}
		}
	}
	emitter "segment01"
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
	emitter "segment02"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/spike"

			start
			{
				size { point 20,20 }
				tint { point 1,0.501961,0 }
				rotate { point 3 }
			}

			motion
			{
				size { envelope cosine count 2,2 }
				tint { envelope linear }
				rotate { envelope linear count 0.05 }
			}

			end
			{
				size { point 15,15 }
			}
		}
	}
	spawner "segment03"
	{
		count		12,15

		sprite
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/spike"
			generatedOriginNormal

			start
			{
				position { cylinder -0.05,-0.05,-0.05,0.05,0.05,0.05 }
				velocity { box 500,-200,-200,500,200,200 }
				acceleration { point 100,100,100 }
				size { point 3,4 }
				tint { line 1,1,0.501961,1,0.501961,0 }
				rotate { point 3 }
			}

			motion
			{
				rotate { envelope linear count -0.05 }
			}

			impact
			{
				bounce	0.5
			}
		}
	}
	light "segment04"
	{
		locked

		light
		{
			duration	1,1
			material	"lights/defaultPointLight"

			start
			{
				size { point 50,50,50 }
			}

			motion
			{
				tint { envelope linear }
			}
		}
	}
	light "segment05"
	{
		locked

		light
		{
			duration	0.1,0.1
			material	"lights/defaultPointLight"

			start
			{
				size { point 50,50,50 }
			}

			motion
			{
				tint { envelope linear }
			}

			end
			{
				tint { point 1,1,0.501961 }
			}
		}
	}
	sound "segment07"
	{
		soundShader	"network_bridge_disconnect"
	}
}


