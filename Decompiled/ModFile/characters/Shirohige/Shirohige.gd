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
	print(currentHakiAmount)
	if (currentHakiAmount > 0):
		hakiEmpty = false
		if (currentHakiAmount >= maximumHakiAmount):
			hakiFull = true
			change_stance_to(hakiAvailableStance)
			print(stance)
		else:
			hakiFull = false
	else:
		if(currentHakiAmount <= 0):
			hakiEmpty = true
	
	if(hakiFull):
		print("Haki plein")
		
	if(hakiEmpty):
		print("Haki vide")
	
	if (hakiActivated):
		if (hakiFull):
			change_stance_to(hakiStance)
			print(stance)
			hakiRegenerate = false
			print("Haki activé")
		else:
			if (hakiEmpty):
				change_stance_to(normalStance)
				print(stance)
				hakiActivated = false
				print("Haki désactivé")
	else:
		if (!hakiFull):
			hakiRegenerate = true
			
	if (hakiRegenerate):
		currentHakiAmount += 1
	
	if(stance == hakiStance):
		currentHakiAmount -= 1
