Class {
	#name : #SpeedPlus,
	#superclass : #Card,
	#instVars : [
		'speedUpEffect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
SpeedPlus class >> withSpeedEffect [
	^ self new initializeWithSpeedEffect.
]

{ #category : #initalize }
SpeedPlus >> initializeWithSpeedEffect [
	speedUpEffect:= SpeedUp new.
]

{ #category : #actions }
SpeedPlus >> notifyCancellationRegarding: target on: aBoardGame [
	aBoardGame remove: speedUpEffect from: target.
	
]

{ #category : #actions }
SpeedPlus >> thrownBy: aPlayer aims: aField on: aBoardGame handledBy: cardHandler [
	aBoardGame verifyIfItIsTheTurnOf: aPlayer.
	aBoardGame add: speedUpEffect on: aField.
	cardHandler influence: aField with: self.
	
]
