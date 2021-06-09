Class {
	#name : #Acceleration,
	#superclass : #Permanent,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Acceleration >> actAt: aBoardGame [ 
	aBoardGame applyToAllPlayers: self.
]

{ #category : #actions }
Acceleration >> action [
	^ 1.
]
