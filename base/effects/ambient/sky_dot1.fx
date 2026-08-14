effect effects/ambient/sky_dot1
{
	size	106

	emitter "flash"
	{
		start		0.125,0.125
		duration	1,1
		count		1,1

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				size { point 5,5 }
				offset { point 0,0,-5.5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 2,2 }
			}
		}
	}
	emitter "flash2"
	{
		start		0.25,0.25
		duration	1,1
		count		1,1

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				size { point 3.5,3.5 }
				offset { point -30,33,6.5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 2,2 }
			}
		}
	}
	emitter "flash3"
	{
		start		0.375,0.375
		duration	1,1
		count		1,1

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				size { point 3,3 }
				offset { point -30,53.25,7.5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 2,2 }
			}
		}
	}
	emitter "flash4"
	{
		start		0.5,0.5
		duration	1,1
		count		1,1

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				size { point 2,2 }
				fade { point 0.7 }
				offset { point -30,60.5,5.75 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}
		}
	}
	emitter "flash5"
	{
		start		0.625,0.625
		duration	1,1
		count		1,1

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				size { point 1.5,1.5 }
				fade { point 0.6 }
				offset { point -30,64.75,4 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 0.5,0.5 }
			}
		}
	}
	emitter "flash6"
	{
		start		0.75,0.75
		duration	1,1
		count		1,1

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				fade { point 0.5 }
				offset { point -30,68.5,2.5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 0.5,0.5 }
			}
		}
	}
	emitter "flash7"
	{
		start		1.5,1.5
		duration	1,1
		count		1,1

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				size { point 1.5,1.5 }
				fade { point 0.25 }
				offset { point -30,88,-4.75 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 0.5,0.5 }
			}
		}
	}
	emitter "flash8"
	{
		start		1.625,1.625
		duration	1,1
		count		1,1

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				size { point 1.5,1.5 }
				fade { point 0.25 }
				offset { point -30,95,-3.75 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 0.5,0.5 }
			}
		}
	}
	emitter "flash9"
	{
		start		1.75,1.75
		duration	1,1
		count		1,1

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				size { point 1.5,1.5 }
				fade { point 0.25 }
				offset { point -30,98.5,-0.75 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 0.5,0.5 }
			}
		}
	}
	emitter "flash10"
	{
		start		1.825,1.825
		duration	1,1
		count		1,1

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				size { point 1.5,1.5 }
				fade { point 0.25 }
				offset { point -30,99,2.5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 0.5,0.5 }
			}
		}
	}
}


