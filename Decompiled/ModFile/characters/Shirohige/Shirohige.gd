extends Fighter

var currentHakiAmount = 50
var maximumHakiAmount = 100
var hakiFull = false
var hakiEmpty = true
var hakiActivated = false
var hakiStance = "Haki"
var normalStance = "Normal"

func tick():
	.tick()
	if (currentHakiAmount == 0):
		hakiEmpty = true
	else:
		hakiEmpty = false
		if (currentHakiAmount == maximumHakiAmount):
			hakiFull = true
		else:
			hakiFull = false
	
	if (hakiActivated):
		if (hakiFull):
			change_stance_to(hakiStance)
			print("Haki activé")
		else:
			if (hakiEmpty):
				change_stance_to(normalStance)
				hakiActivated = false
				print("Haki désactivé")
	else:		
		currentHakiAmount += 0.5
		print("Haki pas encore activé")
