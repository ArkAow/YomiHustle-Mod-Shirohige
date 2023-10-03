extends Fighter

var currentHakiAmount = 0
var maximumHakiAmount = 100
var hakiFull = false
var hakiEmpty = false
var hakiActivated = false
var hakiRegenerate = false
var hakiStance = "Haki"
var normalStance = "Normal"
var hakiAvailableStance = "HakiAvailable"

func tick():
	.tick()
	if (currentHakiAmount > 0):
		hakiEmpty = false
		if (currentHakiAmount >= maximumHakiAmount):
			hakiFull = true
			change_stance_to(hakiAvailableStance)
		else:
			hakiFull = false
	else:
		if(currentHakiAmount <= 0):
			hakiEmpty = true
	
	if (hakiActivated):
		if (hakiFull):
			change_stance_to(hakiStance)
			hakiRegenerate = false
		else:
			if (hakiEmpty):
				change_stance_to(normalStance)
				hakiActivated = false
	else:
		if (!hakiFull):
			hakiRegenerate = true
			
	if (hakiRegenerate):
		currentHakiAmount += 1
	
	if(stance == hakiStance):
		currentHakiAmount -= 1
