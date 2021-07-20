Class {
	#name : #SpeedPlus,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
SpeedPlus >> thrownBy: aPlayer aims: aField on: aBoardGame handledBy: cardHandler [
	aBoardGame verifyIfItIsTheTurnOf: aPlayer.
	aBoardGame addSpeedUpEffectOn: aField.
	cardHandler influence: aField with: self.
	
]
