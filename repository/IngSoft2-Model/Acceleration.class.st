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

{ #category : #actions }
Acceleration >> wantsToBeThrownBy: currentPlayer at: aBoardGame [
	self aCardWantsToBeThrownBy: currentPlayer at: aBoardGame.
	aBoardGame applyToAllPlayers: self.
]
