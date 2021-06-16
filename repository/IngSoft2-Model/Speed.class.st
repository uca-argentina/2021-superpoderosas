Class {
	#name : #Speed,
	#superclass : #Permanent,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Speed >> actAt: aBoardGame on: aPlayer [
	aBoardGame apply: self on: aPlayer.
]

{ #category : #actions }
Speed >> action [
	^ 1.
]

{ #category : #actions }
Speed >> wantsToBeThrownTo: player by: currentPlayer at: aBoardGame [ 
	self aCardWantsToBeThrownBy: currentPlayer at: aBoardGame .
	player isInfluencedBy: self.
]
