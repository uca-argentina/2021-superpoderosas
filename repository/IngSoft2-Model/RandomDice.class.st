Class {
	#name : #RandomDice,
	#superclass : #Dice,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
RandomDice >> throw [
	^(1 to: numberOfFaces) atRandom.
]
