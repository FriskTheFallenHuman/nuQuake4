effect effects/monsters/strogg_flyer/thruster_5sec
{
	size	371

	emitter "smoke"
	{
		duration	5,5
		count		16,16

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				position { cylinder 0.2,-0.1,-0.1,0.2,0.1,0.1 }
				velocity { box 200,-50,-50,400,50,50 }
				size { point 45,45 }
				tint { line 0.721569,0.803922,0.803922,0.294118,0.419608,0.419608 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 100,100 }
				tint { point 0.521569,0.47451,0.301961 }
				fade { point 1 }
				rotate { box -0.333333,0.333333 relative }
			}
		}
	}
	emitter "fire"
	{
		duration	5,5
		count		20,20

		sprite
		{
			duration	0.1,0.2
			blend	add
			material	"gfx/effects/fire/fire_plume_additive"

			start
			{
				position { cylinder 0.2,-0.1,-0.1,0.2,0.1,0.1 }
				velocity { box 50,-50,-50,1000,50,50 }
				size { point 90,90 }
				tint { point 0,1,1 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fast_in_slow_out" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 200,200 }
				fade { point 1 }
				rotate { box -0.333333,0.333333 relative }
			}
		}
	}
	emitter "line_inner"
	{
		duration	5,5
		count		15,15
		locked

		line
		{
			duration	0.1,0.1
			material	"gfx/effects/weapons/blaster_fly_redflipped"

			start
			{
				position { point -2,0,0 }
				size { point 25 }
				tint { line 0,1,1,0.196078,0.843137,0.980392 }
				fade { point 0.5 }
				length { box 200,0,0,300,0,0 }
			}
		}
	}
	emitter "side_streaks2"
	{
		duration	5,5
		count		30,40
		locked

		line
		{
			duration	0.3,0.3
			blend	add
			material	"gfx/effects/weapons/flash_half3"
			generatedOriginNormal

			start
			{
				position { cylinder 0.2,-0.1,-0.1,0.2,0.1,0.1 surface }
				size { box 20,30 }
				tint { line 1,1,1,0,1,1 }
				fade { point 0 }
				offset { point -3,0,0 }
				length { box 10,0,0,20,0,0 }
			}

			motion
			{
				fade { envelope "fast_in_slow_out" }
				length { envelope "linear" }
			}

			end
			{
				fade { point 0.75 }
				length { box 100,0,0,250,0,0 }
			}
		}
	}
	emitter "deform"
	{
		duration	5,5
		count		16,16

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/energy_sparks/teleport_warp"

			start
			{
				position { cylinder 0,-0.1,-0.1,0,0.1,0.1 }
				velocity { box 200,-50,-50,600,50,50 }
				size { point 100,100 }
				tint { line 0.721569,0.803922,0.803922,0.294118,0.419608,0.419608 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				tint { point 0.521569,0.47451,0.301961 }
				fade { point 1 }
				rotate { box -0.333333,0.333333 relative }
			}
		}
	}
	sound "unnamed7"
	{
		soundShader	"effects_fire_whoosh"
		volume	1.8,1.8
		freqshift	0.5,0.5
	}
	sound "unnamed8"
	{
		soundShader	"effects_fire_blast"
		freqshift	0.8,0.8
	}
	sound "unnamed9"
	{
		soundShader	"network_guardian_engine_blast"
	}
	sound "unnamed10"
	{
		soundShader	"network_guardian_rocket_fire"
		freqshift	0.6,0.6
	}
	sound "unnamed11"
	{
		start		2.5,2.5
		soundShader	"effects_fire_blast"
	}
	sound "unnamed12"
	{
		start		2.5,2.5
		soundShader	"effects_fire_whoosh"
		volume	1.8,1.8
		freqshift	0.8,0.8
	}
}



