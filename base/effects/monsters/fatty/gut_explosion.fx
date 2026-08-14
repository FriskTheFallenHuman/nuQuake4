effect effects/monsters/fatty/gut_explosion
{
	size	1166

	emitter "leakage2"
	{
		duration	1,1
		count		30,30
		locked

		line
		{
			duration	1,3
			generatedLine
			material	"gfx/effects/fluids_drips/stroy_spit_alpha"
			gravity		0.025,0.05
			generatedOriginNormal

			start
			{
				position { line 9.5,-10,-10,9.5,10,10 }
				velocity { point 30,0,0 }
				angle { box 0,0,-1,0,0,1 }
				size { box 10,30 }
				tint { line 1,1,1,0.901961,0.882353,0.6 }
				offset { box -15,-10,-10,-15,10,10 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				angle { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { box 100,150 }
				angle { box 0,0,-0.5,0,0,0.5 }
				length { box 500,0,0,800,0,0 }
			}
		}
	}
	emitter "leakage"
	{
		duration	1,1
		count		20,20
		locked

		line
		{
			duration	1,3
			generatedLine
			material	"gfx/effects/fluids_drips/blood_spit_alpha"
			gravity		0.025,0.05
			generatedOriginNormal

			start
			{
				position { line 9,-10,-10,9,10,10 }
				velocity { point 30,0,0 }
				angle { box 0,0,-1,0,0,1 }
				size { box 5,10 }
				tint { line 1,1,1,0.501961,0,0 }
				offset { box -15,-10,-10,-15,10,10 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				angle { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { box 80,300 }
				angle { box 0,0,-0.5,0,0,0.5 }
				length { box 300,0,0,800,0,0 }
			}
		}
	}
	spawner "mflash8"
	{
		count		10,10
		locked

		line
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/fluids_drips/stroy_spit"
			generatedOriginNormal

			start
			{
				position { line 0.75,-0.5,-0.5,0.75,0.5,0.5 }
				size { box 10,20 }
				tint { line 1,1,1,0.501961,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { box 30,50 }
				length { box 100,0,0,500,0,0 }
			}
		}
	}
	spawner "mflash5"
	{
		count		10,10
		locked

		line
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/fluids_drips/blood_spit"
			generatedOriginNormal

			start
			{
				position { cylinder 0,-10,-10,0,10,10 surface }
				angle { box 0,0,-1,0,0,1 }
				size { box 10,20 }
				tint { line 1,1,1,0.501961,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				angle { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { box 30,50 }
				angle { box 0,0,-0.5,0,0,0.5 }
				length { box 100,0,0,500,0,0 }
			}
		}
	}
	spawner "blood3"
	{
		count		30,30
		locked

		sprite
		{
			duration	0.6,0.8
			material	"gfx/effects/gore_spray/bloodhit1"
			gravity		0.05,0.05

			start
			{
				position { line 0,-20,-20,0,20,20 linearSpacing }
				velocity { box 300,-200,-200,500,200,200 }
				size { line 1,3,2,4 }
				tint { line 0.854902,0.054902,0.054902,0.384314,0.121569,0.0509804 }
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
				size { line 100,100,180,180 }
				fade { point 1 }
			}
		}
	}
	spawner "blood4"
	{
		count		30,30
		locked

		sprite
		{
			duration	0.5,0.8
			material	"gfx/effects/gore_spray/bloodhit2"
			gravity		0.05,0.05
			generatedOriginNormal

			start
			{
				position { cylinder 0.1,-0.5,-0.5,0.1,0.5,0.5 surface linearSpacing }
				velocity { box 300,0,0,500,0,0 }
				size { line 1,3,2,4 }
				tint { line 0.945098,0.145098,0.145098,0.509804,0.164706,0.0666667 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
			}

			end
			{
				size { line 100,100,200,200 }
				fade { point 1 }
			}
		}
	}
	spawner "mflash9"
	{
		count		30,30
		locked

		line
		{
			duration	0.5,0.5
			material	"gfx/effects/fluids_drips/stroy_spit_alpha"
			generatedOriginNormal

			start
			{
				position { cylinder 0,-40,-40,0,40,40 surface cone }
				size { box 10,20 }
				tint { line 1,1,1,0,0.501961,0.25098 }
				length { box 20,0,0,50,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { box 50,80 }
				length { box 100,0,0,300,0,0 }
			}
		}
	}
	spawner "mflash7"
	{
		count		15,15
		locked

		line
		{
			duration	0.5,0.5
			material	"gfx/effects/fluids_drips/blood_spit_alpha"

			start
			{
				angle { box 0,0,-1,0,0,1 }
				size { box 10,20 }
				tint { line 1,1,1,0.501961,0,0 }
				offset { box 0,-30,-30,0,30,30 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				angle { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { box 60,80 }
				angle { box 0,0,-0.5,0,0,0.5 }
				length { box 100,0,0,500,0,0 }
			}
		}
	}
	spawner "blood5"
	{
		count		20,20
		locked

		sprite
		{
			duration	0.5,1
			material	"gfx/effects/gore_spray/bloodhit1"
			gravity		0.05,0.05

			start
			{
				position { line 0,0,0,10,0,0 linearSpacing }
				velocity { box 0,-300,-300,0,300,300 }
				size { line 50,50,60,60 }
				tint { line 0.501961,0,0,1,0,0 }
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
				size { line 100,100,200,200 }
				fade { point 1 }
			}
		}
	}
	spawner "blood6"
	{
		count		30,30
		locked

		sprite
		{
			duration	0.25,0.8
			material	"gfx/effects/gore_spray/bloodhit2"
			gravity		0.05,0.05

			start
			{
				position { cylinder 0,-30,-30,0,30,30 surface linearSpacing }
				velocity { box 300,-100,-100,500,100,100 }
				size { line 1,3,2,4 }
				tint { line 0.945098,0.145098,0.145098,0.509804,0.164706,0.0666667 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
			}

			end
			{
				size { line 100,100,200,200 }
				fade { point 1 }
			}
		}
	}
	spawner "blood7"
	{
		count		30,30
		locked

		sprite
		{
			duration	0.25,0.8
			material	"gfx/effects/gore_spray/bloodhit2"

			start
			{
				position { cylinder 0,-30,-30,0,30,30 surface linearSpacing }
				size { line 1,3,2,4 }
				tint { line 0.945098,0.145098,0.145098,0.509804,0.164706,0.0666667 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
			}

			end
			{
				size { line 100,100,200,200 }
				fade { point 1 }
			}
		}
	}
	spawner "unnamed12"
	{
		count		10,10

		debris
		{
			duration	1,1
			entityDef	"debris_gib_torso"

			start
			{
				position { cylinder 0,-20,-20,0,20,20 surface }
				velocity { box 200,-200,-200,300,200,200 }
			}
		}
	}
	spawner "unnamed13"
	{
		count		5,5

		debris
		{
			duration	1,1
			entityDef	"debris_gib_lup_leg"

			start
			{
				position { cylinder 0,-20,-20,0,20,20 surface }
				velocity { box 300,-300,-300,800,300,300 }
			}
		}
	}
}




