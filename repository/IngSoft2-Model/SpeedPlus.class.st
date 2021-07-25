Class {
	#name : #SpeedPlus,
	#superclass : #Card,
	#instVars : [
		'speedUpEffect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
SpeedPlus >> notifyCancellationRegarding: target on: aBoardGame [
	aBoardGame remove: SpeedUp new from: target.
	
]

{ #category : #accessing }
SpeedPlus >> thrownBy: aPlayer aims: aField on: aBoardGame handledBy: cardHandler [
	aBoardGame verifyIfItIsTheTurnOf: aPlayer.
	aBoardGame add: SpeedUp new on: aField.
	cardHandler influence: aField with: self.
	
]
