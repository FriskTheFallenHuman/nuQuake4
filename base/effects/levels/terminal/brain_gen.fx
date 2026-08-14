effect effects/levels/terminal/brain_gen
{
	size	181

	emitter "sprites"
	{
		duration	1,1
		count		40,60

		sprite
		{
			duration	0.65,0.65
			blend	add
			persist
			material	"gfx/effects/energy_sparks/red_beam_pulse"
			generatedNormal
			trailType	motion
			trailTime	0.5,0.5
			trailCount	8,8
			trailMaterial	"gfx/effects/particles_shapes/motionblur"

			start
			{
				position { line 0,-20,-20,0,20,20 }
				velocity { point -100,0,0 }
				angle { box -1,-1,-1,1,1,1 }
				size { line 1,1,25,25 }
				tint { point 1,0.501961,0.501961 }
				fade { point 0.75 }
				offset { box 0,-80,-80,0,80,80 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope "fadeouttable" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				angle { point 0.5,0.5,0.5 relative }
			}
		}
	}
	sound "unnamed1"
	{
		soundShader	"effects_bombardment_focus"
		volume	0.5,0.5
		freqshift	2,2
	}
	sound "unnamed2"
	{
		soundShader	"process_core_power_up"
		volume	2,2
		freqshift	1.9,1.9
	}
}





